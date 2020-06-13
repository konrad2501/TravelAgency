package com.example.projekt.controller;


import com.example.projekt.SQLiteDB;
import com.example.projekt.model.Order;
import com.example.projekt.model.Tour;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Controller
// Klasa zawiera obsługę ostatecznego zamówienia
public class Invoice {

    @GetMapping("Invoice")
    // metoda wykonuje GET do przekazania adresu strony, przekazuje wszystkie dane dotyczące użytkownika, aktualnego zamówienia, wybranych wycieczek
    public String doGetInvoice(@ModelAttribute("Order") Order order, @ModelAttribute("Tour") Tour tour, @ModelAttribute("User")
            User user, Map<String, Object> map) throws SQLException, InterruptedException {
        SQLiteDB query = new SQLiteDB();
        Thread.sleep(400);
        List<Tour> tours = query.CheckSelectedTours();
        User users = query.GetUserNameAndSurname();
        Order orders = query.GetOrdersData();
        map.put("logged", User.IsLogged);
        map.put("tours", tours);
        map.put("users", users);
        map.put("orders", orders);
        return "Invoice";
    }


}
