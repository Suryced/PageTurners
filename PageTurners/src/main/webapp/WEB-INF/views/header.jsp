<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<header>
    <div class="container">
        <nav>
            <a href="/PageTurners/" class="logo">📚 PageTurners</a>
            <ul class="nav-links">
                <li><a href="/PageTurners/">🏠 Home</a></li>
                <li><a href="/PageTurners/books">📖 Browse Books</a></li>
                <li><a href="/PageTurners/cart?action=view">🛒 Cart</a></li>
                <%
                    Object user = session.getAttribute("user");
                    if (user != null) {
                        // User is logged in
                %>
                        <li class="welcome-user">✨ Welcome!</li>
                        <li><a href="/PageTurners/auth?action=logout">🚪 Logout</a></li>
                <%
                    } else {
                        // User is not logged in
                %>
                        <li><a href="/PageTurners/auth?action=login">🔑 Login</a></li>
                        <li><a href="/PageTurners/auth?action=register">📝 Register</a></li>
                <%
                    }
                %>
            </ul>
        </nav>
    </div>
</header>