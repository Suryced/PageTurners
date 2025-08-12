<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books Test Page</title>
    <link rel="stylesheet" type="text/css" href="/PageTurners/css/styles.css">
</head>
<body>
    <%@ include file="header.jsp" %>
    <main>
        <div class="container">
            <h1 class="page-header">Test Books Page</h1>
            <p>This is a simple test page to verify JSP compilation.</p>
            <p>Books retrieved: <%= request.getAttribute("books") != null ? "Found books" : "No books" %></p>
        </div>
    </main>
    <%@ include file="footer.jsp" %>
</body>
</html>