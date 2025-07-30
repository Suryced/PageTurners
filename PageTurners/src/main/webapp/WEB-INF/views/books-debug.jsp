<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pageturners.model.Book" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books Debug - PageTurners</title>
</head>
<body>
    <h1>Books Debug Page</h1>
    
    <h2>Request Attributes:</h2>
    <%
        List<Book> books = (List<Book>) request.getAttribute("books");
        List<String> categories = (List<String>) request.getAttribute("categories");
    %>
    <p>Books attribute: <%= books %></p>
    <p>Number of books: <%= books != null ? books.size() : 0 %></p>
    <p>Categories: <%= categories %></p>
    
    <h2>Books List:</h2>
    <%
        if (books == null || books.isEmpty()) {
    %>
        <p style="color: red;">No books found - books attribute is empty or null</p>
    <%
        } else {
    %>
        <ul>
            <%
                for (int i = 0; i < books.size(); i++) {
                    Book book = books.get(i);
            %>
                <li>
                    <strong><%= (i + 1) %>. <%= book.getTitle() %></strong><br>
                    Author: <%= book.getAuthor() %><br>
                    Price: <%= book.getPrice() %><br>
                    Category: <%= book.getCategory() %><br>
                    Stock: <%= book.getStockQuantity() %><br>
                    <hr>
                </li>
            <%
                }
            %>
        </ul>
    <%
        }
    %>
    
    <h2>Raw Data:</h2>
    <pre>
Books object: <%= request.getAttribute("books") %>
Categories: <%= request.getAttribute("categories") %>
    </pre>
    
    <p><a href="${pageContext.request.contextPath}/books">Back to Books Page</a></p>
</body>
</html>