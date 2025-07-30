<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error - PageTurners</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin: 50px; }
        .error { color: red; }
    </style>
</head>
<body>
    <h1>Oops! Something went wrong</h1>
    <div class="error">
        <h2>Error Details:</h2>
        <p><strong>Status Code:</strong> ${pageContext.errorData.statusCode}</p>
        <p><strong>Request URI:</strong> ${pageContext.errorData.requestURI}</p>
        <p><strong>Exception:</strong> ${pageContext.exception}</p>
    </div>
    <a href="${pageContext.request.contextPath}/">Back to Home</a>
</body>
</html>
