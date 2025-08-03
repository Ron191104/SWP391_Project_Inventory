package model;

public class SupplierAdmin {
    private int supplierId;
    private String supplierName;
    private String phone;
    private String email;
    private String address;
    private int status; // thêm thuộc tính status

    // Constructor đầy đủ có status
    public SupplierAdmin(int supplierId, String supplierName, String phone, String email, String address, int status) {
        this.supplierId = supplierId;
        this.supplierName = supplierName;
        this.phone = phone;
        this.email = email;
        this.address = address;
        this.status = status;
    }

    // Getters & Setters
    public int getSupplierId() { return supplierId; }
    public void setSupplierId(int supplierId) { this.supplierId = supplierId; }

    public String getSupplierName() { return supplierName; }
    public void setSupplierName(String supplierName) { this.supplierName = supplierName; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public int getStatus() { return status; }
    public void setStatus(int status) { this.status = status; }
}
