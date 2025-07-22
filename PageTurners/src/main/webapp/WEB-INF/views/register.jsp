<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PageTurners</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
        }
        
        .register-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
            width: 100%;
            max-width: 600px;
        }
        
        .logo {
            text-align: center;
            color: #2c3e50;
            font-size: 2rem;
            margin-bottom: 2rem;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        .form-group {
            margin-bottom: 1rem;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        label {
            display: block;
            margin-bottom: 0.5rem;
            color: #555;
            font-weight: 500;
        }
        
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .btn {
            width: 100%;
            padding: 12px;
            background-color: #3498db;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        
        .btn:hover {
            background-color: #2980b9;
        }
        
        .error-message {
            background-color: #f8d7da;
            color: #721c24;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 1rem;
            border: 1px solid #f5c6cb;
        }
        
        .links {
            text-align: center;
            margin-top: 1rem;
        }
        
        .links a {
            color: #3498db;
            text-decoration: none;
            margin: 0 10px;
        }
        
        .links a:hover {
            text-decoration: underline;
        }
        
        .required {
            color: #e74c3c;
        }
    </style>
</head>
<body>
    <div class="register-container">
        <h1 class="logo">📚 PageTurners</h1>
        <h2 style="text-align: center; margin-bottom: 2rem; color: #2c3e50;">Create Account</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        
        <form action="${pageContext.request.contextPath}/auth" method="post">
            <input type="hidden" name="action" value="register">
            
            <div class="form-row">
                <div class="form-group">
                    <label for="firstName">First Name <span class="required">*</span>:</label>
                    <input type="text" id="firstName" name="firstName" value="${param.firstName}" required>
                </div>
                
                <div class="form-group">
                    <label for="lastName">Last Name <span class="required">*</span>:</label>
                    <input type="text" id="lastName" name="lastName" value="${param.lastName}" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="username">Username <span class="required">*</span>:</label>
                <input type="text" id="username" name="username" value="${param.username}" required>
            </div>
            
            <div class="form-group">
                <label for="email">Email <span class="required">*</span>:</label>
                <input type="email" id="email" name="email" value="${param.email}" required>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="password">Password <span class="required">*</span>:</label>
                    <input type="password" id="password" name="password" required>
                    <small style="color: #666;">Minimum 6 characters</small>
                </div>
                
                <div class="form-group">
                    <label for="confirmPassword">Confirm Password <span class="required">*</span>:</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
            </div>
            
            <div class="form-group">
                <label for="address">Address:</label>
                <input type="text" id="address" name="address" value="${param.address}">
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="city">City:</label>
                    <input type="text" id="city" name="city" value="${param.city}">
                </div>
                
                <div class="form-group">
                    <label for="state">State:</label>
                    <input type="text" id="state" name="state" value="${param.state}">
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="zipCode">ZIP Code:</label>
                    <input type="text" id="zipCode" name="zipCode" value="${param.zipCode}">
                </div>
                
                <div class="form-group">
                    <label for="phone">Phone:</label>
                    <input type="tel" id="phone" name="phone" value="${param.phone}">
                </div>
            </div>
            
            <button type="submit" class="btn">Create Account</button>
        </form>
        
        <div class="links">
            <a href="${pageContext.request.contextPath}/auth?action=login">Already have an account? Login here</a>
            <br><br>
            <a href="${pageContext.request.contextPath}/">Back to Home</a>
        </div>
    </div>
</body>
</html>