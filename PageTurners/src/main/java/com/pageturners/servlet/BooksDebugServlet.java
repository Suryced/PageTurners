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

@WebServlet("/books-debug")
public class BooksDebugServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BookDAO bookDAO;
    
    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("BooksDebugServlet.doGet() called");
        
        try {
            List<Book> books = bookDAO.getAllBooks();
            System.out.println("Debug: Books retrieved: " + (books != null ? books.size() : "null"));
            
            if (books != null) {
                for (Book book : books) {
                    System.out.println("Debug: Book - " + book.getTitle() + " by " + book.getAuthor());
                }
            }
            
            request.setAttribute("books", books);
            request.setAttribute("categories", bookDAO.getCategories());
            
            System.out.println("Debug: Forwarding to books-debug.jsp");
            request.getRequestDispatcher("/WEB-INF/views/books-debug.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Debug: Error in BooksDebugServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Debug error: " + e.getMessage());
        }
    }
}
