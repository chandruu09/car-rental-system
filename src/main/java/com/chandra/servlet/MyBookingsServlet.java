package com.chandra.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chandra.dao.BookingDAO;
import com.chandra.model.User;

@WebServlet("/my-bookings")
public class MyBookingsServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

    private User getUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session == null ? null : (User) session.getAttribute("user");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.setAttribute("bookings", bookingDAO.getBookingsByUser(user.getId()));
        request.getRequestDispatcher("/my-bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = getUser(request);
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        String message;
        try {
            int id = Integer.parseInt(request.getParameter("bookingId"));
            message = bookingDAO.cancelBooking(id, user.getId()) ? "Booking cancelled." : "Could not cancel this booking.";
        } catch (NumberFormatException e) {
            message = "Invalid booking.";
        }
        request.getSession().setAttribute("flash", message);
        response.sendRedirect(request.getContextPath() + "/my-bookings");
    }
}