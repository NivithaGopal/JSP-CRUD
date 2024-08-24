<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Product, dao.ProductDAO"%>
<%@ page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
    <div class="container mt-4">
        <h1>Edit Product</h1>
        <%
            String errorMessage = "";
            String successMessage = "";
            Product product = null;
            String productIdStr = request.getParameter("product_id");
            int productId = 0;
            
            try {
                if (productIdStr != null && !productIdStr.trim().isEmpty()) {
                    productId = Integer.parseInt(productIdStr);
                }

                ProductDAO productDAO = new ProductDAO();
                product = productDAO.getProductById(productId);
                 
                if (product == null) {
                    errorMessage = "Product not found.";
                } 
                
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String productName = request.getParameter("productName");
                    String productDescription = request.getParameter("productDescription");
                    int productPrice = Integer.parseInt(request.getParameter("productPrice"));

                    product.setProductName(productName);
                    product.setProductDescription(productDescription);
                    product.setProductPrice(productPrice);

                    try {
                        productDAO.updateProduct(product);
                        successMessage = "Product updated successfully.";
                        // Redirect with JavaScript
                        out.print("<script>alert('"+ successMessage +"'); window.location.href='viewProducts.jsp';</script>");
                    } catch (SQLException e) {
                        errorMessage = "Failed to update product.";
                        e.printStackTrace();
                        // Redirect with JavaScript
                        out.print("<script>alert('"+ errorMessage +"'); window.location.href='viewProducts.jsp';</script>");
                    }
                }
            } catch (SQLException e) {
                errorMessage = "An error occurred while retrieving the product.";
                e.printStackTrace();
                // Redirect with JavaScript
                out.print("<script>alert('"+ errorMessage +"');</script>");
            } catch (NumberFormatException e) {
                errorMessage = "Invalid Product ID.";
                // Redirect with JavaScript
                out.print("<script>alert('"+ errorMessage +"'); window.location.href='viewProducts.jsp';</script>");
            }
        %>
        
        <!-- Form is only shown if there are no errors -->
        <%
            if (errorMessage.isEmpty() && successMessage.isEmpty()) {
        %>
        <form action="editProduct.jsp?product_id=<%= productId %>" method="post">
            <div class="form-group">
                <label for="productName">Product Name</label>
                <input type="text" class="form-control" id="productName" name="productName" value="<%= product.getProductName() %>" required>
            </div>
            <div class="form-group">
                <label for="productDescription">Product Description</label>
                <textarea class="form-control" id="productDescription" name="productDescription" rows="3" required><%= product.getProductDescription() %></textarea>
            </div>
            <div class="form-group">
                <label for="productPrice">Product Price</label>
                <input type="number" class="form-control" id="productPrice" name="productPrice" value="<%= product.getProductPrice() %>" required>
            </div>
            <button type="submit" class="btn btn-primary">Update Product</button>
            <a href="viewProducts.jsp" class="btn btn-secondary">Cancel</a>
        </form>
        <%
            }
        %>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
