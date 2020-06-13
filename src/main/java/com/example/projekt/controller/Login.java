package com.example.projekt.controller;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.Order;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.sql.SQLException;

@Controller
// Klasa zawiera obsługę logowania użytkownika
public class Login {

    @GetMapping("Login")
    // metoda wykonuje GET do przekazania adresu strony
    public String doGetLogin(@ModelAttribute("Login") User user){
        return "Login";
    }

    @PostMapping("Login")
    // metoda wykonuje POST do przesłania danych, jeśli się powiedzie ustawiana flaga IsLogged
    public String doPostLogin(@Valid @ModelAttribute ("Login") User user, BindingResult result) throws SQLException {
        SQLiteDB query = new SQLiteDB();
        if(result.hasErrors()) {
            System.out.println("errors");
            return "Login";
        }

        if(query.CheckLogin(user) <= 0)
        {
            return "Login";
        }
        User.Id = query.CheckLogin(user);
        User.IsLogged = true;
        Order.Id = query.NewOrder(user);
        return "redirect:Menu";
    }
}