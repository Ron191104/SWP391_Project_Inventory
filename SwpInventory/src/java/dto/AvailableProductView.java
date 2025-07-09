package dto;

public class AvailableProductView {
    private int productId;
    private String productName;
    private int inventoryQuantity;
    private String categoryName;
    private String supplierName;

    public AvailableProductView() {}

    public AvailableProductView(int productId, String productName, int inventoryQuantity, String categoryName, String supplierName) {
        this.productId = productId;
        this.productName = productName;
        this.inventoryQuantity = inventoryQuantity;
        this.categoryName = categoryName;
        this.supplierName = supplierName;
    }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public int getInventoryQuantity() { return inventoryQuantity; }
    public void setInventoryQuantity(int inventoryQuantity) { this.inventoryQuantity = inventoryQuantity; }
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }
}