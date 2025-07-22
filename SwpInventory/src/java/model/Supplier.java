package model;

public class Supplier {

    private int supplier_id;
    private String supplier_name;
    private String phone;
    private String email;
    private String address;

    // Default constructor
    public Supplier() {
    }

    // Constructor với đầy đủ thông tin
    public Supplier(int supplier_id, String supplier_name, String phone, String email, String address) {
        this.supplier_id = supplier_id;
        this.supplier_name = supplier_name;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }

    // Constructor không có ID (dùng khi thêm mới)
    public Supplier(String supplier_name, String phone, String email, String address) {
        this.supplier_name = supplier_name;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }

    // Constructor đơn giản với ID và tên (dùng trong DAO)
    public Supplier(int supplier_id, String supplier_name) {
        this.supplier_id = supplier_id;
        this.supplier_name = supplier_name;
    }

    // --- Getter và Setter ---

    public int getSupplierId() {
        return supplier_id;
    }

    public void setSupplierId(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public String getSupplierName() {
        return supplier_name;
    }

    public void setSupplierName(String supplier_name) {
        this.supplier_name = supplier_name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Supplier{" +
                "supplier_id=" + supplier_id +
                ", supplier_name='" + supplier_name + '\'' +
                ", phone='" + phone + '\'' +
                ", email='" + email + '\'' +
                ", address='" + address + '\'' +
                '}';
    }
}