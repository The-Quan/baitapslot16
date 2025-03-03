<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<header>
    <jsp:include page="includes/header.jsp" />
</header>
<body>
<h1>Lamborghini</h1>
<div style="width: 100%; display: flex; align-items: center; justify-content: center ">
    <div style="padding: 30px 100px">
        <img src="./static/anh-o-to-40.jpg" alt="Banner Car" />
    </div>
</div>
</body>
<footer>
    <jsp:include page="includes/footer.jsp"/>
</footer>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>