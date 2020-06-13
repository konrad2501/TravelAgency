package com.example.projekt.controller;

import com.example.projekt.SQLiteDB;
import com.example.projekt.model.RemovedTours;
import com.example.projekt.model.Tour;
import com.example.projekt.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Controller
// Klasa zawiera obsługę początkowo wybranego zamówienia
public class ReservationTour {
    @GetMapping("Reservation")
    // metoda wykonuje GET do przekazania adresu strony, przekazuje dane użytkownika i wybrane wycieczki dla aktualnego zamówienia
    public String doGetReservation(@ModelAttribute("Tour") Tour tour,
                                 @ModelAttribute User user,
                                  Map<String, Object> map) throws SQLException, InterruptedException {
        SQLiteDB query = new SQLiteDB();
        Thread.sleep(400);
        List<Tour> tours = query.GetReservationTours();
        map.put("logged", User.IsLogged);
        map.put("tours", tours);
        return "Reservation";
    }

    @RequestMapping(method = RequestMethod.POST, value = "Reservation")
    @ResponseBody
    // metoda wykonuje POST do przesłania danych, usuwa wycieczki z których zrezygnował użytkownik
    public void doPostReservation(@RequestBody RemovedTours obj)
            throws SQLException
    {
        SQLiteDB query = new SQLiteDB();
            for(String id : obj.getRemovedReservation())
            {
                query.RemoveTourFromReservation(Integer.parseInt(id));
            }
        query.AddData(obj);
    }
}
