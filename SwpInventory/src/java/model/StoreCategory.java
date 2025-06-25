/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class StoreCategory {
    private int storeCategoryId;
    private int storeId;
    private String categoryName;
    private int quantity;

    public StoreCategory() {
    }

    public StoreCategory(int storeCategoryId, int storeId, String categoryName) {
        this.storeCategoryId = storeCategoryId;
        this.storeId = storeId;
        this.categoryName = categoryName;
    }

    public int getStoreCategoryId() {
        return storeCategoryId;
    }

    public void setStoreCategoryId(int storeCategoryId) {
        this.storeCategoryId = storeCategoryId;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    

    @Override
    public String toString() {
        return "StoreCategory{" + "storeCategoryId=" + storeCategoryId + ", storeId=" + storeId + ", categoryName=" + categoryName + '}';
    }
    
    
}
