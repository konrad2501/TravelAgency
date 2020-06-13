package com.example.projekt.model;

import java.util.List;

// Klasa zawiera pola dotyczące usuniętych wycieczek
public class RemovedTours {

    private List<String> removedReservation;
    public List<String> getRemovedReservation() { return removedReservation; }
    public void setRemovedReservation(List<String> removedReservation) { this.removedReservation = removedReservation; }

    private String email;
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    private String number;
    public int getNumber() { return Integer.parseInt(number); }
    public void setNumber(String number) { this.number = number; }
}
