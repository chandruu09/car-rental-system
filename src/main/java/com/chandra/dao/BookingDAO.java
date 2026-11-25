package com.chandra.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import com.chandra.model.Booking;
import com.chandra.util.DBconnection;

public class BookingDAO {

    // True if no PENDING/APPROVED booking overlaps the requested dates
    public boolean isCarAvailable(int carId, Date start, Date end) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE car_id = ? "
                   + "AND status IN ('PENDING','APPROVED') "
                   + "AND start_date <= ? AND end_date >= ?";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, carId);
            ps.setDate(2, end);
            ps.setDate(3, start);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) == 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // if anything goes wrong, do not allow the booking
    }

    public boolean createBooking(Booking b) {
        String sql = "INSERT INTO bookings (user_id, car_id, start_date, end_date, total_amount, status) "
                   + "VALUES (?, ?, ?, ?, ?, 'PENDING')";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, b.getUserId());
            ps.setInt(2, b.getCarId());
            ps.setDate(3, b.getStartDate());
            ps.setDate(4, b.getEndDate());
            ps.setDouble(5, b.getTotalAmount());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, c.brand, c.model FROM bookings b "
                   + "JOIN cars c ON b.car_id = c.id WHERE b.user_id = ? ORDER BY b.id DESC";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = new Booking();
                    b.setId(rs.getInt("id"));
                    b.setUserId(rs.getInt("user_id"));
                    b.setCarId(rs.getInt("car_id"));
                    b.setStartDate(rs.getDate("start_date"));
                    b.setEndDate(rs.getDate("end_date"));
                    b.setTotalAmount(rs.getDouble("total_amount"));
                    b.setStatus(rs.getString("status"));
                    b.setCarName(rs.getString("brand") + " " + rs.getString("model"));
                    list.add(b);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // A user can only cancel their own booking
    public boolean cancelBooking(int bookingId, int userId) {
        String sql = "UPDATE bookings SET status = 'CANCELLED' "
                   + "WHERE id = ? AND user_id = ? AND status IN ('PENDING','APPROVED')";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, c.brand, c.model, u.name AS user_name FROM bookings b "
                   + "JOIN cars c ON b.car_id = c.id "
                   + "JOIN users u ON b.user_id = u.id ORDER BY b.id DESC";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Booking b = new Booking();
                b.setId(rs.getInt("id"));
                b.setUserId(rs.getInt("user_id"));
                b.setCarId(rs.getInt("car_id"));
                b.setStartDate(rs.getDate("start_date"));
                b.setEndDate(rs.getDate("end_date"));
                b.setTotalAmount(rs.getDouble("total_amount"));
                b.setStatus(rs.getString("status"));
                b.setCarName(rs.getString("brand") + " " + rs.getString("model"));
                b.setUserName(rs.getString("user_name"));
                list.add(b);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Changes the status only if the booking is currently in 'requiredCurrent'
    public boolean updateStatus(int bookingId, String newStatus, String requiredCurrent) {
        String sql = "UPDATE bookings SET status = ? WHERE id = ? AND status = ?";
        try (Connection con = DBconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, newStatus);
            ps.setInt(2, bookingId);
            ps.setString(3, requiredCurrent);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
