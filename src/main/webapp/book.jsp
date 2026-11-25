<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Book a car - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <nav class="navbar navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard.jsp">Car Rental</a>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Logout</a>
  </nav>

  <div class="container" style="max-width: 520px; margin-top: 40px;">
    <div class="card shadow-sm">
      <div class="card-body p-4">
        <h4><c:out value="${car.brand}"/> <c:out value="${car.model}"/></h4>
        <p class="text-muted mb-3"><c:out value="${car.type}"/> &middot; ${car.seats} seats &middot; &#8377;${car.pricePerDay} / day</p>

        <c:if test="${not empty error}">
          <div class="alert alert-danger"><c:out value="${error}"/></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/book" method="post">
          <input type="hidden" name="carId" value="${car.id}">
          <div class="mb-3">
            <label class="form-label">Start date</label>
            <input type="date" name="startDate" class="form-control" min="${today}" required>
          </div>
          <div class="mb-3">
            <label class="form-label">End date</label>
            <input type="date" name="endDate" class="form-control" min="${today}" required>
          </div>
          <button class="btn btn-success w-100">Request booking</button>
          <a href="${pageContext.request.contextPath}/cars" class="btn btn-link w-100 mt-2">Back to cars</a>
        </form>
      </div>
    </div>
  </div>
</body>
</html>