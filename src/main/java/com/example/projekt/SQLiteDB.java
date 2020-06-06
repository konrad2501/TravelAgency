package com.example.projekt;

import com.example.projekt.model.Order;
import com.example.projekt.model.RemovedTours;
import com.example.projekt.model.Tour;
import com.example.projekt.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Instant;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

public class SQLiteDB {
    public void AddNewUser(User user) throws SQLException {
        SQLite connection = new SQLite();
        try (Connection conn = connection.DbConnect()) {
            PreparedStatement statement = (PreparedStatement) conn.prepareStatement("INSERT INTO Users (name, surname, password, passwordConfirmation)" +
                    "VALUES (?, ?, ?, ?)");
            statement.setString(1, user.getName());
            statement.setString(2, user.getSurname());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getPasswordConfirmation());
            statement.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        finally {
            connection.DbDisconnect();
        }
    }

    public boolean CheckIfUserExist(User user) throws SQLException {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = (PreparedStatement) conn.prepareStatement("SELECT COUNT(*) as count FROM Users WHERE name = ?");
        statement.setString(1, user.getName());
        ResultSet rs = statement.executeQuery();
        int i = 0;
        while(rs.next())
        {
            i = rs.getInt("count");
        }
        System.out.println(i);
        rs.close();
        connection.DbDisconnect();
        return i > 0;
    }

    public int CheckLogin (User user) throws SQLException {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = (PreparedStatement) conn.prepareStatement("SELECT id_user, password FROM Users WHERE name = ?");
        statement.setString(1, user.getName());
        ResultSet rs = statement.executeQuery();
        String password = null;
        int userId = 0;
        while(rs.next())
        {
            userId = rs.getInt("id_user");
            password = rs.getString("password");
        }
        if (userId == 0 ) return 0;
        rs.close();
        connection.DbDisconnect();
        return password.equals(user.getPassword()) ? userId : 0;
    }


    public List<Tour> GetAllTours() throws SQLException {
        List<Tour> tours = new ArrayList<>();
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = (PreparedStatement) conn.prepareStatement("SELECT id_tour, country, city, days, price, departure, arrival FROM Tours");
        ResultSet rs = statement.executeQuery();

        while(rs.next())
        {
            Tour tour = new Tour();
            tour.setIdTour(rs.getInt("id_tour"));
            tour.setCountry(rs.getString("country"));
            tour.setCity(rs.getString("city"));
            tour.setDays(rs.getInt("days"));
            tour.setPrice(rs.getInt("price"));
            tour.setDeparture(rs.getString("departure"));
            tour.setArrival(rs.getString("arrival"));
            tours.add(tour);
        }
        rs.close();
        connection.DbDisconnect();
        return tours;
    }

    public int NewOrder(User user) throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        int orderId = 0;
        PreparedStatement statement = (PreparedStatement)conn.prepareStatement("INSERT INTO Orders(id_user,email,number,total,date) VALUES (?,?,?,?,?)");
    statement.setInt(1,User.Id);
    statement.setString(2,"");
    statement.setInt(3, 0);
    statement.setInt(4,0);
        DateTimeFormatter formatter =
                DateTimeFormatter.ofLocalizedDateTime( FormatStyle.SHORT )
                        .withLocale( Locale.GERMAN )
                        .withZone(ZoneId.systemDefault());
        String dateNow = formatter.format(Instant.now());
    statement.setString(5, dateNow);
    statement.executeUpdate();
    statement = conn.prepareStatement("SELECT last_insert_rowid()");
    ResultSet rs = statement.executeQuery();
    while(rs.next()){
        orderId = rs.getInt(1);
    }
    rs.close();
    connection.DbDisconnect();
    return orderId;
    }

    public Tour FindTourByName(String city) throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        Tour tour = new Tour();
        PreparedStatement statement = conn.prepareStatement("SELECT * FROM Tours WHERE city = ?");
        statement.setString(1, city);
        ResultSet rs = statement.executeQuery();
        while(rs.next())
        {
            tour.setIdTour(rs.getInt(1));
            tour.setCountry(rs.getString(2));
            tour.setCity(rs.getString(3));
            tour.setDays(rs.getInt(4));
            tour.setPrice(rs.getInt(5));
            tour.setDeparture(rs.getString(6));
            tour.setArrival(rs.getString(7));
        }
        rs.close();
        connection.DbDisconnect();
        return tour;
    }

    public void AddOrderTour(int tourId) throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = (PreparedStatement) conn.prepareStatement("INSERT INTO Reservations (id_tours, id_orders)" +
                "VALUES (?, ?)");
        statement.setInt(1, tourId);
        statement.setInt(2, Order.Id);
        statement.executeUpdate();
        connection.DbDisconnect();
    }

    public List<Tour> GetReservationTours() throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = conn.prepareStatement(" SELECT Tours.id_tour, Tours.city, Tours.price FROM Reservations " +
                "JOIN Tours ON Tours.id_tour = Reservations.id_tours WHERE Reservations.id_orders = ?");
        statement.setInt(1, Order.Id);
        ResultSet rs = statement.executeQuery();
        List<Tour> tours = new ArrayList<>();
        while(rs.next()){
            Tour tour = new Tour();
            tour.setIdTour(rs.getInt(1));
            tour.setCity(rs.getString(2));
            tour.setPrice(rs.getInt(3));
            tours.add(tour);
        }
        rs.close();
        connection.DbDisconnect();
        return tours;
    }

    public void AddData(RemovedTours data) throws SQLException {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = (PreparedStatement) conn.prepareStatement("UPDATE Orders SET email = ?, number = ? " +
                "WHERE id_order = ?");
        statement.setString(1, data.getEmail());
        statement.setInt(2, data.getNumber());
        statement.setInt(3, Order.Id);
        statement.executeUpdate();
        statement = conn.prepareStatement("SELECT SUM(Tours.price) FROM Reservations JOIN Tours ON Tours.id_tour = Reservations.id_tours WHERE Reservations.id_orders = ? ");
        statement.setInt(1, Order.Id);
        ResultSet rs = statement.executeQuery();
        int total = 0;
        while(rs.next())
        {
            total = rs.getInt(1);
        }
        statement = conn.prepareStatement("UPDATE Orders SET total = ? WHERE id_order = ?");
        statement.setInt(1, total);
        statement.setInt(2, Order.Id);
        statement.executeUpdate();
        rs.close();
        connection.DbDisconnect();
    }

    public void RemoveTourFromReservation(int TourId) throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = (PreparedStatement) conn.prepareStatement("DELETE FROM Reservations WHERE id_reservation IN (SELECT distinct id_reservation FROM Reservations WHERE id_orders = ? AND id_tours = ? LIMIT 1)\n");
        statement.setInt(1, Order.Id);
        statement.setInt(2, TourId);
        statement.executeUpdate();
        connection.DbDisconnect();
    }

    public List<Tour> CheckSelectedTours() throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = conn.prepareStatement(" SELECT Tours.id_tour, Tours.country, Tours.city, Tours.days, Tours.price, Tours.departure, Tours.arrival FROM Reservations " +
                "JOIN Tours ON Tours.id_tour = Reservations.id_tours WHERE Reservations.id_orders = ?");
        statement.setInt(1, Order.Id);
        ResultSet rs = statement.executeQuery();
        List<Tour> tours = new ArrayList<>();
        while(rs.next()){
            Tour tour = new Tour();
            tour.setIdTour(rs.getInt(1));
            tour.setCountry(rs.getString(2));
            tour.setCity(rs.getString(3));
            tour.setDays(rs.getInt(4));
            tour.setPrice(rs.getInt(5));
            tour.setDeparture(rs.getString(6));
            tour.setArrival(rs.getString(7));
            tours.add(tour);
        }
        rs.close();
        connection.DbDisconnect();
        return tours;
    }

    public User GetUserNameAndSurname() throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = conn.prepareStatement("SELECT Users.name, Users.surname " +
                "FROM Orders JOIN Users ON Users.id_user = Orders.id_user WHERE Orders.id_order = ?");
        statement.setInt(1, Order.Id);
        ResultSet rs = statement.executeQuery();
        User user = new User();
        while(rs.next())
        {
            user.setName(rs.getString(1));
            user.setSurname(rs.getString(2));
        }
        rs.close();
        connection.DbDisconnect();
        return user;
    }

    public Order GetOrdersData() throws SQLException
    {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        PreparedStatement statement = conn.prepareStatement("SELECT email, number, total, date " +
                "FROM Orders WHERE Orders.id_order = ?");
        statement.setInt(1, Order.Id);
        ResultSet rs = statement.executeQuery();
        Order order = new Order();
        while(rs.next())
        {
            order.setEmail(rs.getString(1));
            order.setNumber(rs.getInt(2));
            order.setTotal(rs.getInt(3));
            order.setDate(rs.getString(4));
        }
        rs.close();
        connection.DbDisconnect();
        return order;
    }
}
