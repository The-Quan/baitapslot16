<%@ page import="org.example.bt_slot16.entities.Orders" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.bt_slot16.entities.response.OrderResponse" %><%--
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
    <form method="post" action="orders" class="mb-4">
        <div class="form-group">
            <label>User Id</label>
            <input class="form-control" type="number" name="userId" required>
        </div>
        <div class="form-group">
            <label>Product Id</label>
            <input class="form-control" type="number" name="productId" required>
        </div>
        <button class="btn btn-primary btn-sm" type="submit">Save</button>
        <button class="btn btn-secondary btn-sm" type="reset">Cancel</button>
    </form>
</div>
<div style="padding: 30px 100px">
    <table class="table table-striped">
        <thead class="thead-dark">
        <tr>
            <th>Order Id</th>
            <th>User Id</th>
            <th>User name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Product Id</th>
            <th>Product Name</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<OrderResponse> orders = (List<OrderResponse>) request.getAttribute("orders");
            if (orders != null && !orders.isEmpty()) {
                for (OrderResponse order : orders) {
        %>
        <tr>
            <td><%= order.getOrder_id() %></td>
            <td><%= order.getUser_id() %></td>
            <td><%= order.getUsername() %></td>
            <td><%= order.getEmail() %></td>
            <td><%= order.getPhone() %></td>
            <td><%= order.getProduct_id() %></td>
            <td><%= order.getProduct_name() %></td>
            <td><%= order.getPrice() %></td>
            <td>
                <button class="btn btn-warning btn-sm ">Update</button>
                <button class="btn btn-danger btn-sm" onclick="deleteOrder(<%= order.getOrder_id()%>)">Delete</button>
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
<script>
    function deleteOrder(id) {
        if (confirm("Bạn có chắc muốn xóa Product học này không?")) {
            fetch('/bt_slot16_war_exploded/orders?id=' + id, { method: 'DELETE' })
                .then(response => {
                    if (response.ok) {
                        alert("Xóa thành công!");
                        location.reload();
                    } else {
                        response.json().then(data => alert("Xóa thất bại: " + data.error));
                    }
                })
                .catch(error => console.error('Lỗi:', error));
        }
    }
</script>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</html>
