<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books Debug - PageTurners</title>
</head>
<body>
    <h1>Books Debug Page</h1>
    
    <h2>Request Attributes:</h2>
    <p>Books attribute: ${books}</p>
    <p>Number of books: ${fn:length(books)}</p>
    <p>Categories: ${categories}</p>
    
    <h2>Books List:</h2>
    <c:choose>
        <c:when test="${empty books}">
            <p style="color: red;">No books found - books attribute is empty or null</p>
        </c:when>
        <c:otherwise>
            <ul>
                <c:forEach var="book" items="${books}" varStatus="status">
                    <li>
                        <strong>${status.index + 1}. ${book.title}</strong><br>
                        Author: ${book.author}<br>
                        Price: ${book.price}<br>
                        Category: ${book.category}<br>
                        Stock: ${book.stockQuantity}<br>
                        <hr>
                    </li>
                </c:forEach>
            </ul>
        </c:otherwise>
    </c:choose>
    
    <h2>Raw Data:</h2>
    <pre>
Books object: <%= request.getAttribute("books") %>
Categories: <%= request.getAttribute("categories") %>
    </pre>
    
    <p><a href="/PageTurners/books">Back to Books Page</a></p>
</body>
</html>
