package com.chandra.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.mindrot.jbcrypt.BCrypt;

import com.chandra.dao.UserDAO;
import com.chandra.model.User;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = clean(request.getParameter("name"));
        String email = clean(request.getParameter("email"));
        String phone = clean(request.getParameter("phone"));
        String password = request.getParameter("password");
        String confirm = request.getParameter("confirmPassword");

        String error = null;
        if (name.isEmpty() || email.isEmpty() || password == null || password.isEmpty()) {
            error = "Name, email and password are required.";
        } else if (password.length() < 6) {
            error = "Password must be at least 6 characters.";
        } else if (!password.equals(confirm)) {
            error = "Passwords do not match.";
        } else if (userDAO.getUserByEmail(email) != null) {
            error = "This email is already registered.";
        }

        if (error != null) {
            request.setAttribute("error", error);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPhone(phone);
        user.setPasswordHash(BCrypt.hashpw(password, BCrypt.gensalt()));
        user.setRole("USER");

        if (userDAO.registerUser(user)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?registered=1");
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    private String clean(String value) {
        return value == null ? "" : value.trim();
    }
}
