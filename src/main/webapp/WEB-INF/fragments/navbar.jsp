<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark px-3">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/">&#128663; Car Rental</a>
  <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#nav">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="nav">
    <ul class="navbar-nav me-auto">
      <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/">Home</a></li>
      <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/cars">Cars</a></li>
      <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'USER'}">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/my-bookings">My bookings</a></li>
      </c:if>
      <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'ADMIN'}">
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/cars">Manage cars</a></li>
        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/admin/bookings">Bookings</a></li>
      </c:if>
    </ul>
    <div class="d-flex align-items-center gap-2">
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <span class="text-light small">Hi, <c:out value="${sessionScope.user.name}"/></span>
          <a href="${pageContext.request.contextPath}/logout" class="btn btn-light btn-sm">Logout</a>
        </c:when>
        <c:otherwise>
          <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-outline-light btn-sm">Login</a>
          <a href="${pageContext.request.contextPath}/register.jsp" class="btn btn-primary btn-sm">Register</a>
        </c:otherwise>
      </c:choose>
    </div>
  </div>
</nav>