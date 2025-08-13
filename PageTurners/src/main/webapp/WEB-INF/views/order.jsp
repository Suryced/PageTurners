<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order History</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <main>
        <div class="container">
            <c:choose>
                <c:when test="${not empty order}">
                    <h1>Order Details</h1>
                    <p><strong>Order #:</strong> ${order.orderId}</p>
                    <p><strong>Date:</strong> ${order.orderDate}</p>
                    <p><strong>Total:</strong> $${order.totalAmount}</p>
                    <p><strong>Status:</strong> ${order.status}</p>
                    <p><strong>Shipping Address:</strong> ${order.shippingAddress}, ${order.shippingCity}, ${order.shippingState} ${order.shippingZip}</p>
                    <h2>Items</h2>
                    <ul>
                        <c:forEach var="item" items="${order.orderItems}">
                            <li>${item.book.title} - Qty: ${item.quantity} - $${item.book.price}</li>
                        </c:forEach>
                    </ul>
                    <p><a href="${pageContext.request.contextPath}/account">Back to Order History</a></p>
                </c:when>
                <c:otherwise>
                    <h1>Your Orders</h1>
                    <c:if test="${not empty sessionScope.user.orders}">
                        <ul>
                            <c:forEach var="order" items="${sessionScope.user.orders}">
                                <li>Order #${order.orderId} - ${order.orderDate} - $${order.totalAmount}</li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${empty sessionScope.user.orders}">
                        <p>You have no orders.</p>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    <%@ include file="footer.jsp" %>
</body>
</html>