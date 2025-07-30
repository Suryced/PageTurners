<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Books Test Page</title>
</head>
<body>
    <h1>Test Books Page</h1>
    <p>This is a simple test page to verify JSP compilation.</p>
    <p>Books retrieved: <%= request.getAttribute("books") != null ? "Found books" : "No books" %></p>
</body>
</html>