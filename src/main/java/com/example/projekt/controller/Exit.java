package com.example.projekt.controller;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.sql.SQLException;
import java.util.Map;

@Controller
// Klasa zawiera obsługę ostatniej strony
public class Exit {
    @GetMapping("Exit")
    // metoda wykonuje GET do przekazania adresu strony, przekazuje aktualnie zalogowanego użytkownika
    public String doGetExit(@ModelAttribute("User")
                                  User user, Map<String, Object> map) throws SQLException, InterruptedException {
        SQLiteDB query = new SQLiteDB();
        Thread.sleep(400);
        User users = query.GetUserNameAndSurname();
        map.put("users", users);
        return "Exit";
    }
}