<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
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
                    <input type="text" name="search" value="${searchTerm}" placeholder="🔍 Search for books, authors, or genres..." class="search-input">
                    <button type="submit" class="search-btn">Search</button>
                </form>
                
                <div class="categories">
                    <a href="/PageTurners/books" 
                       class="category-btn ${empty selectedCategory ? 'active' : ''}">All Categories</a>
                    <c:forEach var="category" items="${categories}">
                        <a href="/PageTurners/books?category=${category}" 
                           class="category-btn ${selectedCategory eq category ? 'active' : ''}">${category}</a>
                    </c:forEach>
                </div>
            </div>

            <div class="books-grid">
                <c:choose>
                    <c:when test="${empty books}">
                        <p class="no-books">No books found matching your criteria.</p>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="book" items="${books}">
                            <div class="book-card">
                                <h3>${book.title}</h3>
                                <p class="book-author">by ${book.author}</p>
                                <p class="book-category">Category: ${book.category}</p>
                                <p class="book-price"><fmt:formatNumber value="${book.price}" type="currency"/></p>
                                <p class="book-description">${book.description}</p>
                                <p class="book-stock">In Stock: ${book.stockQuantity}</p>
                                
                                <form action="/PageTurners/cart" method="post" class="add-to-cart-form">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="bookId" value="${book.bookId}">
                                    <c:if test="${book.inStock}">
                                        <div class="quantity-controls">
                                            <label for="quantity_${book.bookId}">Quantity:</label>
                                            <input type="number" id="quantity_${book.bookId}" name="quantity" 
                                                   value="1" min="1" max="${book.stockQuantity}" class="quantity-input">
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                                    </c:if>
                                    <c:if test="${!book.inStock}">
                                        <button class="btn btn-disabled" disabled>Out of Stock</button>
                                    </c:if>
                                </form>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>
</html>
