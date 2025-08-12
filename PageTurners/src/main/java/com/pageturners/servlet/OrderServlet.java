package com.pageturners.servlet;

import com.pageturners.model.Order;
import com.pageturners.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
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
        doGet(request, response);
    }
}