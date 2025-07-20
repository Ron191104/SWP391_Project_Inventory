package model;

import java.util.Date;

public class ReturnRequest {

    private int id; 
    private int supplier_id;
    private int employee_id;
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
        return supplier_id;
    }

    public void setSupplierId(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public int getEmployeeId() {
        return employee_id;
    }

    public void setEmployeeId(int employee_id) {
        this.employee_id = employee_id;
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
