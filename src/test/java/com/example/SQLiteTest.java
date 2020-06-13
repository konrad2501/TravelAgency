package com.example;

import com.example.projekt.SQLite;
import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.SQLException;

import static org.junit.Assert.*;
import static org.junit.jupiter.api.Assertions.assertDoesNotThrow;

public class SQLiteTest {
    @Test
    public void ConnectionTest() throws SQLException {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        assertNotNull(conn);
        connection.DbDisconnect();
    }

    @Test
    public void DisconnectTest() {
        SQLite connection = new SQLite();
        Connection conn = connection.DbConnect();
        assertNotNull(conn);
        assertDoesNotThrow(
                connection::DbDisconnect
        );
    }
}