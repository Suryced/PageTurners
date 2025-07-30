<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .page-header {
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
        
        .cart-container {
            background: linear-gradient(145deg, #ffffff 0%, #f8f9fa 100%);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: 1px solid rgba(255,255,255,0.8);
        }
        
        .cart-item {
            display: grid;
            grid-template-columns: 3fr 2fr 1fr 1fr;
            gap: 1.5rem;
            align-items: center;
            padding: 1.5rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.1);
            position: relative;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .cart-item:hover {
            background: rgba(52, 152, 219, 0.05);
            border-radius: 10px;
            margin: 0 -1rem;
            padding-left: 2.5rem;
            padding-right: 2.5rem;
        }
        
        .book-info h3 {
            font-family: 'Playfair Display', serif;
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-size: 1.3rem;
        }
        
        .book-info .author {
            color: #7f8c8d;
            font-style: italic;
            margin-bottom: 0.5rem;
        }
        
        .book-info .price {
            color: #e74c3c;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 0.8rem;
            background: white;
            padding: 0.5rem;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        
        .quantity-input {
            width: 60px;
            padding: 8px;
            border: 2px solid #e0e0e0;
            border-radius: 8px;
            text-align: center;
            font-weight: 600;
            background: white;
        }
        
        .quantity-input:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52, 152, 219, 0.1);
        }
        
        .remove-btn {
            background: linear-gradient(135deg, #e74c3c, #c0392b);
            color: white;
            border: none;
            padding: 8px 12px;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 600;
        }
        
        .remove-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(231, 76, 60, 0.4);
        }
        
        .cart-summary {
            margin-top: 2.5rem;
            padding-top: 2rem;
            border-top: 2px solid rgba(52, 152, 219, 0.2);
            text-align: right;
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .total {
            font-family: 'Playfair Display', serif;
            font-size: 2rem;
            font-weight: 700;
            color: #2c3e50;
            margin-bottom: 2rem;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.1);
        }
        
        .empty-cart {
            text-align: center;
            padding: 5rem 2rem;
            color: #7f8c8d;
        }
        
        .empty-cart::before {
            content: '🛒';
            display: block;
            font-size: 5rem;
            margin-bottom: 2rem;
        }
        
        .empty-cart h2 {
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            margin-bottom: 1rem;
            color: #2c3e50;
        }
        
        .empty-cart p {
            font-size: 1.2rem;
            margin-bottom: 2rem;
            color: #7f8c8d;
        }
        
        .actions {
            display: flex;
            gap: 1rem;
            justify-content: space-between;
            align-items: center;
            margin-top: 2rem;
            flex-wrap: wrap;
        }
        
        .continue-shopping {
            color: #3498db;
            text-decoration: none;
            font-weight: 600;
            transition: all 0.3s ease;
        }
        
        .continue-shopping:hover {
            color: #2980b9;
            transform: translateX(-5px);
        }
        
        .checkout-btn {
            background: linear-gradient(135deg, #27ae60, #229954);
            font-size: 1.1rem;
            padding: 16px 32px;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <div class="container">
            <div class="page-header">
                <h1>🛒 Your Shopping Cart</h1>
            </div>
            
            <div class="cart-container">
                <c:choose>
                    <c:when test="${empty sessionScope.cart}">
                        <div class="empty-cart">
                            <h2>Your cart is empty</h2>
                            <p>Browse our amazing collection and add some books to your cart!</p>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">📚 Browse Books</a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:set var="total" value="0" />
                        <div class="cart-item" style="font-weight: bold; border-bottom: 2px solid #ddd;">
                            <div>Book</div>
                            <div>Quantity</div>
                            <div>Subtotal</div>
                            <div>Action</div>
                        </div>
                        <c:forEach var="item" items="${sessionScope.cart}">
                            <div class="cart-item">
                                <div class="book-info">
                                    <h3>${item.book.title}</h3>
                                    <p class="book-author">by ${item.book.author}</p>
                                    <p><fmt:formatNumber value="${item.book.price}" type="currency"/> each</p>
                                </div>
                                
                                <div class="quantity-control">
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="bookId" value="${item.book.bookId}">
                                        <input type="number" name="quantity" value="${item.quantity}" 
                                               min="1" max="${item.book.stockQuantity}" class="quantity-input">
                                        <button type="submit" class="btn btn-primary">Update</button>
                                    </form>
                                </div>
                                
                                <div>
                                    <fmt:formatNumber value="${item.subtotal}" type="currency"/>
                                </div>
                                
                                <div>
                                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove">
                                        <input type="hidden" name="bookId" value="${item.book.bookId}">
                                        <button type="submit" class="btn btn-danger">Remove</button>
                                    </form>
                                </div>
                            </div>
                            <c:set var="total" value="${total + item.subtotal}" />
                        </c:forEach>
                        
                        <div class="cart-summary">
                            <div class="total">
                                Total: <fmt:formatNumber value="${total}" type="currency"/>
                            </div>
                            
                            <div class="actions">
                                <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">Continue Shopping</a>
                                
                                <c:choose>
                                    <c:when test="${sessionScope.user != null}">
                                        <a href="${pageContext.request.contextPath}/checkout" class="btn btn-success">Proceed to Checkout</a>
                                    </c:when>
                                    <c:otherwise>
                                        <div>
                                            <p style="margin-bottom: 1rem;">Please log in to checkout</p>
                                            <a href="${pageContext.request.contextPath}/auth?action=login" class="btn btn-success">Login to Checkout</a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <%@ include file="footer.jsp" %>
</body>
</html>