<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="dao.ProductDAO"%>
<%@ page import="java.sql.SQLException"%>
<%
    String productIdStr = request.getParameter("product_id");
    String redirectPage = "viewProducts.jsp"; // Page to redirect to after processing
    String script = "";

    if (productIdStr != null && !productIdStr.trim().isEmpty()) {
        try {
            int productId = Integer.parseInt(productIdStr);
            ProductDAO productDAO = new ProductDAO();
            boolean success = productDAO.deleteProduct(productId);

            if (success) {
                script = "alert('Product deleted successfully.'); window.location.href='" + redirectPage + "';";
            } else {
                script = "alert('Failed to delete product.'); window.location.href='" + redirectPage + "';";
            }
        } catch (NumberFormatException e) {
            script = "alert('Invalid product ID.'); window.location.href='" + redirectPage + "';";
        } catch (SQLException e) {
            script = "alert('An error occurred while deleting the product.'); window.location.href='" + redirectPage + "';";
            e.printStackTrace();
        }
    } else {
        script = "alert('Product ID is missing.'); window.location.href='" + redirectPage + "';";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Product</title>
</head>
<body>
    <script>
        <%= script %>
    </script>
</body>
</html>
