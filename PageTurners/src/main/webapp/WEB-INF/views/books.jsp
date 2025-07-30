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
        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .page-header h1 {
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            color: #2c3e50;
            margin-bottom: 1rem;
            position: relative;
        }
        
        .page-header h1::after {
            content: '';
            position: absolute;
            bottom: -10px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #9b59b6);
            border-radius: 2px;
        }
        
        .page-header p {
            font-size: 1.2rem;
            color: #7f8c8d;
            font-weight: 300;
        }
        
        .search-form input {
            background: white;
            border: 2px solid #e0e0e0;
            padding: 15px 20px;
            border-radius: 30px;
            font-size: 1rem;
            width: 400px;
            max-width: 100%;
            transition: all 0.3s ease;
        }
        
        .search-form input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .search-form .btn {
            border-radius: 30px;
            padding: 15px 30px;
        }
        
        .book-card .book-category {
            background: linear-gradient(135deg, #9b59b6, #8e44ad);
            color: white;
            padding: 6px 16px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        
        .book-card .book-description {
            color: #555;
            margin-bottom: 1.5rem;
            line-height: 1.6;
            font-size: 0.95rem;
        }
        
        .stock-info {
            font-size: 0.9rem;
            color: #27ae60;
            margin-bottom: 1rem;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .stock-info.out-of-stock {
            color: #e74c3c;
        }
        
        .stock-info::before {
            content: '✓';
            background: #27ae60;
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.7rem;
            font-weight: bold;
        }
        
        .stock-info.out-of-stock::before {
            content: '✗';
            background: #e74c3c;
        }
        
        .add-to-cart-form {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-top: auto;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .quantity-selector {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .quantity-selector label {
            font-weight: 600;
            color: #2c3e50;
            font-size: 0.9rem;
        }
        
        .quantity-selector select {
            padding: 8px 12px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            background: white;
            font-weight: 500;
            cursor: pointer;
        }
        
        .no-books {
            text-align: center;
            color: #7f8c8d;
            font-size: 1.3rem;
            grid-column: 1 / -1;
            padding: 4rem 2rem;
            background: white;
            border-radius: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .no-books::before {
            content: '📚';
            display: block;
            font-size: 4rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <div class="container">
            <div class="page-header">
                <h1>📚 Discover Your Next Great Read</h1>
                <p>Explore our curated collection of books across all genres</p>
            </div>
            
            <div class="search-filter-section">
                <form action="${pageContext.request.contextPath}/books" method="get" class="search-form">
                    <input type="text" name="search" value="${searchTerm}" placeholder="🔍 Search for books, authors, or genres...">
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
                <p class="stock-info ${book.stockQuantity <= 0 ? 'out-of-stock' : ''}">
                    <c:choose>
                        <c:when test="${book.stockQuantity > 0}">
                            ${book.stockQuantity} in stock
                        </c:when>
                        <c:otherwise>
                            Out of stock
                        </c:otherwise>
                    </c:choose>
                </p>                                <c:if test="${book.stockQuantity > 0}">
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