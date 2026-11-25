<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.user}">
  <c:redirect url="login.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Dashboard - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <nav class="navbar navbar-dark bg-dark px-3">
    <span class="navbar-brand">Car Rental</span>
    <a href="logout" class="btn btn-outline-light btn-sm">Logout</a>
  </nav>
  <div class="container mt-4">
    <h3>Welcome, <c:out value="${sessionScope.user.name}"/>!</h3>
   <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary">Browse cars</a>
   <a href="${pageContext.request.contextPath}/my-bookings" class="btn btn-outline-primary">My bookings</a>
  </div>
</body>
</html>