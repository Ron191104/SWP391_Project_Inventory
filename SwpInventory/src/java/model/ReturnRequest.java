/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

public class ReturnRequest {
    private int returnId;
    private int supplierId;
    private int employeeId;
    private String reason;
    private String note;
    private int status;
    private Date createdAt;

    public ReturnRequest() {
    }

    
    public ReturnRequest(int returnId, int supplierId, int employeeId, String reason, String note, int status, Date createdAt) {
        this.returnId = returnId;
        this.supplierId = supplierId;
        this.employeeId = employeeId;
        this.reason = reason;
        this.note = note;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getReturnId() {
        return returnId;
    }

    public void setReturnId(int returnId) {
        this.returnId = returnId;
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

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    
    
}
