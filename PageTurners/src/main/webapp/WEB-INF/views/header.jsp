<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<header>
    <div class="container">
        <nav>
            <a href="${pageContext.request.contextPath}/home" class="logo">PageTurners</a>
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                <li><a href="${pageContext.request.contextPath}/books">Browse Books</a></li>
                <li><a href="${pageContext.request.contextPath}/cart?action=view">Cart</a></li>
                <c:choose>
                    <c:when test="${not empty sessionScope.user}">
                        <!-- User is logged in -->
                        <li><a href="${pageContext.request.contextPath}/account">Account</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth?action=logout">Logout</a></li>
                    </c:when>
                    <c:otherwise>
                        <!-- User is not logged in -->
                        <li><a href="${pageContext.request.contextPath}/auth?action=login">Login</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth?action=register">Register</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </nav>
    </div>
</header>