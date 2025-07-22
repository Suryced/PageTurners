<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Browse Books - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .search-filter-section {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .search-form {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
            justify-content: center;
        }
        
        .search-form input {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            width: 300px;
        }
        
        .categories {
            display: flex;
            justify-content: center;
            gap: 1rem;
            flex-wrap: wrap;
        }
        
        .category-btn {
            padding: 8px 16px;
            background-color: #ecf0f1;
            color: #2c3e50;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s;
        }
        
        .category-btn:hover, .category-btn.active {
            background-color: #3498db;
            color: white;
        }
        
        .book-card .book-category {
            color: #3498db;
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }
        
        .book-card .book-description {
            color: #555;
            margin-bottom: 1rem;
            line-height: 1.5;
        }
        
        .stock-info {
            font-size: 0.9rem;
            color: #27ae60;
            margin-bottom: 1rem;
        }
        
        .add-to-cart-form {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .quantity-selector select {
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
        }
        
        .no-books {
            text-align: center;
            color: #7f8c8d;
            font-size: 1.2rem;
            grid-column: 1 / -1;
            padding: 2rem;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <div class="container">
            <h1>Browse Books</h1>
            
            <div class="search-filter-section">
                <form action="${pageContext.request.contextPath}/books" method="get" class="search-form">
                    <input type="text" name="search" value="${searchTerm}" placeholder="Search books...">
                    <button type="submit" class="btn">Search</button>
                </form>
                
                <div class="categories">
                    <a href="${pageContext.request.contextPath}/books" 
                       class="category-btn ${empty selectedCategory ? 'active' : ''}">All Categories</a>
                    <c:forEach var="category" items="${categories}">
                        <a href="${pageContext.request.contextPath}/books?category=${category}" 
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
                                <p class="stock-info">
                                    <c:choose>
                                        <c:when test="${book.stockQuantity > 0}">
                                            ${book.stockQuantity} in stock
                                        </c:when>
                                        <c:otherwise>
                                            Out of stock
                                        </c:otherwise>
                                    </c:choose>
                                </p>
                                
                                <c:if test="${book.stockQuantity > 0}">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" class="add-to-cart-form">
                                        <input type="hidden" name="action" value="add">
                                        <input type="hidden" name="bookId" value="${book.bookId}">
                                        <div class="quantity-selector">
                                            <label for="quantity-${book.bookId}">Quantity:</label>
                                            <select name="quantity" id="quantity-${book.bookId}">
                                                <c:forEach begin="1" end="${book.stockQuantity > 10 ? 10 : book.stockQuantity}" var="i">
                                                    <option value="${i}">${i}</option>
                                                </c:forEach>
                                            </select>
                                        </div>
                                        <button type="submit" class="btn btn-primary">Add to Cart</button>
                                    </form>
                                </c:if>
                                <c:if test="${book.stockQuantity <= 0}">
                                    <button class="btn btn-disabled" disabled>Out of Stock</button>
                                </c:if>
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