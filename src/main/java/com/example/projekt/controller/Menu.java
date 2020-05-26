package com.example.projekt.controller;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.Order;
import com.example.projekt.model.Tour;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Controller
public class Menu {

    @GetMapping("Menu")
    public String GetMenu(@ModelAttribute("Order") Order order, @ModelAttribute("Tour") Tour tour, @ModelAttribute("User")
                          User user, Map<String, Object> map) throws SQLException{
        SQLiteDB query = new SQLiteDB();
        List<Tour> tours = query.GetAllTours();
        map.put("logged",User.IsLogged);
        map.put("Spain", tours.stream().filter(t -> t.getCountry().equals("Hiszpania")).collect(Collectors.toList()));
        map.put("Italy", tours.stream().filter(t -> t.getCountry().equals("Włochy")).collect(Collectors.toList()));
        map.put("Turkey", tours.stream().filter(t -> t.getCountry().equals("Turcja")).collect(Collectors.toList()));
        map.put("Portugal", tours.stream().filter(t -> t.getCountry().equals("Portugalia")).collect(Collectors.toList()));
        return "Menu";
    }

    @RequestMapping(method = RequestMethod.POST, value = "Menu")
    @ResponseBody
    public void AddMenu(@RequestBody List<String> tours) throws SQLException{
        SQLiteDB query = new SQLiteDB();
        for(String city: tours)
        {
            Tour tour = (query.FindTourByName(city));
            query.AddOrderTour(tour.getIdTour());
        }
    }
}
