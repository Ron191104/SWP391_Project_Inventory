/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */
public class StockOutDetail {
    private int stockOutDetailId;
    private int stockOutId;
    private int productId;
    private int quantity;
    private double priceOut;
    private String productName;

    public StockOutDetail() {}

    public StockOutDetail(int stockOutDetailId, int stockOutId, int productId, int quantity, double priceOut) {
        this.stockOutDetailId = stockOutDetailId;
        this.stockOutId = stockOutId;
        this.productId = productId;
        this.quantity = quantity;
        this.priceOut = priceOut;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }
    

    public int getStockOutDetailId() {
        return stockOutDetailId;
    }

    public void setStockOutDetailId(int stockOutDetailId) {
        this.stockOutDetailId = stockOutDetailId;
    }

    public int getStockOutId() {
        return stockOutId;
    }

    public void setStockOutId(int stockOutId) {
        this.stockOutId = stockOutId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPriceOut() {
        return priceOut;
    }

    public void setPriceOut(double priceOut) {
        this.priceOut = priceOut;
    }
}

