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
        .cart-container {
            background: white;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        
        .cart-item {
            display: grid;
            grid-template-columns: 3fr 2fr 1fr 1fr;
            gap: 1rem;
            align-items: center;
            padding: 1rem 0;
            border-bottom: 1px solid #eee;
        }
        
        .cart-item:last-child {
            border-bottom: none;
        }
        
        .book-info h3 {
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }
        
        .quantity-control {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        
        .quantity-input {
            width: 60px;
            padding: 5px;
            border: 1px solid #ddd;
            border-radius: 3px;
            text-align: center;
        }
        
        .cart-summary {
            margin-top: 2rem;
            padding-top: 2rem;
            border-top: 2px solid #eee;
            text-align: right;
        }
        
        .total {
            font-size: 1.5rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 2rem;
        }
        
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            color: #7f8c8d;
        }
        
        .empty-cart h2 {
            margin-bottom: 1rem;
        }
        
        .actions {
            display: flex;
            gap: 1rem;
            justify-content: space-between;
            align-items: center;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>

    <main>
        <div class="container">
            <h1>Shopping Cart</h1>
            
            <div class="cart-container">
                <c:choose>
                    <c:when test="${empty sessionScope.cart}">
                        <div class="empty-cart">
                            <h2>Your cart is empty</h2>
                            <p>Browse our collection and add some books to your cart!</p>
                            <a href="${pageContext.request.contextPath}/books" class="btn btn-primary">Browse Books</a>
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