package com.pageturners.servlet;

import com.pageturners.model.Order;
import com.pageturners.model.User;
import com.pageturners.model.CartItem;
import com.pageturners.dao.OrderDAO;
import com.pageturners.util.EmailService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/order")
public class OrderServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderIdParam = request.getParameter("orderId");
        if (orderIdParam != null) {
            try {
                int orderId = Integer.parseInt(orderIdParam);
                User user = (User) request.getSession().getAttribute("user");
                if (user != null && user.getOrders() != null) {
                    for (Order order : user.getOrders()) {
                        if (order.getOrderId() == orderId) {
                            request.setAttribute("order", order);
                            break;
                        }
                    }
                }
            } catch (NumberFormatException e) {
                // Invalid orderId, ignore and show all orders
            }
        }
        request.getRequestDispatcher("/WEB-INF/views/order.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        // Check if user is logged in and has items in cart
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        try {
            // Get form data
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String city = request.getParameter("city");
            String state = request.getParameter("state");
            String zip = request.getParameter("zip");
            
            // Calculate total
            BigDecimal total = cart.stream()
                .map(CartItem::getSubtotal)
                .reduce(BigDecimal.ZERO, BigDecimal::add);
            
            // Create order
            Order order = new Order(user.getUserId(), total, address, city, state, zip);
            order.setOrderItems(cart);
            
            // Save order to database
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.saveOrder(order);
            order.setOrderId(orderId);
            
            // Send order confirmation email
            try {
                EmailService emailService = new EmailService();
                boolean emailSent = emailService.sendOrderConfirmationEmail(user, order);
                if (emailSent) {
                    System.out.println("Order confirmation email sent successfully to: " + user.getEmail());
                } else {
                    System.err.println("Failed to send order confirmation email to: " + user.getEmail());
                }
            } catch (Exception emailError) {
                System.err.println("Error initializing email service or sending email: " + emailError.getMessage());
                emailError.printStackTrace();
                // Continue with order processing even if email fails
            }
            
            // Store completed order in session for confirmation page
            session.setAttribute("completedOrder", order);
            
            // Clear the cart
            session.removeAttribute("cart");
            
            // Update user's orders list
            if (user.getOrders() != null) {
                user.getOrders().add(0, order); // Add to beginning of list
            } else {
                user.setOrders(orderDAO.getOrdersByUserId(user.getUserId()));
            }
            
            // Redirect to order confirmation page
            response.sendRedirect(request.getContextPath() + "/order-confirmation");
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "An error occurred while processing your order. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
        }
    }
}