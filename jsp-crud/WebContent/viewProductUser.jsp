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
        .card {
            margin-bottom: 20px;
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: bold;
        }
        .card-text {
            font-size: 1rem;
        }
        .btn-custom {
            margin: 5px;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <h1 class="mb-4">Product List</h1>

        <!-- Filter Form with Slider -->
         <form method="get" action="" class="mb-4">
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

        <div class="row">
            <%
                List<Product> products = null;
                String errorMessage = "Failed to retrieve products";

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
                <div class="col-12">
                    <div class="alert alert-danger" role="alert">
                        <%= errorMessage %>
                    </div>
                </div>
            <%
                } else {
                    for (Product product : products) {
            %>
                <div class="col-md-4 mb-4">
                    <div class="card">
                        <div class="card-body">
                            <h5 class="card-title"><%= product.getProductName() %></h5>
                            <h6 class="card-subtitle mb-2 text-muted">  &#x20b9; <%= product.getProductPrice() %></h6>
                            <p class="card-text"><%= product.getProductDescription() %></p>
                            <a href="addToFavourites.jsp?product_id=<%= product.getProduct_id() %>" class="btn btn-info btn-custom">
                                <i class="fas fa-heart"></i> Add to Favourites
                            </a>
                            <a href="addToCart.jsp?product_id=<%= product.getProduct_id() %>" class="btn btn-warning btn-custom">
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </a>
                        </div>
                    </div>
                </div>
            <%
                    }
                }
            %>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

    <!-- Slider JavaScript -->
    <script>
        const priceRange = document.getElementById('priceRange');
        const maxPriceLabel = document.getElementById('maxPriceLabel');
        const minPrice = document.getElementById('minPrice');
        const maxPrice = document.getElementById('maxPrice');

        // Update labels and hidden inputs when the slider value changes
        priceRange.addEventListener('input', function() {
            maxPriceLabel.textContent = priceRange.value;
            maxPrice.value = priceRange.value;
        });

        // Set initial values on page load
        maxPriceLabel.textContent = priceRange.value;
        minPrice.value = 0;
        maxPrice.value = priceRange.value;
    </script>
</body>
</html>
