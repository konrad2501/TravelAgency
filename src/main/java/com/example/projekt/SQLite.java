package com.example.projekt;
import java.sql.*;
import java.util.logging.ConsoleHandler;

public class SQLite {
    Connection conn = null;
    public Connection DbConnect()
    {
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:/Users/konradmichalski/Desktop/TravelAgencyJava/database.db");
            System.out.println("Connected");
            return conn;
        }
        catch(Exception ex)
        {
            System.out.println("Error " + ex.getMessage());
            return null;
        }
    }
    public void DbDisconnect() throws SQLException {
        try
        {
            conn.close();
            System.out.println("Disconnected");
        }
        catch (Exception ex)
        {
            System.out.println("Error " + ex.getMessage());
        }
    }
}

