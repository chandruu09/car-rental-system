<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Login - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>

  <div class="container" style="max-width: 440px; margin-top: 60px;">
    <div class="card border-0 shadow rounded-4">
      <div class="card-body p-4 p-md-5">
        <div class="text-center mb-4">
          <div style="font-size: 44px;">&#128663;</div>
          <h3 class="fw-bold mb-1">Welcome back</h3>
          <p class="text-muted mb-0">Log in to book your next ride</p>
        </div>

        <c:if test="${param.registered == '1'}">
          <div class="alert alert-success">Registration successful! Please log in.</div>
        </c:if>
        <c:if test="${not empty error}">
          <div class="alert alert-danger"><c:out value="${error}"/></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control form-control-lg" required>
          </div>
          <div class="mb-4">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control form-control-lg" required>
          </div>
          <button type="submit" class="btn btn-primary btn-lg w-100">Login</button>
        </form>

        <p class="text-center mt-4 mb-0">New here?
          <a href="${pageContext.request.contextPath}/register.jsp">Create an account</a>
        </p>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/fragments/footer.jsp"/>
</body>
</html>