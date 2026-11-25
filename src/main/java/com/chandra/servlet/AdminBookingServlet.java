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

@WebServlet("/admin/bookings")
public class AdminBookingServlet extends HttpServlet {

    private final BookingDAO bookingDAO = new BookingDAO();

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
        request.setAttribute("bookings", bookingDAO.getAllBookings());
        request.getRequestDispatcher("/admin-bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String message;
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            boolean ok;
            if ("approve".equals(action)) {
                ok = bookingDAO.updateStatus(id, "APPROVED", "PENDING");
                message = ok ? "Booking approved." : "Only pending bookings can be approved.";
            } else if ("reject".equals(action)) {
                ok = bookingDAO.updateStatus(id, "REJECTED", "PENDING");
                message = ok ? "Booking rejected." : "Only pending bookings can be rejected.";
            } else if ("complete".equals(action)) {
                ok = bookingDAO.updateStatus(id, "COMPLETED", "APPROVED");
                message = ok ? "Booking marked as completed." : "Only approved bookings can be completed.";
            } else {
                message = "Unknown action.";
            }
        } catch (NumberFormatException e) {
            message = "Invalid booking.";
        }

        request.getSession().setAttribute("flash", message);
        response.sendRedirect(request.getContextPath() + "/admin/bookings");
    }
}