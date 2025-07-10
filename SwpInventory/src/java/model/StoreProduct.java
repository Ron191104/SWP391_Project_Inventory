/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class StoreProduct {

    private int storeProductId;
    private int storeId;
    private int storeCategoryId;
    private Product product;
    private double priceOut;
    private int quantity;
    private String baseUnitName;
    private double priceIn;

    public StoreProduct() {
    }

    public StoreProduct(int storeProductId, int storeId, int storeCategoryId, Product product, double priceOut, int quantity) {
        this.storeProductId = storeProductId;
        this.storeId = storeId;
        this.storeCategoryId = storeCategoryId;
        this.product = product;
        this.priceOut = priceOut;
        this.quantity = quantity;
    }

    public StoreProduct(int storeProductId, int storeId, int storeCategoryId, Product product, double priceOut, int quantity, String baseUnitName) {
        this.storeProductId = storeProductId;
        this.storeId = storeId;
        this.storeCategoryId = storeCategoryId;
        this.product = product;
        this.priceOut = priceOut;
        this.quantity = quantity;
        this.baseUnitName = baseUnitName;
    }

    public int getStoreProductId() {
        return storeProductId;
    }

    public void setStoreProductId(int storeProductId) {
        this.storeProductId = storeProductId;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public int getStoreCategoryId() {
        return storeCategoryId;
    }

    public void setStoreCategoryId(int storeCategoryId) {
        this.storeCategoryId = storeCategoryId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public double getPriceOut() {
        return priceOut;
    }

    public void setPriceOut(double priceOut) {
        this.priceOut = priceOut;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getBaseUnitName() {
        return baseUnitName;
    }

    public void setBaseUnitName(String baseUnitName) {
        this.baseUnitName = baseUnitName;
    }

    public double getPriceIn() {
        return priceIn;
    }

    public void setPriceIn(double priceIn) {
        this.priceIn = priceIn;
    }

    @Override
    public String toString() {
        return "StoreProduct{" + "storeProductId=" + storeProductId + ", storeId=" + storeId + ", storeCategoryId=" + storeCategoryId + ", product=" + product + ", priceOut=" + priceOut + ", quantity=" + quantity + '}';
    }

}
