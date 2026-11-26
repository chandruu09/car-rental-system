<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Manage Cars - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
 <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>

  <div class="container mt-4">
    <h3>Manage cars</h3>

    <c:if test="${not empty sessionScope.flash}">
      <div class="alert alert-info"><c:out value="${sessionScope.flash}"/></div>
      <c:remove var="flash" scope="session"/>
    </c:if>

    <div class="card mb-4">
      <div class="card-body">
        <h5>Add a car</h5>
        <form action="${pageContext.request.contextPath}/admin/cars" method="post" class="row g-2">
          <input type="hidden" name="action" value="add">
          <div class="col-md-3"><input name="brand" class="form-control" placeholder="Brand" required></div>
          <div class="col-md-3"><input name="model" class="form-control" placeholder="Model" required></div>
          <div class="col-md-2">
            <select name="type" class="form-select">
              <option>Hatchback</option><option>Sedan</option><option>SUV</option><option>Luxury</option>
            </select>
          </div>
          <div class="col-md-2"><input type="number" name="seats" class="form-control" placeholder="Seats" min="1" required></div>
          <div class="col-md-2"><input type="number" step="0.01" name="pricePerDay" class="form-control" placeholder="Price/day" min="0" required></div>
          <div class="col-md-9"><input name="imageUrl" class="form-control" placeholder="Image URL (optional)"></div>
          <div class="col-md-3"><button class="btn btn-primary w-100">Add car</button></div>
        </form>
      </div>
    </div>

    <table class="table table-bordered bg-white">
      <thead class="table-dark">
        <tr><th>ID</th><th>Brand</th><th>Model</th><th>Type</th><th>Seats</th><th>Price/day</th><th>Status</th><th></th></tr>
      </thead>
      <tbody>
        <c:forEach var="car" items="${cars}">
          <tr>
            <td>${car.id}</td>
            <td><c:out value="${car.brand}"/></td>
            <td><c:out value="${car.model}"/></td>
            <td><c:out value="${car.type}"/></td>
            <td>${car.seats}</td>
            <td>${car.pricePerDay}</td>
            <td>${car.status}</td>
            <td>
              <form action="${pageContext.request.contextPath}/admin/cars" method="post"
                    onsubmit="return confirm('Delete this car?');">
                <input type="hidden" name="action" value="delete">
                <input type="hidden" name="id" value="${car.id}">
                <button class="btn btn-sm btn-danger">Delete</button>
              </form>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty cars}">
          <tr><td colspan="8" class="text-center text-muted">No cars yet.</td></tr>
        </c:if>
      </tbody>
    </table>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>