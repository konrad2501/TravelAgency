package com.example.projekt.controller;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.sql.SQLException;
import java.util.Objects;

@Controller
// Klasa zawiera obsługę rejestracji użytkownika
public class Registration {
    @GetMapping("Registration")
    // metoda wykonuje GET do przekazania adresu strony, jeśli dane poprawne przenosi na kolejną stronę
    public String doGetRegistration(@ModelAttribute ("Registration") User user)
    {
        return "Registration";
    }

    @PostMapping("Registration")
    // metoda wykonuje POST do przesłania danych, jeśli nieprawidłowe dane następuje powrót do rejestracji
    public String doPostRegistration(@Valid @ModelAttribute ("Registration") User user, BindingResult result) throws SQLException {
        SQLiteDB query = new SQLiteDB();
        if((result.hasErrors()) || !Objects.equals(user.getPassword(), user.getPasswordConfirmation()) || query.CheckIfUserExist(user))
        {
            System.out.println("errors");
            return "Registration";
        }
        query.AddNewUser(user);
        return "redirect:Login";
    }
}