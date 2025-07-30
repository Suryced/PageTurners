<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmation - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <main class="main-content">
        <div class="container">
            <div class="confirmation-container">
                <div class="success-icon">✅</div>
                <h1>Order Confirmed!</h1>
                <p class="confirmation-message">Thank you for your order! Your books are being prepared for shipment.</p>
            background: white;
            border-radius: 10px;
            padding: 3rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            text-align: center;
        }
        
        .success-icon {
            font-size: 4rem;
            color: #27ae60;
            margin-bottom: 1rem;
        }
        
        h1 {
            color: #2c3e50;
            margin-bottom: 1rem;
        }
        
        .order-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 2rem;
            margin: 2rem 0;
            text-align: left;
        }
        
        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }
        
        .detail-label {
            font-weight: bold;
            color: #2c3e50;
        }
        
        .order-items {
            margin-top: 2rem;
        }
        
        .item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .item:last-child {
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
        
        .total-row {
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 2px solid #3498db;
            font-size: 1.2rem;
            font-weight: bold;
            color: #2c3e50;
        }
        
        .shipping-info {
            background-color: #e8f4fd;
            border-left: 4px solid #3498db;
            padding: 1rem;
            margin: 2rem 0;
            text-align: left;
        }
        
        .shipping-info h3 {
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .email-simulation {
            background-color: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 1rem;
            margin: 2rem 0;
            color: #856404;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <div class="container">
            <div class="confirmation-container">
                <div class="success-icon">✅</div>
                <h1>Order Confirmed!</h1>
                <p>Thank you for your order. Your books will be shipped to you soon.</p>
                
                <div class="email-simulation">
                    📧 <strong>Email Confirmation Simulation:</strong> A confirmation email would be sent to ${sessionScope.user.email} with order details and tracking information.
                </div>
                
                <div class="order-details">
                    <div class="detail-row">
                        <span class="detail-label">Order Number:</span>
                        <span>#${sessionScope.completedOrder.orderId}</span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Order Date:</span>
                        <span><fmt:formatDate value="${sessionScope.completedOrder.orderDate}" pattern="MMM dd, yyyy HH:mm"/></span>
                    </div>
                    <div class="detail-row">
                        <span class="detail-label">Status:</span>
                        <span>${sessionScope.completedOrder.status}</span>
                    </div>
                    
                    <div class="shipping-info">
                        <h3>Shipping Address:</h3>
                        <p>${sessionScope.user.fullName}</p>
                        <p>${sessionScope.completedOrder.shippingAddress}</p>
                        <p>${sessionScope.completedOrder.shippingCity}, ${sessionScope.completedOrder.shippingState} ${sessionScope.completedOrder.shippingZip}</p>
                    </div>
                    
                    <div class="order-items">
                        <h3 style="margin-bottom: 1rem; color: #2c3e50;">Items Ordered:</h3>
                        <c:forEach var="item" items="${sessionScope.completedOrder.orderItems}">
                            <div class="item">
                                <div class="item-info">
                                    <h4>${item.book.title}</h4>
                                    <p class="item-author">by ${item.book.author}</p>
                                    <p>Quantity: ${item.quantity}</p>
                                </div>
                                <div>
                                    <fmt:formatNumber value="${item.subtotal}" type="currency"/>
                                </div>
                            </div>
                        </c:forEach>
                        
                        <div class="detail-row total-row">
                            <span class="detail-label">Total Amount:</span>
                            <span><fmt:formatNumber value="${sessionScope.completedOrder.totalAmount}" type="currency"/></span>
                        </div>
                    </div>
                </div>
                
                <div>
                    <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">Continue Shopping</a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-success">Back to Home</a>
                </div>
            </div>
        </div>
    </main>
    
    <%@ include file="footer.jsp" %>
</body>
</html>