<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<header>
    <div class="container">
        <nav>
            <a href="/PageTurners/" class="logo">📚 PageTurners</a>
            <ul class="nav-links">
                <li><a href="/PageTurners/">🏠 Home</a></li>
                <li><a href="/PageTurners/books">📖 Browse Books</a></li>
                <li><a href="/PageTurners/cart?action=view">🛒 Cart</a></li>
                <c:choose>
                    <c:when test="${sessionScope.user != null}">
                        <li class="welcome-user">✨ Welcome, ${sessionScope.user.firstName}!</li>
                        <li><a href="/PageTurners/auth?action=logout">🚪 Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/PageTurners/auth?action=login">🔑 Login</a></li>
                        <li><a href="/PageTurners/auth?action=register">📝 Register</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</header>