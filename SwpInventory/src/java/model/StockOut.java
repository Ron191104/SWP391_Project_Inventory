/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author User
 */
public class StockOut {
    private int stockOutId;
    private int employeeId;
    private java.util.Date stockOutDate;
    private String reason;
    private String note;
    private java.util.Date createdAt;
    private int status;
    private int storeId;

    public StockOut() {}

    public StockOut(int stockOutId, int employeeId, java.util.Date stockOutDate,
                    String reason, String note, java.util.Date createdAt, int status, int storeId) {
        this.stockOutId = stockOutId;
        this.employeeId = employeeId;
        this.stockOutDate = stockOutDate;
        this.reason = reason;
        this.note = note;
        this.createdAt = createdAt;
        this.status = status;
        this.storeId = storeId;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }
    

    public int getStockOutId() {
        return stockOutId;
    }

    public void setStockOutId(int stockOutId) {
        this.stockOutId = stockOutId;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public java.util.Date getStockOutDate() {
        return stockOutDate;
    }

    public void setStockOutDate(java.util.Date stockOutDate) {
        this.stockOutDate = stockOutDate;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public java.util.Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.util.Date createdAt) {
        this.createdAt = createdAt;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
    
}

