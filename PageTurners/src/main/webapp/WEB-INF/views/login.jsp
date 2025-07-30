<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="/PageTurners/css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main class="main-content">
        <div class="auth-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h1>🔑 Welcome Back</h1>
                    <p>Your gateway to endless literary adventures</p>
                </div>
                
                <c:if test="${not empty error}">
                    <div class="error-message">${error}</div>
                </c:if>
                
                <c:if test="${not empty success}">
                    <div class="success-message">${success}</div>
                </c:if>
                
                <form action="/PageTurners/auth" method="post" class="auth-form">
                    <input type="hidden" name="action" value="login">
                    
                    <div class="form-group">
                        <label for="username">Username:</label>
                        <input type="text" id="username" name="username" value="${param.username}" required>
                    </div>
                    
                    <div class="form-group">
                        <label for="password">Password:</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-full">Login</button>
                    
                    <div class="auth-footer">
                        <a href="/PageTurners/auth?action=register">Don't have an account? Register here</a>
                        <br><br>
                        <a href="/PageTurners/">Back to Home</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>