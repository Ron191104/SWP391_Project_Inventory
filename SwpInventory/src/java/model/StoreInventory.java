package model;

public class StoreInventory {
    private int storeId;
    private String storeName;
    private int productId;
    private String productName;
    private String categoryName;
    private String supplierName;
    private int stockQuantity;
    private String unit;
    private double price;
    private double priceOut;

    // Default constructor
    public StoreInventory() {}

    // Full constructor
    public StoreInventory(int storeId, String storeName, int productId, String productName,
                         String categoryName, String supplierName, int stockQuantity,
                         String unit, double price, double priceOut) {
        this.storeId = storeId;
        this.storeName = storeName;
        this.productId = productId;
        this.productName = productName;
        this.categoryName = categoryName;
        this.supplierName = supplierName;
        this.stockQuantity = stockQuantity;
        this.unit = unit;
        this.price = price;
        this.priceOut = priceOut;
    }

    // Getters & Setters
    public int getStoreId() { return storeId; }
    public void setStoreId(int storeId) { this.storeId = storeId; }

    public String getStoreName() { return storeName; }
    public void setStoreName(String storeName) { this.storeName = storeName; }

    public int getProductId() { return productId; }
    public void setProductId(int productId) { this.productId = productId; }

    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }

    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }

    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }

    public int getStockQuantity() { return stockQuantity; }
    public void setStockQuantity(int stockQuantity) { this.stockQuantity = stockQuantity; }

    public String getUnit() { return unit; }
    public void setUnit(String unit) { this.unit = unit; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public double getPriceOut() { return priceOut; }
    public void setPriceOut(double priceOut) { this.priceOut = priceOut; }

    // Optionally: toString() for debugging
    @Override
    public String toString() {
        return "StoreInventory{" +
                "storeId=" + storeId +
                ", storeName='" + storeName + '\'' +
                ", productId=" + productId +
                ", productName='" + productName + '\'' +
                ", categoryName='" + categoryName + '\'' +
                ", supplierName='" + supplierName + '\'' +
                ", stockQuantity=" + stockQuantity +
                ", unit='" + unit + '\'' +
                ", price=" + price +
                ", priceOut=" + priceOut +
                '}';
    }
}