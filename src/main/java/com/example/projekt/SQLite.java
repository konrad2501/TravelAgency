package com.example.projekt;
import java.sql.*;
import java.util.logging.ConsoleHandler;

// Klasa służy do połączenia z bazą danych
public class SQLite {
    Connection conn = null;
    // metoda odpowiada za połączenie z bazą danych
    public Connection DbConnect()
    {
        try {
            Class.forName("org.sqlite.JDBC");
            conn = DriverManager.getConnection("jdbc:sqlite:/Users/konradmichalski/Desktop/TravelAgency-master/database.db");
            System.out.println("Connected");
            return conn;
        }
        catch(Exception ex)
        {
            System.out.println("Error " + ex.getMessage());
            return null;
        }
    }

    // metoda odpowiada za odłączenie się od bazy danych
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

