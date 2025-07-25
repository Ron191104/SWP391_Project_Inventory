/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */
public class StockInDetail {

    private int stockInDetailId;
    private double stockInId;
    private int productId;
    private int quantity;
    private double priceIn;
    private java.util.Date manufactureDate;
    private java.util.Date expiredDate;
    private String productName;

    public StockInDetail() {
    }

    public StockInDetail(int stockInDetailId, double stockInId, int productId, int quantity,
            double priceIn, java.util.Date manufactureDate, java.util.Date expiredDate) {
        this.stockInDetailId = stockInDetailId;
        this.stockInId = stockInId;
        this.productId = productId;
        this.quantity = quantity;
        this.priceIn = priceIn;
        this.manufactureDate = manufactureDate;
        this.expiredDate = expiredDate;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getStockInDetailId() {
        return stockInDetailId;
    }

    public void setStockInDetailId(int stockInDetailId) {
        this.stockInDetailId = stockInDetailId;
    }

    public double getStockInId() {
        return stockInId;
    }

    public void setStockInId(int stockInId) {
        this.stockInId = stockInId;
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

    public double getPriceIn() {
        return priceIn;
    }

    public void setPriceIn(double priceIn) {
        this.priceIn = priceIn;
    }

    public java.util.Date getManufactureDate() {
        return manufactureDate;
    }

    public void setManufactureDate(java.util.Date manufactureDate) {
        this.manufactureDate = manufactureDate;
    }

    public java.util.Date getExpiredDate() {
        return expiredDate;
    }

    public void setExpiredDate(java.util.Date expiredDate) {
        this.expiredDate = expiredDate;
    }


}
