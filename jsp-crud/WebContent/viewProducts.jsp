<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Product, dao.ProductDAO"%>
<%@ page import="dbconnection.DBConnection"%>
<%@ page import="java.sql.Connection, java.sql.SQLException"%>
<%@ page import="java.util.List"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Products</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        .container-fluid {
            padding: 20px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <h1 class="mb-4">Product List</h1>

        <!-- Filter Form -->
        <form method="get" action="viewProducts.jsp" class="mb-4">
            <div class="row">
                <div class="col-md-4">
                    <input type="number" name="minPrice" class="form-control" placeholder="Min Price" value="<%= request.getParameter("minPrice") %>">
                </div>
                <div class="col-md-4">
                    <input type="number" name="maxPrice" class="form-control" placeholder="Max Price" value="<%= request.getParameter("maxPrice") %>">
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-primary btn-block">Filter</button>
                </div>
            </div>
        </form>

        <div class="table-responsive">
            <table class="table table-bordered table-striped">
                <thead class="thead-dark">
                    <tr>
                        <th>#</th>
                        <th>PRODUCT ID</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Created At</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Product> products = null;
                        String errorMessage = "Failed to retrieve products";
                        int rowNumber = 1; // Initialize counter

                        // Get filter parameters
                        String minPriceStr = request.getParameter("minPrice");
                        String maxPriceStr = request.getParameter("maxPrice");
                        Double minPrice = minPriceStr != null && !minPriceStr.trim().isEmpty() ? Double.parseDouble(minPriceStr) : null;
                        Double maxPrice = maxPriceStr != null && !maxPriceStr.trim().isEmpty() ? Double.parseDouble(maxPriceStr) : null;

                        try {
                            ProductDAO productDAO = new ProductDAO();
                            products = productDAO.getFilteredProducts(minPrice, maxPrice);
                        } catch (SQLException e) {
                            errorMessage = "An error occurred while retrieving products.";
                            e.printStackTrace();
                        }

                        if (products == null || products.isEmpty()) {
                    %>
                        <tr>
                            <td colspan="7"><%= errorMessage %></td>
                        </tr>
                    <%
                        } else {
                            for (Product product : products) {
                    %>
                        <tr>
                            <td><%= rowNumber++ %></td>
                            <td><%= product.getProduct_id() %></td>
                            <td><%= product.getProductName() %></td>
                            <td><%= product.getProductDescription() %></td>
                            <td><%= product.getProductPrice() %></td>
                            <td><%= product.getCreatedAt() %></td>
                            <td class="text-center">
                                <a href="editProduct.jsp?product_id=<%= product.getProduct_id() %>">
                                    <i class="fas fa-edit fa-lg" style="color: #333;"></i>
                                </a>
                                <a href="deleteProduct.jsp?product_id=<%= product.getProduct_id() %>">
                                    <i class="fas fa-trash-alt fa-lg" style="color: red;"></i>
                                </a>
                            </td>
                        </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
