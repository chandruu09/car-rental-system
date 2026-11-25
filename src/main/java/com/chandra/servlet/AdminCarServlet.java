package com.chandra.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.chandra.dao.CarDAO;
import com.chandra.model.Car;
import com.chandra.model.User;

@WebServlet("/admin/cars")
public class AdminCarServlet extends HttpServlet {

    private final CarDAO carDAO = new CarDAO();

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return false;
        User user = (User) session.getAttribute("user");
        return user != null && "ADMIN".equals(user.getRole());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        List<Car> cars = carDAO.getAllCars();
        request.setAttribute("cars", cars);
        request.getRequestDispatcher("/admin-cars.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String message = null;

        if ("add".equals(action)) {
            try {
                Car car = new Car();
                car.setBrand(request.getParameter("brand").trim());
                car.setModel(request.getParameter("model").trim());
                car.setType(request.getParameter("type").trim());
                car.setSeats(Integer.parseInt(request.getParameter("seats")));
                car.setPricePerDay(Double.parseDouble(request.getParameter("pricePerDay")));
                car.setImageUrl(request.getParameter("imageUrl").trim());
                message = carDAO.addCar(car) ? "Car added." : "Could not add the car.";
            } catch (NumberFormatException | NullPointerException e) {
                message = "Please enter valid values.";
            }
        } else if ("delete".equals(action)) {
            try {
                int id = Integer.parseInt(request.getParameter("id"));
                message = carDAO.deleteCar(id) ? "Car deleted." : "Could not delete (it may have bookings).";
            } catch (NumberFormatException e) {
                message = "Invalid car.";
            }
        }

        request.getSession().setAttribute("flash", message);
        response.sendRedirect(request.getContextPath() + "/admin/cars");
    }
}