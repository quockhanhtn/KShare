package com.example.controller;

import com.example.model.Order;

import java.io.IOException;
import java.lang.NumberFormatException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/order-reply")
public class OrderSevlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        boolean orderSuccess = true;
        String errorMessage = "";

        String orderQuantity = request.getParameter("order-quantity");
        String customerName = request.getParameter("customer-name");
        String customerEmail = request.getParameter("customer-email");

        Integer quantity;
        try { quantity = Integer.parseInt(orderQuantity); }
        catch (NumberFormatException e) { quantity = 0; }

        if (quantity <= 0) {
            orderSuccess = false;
            errorMessage = " - Quantity must be greater than or equal 1<br>";
        }
        if (customerName.trim().isEmpty()) {
            orderSuccess = false;
            errorMessage += "- You must enter your name !<br>";
        }
        if (customerEmail.trim().isEmpty()) {
            orderSuccess = false;
            errorMessage += "- You must enter your email to verify !<br>";
        }

        if (orderSuccess) {
            Order orderDetail = new Order(customerName, customerEmail, quantity);
            request.setAttribute("orderDetail", orderDetail);
            request.setAttribute("pricePerUnit", Order.pricePerUnit);

            RequestDispatcher rd = request.getRequestDispatcher("order-success.jsp");
            rd.forward(request, response);
        } else {
            request.setAttribute("errorMessage", errorMessage);

            RequestDispatcher rd = request.getRequestDispatcher("order-error.jsp");
            rd.forward(request, response);
        }
    }
}

