<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.pageturners.model.Book" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="/PageTurners/css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h1>📚 Discover Your Next Great Read</h1>
                <p>Explore our curated collection of books across all genres</p>
            </div>
            
            <div class="search-filter-section">
                <form action="/PageTurners/books" method="get" class="search-form">
                    <input type="text" name="search" value="<%= request.getAttribute("searchTerm") != null ? request.getAttribute("searchTerm") : "" %>" placeholder="🔍 Search for books, authors, or genres..." class="search-input">
                    <button type="submit" class="search-btn">Search</button>
                </form>
                
                <div class="categories">
                    <a href="/PageTurners/books" 
                       class="category-btn <%= request.getAttribute("selectedCategory") == null ? "active" : "" %>">All Categories</a>
                    <%
                        @SuppressWarnings("unchecked")
                        List<String> categories = (List<String>) request.getAttribute("categories");
                        String selectedCategory = (String) request.getAttribute("selectedCategory");
                        if (categories != null) {
                            for (String category : categories) {
                                String activeClass = category.equals(selectedCategory) ? "active" : "";
                    %>
                        <a href="/PageTurners/books?category=<%= category %>" 
                           class="category-btn <%= activeClass %>"><%= category %></a>
                    <%
                            }
                        }
                    %>
                </div>
            </div>

            <div class="books-grid">
                <%
                    @SuppressWarnings("unchecked")
                    List<Book> books = (List<Book>) request.getAttribute("books");
                    if (books == null || books.isEmpty()) {
                %>
                    <p class="no-books">No books found matching your criteria.</p>
                <%
                    } else {
                        NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.US);
                        for (Book book : books) {
                %>
                    <div class="book-card">
                        <h3><%= book.getTitle() %></h3>
                        <p class="book-author">by <%= book.getAuthor() %></p>
                        <p class="book-category">Category: <%= book.getCategory() %></p>
                        <p class="book-price"><%= currencyFormat.format(book.getPrice()) %></p>
                        <p class="book-description"><%= book.getDescription() %></p>
                        <p class="book-stock">In Stock: <%= book.getStockQuantity() %></p>
                        
                        <form action="/PageTurners/cart" method="post" class="add-to-cart-form">
                            <input type="hidden" name="action" value="add">
                            <input type="hidden" name="bookId" value="<%= book.getBookId() %>">
                            <% if (book.getStockQuantity() > 0) { %>
                                <div class="quantity-controls">
                                    <label for="quantity_<%= book.getBookId() %>">Quantity:</label>
                                    <input type="number" id="quantity_<%= book.getBookId() %>" name="quantity" 
                                           value="1" min="1" max="<%= book.getStockQuantity() %>" class="quantity-input">
                                </div>
                                <button type="submit" class="btn btn-primary">Add to Cart</button>
                            <% } else { %>
                                <button class="btn btn-disabled" disabled>Out of Stock</button>
                            <% } %>
                        </form>
                    </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>
</html>