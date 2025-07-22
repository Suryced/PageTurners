<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PageTurners - Online Bookstore</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 4rem 0;
            text-align: center;
        }
        
        .hero h1 {
            font-size: 3rem;
            margin-bottom: 1rem;
        }
        
        .hero p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
        }
        
        .featured-section {
            padding: 4rem 0;
        }
        
        .section-title {
            text-align: center;
            font-size: 2.5rem;
            margin-bottom: 3rem;
            color: #2c3e50;
        }
        
        .categories {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin: 2rem 0;
            flex-wrap: wrap;
        }
        
        .category-btn {
            padding: 8px 16px;
            background-color: #ecf0f1;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 20px;
            transition: background-color 0.3s;
        }
        
        .category-btn:hover {
            background-color: #3498db;
            color: white;
        }
        
        .search-bar {
            display: flex;
            margin: 2rem 0;
            justify-content: center;
        }
        
        .search-bar input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px 0 0 5px;
            width: 300px;
        }
        
        .search-bar button {
            padding: 10px 20px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 0 5px 5px 0;
            cursor: pointer;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <section class="hero">
            <div class="container">
                <h1>Welcome to PageTurners</h1>
                <p>Discover your next favorite book from our extensive collection</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">Browse Books</a>
            </div>
        </section>

        <section class="featured-section">
            <div class="container">
                <h2 class="section-title">Featured Books</h2>
                
                <div class="search-bar">
                    <form action="${pageContext.request.contextPath}/books" method="get">
                        <input type="text" name="search" placeholder="Search books by title, author, or description...">
                        <button type="submit">Search</button>
                    </form>
                </div>

                <div class="categories">
                    <a href="${pageContext.request.contextPath}/books" class="category-btn">All Books</a>
                    <c:forEach var="category" items="${categories}">
                        <a href="${pageContext.request.contextPath}/books?category=${category}" class="category-btn">${category}</a>
                    </c:forEach>
                </div>

                <div class="books-grid">
                    <c:forEach var="book" items="${featuredBooks}">
                        <div class="book-card">
                            <h3>${book.title}</h3>
                            <p class="book-author">by ${book.author}</p>
                            <p class="book-price"><fmt:formatNumber value="${book.price}" type="currency"/></p>
                            <p class="book-description">${book.description}</p>
                            <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="bookId" value="${book.bookId}">
                                <input type="hidden" name="quantity" value="1">
                                <c:if test="${book.inStock}">
                                    <button type="submit" class="btn">Add to Cart</button>
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