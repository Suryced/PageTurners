package com.pageturners.servlet;

import com.pageturners.dao.BookDAO;
import com.pageturners.dao.OrderDAO;
import com.pageturners.model.CartItem;
import com.pageturners.model.Order;
import com.pageturners.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    private OrderDAO orderDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
        orderDAO = new OrderDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        
        @SuppressWarnings("unchecked")
        List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart?action=view");
            return;
        }
        
        // Get shipping information from form
        String shippingAddress = request.getParameter("shippingAddress");
        String shippingCity = request.getParameter("shippingCity");
        String shippingState = request.getParameter("shippingState");
        String shippingZip = request.getParameter("shippingZip");
        
        // Validate shipping information
        if (shippingAddress == null || shippingAddress.trim().isEmpty() ||
            shippingCity == null || shippingCity.trim().isEmpty() ||
            shippingState == null || shippingState.trim().isEmpty() ||
            shippingZip == null || shippingZip.trim().isEmpty()) {
            
            request.setAttribute("error", "All shipping fields are required.");
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            return;
        }
        
        // Calculate total amount
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (CartItem item : cart) {
            totalAmount = totalAmount.add(item.getSubtotal());
        }
        
        // Create order
        Order order = new Order(user.getUserId(), totalAmount, 
                               shippingAddress.trim(), shippingCity.trim(), 
                               shippingState.trim(), shippingZip.trim());
        order.setOrderItems(cart);
        
        // Save order to database
        try {
            int generatedOrderId = orderDAO.saveOrder(order);
            order.setOrderId(generatedOrderId);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Failed to save order. Please try again.");
            request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
            return;
        }
        
        // Update stock quantities (in a real application)
        for (CartItem item : cart) {
            int newStock = item.getBook().getStockQuantity() - item.getQuantity();
            bookDAO.updateStock(item.getBook().getBookId(), newStock);
        }
        
        // Clear cart
        session.removeAttribute("cart");
        
        // Store order for confirmation page
        session.setAttribute("completedOrder", order);
        
        // Reload user's orders from database
        try {
            user.setOrders(orderDAO.getOrdersByUserId(user.getUserId()));
            session.setAttribute("user", user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        response.sendRedirect(request.getContextPath() + "/order-confirmation");
    }
}