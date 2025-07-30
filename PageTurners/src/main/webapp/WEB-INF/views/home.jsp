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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            color: white;
            padding: 6rem 0;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .hero::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="40" r="1.5" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="80" r="1" fill="rgba(255,255,255,0.1)"/></svg>') repeat;
            animation: float 20s infinite linear;
        }
        
        .hero h1 {
            font-family: 'Playfair Display', serif;
            font-size: 4rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            position: relative;
            z-index: 1;
        }
        
        .hero p {
            font-size: 1.4rem;
            margin-bottom: 2.5rem;
            position: relative;
            z-index: 1;
            font-weight: 300;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .hero .btn {
            position: relative;
            z-index: 1;
            font-size: 1.1rem;
            padding: 16px 32px;
        }
        
        .featured-section {
            padding: 5rem 0;
            background: rgba(255,255,255,0.7);
        }
        
        .section-title {
            text-align: center;
            font-family: 'Playfair Display', serif;
            font-size: 3rem;
            font-weight: 600;
            margin-bottom: 1rem;
            color: #2c3e50;
            position: relative;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 4px;
            background: linear-gradient(90deg, #3498db, #9b59b6);
            border-radius: 2px;
        }
        
        .search-bar {
            display: flex;
            justify-content: center;
            margin: 3rem 0;
        }
        
        .search-bar form {
            display: flex;
            align-items: center;
            background: white;
            border-radius: 50px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            overflow: hidden;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }
        
        .search-bar form:focus-within {
            border-color: #3498db;
            box-shadow: 0 15px 40px rgba(52, 152, 219, 0.2);
        }
        
        .search-bar input {
            padding: 18px 25px;
            border: none;
            outline: none;
            font-size: 1.1rem;
            width: 450px;
            max-width: 100%;
            background: transparent;
        }
        
        .search-bar button {
            padding: 18px 30px;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border: none;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .search-bar button:hover {
            background: linear-gradient(135deg, #2980b9 0%, #1f5f8b 100%);
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
                <h1>📚 Welcome to PageTurners</h1>
                <p>Discover your next favorite book from our carefully curated collection of literary treasures</p>
                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">🔍 Browse Our Collection</a>
            </div>
        </section>

        <section class="featured-section">
            <div class="container">
                <h2 class="section-title">✨ Featured Books</h2>
                
                <div class="search-bar">
                    <form action="${pageContext.request.contextPath}/books" method="get">
                        <input type="text" name="search" placeholder="🔍 Search books by title, author, or description...">
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