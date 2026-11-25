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

@WebServlet("/cars")
public class CarServlet extends HttpServlet {

    private final CarDAO carDAO = new CarDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String type = request.getParameter("type");
        String maxPriceText = request.getParameter("maxPrice");
        Double maxPrice = null;
        if (maxPriceText != null && !maxPriceText.trim().isEmpty()) {
            try {
                maxPrice = Double.parseDouble(maxPriceText.trim());
            } catch (NumberFormatException e) {
                maxPrice = null; // ignore invalid input
            }
        }

        List<Car> cars = carDAO.searchCars(type, maxPrice);
        request.setAttribute("cars", cars);
        request.setAttribute("selectedType", type == null ? "" : type);
        request.setAttribute("selectedMaxPrice", maxPriceText == null ? "" : maxPriceText);
        request.getRequestDispatcher("/cars.jsp").forward(request, response);
    }
}
