<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="/PageTurners/css/styles.css">
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