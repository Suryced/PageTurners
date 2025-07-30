package com.pageturners.servlet;

import com.pageturners.dao.BookDAO;
import com.pageturners.model.Book;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get featured books (first 6 books for homepage display)
        List<Book> featuredBooks = bookDAO.getAllBooks();
        if (featuredBooks.size() > 6) {
            featuredBooks = featuredBooks.subList(0, 6);
        }
        
        request.setAttribute("featuredBooks", featuredBooks);
        request.setAttribute("categories", bookDAO.getCategories());
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
}