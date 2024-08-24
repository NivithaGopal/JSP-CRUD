package bean;

import java.sql.Timestamp;

public class Product {
	
    public Timestamp getCreatedAt() {
		return createdAt;
	}
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}

	private int product_id;
    private String productName;
    private String productDescription;
    private int productPrice;
    private Timestamp createdAt;
	public Product(int product_id, String productName, String productDescription, int productPrice,
			Timestamp createdAt) {
		super();
		this.product_id = product_id;
		this.productName = productName;
		this.productDescription = productDescription;
		this.productPrice = productPrice;
		this.createdAt = createdAt;
	}
	public Product() {
		super();
	}
	public int getProduct_id() {
		return product_id;
	}
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getProductDescription() {
		return productDescription;
	}
	public void setProductDescription(String productDescription) {
		this.productDescription = productDescription;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	
	@Override
	public String toString() {
		return "Product [product_id=" + product_id + ", productName=" + productName + ", productDescription="
				+ productDescription + ", productPrice=" + productPrice + ", createdAt=" + createdAt + "]";
	}
    
 }