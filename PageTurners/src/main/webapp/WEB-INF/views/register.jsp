<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>
<body>
    <%@ include file="header.jsp" %>
    
    <main class="main-content auth-body">
        <div class="auth-container register-container">
            <div class="auth-card">
                <div class="auth-header">
                    <h1>📝 Join PageTurners</h1>
                    <p>Create your account and start your literary journey</p>
                </div>
                
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null && !error.isEmpty()) {
                %>
                    <div class="error-message"><%= error %></div>
                <%
                    }
                    
                    String success = (String) request.getAttribute("success");
                    if (success != null && !success.isEmpty()) {
                %>
                    <div class="success-message"><%= success %></div>
                <%
                    }
                %>
                
                <form action="${pageContext.request.contextPath}/auth" method="post" class="auth-form">
                    <input type="hidden" name="action" value="register">
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="firstName">First Name: *</label>
                            <input type="text" id="firstName" name="firstName" 
                                   value="<%= request.getParameter("firstName") != null ? request.getParameter("firstName") : "" %>" 
                                   required>
                        </div>
                        
                        <div class="form-group">
                            <label for="lastName">Last Name: *</label>
                            <input type="text" id="lastName" name="lastName" 
                                   value="<%= request.getParameter("lastName") != null ? request.getParameter("lastName") : "" %>" 
                                   required>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">Email Address: *</label>
                        <input type="email" id="email" name="email" 
                               value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" 
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label for="username">Username: *</label>
                        <input type="text" id="username" name="username" 
                               value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" 
                               required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="password">Password: *</label>
                            <input type="password" id="password" name="password" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="confirmPassword">Confirm Password: *</label>
                            <input type="password" id="confirmPassword" name="confirmPassword" required>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>📍 Shipping Information (Optional)</h3>
                        <p class="form-note">You can add this information later in your profile</p>
                        
                        <div class="form-group">
                            <label for="address">Street Address:</label>
                            <input type="text" id="address" name="address" 
                                   value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>">
                        </div>
                        
                        <div class="form-row">
                            <div class="form-group">
                                <label for="city">City:</label>
                                <input type="text" id="city" name="city" 
                                       value="<%= request.getParameter("city") != null ? request.getParameter("city") : "" %>">
                            </div>
                            
                            <div class="form-group">
                                <label for="state">State:</label>
                                <input type="text" id="state" name="state" 
                                       value="<%= request.getParameter("state") != null ? request.getParameter("state") : "" %>">
                            </div>
                            
                            <div class="form-group">
                                <label for="zipCode">ZIP Code:</label>
                                <input type="text" id="zipCode" name="zipCode" 
                                       value="<%= request.getParameter("zipCode") != null ? request.getParameter("zipCode") : "" %>">
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="phone">Phone Number:</label>
                            <input type="tel" id="phone" name="phone" 
                                   value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>">
                        </div>
                    </div>
                    
                    <button type="submit" class="btn btn-primary btn-full">Create Account</button>
                    
                    <div class="auth-footer">
                        <a href="${pageContext.request.contextPath}/auth?action=login">Already have an account? Login here</a>
                        <br><br>
                        <a href="${pageContext.request.contextPath}/home">Back to Home</a>
                    </div>
                </form>
            </div>
        </div>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>