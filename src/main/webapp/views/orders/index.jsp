<%@ page import="org.example.bt_slot16.entities.Orders" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: admin
  Date: 2/23/2025
  Time: 5:36 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<header>
    <jsp:include page="../../includes/header.jsp" />
</header>
<body>

<div style="padding: 30px 100px">
    <h1 class="mb-4">Add Order</h1>
    <form method="post" action="classroom" class="mb-4">
        <div class="form-group">
            <label>UserName</label>
            <input class="form-control" type="text" name="name_class" required>
        </div>
        <div class="form-group">
            <label>Members Number</label>
            <input class="form-control" type="number" name="number_member" required>
        </div>
        <button class="btn btn-primary btn-sm" type="submit">Save</button>
        <button class="btn btn-secondary btn-sm" type="reset">Cancel</button>
    </form>
</div>
<div style="padding: 30px 100px">
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th>ID</th>
            <th>Order Id</th>
            <th>User Id</th>
            <th>Product Id</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Orders> orders = (List<Orders>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (Orders order : orders) {
        %>
        <tr>
            <td><%= order.getOrder_id() %></td>
            <td><%= order.getUser_id() %></td>
            <td><%= order.getProduct_id() %></td>
            <td>
                <button class="btn btn-warning btn-sm ">Update</button>
                <button class="btn btn-danger btn-sm">Delete</button>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" class="text-center text-muted">No classes found</td>
        </tr>
        <%
            }
        %>
        </tbody>
    </table>
</div>
</body>
<footer>
    <jsp:include page="../../includes/footer.jsp"/>
</footer>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>
