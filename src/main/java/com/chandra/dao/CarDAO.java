package com.chandra.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.chandra.model.Car;
import com.chandra.util.DBconnection;

public class CarDAO {
	// Add cars
    public boolean addCar(Car car) {
        String sql = "INSERT INTO cars (brand, model, type, seats, price_per_day, status, image_url) "
                   + "VALUES (?, ?, ?, ?, ?, 'AVAILABLE', ?)";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, car.getBrand());
            ps.setString(2, car.getModel());
            ps.setString(3, car.getType());
            ps.setInt(4, car.getSeats());
            ps.setDouble(5, car.getPricePerDay());
            ps.setString(6, car.getImageUrl());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    // get Car details
    public List<Car> getAllCars() {
        List<Car> cars = new ArrayList<>();
        String sql = "SELECT * FROM cars ORDER BY id DESC";
        try (Connection con = DBconnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                cars.add(mapCar(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }
    //Search Cars
    public List<Car> searchCars(String type, Double maxPrice) {
        List<Car> cars = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM cars WHERE status <> 'MAINTENANCE'");
        List<Object> params = new ArrayList<>();

        if (type != null && !type.isEmpty()) {
            sql.append(" AND type = ?");
            params.add(type);
        }
        if (maxPrice != null) {
            sql.append(" AND price_per_day <= ?");
            params.add(maxPrice);
        }
        sql.append(" ORDER BY price_per_day ASC");

        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    cars.add(mapCar(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cars;
    }
    // delete Cars
    public boolean deleteCar(int id) {
        String sql = "DELETE FROM cars WHERE id = ?";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace(); // fails if the car already has bookings
            return false;
        }
    }

    private Car mapCar(ResultSet rs) throws SQLException {
        Car car = new Car();
        car.setId(rs.getInt("id"));
        car.setBrand(rs.getString("brand"));
        car.setModel(rs.getString("model"));
        car.setType(rs.getString("type"));
        car.setSeats(rs.getInt("seats"));
        car.setPricePerDay(rs.getDouble("price_per_day"));
        car.setStatus(rs.getString("status"));
        car.setImageUrl(rs.getString("image_url"));
        return car;
    }
    
    //Get Car By Id
    public Car getCarById(int id) {
        String sql = "SELECT * FROM cars WHERE id = ?";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCar(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}