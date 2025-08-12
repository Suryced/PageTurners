<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Account Information</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <main>
        <div class="container">
            <h1>Account Information</h1>
            <c:if test="${not empty sessionScope.user}">
                <div class="account-info">
                    <strong>Name:</strong> ${sessionScope.user.firstName} ${sessionScope.user.lastName}<br>
                    <strong>Email:</strong> ${sessionScope.user.email}<br>
                    <strong>Order History:</strong>
                    <ul>
                        <c:forEach var="order" items="${sessionScope.user.orders}">
                            <li>
                                <a href="${pageContext.request.contextPath}/order?orderId=${order.orderId}">
                                    Order #${order.orderId} - ${order.orderDate} - $${order.totalAmount}
                                </a>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </c:if>
            <c:if test="${empty sessionScope.user}">
                <p>You are not logged in. Please <a href="${pageContext.request.contextPath}/auth?action=login">login</a>.</p>
            </c:if>
        </div>
    </main>
    <%@ include file="footer.jsp" %>
</body>
</html>