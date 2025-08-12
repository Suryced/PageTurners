package com.pageturners.servlet;

import com.pageturners.model.Order;
import com.pageturners.model.User;
import com.pageturners.dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Order completedOrder = (Order) session.getAttribute("completedOrder");
        
        System.out.println("=== ORDER CONFIRMATION DEBUG ===");
        System.out.println("completedOrder in session: " + (completedOrder != null ? "FOUND (ID: " + completedOrder.getOrderId() + ")" : "NOT FOUND"));
        
        // If no completed order in session, try to get the most recent order for the user
        if (completedOrder == null) {
            User user = (User) session.getAttribute("user");
            System.out.println("User in session: " + (user != null ? "FOUND (ID: " + user.getUserId() + ")" : "NOT FOUND"));
            
            if (user != null) {
                try {
                    OrderDAO orderDAO = new OrderDAO();
                    // Get the user's most recent order
                    if (user.getOrders() != null && !user.getOrders().isEmpty()) {
                        completedOrder = user.getOrders().get(0); // Most recent order
                        session.setAttribute("completedOrder", completedOrder);
                        System.out.println("Using most recent order from user.orders: " + completedOrder.getOrderId());
                    } else {
                        // Try to fetch fresh orders from database
                        user.setOrders(orderDAO.getOrdersByUserId(user.getUserId()));
                        if (user.getOrders() != null && !user.getOrders().isEmpty()) {
                            completedOrder = user.getOrders().get(0);
                            session.setAttribute("completedOrder", completedOrder);
                            System.out.println("Fetched fresh orders, using most recent: " + completedOrder.getOrderId());
                        }
                    }
                } catch (Exception e) {
                    System.err.println("Error fetching user orders: " + e.getMessage());
                    e.printStackTrace();
                }
            }
        }
        
        // If still no order found, redirect to books page
        if (completedOrder == null) {
            System.out.println("No completed order found, redirecting to books");
            response.sendRedirect(request.getContextPath() + "/books");
            return;
        }
        
        System.out.println("Displaying order confirmation for order ID: " + completedOrder.getOrderId());
        System.out.println("==============================");
        request.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp").forward(request, response);
    }
}