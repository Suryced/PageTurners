<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PageTurners - Online Bookstore</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <a href="${pageContext.request.contextPath}/" class="logo">📚 PageTurners</a>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/">🏠 Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/books">📖 Browse Books</a></li>
                    <li><a href="${pageContext.request.contextPath}/cart?action=view">🛒 Cart</a></li>
                    <c:choose>
                        <c:when test="${sessionScope.user != null}">
                            <li class="welcome-user">✨ Welcome, ${sessionScope.user.firstName}!</li>
                            <li><a href="${pageContext.request.contextPath}/auth?action=logout">🚪 Logout</a></li>
                        </c:when>
                        <c:otherwise>
                            <li><a href="${pageContext.request.contextPath}/auth?action=login">🔑 Login</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth?action=register">📝 Register</a></li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </nav>
        </div>
    </header>
    <main>
        <div class="container">