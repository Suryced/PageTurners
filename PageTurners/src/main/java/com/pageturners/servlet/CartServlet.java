package com.pageturners.servlet;

import com.pageturners.dao.BookDAO;
import com.pageturners.model.Book;
import com.pageturners.model.CartItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("view".equals(action) || action == null) {
            request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        if ("add".equals(action)) {
            addToCart(request, session);
        } else if ("update".equals(action)) {
            updateCart(request, session);
        } else if ("remove".equals(action)) {
            removeFromCart(request, session);
        }
        
        response.sendRedirect(request.getContextPath() + "/cart?action=view");
    }
    
    @SuppressWarnings("unchecked")
    private void addToCart(HttpServletRequest request, HttpSession session) {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            if (quantity <= 0) return;
            
            Book book = bookDAO.getBookById(bookId);
            if (book == null || !book.isInStock()) return;
            
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart == null) {
                cart = new ArrayList<>();
                session.setAttribute("cart", cart);
            }
            
            // Check if book is already in cart
            boolean found = false;
            for (CartItem item : cart) {
                if (item.getBook().getBookId() == bookId) {
                    int newQuantity = item.getQuantity() + quantity;
                    if (newQuantity <= book.getStockQuantity()) {
                        item.setQuantity(newQuantity);
                    }
                    found = true;
                    break;
                }
            }
            
            // If not found, add new item
            if (!found && quantity <= book.getStockQuantity()) {
                cart.add(new CartItem(book, quantity));
            }
            
        } catch (NumberFormatException e) {
            // Invalid parameters, ignore
        }
    }
    
    @SuppressWarnings("unchecked")
    private void updateCart(HttpServletRequest request, HttpSession session) {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null) {
                for (CartItem item : cart) {
                    if (item.getBook().getBookId() == bookId) {
                        if (quantity <= 0) {
                            cart.remove(item);
                        } else if (quantity <= item.getBook().getStockQuantity()) {
                            item.setQuantity(quantity);
                        }
                        break;
                    }
                }
            }
        } catch (NumberFormatException e) {
            // Invalid parameters, ignore
        }
    }
    
    @SuppressWarnings("unchecked")
    private void removeFromCart(HttpServletRequest request, HttpSession session) {
        try {
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            
            List<CartItem> cart = (List<CartItem>) session.getAttribute("cart");
            if (cart != null) {
                cart.removeIf(item -> item.getBook().getBookId() == bookId);
            }
        } catch (NumberFormatException e) {
            // Invalid parameters, ignore
        }
    }
}