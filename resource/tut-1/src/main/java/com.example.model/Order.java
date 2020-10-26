package com.example.model;

public class Order {
    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }

    public double getTotalPrice() { return pricePerUnit * this.quantity; }

    public final static double pricePerUnit = 9.55;

    public Order(String _customerName, String _customerEmail, Integer _quantity) {
        this.customerName = _customerName;
        this.customerEmail = _customerEmail;
        this.quantity = _quantity;
    }

    String customerName;
    String customerEmail;
    Integer quantity;
}