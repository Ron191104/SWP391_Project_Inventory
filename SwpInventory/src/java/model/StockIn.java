/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.util.Date;
/**
 *
 * @author User
 */
public class StockIn {
    private int stockInId;
    private int supplierId;
    private int employeeId;
    private Date stockInDate;
    private String note;
    private Date createdAt;

    public StockIn() {}

    public StockIn(int stockInId, int supplierId, int employeeId, java.util.Date stockInDate,
                   String note, java.util.Date createdAt) {
        this.stockInId = stockInId;
        this.supplierId = supplierId;
        this.employeeId = employeeId;
        this.stockInDate = stockInDate;
        this.note = note;
        this.createdAt = createdAt;
    }

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

    public int getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(int employeeId) {
        this.employeeId = employeeId;
    }

    public java.util.Date getStockInDate() {
        return stockInDate;
    }

    public void setStockInDate(java.util.Date stockInDate) {
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

    public void setCreatedAt(java.util.Date createdAt) {
        this.createdAt = createdAt;
    }
}


