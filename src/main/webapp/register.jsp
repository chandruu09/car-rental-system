<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Register - Car Rental</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
  <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
  <jsp:include page="/WEB-INF/fragments/navbar.jsp"/>

  <div class="container" style="max-width: 480px; margin-top: 40px;">
    <div class="card border-0 shadow rounded-4">
      <div class="card-body p-4 p-md-5">
        <div class="text-center mb-4">
          <div style="font-size: 44px;">&#128273;</div>
          <h3 class="fw-bold mb-1">Create your account</h3>
          <p class="text-muted mb-0">It takes less than a minute</p>
        </div>

        <c:if test="${not empty error}">
          <div class="alert alert-danger"><c:out value="${error}"/></div>
        </c:if>

        <form action="${pageContext.request.contextPath}/register" method="post">
          <div class="mb-3">
            <label class="form-label">Full name</label>
            <input type="text" name="name" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Email</label>
            <input type="email" name="email" class="form-control" required>
          </div>
          <div class="mb-3">
            <label class="form-label">Phone</label>
            <input type="text" name="phone" class="form-control">
          </div>
          <div class="mb-3">
            <label class="form-label">Password</label>
            <input type="password" name="password" class="form-control" required minlength="6">
            <div class="form-text">At least 6 characters</div>
          </div>
          <div class="mb-4">
            <label class="form-label">Confirm password</label>
            <input type="password" name="confirmPassword" class="form-control" required>
          </div>
          <button type="submit" class="btn btn-primary btn-lg w-100">Register</button>
        </form>

        <p class="text-center mt-4 mb-0">Already have an account?
          <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
        </p>
      </div>
    </div>
  </div>

  <jsp:include page="/WEB-INF/fragments/footer.jsp"/>
</body>
</html>