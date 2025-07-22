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

@WebServlet("/books")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String category = request.getParameter("category");
        String search = request.getParameter("search");
        
        List<Book> books;
        
        if (search != null && !search.trim().isEmpty()) {
            books = bookDAO.searchBooks(search.trim());
            request.setAttribute("searchTerm", search.trim());
        } else if (category != null && !category.trim().isEmpty()) {
            books = bookDAO.getBooksByCategory(category);
            request.setAttribute("selectedCategory", category);
        } else {
            books = bookDAO.getAllBooks();
        }
        
        request.setAttribute("books", books);
        request.setAttribute("categories", bookDAO.getCategories());
        request.getRequestDispatcher("/WEB-INF/views/books.jsp").forward(request, response);
    }
}