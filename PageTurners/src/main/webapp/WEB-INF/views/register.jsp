<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PageTurners</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;600;700&family=Open+Sans:wght@300;400;500;600&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Open Sans', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            background-attachment: fixed;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem 0;
            position: relative;
            overflow-x: hidden;
        }
        
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="20" cy="20" r="2" fill="rgba(255,255,255,0.1)"/><circle cx="80" cy="40" r="1.5" fill="rgba(255,255,255,0.1)"/><circle cx="40" cy="80" r="1" fill="rgba(255,255,255,0.1)"/></svg>') repeat;
            animation: float 20s infinite linear;
        }
        
        @keyframes float {
            0% { transform: translateY(0px); }
            100% { transform: translateY(-100px); }
        }
        
        .register-container {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            padding: 3rem;
            border-radius: 25px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.15);
            width: 100%;
            max-width: 650px;
            border: 1px solid rgba(255,255,255,0.8);
            position: relative;
            z-index: 1;
        }
        
        .register-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 5px;
            background: linear-gradient(90deg, #3498db, #9b59b6, #e74c3c, #f39c12);
            border-radius: 25px 25px 0 0;
        }
        
        .logo {
            text-align: center;
            color: #2c3e50;
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.1);
        }
        
        .logo-subtitle {
            text-align: center;
            color: #7f8c8d;
            font-size: 1rem;
            margin-bottom: 2.5rem;
            font-weight: 300;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        .form-group.full-width {
            grid-column: 1 / -1;
        }
        
        label {
            display: block;
            margin-bottom: 0.8rem;
            color: #2c3e50;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        input[type="text"], input[type="email"], input[type="password"], input[type="tel"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e0e0e0;
            border-radius: 15px;
            font-size: 1rem;
            font-family: 'Open Sans', sans-serif;
            transition: all 0.3s ease;
            background: white;
            color: #2c3e50;
        }
        
        input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }
        
        .btn {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            color: white;
            border: none;
            border-radius: 15px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1rem;
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            position: relative;
            overflow: hidden;
        }
        
        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.3), transparent);
            transition: left 0.5s;
        }
        
        .btn:hover::before {
            left: 100%;
        }
        
        .btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(52, 152, 219, 0.6);
        }
        
        .error-message {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 1.5rem;
            border: 1px solid #f5c6cb;
            border-left: 5px solid #e74c3c;
            box-shadow: 0 2px 10px rgba(231, 76, 60, 0.1);
        }
        
        .links {
            text-align: center;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .links a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            margin: 0 10px;
        }
        
        .links a:hover {
            color: #2980b9;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
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
        <p class="logo-subtitle">Your gateway to endless literary adventures</p>
        <h2 style="text-align: center; margin-bottom: 2rem; color: #2c3e50; font-family: 'Playfair Display', serif; font-size: 1.8rem;">📝 Join Our Community</h2>
        
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