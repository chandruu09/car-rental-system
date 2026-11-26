<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Manage Bookings - Admin</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body class="bg-light">
 <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>

  <div class="container mt-4">
    <h3>All bookings</h3>

    <c:if test="${not empty sessionScope.flash}">
      <div class="alert alert-info"><c:out value="${sessionScope.flash}"/></div>
      <c:remove var="flash" scope="session"/>
    </c:if>

    <table class="table table-bordered bg-white align-middle">
      <thead class="table-dark">
        <tr><th>#</th><th>User</th><th>Car</th><th>From</th><th>To</th><th>Total</th><th>Status</th><th>Actions</th></tr>
      </thead>
      <tbody>
        <c:forEach var="b" items="${bookings}">
          <tr>
            <td>${b.id}</td>
            <td><c:out value="${b.userName}"/></td>
            <td><c:out value="${b.carName}"/></td>
            <td>${b.startDate}</td>
            <td>${b.endDate}</td>
            <td>&#8377;${b.totalAmount}</td>
            <td>${b.status}</td>
            <td>
              <c:if test="${b.status == 'PENDING'}">
                <form action="${pageContext.request.contextPath}/admin/bookings" method="post" class="d-inline">
                  <input type="hidden" name="id" value="${b.id}">
                  <button name="action" value="approve" class="btn btn-sm btn-success">Approve</button>
                  <button name="action" value="reject" class="btn btn-sm btn-danger">Reject</button>
                </form>
              </c:if>
              <c:if test="${b.status == 'APPROVED'}">
                <form action="${pageContext.request.contextPath}/admin/bookings" method="post" class="d-inline">
                  <input type="hidden" name="id" value="${b.id}">
                  <button name="action" value="complete" class="btn btn-sm btn-primary">Mark returned</button>
                </form>
              </c:if>
            </td>
          </tr>
        </c:forEach>
        <c:if test="${empty bookings}">
          <tr><td colspan="8" class="text-center text-muted">No bookings yet.</td></tr>
        </c:if>
      </tbody>
    </table>
  </div>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>