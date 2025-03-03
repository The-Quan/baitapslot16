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
<div class="modal fade" id="editProductModal" tabindex="-1" aria-labelledby="editProductModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editProductModalLabel">Edit User</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="editProductForm">
                    <input type="hidden" id="editProductId" name="product_id">
                    <div class="form-group">
                        <label>Product Name</label>
                        <input class="form-control" type="text" id="editProductName" name="product_name" required>
                    </div>
                    <div class="form-group">
                        <label>Description</label>
                        <input class="form-control" type="text" id="editDescription" name="description" required>
                    </div>
                    <div class="form-group">
                        <label>Price</label>
                        <input class="form-control" type="number" id="editPrice" name="price" required>
                    </div>
                    <button class="btn btn-primary" type="submit">Save Changes</button>
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                </form>
            </div>
        </div>
    </div>
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
            <td><%= product.getDescription() %></td>
            <td><%= product.getPrice() %></td>
            <td>
                <button class="btn btn-warning btn-sm " onclick="editProduct(<%= product.getProduct_id() %>, '<%= product.getProduct_name() %>', '<%= product.getDescription() %>', '<%= product.getPrice() %>')"> Update</button>
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
    function editProduct(id, productName, description, price) {
        document.getElementById("editProductId").value = id;
        document.getElementById("editProductName").value = productName;
        document.getElementById("editDescription").value = description;
        document.getElementById("editPrice").value = price;
        $('#editProductModal').modal('show');
    }

    document.getElementById("editProductForm").addEventListener("submit", function (event) {
        event.preventDefault();

        let productId = document.getElementById("editProductId").value;
        let product_name = document.getElementById("editProductName").value;
        let description = document.getElementById("editDescription").value;
        let price = document.getElementById("editPrice").value;

        fetch('/bt_slot16_war_exploded/products', {
            method: 'PUT',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ product_id: productId, product_name, description, price })
        })
            .then(response => {
                if (response.ok) {
                    alert("Cập nhật thành công!");
                    location.reload();
                } else {
                    alert("Cập nhật thất bại!");
                }
            })
            .catch(error => console.error("Lỗi:", error));
    });
</script>
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
