<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Car Rental System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>

  <section class="hero text-center">
    <div class="container">
      <span class="badge bg-warning text-dark mb-3">Best prices &middot; Instant booking</span>
      <h1 class="display-4">Rent the perfect car<br>for every journey</h1>
      <p class="lead mb-4">Browse cars, pick your dates, and book online in minutes.</p>
      <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary btn-lg me-2">Browse cars</a>
      <c:if test="${empty sessionScope.user}">
        <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-outline-light btn-lg">Sign up free</a>
      </c:if>
    </div>
  </section>

  <div class="container my-5">
    <h2 class="section-title text-center">Choose your ride</h2>
    <p class="section-sub text-center">Pick a category to see available cars</p>
    <div class="row g-4">
      <div class="col-6 col-md-3">
        <a class="cat-card" href="${pageContext.request.contextPath}/cars?type=Hatchback">
          <div class="icon">&#128664;</div><h5 class="mt-2 mb-0">Hatchback</h5><small class="text-muted">City friendly</small>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a class="cat-card" href="${pageContext.request.contextPath}/cars?type=Sedan">
          <div class="icon">&#128663;</div><h5 class="mt-2 mb-0">Sedan</h5><small class="text-muted">Comfort &amp; style</small>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a class="cat-card" href="${pageContext.request.contextPath}/cars?type=SUV">
          <div class="icon">&#128661;</div><h5 class="mt-2 mb-0">SUV</h5><small class="text-muted">Family &amp; trips</small>
        </a>
      </div>
      <div class="col-6 col-md-3">
        <a class="cat-card" href="${pageContext.request.contextPath}/cars?type=Luxury">
          <div class="icon">&#127950;</div><h5 class="mt-2 mb-0">Luxury</h5><small class="text-muted">Premium rides</small>
        </a>
      </div>
    </div>
  </div>

  <div class="container my-5 text-center">
    <h2 class="section-title">How it works</h2>
    <p class="section-sub">Three simple steps</p>
    <div class="row g-4">
      <div class="col-md-4"><div class="step-circle">1</div><h5 class="mt-3">Choose</h5><p class="text-muted">Filter cars by type and price.</p></div>
      <div class="col-md-4"><div class="step-circle">2</div><h5 class="mt-3">Book</h5><p class="text-muted">Select your dates. We check availability instantly.</p></div>
      <div class="col-md-4"><div class="step-circle">3</div><h5 class="mt-3">Ride</h5><p class="text-muted">Track your bookings and cancel anytime.</p></div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/fragments/footer.jsp"/>
</body>
</html>