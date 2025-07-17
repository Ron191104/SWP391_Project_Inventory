package model;

import java.util.Date;

public class ReturnRequest {

    private int id; 
    private int supplierId;
    private int employeeId;
    private String reason;
    private String note;
    private Date createdDate;
    private int status;

    public ReturnRequest() {
    }

    // 
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    // 
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

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }
}
