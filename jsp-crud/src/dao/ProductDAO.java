package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import bean.Product;
import dbconnection.DBConnection;

public class ProductDAO {
	
	
	
	public List<Product> getFilteredProducts(Double minPrice, Double maxPrice) throws SQLException {
	    List<Product> products = new ArrayList<>();
	    String query = "SELECT * FROM products WHERE 1=1"; // Base query

	    // Append conditions based on filters
	    if (minPrice != null) {
	        query += " AND productPrice >= ?";
	    }
	    if (maxPrice != null) {
	        query += " AND productPrice <= ?";
	    }

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement pstmt = conn.prepareStatement(query)) {
	        int paramIndex = 1;

	        if (minPrice != null) {
	            pstmt.setDouble(paramIndex++, minPrice);
	        }
	        if (maxPrice != null) {
	            pstmt.setDouble(paramIndex++, maxPrice);
	        }

	        try (ResultSet rs = pstmt.executeQuery()) {
	            while (rs.next()) {
	                Product product = new Product();
	                product.setProduct_id(rs.getInt("product_id"));
	                product.setProductName(rs.getString("productName"));
                    product.setProductDescription(rs.getString("productDescription"));
                    product.setProductPrice(rs.getInt("productPrice"));
                    product.setCreatedAt(rs.getTimestamp("createdAt"));

	                products.add(product);
	            }
	        }
	    }
	    return products;
	}


    public void saveProduct(Product product) throws SQLException {
        String query = "INSERT INTO products (productName, productDescription, productPrice, createdAt) VALUES (?, ?, ?, NOW())";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getProductDescription());
            stmt.setInt(3, product.getProductPrice());

            // Print debug information
            System.out.println("Saving product: " + product);
            System.out.println("Timestamp: " + product.getCreatedAt());

            stmt.executeUpdate();
        }
    }
    
    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM products";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int product_id = rs.getInt("product_id");
                String productName = rs.getString("productName");
                String productDescription = rs.getString("productDescription");
                int productPrice = rs.getInt("productPrice");
                Timestamp createdAt;

                // Handle invalid timestamps
                try {
                    createdAt = rs.getTimestamp("createdAt");
                    if (createdAt == null || createdAt.getTime() == 0) {
                        createdAt = new Timestamp(System.currentTimeMillis()); // Fallback to current timestamp
                    }
                } catch (SQLException e) {
                    createdAt = new Timestamp(System.currentTimeMillis()); // Fallback to current timestamp
                }

                Product product = new Product(product_id, productName, productDescription, productPrice, createdAt);
                products.add(product);
            }
        }
        return products;
    }

    public Product getProductById(int productId) throws SQLException {
        Product product = null;
        String query = "SELECT * FROM products WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, productId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    product = new Product();
                    product.setProduct_id(rs.getInt("product_id"));
                    product.setProductName(rs.getString("productName"));
                    product.setProductDescription(rs.getString("productDescription"));
                    product.setProductPrice(rs.getInt("productPrice"));
                    
                    // Handle possible null values or invalid timestamps
                    try {
                        product.setCreatedAt(rs.getTimestamp("createdAt"));
                    } catch (SQLException e) {
                        product.setCreatedAt(null);
                    }
                }
            }
        }
        return product;
    }

    public void updateProduct(Product product) throws SQLException {
        String query = "UPDATE products SET productName = ?, productDescription = ?, productPrice = ? WHERE product_id = ?";

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getProductDescription());
            stmt.setInt(3, product.getProductPrice());
            stmt.setInt(4, product.getProduct_id());

            stmt.executeUpdate();
        }
    }
    
 // Method to delete a product by ID
    public boolean deleteProduct(int productId) throws SQLException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        boolean isDeleted = false;

        try {
            // Get database connection
            connection = DBConnection.getConnection();

            // SQL query to delete a product
            String sql = "DELETE FROM products WHERE product_id = ?";

            // Prepare the statement
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, productId);

            // Execute the update
            int rowsAffected = preparedStatement.executeUpdate();

            // Check if the product was deleted
            if (rowsAffected > 0) {
                isDeleted = true;
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error occurred while deleting the product.");
        } finally {
            // Close resources
            if (preparedStatement != null) {
                preparedStatement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return isDeleted;
    }
}
