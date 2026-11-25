<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Browse Cars - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <nav class="navbar navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard.jsp">Car Rental</a>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Logout</a>
  </nav>

  <div class="container mt-4">
    <h3>Available cars</h3>

    <form action="${pageContext.request.contextPath}/cars" method="get" class="row g-2 mb-4">
      <div class="col-md-4">
        <select name="type" class="form-select">
          <option value="">All types</option>
          <option value="Hatchback" ${selectedType == 'Hatchback' ? 'selected' : ''}>Hatchback</option>
          <option value="Sedan" ${selectedType == 'Sedan' ? 'selected' : ''}>Sedan</option>
          <option value="SUV" ${selectedType == 'SUV' ? 'selected' : ''}>SUV</option>
          <option value="Luxury" ${selectedType == 'Luxury' ? 'selected' : ''}>Luxury</option>
        </select>
      </div>
      <div class="col-md-4">
        <input type="number" name="maxPrice" class="form-control" placeholder="Max price per day"
               min="0" value="<c:out value='${selectedMaxPrice}'/>">
      </div>
      <div class="col-md-4">
        <button class="btn btn-primary">Filter</button>
        <a href="${pageContext.request.contextPath}/cars" class="btn btn-outline-secondary">Reset</a>
      </div>
    </form>

    <div class="row g-3">
      <c:forEach var="car" items="${cars}">
        <div class="col-md-4">
          <div class="card h-100 shadow-sm">
            <c:if test="${not empty car.imageUrl}">
              <img src="<c:out value='${car.imageUrl}'/>" class="card-img-top" alt="car"
                   style="height:180px; object-fit:cover;">
            </c:if>
            <div class="card-body">
              <h5 class="card-title"><c:out value="${car.brand}"/> <c:out value="${car.model}"/></h5>
              <p class="mb-1"><c:out value="${car.type}"/> &middot; ${car.seats} seats</p>
              <p class="fw-bold mb-3">&#8377;${car.pricePerDay} / day</p>
              <a href="#" class="btn btn-success w-100 disabled">Book (coming next)</a>
            </div>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty cars}">
        <p class="text-muted">No cars match your filters.</p>
      </c:if>
    </div>
  </div>
</body>
</html>