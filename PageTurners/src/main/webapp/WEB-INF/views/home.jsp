<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PageTurners - Online Bookstore</title>
    <link rel="stylesheet" type="text/css" href="/PageTurners/css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main class="main-content">
        <section class="hero-section">
            <div class="hero-content">
                <h1 class="hero-title">📚 Welcome to PageTurners</h1>
                <p class="hero-subtitle">Discover your next favorite book from our carefully curated collection of literary treasures</p>
                <a href="/PageTurners/books" class="hero-btn">🔍 Browse Our Collection</a>
            </div>
        </section>

        <section class="featured-section">
            <div class="container">
                <div class="section-header">
                    <h2>✨ Featured Books</h2>
                </div>
                
                <div class="search-bar-container">
                    <form action="/PageTurners/books" method="get" class="search-form">
                        <input type="text" name="search" placeholder="🔍 Search books by title, author, or description..." class="search-input">
                        <button type="submit" class="search-btn">Search</button>
                    </form>
                </div>

                <div class="categories">
                    <a href="/PageTurners/books" class="category-btn">All Books</a>
                    <c:forEach var="category" items="${categories}">
                        <a href="/PageTurners/books?category=${category}" class="category-btn">${category}</a>
                    </c:forEach>
                </div>

                <div class="featured-grid">
                    <c:forEach var="book" items="${featuredBooks}">
                        <div class="book-card">
                            <h3 class="book-title">${book.title}</h3>
                            <p class="book-author">by ${book.author}</p>
                            <p class="book-price"><fmt:formatNumber value="${book.price}" type="currency"/></p>
                            <p class="book-description">${book.description}</p>
                            <form action="/PageTurners/cart" method="post" class="add-to-cart-form">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="bookId" value="${book.bookId}">
                                <input type="hidden" name="quantity" value="1">
                                <c:if test="${book.inStock}">
                                    <button type="submit" class="btn btn-primary">Add to Cart</button>
                                </c:if>
                                <c:if test="${!book.inStock}">
                                    <button class="btn btn-disabled" disabled>Out of Stock</button>
                                </c:if>
                            </form>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="footer.jsp" %>
</body>
</html>