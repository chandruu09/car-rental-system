package com.chandra.servlet;

import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.time.temporal.ChronoUnit;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chandra.dao.BookingDAO;
import com.chandra.dao.CarDAO;
import com.chandra.model.Booking;
import com.chandra.model.Car;
import com.chandra.model.User;

@WebServlet("/book")
public class BookServlet extends HttpServlet {

    private final CarDAO carDAO = new CarDAO();
    private final BookingDAO bookingDAO = new BookingDAO();

    private User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session == null ? null : (User) session.getAttribute("user");
    }

    private Car loadCar(HttpServletRequest request) {
        try {
            return carDAO.getCarById(Integer.parseInt(request.getParameter("carId")));
        } catch (NumberFormatException e) {
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (getUser(request) == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Car car = loadCar(request);
        if (car == null) {
            response.sendRedirect(request.getContextPath() + "/cars");
            return;
        }
        request.setAttribute("car", car);
        request.setAttribute("today", LocalDate.now().toString());
        request.getRequestDispatcher("/book.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        Car car = loadCar(request);
        if (car == null) {
            response.sendRedirect(request.getContextPath() + "/cars");
            return;
        }

        String error = null;
        LocalDate start = null, end = null;
        try {
            start = LocalDate.parse(request.getParameter("startDate"));
            end = LocalDate.parse(request.getParameter("endDate"));
        } catch (DateTimeParseException | NullPointerException e) {
            error = "Please choose valid dates.";
        }

        if (error == null) {
            if (start.isBefore(LocalDate.now())) {
                error = "Start date cannot be in the past.";
            } else if (end.isBefore(start)) {
                error = "End date cannot be before the start date.";
            } else if ("MAINTENANCE".equals(car.getStatus())) {
                error = "This car is not available for booking.";
            } else if (!bookingDAO.isCarAvailable(car.getId(), Date.valueOf(start), Date.valueOf(end))) {
                error = "Sorry, this car is already booked for some of these dates.";
            }
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.setAttribute("car", car);
            request.setAttribute("today", LocalDate.now().toString());
            request.getRequestDispatcher("/book.jsp").forward(request, response);
            return;
        }

        long days = ChronoUnit.DAYS.between(start, end) + 1; // both days count
        Booking b = new Booking();
        b.setUserId(user.getId());
        b.setCarId(car.getId());
        b.setStartDate(Date.valueOf(start));
        b.setEndDate(Date.valueOf(end));
        b.setTotalAmount(days * car.getPricePerDay());

        if (bookingDAO.createBooking(b)) {
            request.getSession().setAttribute("flash", "Booking request sent! Total: Rs. " + b.getTotalAmount());
            response.sendRedirect(request.getContextPath() + "/my-bookings");
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.setAttribute("car", car);
            request.setAttribute("today", LocalDate.now().toString());
            request.getRequestDispatcher("/book.jsp").forward(request, response);
        }
    }
}
