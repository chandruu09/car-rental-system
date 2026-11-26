<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${empty sessionScope.user or sessionScope.user.role != 'ADMIN'}">
  <c:redirect url="login.jsp"/>
</c:if>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Admin - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
  <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>
  <div class="container mt-4">
    <h3>Admin panel</h3>
   <a href="${pageContext.request.contextPath}/admin/cars" class="btn btn-primary">Manage cars</a>
   <a href="${pageContext.request.contextPath}/admin/bookings" class="btn btn-outline-primary">View bookings</a>
   <a href="${pageContext.request.contextPath}/" class="btn btn-outline-secondary">Home</a>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>