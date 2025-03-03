<%@ page import="org.example.bt_slot16.entities.Users" %>
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
    <title>User Table</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<header>
    <jsp:include page="../../includes/header.jsp" />
</header>
<body>
<div style="padding: 30px 100px">
    <h1 class="mb-4">Add User</h1>
    <form method="post" action="classroom" class="mb-4">
        <div class="form-group">
            <label>UserName</label>
            <input class="form-control" type="text" name="username" required>
        </div>
        <div class="form-group">
            <label>Email</label>
            <input class="form-control" type="number" name="email" required>
        </div>
        <div class="form-group">
            <label>Phone</label>
            <input class="form-control" type="number" name="phone" required>
        </div>
        <div class="form-group">
            <label>Address</label>
            <input class="form-control" type="number" name="address" required>
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
            <th>Name</th>
            <th>Email</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Users> users = (List<Users>) request.getAttribute("users");
            if (users != null && !users.isEmpty()) {
                for (Users user : users) {
        %>
        <tr>
            <td><%= user.getUser_id() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getAddress() %></td>
            <td><%= user.getPhone() %></td>
            <td>
                <button class="btn btn-warning btn-sm ">Update</button>
                <button class="btn btn-danger btn-sm" onclick="deleteClass(<%= user.getUser_id() %>)">Delete</button>
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
    function deleteClass(id) {
        if (confirm("Bạn có chắc muốn xóa User học này không?")) {
            fetch('/bt_slot16_war_exploded/users?id=' + id, { method: 'DELETE' })
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
