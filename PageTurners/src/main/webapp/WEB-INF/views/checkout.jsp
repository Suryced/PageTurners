<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout - PageTurners</title>
    <link rel="stylesheet" type="text/css" href="/PageTurners/css/styles.css">
    <script>
    function formatCardNumber(input) {
        let value = input.value.replace(/\D/g, '');
        let formatted = value.replace(/(.{4})/g, '$1 ').trim();
        input.value = formatted;
    }
    function stripCardNumberOnSubmit(form) {
        var cardInput = form.querySelector('#card');
        if (cardInput) {
            cardInput.value = cardInput.value.replace(/\s+/g, '');
        }
    }
    function validateExpiry(input) {
        const value = input.value.trim();
        const match = value.match(/^(0[1-9]|1[0-2])\/(\d{2})$/);
        if (!match) {
            input.setCustomValidity('Enter expiry as MM/YY');
            return;
        }
        const month = parseInt(match[1], 10);
        const year = parseInt(match[2], 10);
        const now = new Date();
        const currentYear = now.getFullYear() % 100;
        const currentMonth = now.getMonth() + 1;
        if (year < currentYear || (year === currentYear && month < currentMonth)) {
            input.setCustomValidity('Expiry date cannot be in the past');
        } else {
            input.setCustomValidity('');
        }
    }
    </script>
</head>
<body>
    <%@ include file="header.jsp" %>
    <main>
        <div class="container">
            <h1>Checkout</h1>
            <c:choose>
                <c:when test="${empty sessionScope.cart}">
                    <p>Your cart is empty. <a href="/PageTurners/books">Continue shopping</a>.</p>
                </c:when>
                <c:otherwise>
                    <div class="book-card checkout-summary-bubble">
                        <h3>Total: <fmt:formatNumber value="${total}" type="currency"/></h3>
                        <table class="cart-table" style="margin-bottom: 1.5rem;">
                            <thead>
                                <tr>
                                    <th>Book</th>
                                    <th>Author</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Subtotal</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${sessionScope.cart}">
                                    <tr>
                                        <td>${item.book.title}</td>
                                        <td>${item.book.author}</td>
                                        <td>${item.quantity}</td>
                                        <td><fmt:formatNumber value="${item.book.price}" type="currency"/></td>
                                        <td><fmt:formatNumber value="${item.subtotal}" type="currency"/></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <form action="/PageTurners/order" method="post" style="display: flex; flex-wrap: wrap; gap: 2rem;" onsubmit="stripCardNumberOnSubmit(this)">
                        <div class="book-card shipping-bubble" style="flex: 1 1 320px;">
                            <h4>Shipping Information</h4>
                            <label for="name">Full Name:</label>
                            <input type="text" id="name" name="name" required><br>
                            <label for="address">Address:</label>
                            <input type="text" id="address" name="address" required><br>
                            <label for="city">City:</label>
                            <input type="text" id="city" name="city" required><br>
                            <label for="state">State:</label>
                            <input type="text" id="state" name="state" required><br>
                            <label for="zip">Zip Code:</label>
                            <input type="text" id="zip" name="zip" required><br>
                            <label for="phone">Phone:</label>
                            <input type="text" id="phone" name="phone" required><br>
                        </div>
                        <div class="book-card payment-bubble" style="flex: 1 1 320px;">
                            <h4>Payment Information</h4>
                            <label for="merchant">Card Merchant:</label>
                            <select id="merchant" name="merchant" required>
                                <option value="">Select...</option>
                                <option value="Visa">Visa</option>
                                <option value="Mastercard">Mastercard</option>
                                <option value="Amex">American Express</option>
                                <option value="Discover">Discover</option>
                            </select><br>
                            <label for="card">Card Number:</label>
                            <input type="text" id="card" name="card" required pattern="^(?:4\d{3} ?\d{4} ?\d{4} ?\d{4}|5[1-5]\d{2} ?\d{4} ?\d{4} ?\d{4}|3[47]\d{2} ?\d{6} ?\d{5}|6(?:011|5\d{2}) ?\d{4} ?\d{4} ?\d{4})$" title="Enter a valid card number (Visa, Mastercard, Amex, Discover)" maxlength="19" oninput="formatCardNumber(this)"><br>
                            <label for="expiry">Expiry Date:</label>
                            <input type="text" id="expiry" name="expiry" placeholder="MM/YY" required oninput="validateExpiry(this)"><br>
                            <label for="cvv">CVV:</label>
                            <input type="text" id="cvv" name="cvv" required><br>
                            <button type="submit" class="btn btn-success" style="margin-top: 1.5rem;">Place Order</button>
                        </div>
                    </form>
                </c:otherwise>
            </c:choose>
        </div>
    </main>
    <%@ include file="footer.jsp" %>
</body>
</html>