<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Browse Cars - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>

  <div class="page-banner">
    <div class="container">
      <h2 class="mb-0">Available cars</h2>
      <small class="text-light">Pick a car and book it for your dates</small>
    </div>
  </div>

  <div class="container mt-4">
    <form action="${pageContext.request.contextPath}/cars" method="get" class="row g-2 mb-4 bg-white p-3 rounded-3 shadow-sm">
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

    <div class="row g-4">
      <c:forEach var="car" items="${cars}">
        <div class="col-md-6 col-lg-4">
          <div class="card car-card h-100">

            <c:choose>
              <c:when test="${empty car.imageUrl}">
                <div class="car-img-placeholder">&#128663;</div>
              </c:when>
              <c:when test="${fn:startsWith(car.imageUrl, 'http')}">
                <img src="<c:out value='${car.imageUrl}'/>" alt="<c:out value='${car.brand} ${car.model}'/>">
              </c:when>
              <c:otherwise>
                <img src="${pageContext.request.contextPath}/<c:out value='${car.imageUrl}'/>" alt="<c:out value='${car.brand} ${car.model}'/>">
              </c:otherwise>
            </c:choose>

            <div class="card-body d-flex flex-column">
              <div class="mb-2">
                <span class="badge bg-primary"><c:out value="${car.type}"/></span>
                <span class="badge bg-secondary">${car.seats} seats</span>
                <c:choose>
                  <c:when test="${car.status == 'AVAILABLE'}"><span class="badge bg-success">Available</span></c:when>
                  <c:when test="${car.status == 'BOOKED'}"><span class="badge bg-warning text-dark">Booked</span></c:when>
                  <c:otherwise><span class="badge bg-danger">Unavailable</span></c:otherwise>
                </c:choose>
              </div>
              <h5 class="card-title"><c:out value="${car.brand}"/> <c:out value="${car.model}"/></h5>
              <div class="price-tag mb-3">&#8377;${car.pricePerDay} <small>/ day</small></div>
              <a href="${pageContext.request.contextPath}/book?carId=${car.id}" class="btn btn-success mt-auto">Book now</a>
            </div>
          </div>
        </div>
      </c:forEach>
      <c:if test="${empty cars}">
        <div class="col-12 text-center text-muted py-5">No cars match your filters.</div>
      </c:if>
    </div>
  </div>

  <jsp:include page="/WEB-INF/fragments/footer.jsp"/>
</body>
</html>