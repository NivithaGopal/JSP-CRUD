<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="bean.Product, dao.ProductDAO"%>
<%@ page import="dbconnection.DBConnection"%>
<%@ page import="java.sql.Connection, java.sql.Timestamp"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.SQLException"%>

<%
    String productName = request.getParameter("productName");
    String productDescription = request.getParameter("productDescription");
    int productPrice = Integer.parseInt(request.getParameter("productPrice"));
    Timestamp createdAt = new Timestamp(System.currentTimeMillis());

    // Create a new Product object
    Product product = new Product();
    product.setProductName(productName);
    product.setProductDescription(productDescription);
    product.setProductPrice(productPrice);
    product.setCreatedAt(createdAt);

    // Create ProductDAO instance with the connection
    ProductDAO productDAO = new ProductDAO(); // Ensure you pass the connection

    // Redirect to a success page or display a success message
    try {
        // Save the product to the database
        productDAO.saveProduct(product);

        // Success message and redirect
        out.print("<script type='text/javascript'>");
        out.print("alert('Product successfully saved!');");
        out.print("window.location.href = 'viewProducts.jsp';");
        out.print("</script>");

    } catch (SQLException e) {
        // Show an error message if registration fails
        out.print("<script type='text/javascript'>");
        out.print("alert('Failed to save product');");
        out.print("</script>");
        e.printStackTrace();
    }
%>
