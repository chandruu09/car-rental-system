package com.chandra.util;



import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBconnection {

    private static final String URL = getEnv("DB_URL", "jdbc:postgresql://localhost:5432/car_rental");
    private static final String USER = getEnv("DB_USER", "postgres");
    private static final String PASSWORD = getEnv("DB_PASSWORD", "your_local_password");

    private static String getEnv(String key, String fallback) {
        String value = System.getenv(key);
        return value != null ? value : fallback;
    }

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL driver not found", e);
        }
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}
