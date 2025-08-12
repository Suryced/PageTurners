package com.pageturners.servlet;

import com.pageturners.model.Order;
import com.pageturners.model.User;
import com.pageturners.model.Book;
import com.pageturners.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.Arrays;

@WebServlet("/debug-redirect")
public class DebugRedirectServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        
        out.println("<html><head><title>Debug Redirect Test</title></head><body>");
        out.println("<h1>Debug Redirect Test</h1>");
        out.println("<p>This page tests the redirect functionality.</p>");
        
        // Show current session attributes
        out.println("<h2>Session Attributes:</h2>");
        out.println("<ul>");
        if (session.getAttribute("completedOrder") != null) {
            out.println("<li>completedOrder: FOUND</li>");
        } else {
            out.println("<li>completedOrder: NOT FOUND</li>");
        }
        if (session.getAttribute("user") != null) {
            out.println("<li>user: FOUND</li>");
        } else {
            out.println("<li>user: NOT FOUND</li>");
        }
        out.println("</ul>");
        
        // Add option to create fake order for testing
        String action = request.getParameter("action");
        if ("createFakeOrder".equals(action)) {
            Order fakeOrder = createFakeOrder();
            session.setAttribute("completedOrder", fakeOrder);
            out.println("<div style='background-color: #d4edda; padding: 10px; margin: 10px 0; border-radius: 5px;'>");
            out.println("<strong>✅ Fake order created and stored in session!</strong><br>");
            out.println("Order ID: " + fakeOrder.getOrderId() + "<br>");
            out.println("Total: $" + fakeOrder.getTotalAmount());
            out.println("</div>");
        }
        
        // Test redirect to order-confirmation
        out.println("<h2>Test Actions:</h2>");
        out.println("<a href='" + request.getContextPath() + "/debug-redirect?action=createFakeOrder' style='background-color: #007bff; color: white; padding: 10px; text-decoration: none; border-radius: 5px; margin: 5px;'>Create Fake Order in Session</a><br><br>");
        out.println("<a href='" + request.getContextPath() + "/order-confirmation' style='background-color: #28a745; color: white; padding: 10px; text-decoration: none; border-radius: 5px; margin: 5px;'>Test redirect to order-confirmation</a><br><br>");
        out.println("<a href='" + request.getContextPath() + "/order' style='background-color: #dc3545; color: white; padding: 10px; text-decoration: none; border-radius: 5px; margin: 5px;'>Test redirect to order (list)</a><br>");
        
        out.println("</body></html>");
    }
    
    private Order createFakeOrder() {
        Order order = new Order();
        order.setOrderId(99999); // Fake order ID
        order.setUserId(1);
        order.setOrderDate(LocalDateTime.now());
        order.setStatus("Confirmed");
        order.setTotalAmount(new BigDecimal("25.98"));
        order.setShippingAddress("123 Test Street");
        order.setShippingCity("Test City");
        order.setShippingState("TS");
        order.setShippingZip("12345");
        
        // Create fake book and cart item
        Book book = new Book();
        book.setBookId(1);
        book.setTitle("Test Book");
        book.setAuthor("Test Author");
        book.setPrice(new BigDecimal("25.98"));
        
        CartItem item = new CartItem();
        item.setBook(book);
        item.setQuantity(1);
        
        order.setOrderItems(Arrays.asList(item));
        
        return order;
    }
}