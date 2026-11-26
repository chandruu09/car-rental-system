package com.chandra.util;

import org.mindrot.jbcrypt.BCrypt;

import com.chandra.dao.UserDAO;
import com.chandra.model.User;

public class TestUserDAO {
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();

        User u = new User();
        u.setName("Test User");
        u.setEmail("test" + System.currentTimeMillis() + "@mail.com");
        u.setPasswordHash(BCrypt.hashpw("test123", BCrypt.gensalt()));
        u.setPhone("9999999999");

        System.out.println("Saved: " + dao.registerUser(u));

        User found = dao.getUserByEmail(u.getEmail());
        System.out.println("Found: " + (found != null ? found.getName() : "null"));
    }
}
