<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>My Bookings - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
  <nav class="navbar navbar-dark bg-dark px-3">
    <a class="navbar-brand" href="${pageContext.request.contextPath}/dashboard.jsp">Car Rental</a>
    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-light btn-sm">Logout</a>
  </nav>

  <div class="container mt-4">
    <h3>My bookings</h3>

    <c:if test="${not empty sessionScope.flash}">
      <div class="alert alert-info"><c:out value="${sessionScope.flash}"/></div>
      <c:remove var="flash" scope="session"/>
    </c:if>

    <table class="table table-bordered bg-white">
      <thead class="table-dark">
        <tr><th>#</th><th>Car</th><th>From</th><th>To</th><th>Total</th><th>Status</th><th></th></tr>
      </thead>
      <tbody>
        <c:forEach var="b" items="${bookings}">
          <tr>
            <td>${b.id}</td>
            <td><c:out value="${b.carName}"/></td>
            <td>${b.startDate}</td>
            <td>${b.endDate}</td>
            <td>&#8377;${b.totalAmount}</td>
            <td>${b.status}</td>
            <td>
              <c:if test="${b.status == 'PENDING' or b.status == 'APPROVED'}">
                <form action="${pageContext.request.contextPath}/my-bookings" method="post"
                      onsubmit="return confirm('Cancel this booking?');">
                  <input type="hidden" name="bookingId" value="${b.id}">
                  <button class="btn btn-sm btn-outline-danger">Cancel</button>
                </form>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty bookings}">
          <tr><td colspan="7" class="text-center text-muted">No bookings yet.</td></tr>
        </c:if>
      </tbody>
    </table>
    <a href="${pageContext.request.contextPath}/cars" class="btn btn-primary">Browse cars</a>
  </div>
</body>
</html>