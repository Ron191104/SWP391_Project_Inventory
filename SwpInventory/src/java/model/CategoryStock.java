// File: src/main/java/model/CategoryStock.java
package model;

public class CategoryStock {
    private String categoryName;
    private int totalQuantity;

    public CategoryStock(String categoryName, int totalQuantity) {
        this.categoryName = categoryName;
        this.totalQuantity = totalQuantity;
    }

    // Getters and Setters
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
    public int getTotalQuantity() { return totalQuantity; }
    public void setTotalQuantity(int totalQuantity) { this.totalQuantity = totalQuantity; }
}