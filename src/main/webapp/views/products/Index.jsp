<%@ page import="org.example.bt_slot16.entities.Products" %>
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
    <title>Product</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<header>
    <jsp:include page="../../includes/header.jsp" />
</header>
<body>
<div style="padding: 30px 100px">
    <h1 class="mb-4">Add Product</h1>
    <form method="post" action="products" class="mb-4">
        <div class="form-group">
            <label>Product Name</label>
            <input class="form-control" type="text" name="product_name" required>
        </div>
        <div class="form-group">
            <label>Description</label>
            <input class="form-control" type="text" name="description" required>
        </div>
        <div class="form-group">
            <label>Price</label>
            <input class="form-control" type="number" name="price" required>
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
            <th>Description</th>
            <th>Price</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Products> products = (List<Products>) request.getAttribute("products");
            if (products != null && !products.isEmpty()) {
                for (Products product : products) {
        %>
        <tr>
            <td><%= product.getProduct_id() %></td>
            <td><%= product.getProduct_name() %></td>
            <td><%= product.getProduct_name() %></td>
            <td><%= product.getPrice() %></td>
            <td>
                <button class="btn btn-warning btn-sm ">Update</button>
                <button class="btn btn-danger btn-sm" onclick="deleteProduct(<%= product.getProduct_id()%>)">Delete</button>
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
    function deleteProduct(id) {
        if (confirm("Bạn có chắc muốn xóa Product học này không?")) {
            fetch('/bt_slot16_war_exploded/products?id=' + id, { method: 'DELETE' })
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
