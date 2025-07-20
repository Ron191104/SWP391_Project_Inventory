package model;

import java.util.Date;
import java.util.List;

public class ReturnRequest {

    private int id;
    private int supplier_id;
    private int employee_id;
    private String reason;
    private String note;
    private Date createdDate;
    private int status;

    // Bổ sung cho hiển thị
    private String supplierName;
    private String employeeName;

    // Danh sách chi tiết trả hàng
    private List<ReturnRequestDetail> details;

    public ReturnRequest() {
    }

    // Các Getter và Setter thông thường

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

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

    // Các trường hiển thị thêm

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public String getEmployeeName() {
        return employeeName;
    }

    public void setEmployeeName(String employeeName) {
        this.employeeName = employeeName;
    }

    // Getter và Setter cho details

    public List<ReturnRequestDetail> getDetails() {
        return details;
    }

    public void setDetails(List<ReturnRequestDetail> details) {
        this.details = details;
    }
}
