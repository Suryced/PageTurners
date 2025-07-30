<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="ssl-notice">
                🔒 Secure Checkout - Your information is protected with SSL encryption
            </div>
            
            <div class="page-header">
                <h1>Checkout</h1>
            </div>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <div class="checkout-container">
                <div class="checkout-section">
                    <h2 class="section-title">Shipping Information</h2>
                    
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm" class="checkout-form">
                        <div class="form-group">
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
        
        .checkout-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2.5rem;
        }
        
        .checkout-section {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.8);
        }
        
        .section-title {
            font-family: 'Playfair Display', serif;
            color: #2c3e50;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 3px solid transparent;
            background: linear-gradient(white, white) padding-box,
                       linear-gradient(90deg, #3498db, #9b59b6) border-box;
            border-bottom: 3px solid;
            font-size: 1.5rem;
            font-weight: 600;
        }
        
        .form-group {
            margin-bottom: 1.5rem;
        }
        
        label {
            display: block;
            margin-bottom: 0.8rem;
            color: #2c3e50;
            font-weight: 600;
            font-size: 0.95rem;
        }
        
        input[type="text"], input[type="email"] {
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
        
        input[type="text"]:focus, input[type="email"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
            transform: translateY(-2px);
        }
        
        input:focus {
            outline: none;
            border-color: #3498db;
        }
        
        .order-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .order-item:last-child {
            border-bottom: none;
        }
        
        .item-info h4 {
            color: #2c3e50;
            margin-bottom: 0.25rem;
        }
        
        .item-author {
            color: #7f8c8d;
            font-size: 0.9rem;
        }
        
        .item-price {
            color: #e74c3c;
            font-weight: bold;
        }
        
        .total-section {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid #3498db;
        }
        
        .total {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c3e50;
            text-align: right;
        }
        
        .btn-success {
            width: 100%;
            margin-top: 2rem;
        }
        
        .required {
            color: #e74c3c;
        }
        
        .ssl-notice {
            background-color: #d4edda;
            color: #155724;
            padding: 1rem;
            border-radius: 5px;
            margin-bottom: 2rem;
            border: 1px solid #c3e6cb;
            text-align: center;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <div class="container">
            <div class="ssl-notice">
                🔒 Secure Checkout - Your information is protected with SSL encryption
            </div>
            
            <h1>Checkout</h1>
            
            <c:if test="${not empty error}">
                <div class="error-message">${error}</div>
            </c:if>
            
            <div class="checkout-container">
                <div class="checkout-section">
                    <h2 class="section-title">Shipping Information</h2>
                    
                    <form action="${pageContext.request.contextPath}/checkout" method="post" id="checkoutForm">
                        <div class="form-group">
                            <label for="firstName">First Name:</label>
                            <input type="text" id="firstName" value="${sessionScope.user.firstName}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="lastName">Last Name:</label>
                            <input type="text" id="lastName" value="${sessionScope.user.lastName}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="email">Email:</label>
                            <input type="email" id="email" value="${sessionScope.user.email}" readonly>
                        </div>
                        
                        <div class="form-group">
                            <label for="shippingAddress">Address <span class="required">*</span>:</label>
                            <input type="text" id="shippingAddress" name="shippingAddress" 
                                   value="${sessionScope.user.address}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="shippingCity">City <span class="required">*</span>:</label>
                            <input type="text" id="shippingCity" name="shippingCity" 
                                   value="${sessionScope.user.city}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="shippingState">State <span class="required">*</span>:</label>
                            <input type="text" id="shippingState" name="shippingState" 
                                   value="${sessionScope.user.state}" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="shippingZip">ZIP Code <span class="required">*</span>:</label>
                            <input type="text" id="shippingZip" name="shippingZip" 
                                   value="${sessionScope.user.zipCode}" required>
                        </div>
                        
                        <button type="submit" class="btn btn-success">Place Order</button>
                    </form>
                </div>
                
                <div class="checkout-section">
                    <h2 class="section-title">Order Summary</h2>
                    
                    <c:set var="total" value="0" />
                    <c:forEach var="item" items="${sessionScope.cart}">
                        <div class="order-item">
                            <div class="item-info">
                                <h4>${item.book.title}</h4>
                                <p class="item-author">by ${item.book.author}</p>
                                <p>Quantity: ${item.quantity}</p>
                            </div>
                            <div class="item-price">
                                <fmt:formatNumber value="${item.subtotal}" type="currency"/>
                            </div>
                        </div>
                        <c:set var="total" value="${total + item.subtotal}" />
                    </c:forEach>
                    
                    <div class="total-section">
                        <div class="total">
                            Total: <fmt:formatNumber value="${total}" type="currency"/>
                        </div>
                    </div>
                </div>
            </div>
            
            <div style="text-align: center; margin-top: 2rem;">
                <a href="${pageContext.request.contextPath}/cart?action=view" class="btn btn-primary">Back to Cart</a>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>
</html>