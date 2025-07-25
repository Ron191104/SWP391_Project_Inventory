/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.util.List;

/**
 *
 * @author User
 */
public class StockIn {

    private int stockInId;
    private int supplierId;
    private String supplierName;
    private int employeeId;
    private Date stockInDate;
    private String note;
    private Date createdAt;

    private List<StockInDetail> details; // ✅ Thêm danh sách chi tiết

    public StockIn() {
    }

    public StockIn(int stockInId, int supplierId, int employeeId, Date stockInDate,
            String note, Date createdAt) {
        this.stockInId = stockInId;
        this.supplierId = supplierId;
        this.employeeId = employeeId;
        this.stockInDate = stockInDate;
        this.note = note;
        this.createdAt = createdAt;
    }

    // Getters & Setters
    public int getStockInId() {
        return stockInId;
    }

    public void setStockInId(int stockInId) {
        this.stockInId = stockInId;
    }

    public int getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(int supplierId) {
        this.supplierId = supplierId;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public Date getStockInDate() {
        return stockInDate;
    }

    public void setStockInDate(Date stockInDate) {
        this.stockInDate = stockInDate;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public List<StockInDetail> getDetails() {
        return details;
    }

    public void setDetails(List<StockInDetail> details) {
        this.details = details;
    }
}
