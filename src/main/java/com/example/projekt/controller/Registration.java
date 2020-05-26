package com.example.projekt.controller;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.validation.Valid;
import java.sql.SQLException;
import java.util.Objects;

@Controller
public class Registration {
    @GetMapping("Registration")
    public String GetRegistration(@ModelAttribute ("Registration") User user)
    {
        return "Registration";
    }

    @PostMapping("Registration")
    public String AddRegistration(@Valid @ModelAttribute ("Registration") User user, BindingResult result) throws SQLException {
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