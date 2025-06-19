// File: src/main/java/model/Supplier.java
// (This file should be in your 'model' package)
package model;

/**
 * Represents a Supplier from the database.
 * This class maps to the 'suppliers' table.
 */
public class Supplier {

    private int supplier_id;
    private String supplier_name;
    private String phone;
    private String email;
    private String address;

    // Default constructor
    public Supplier() {
    }

    // Constructor with all fields
    public Supplier(int supplier_id, String supplier_name, String phone, String email, String address) {
        this.supplier_id = supplier_id;
        this.supplier_name = supplier_name;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }
    
    // Constructor without ID (for creating new suppliers)
    public Supplier(String supplier_name, String phone, String email, String address) {
        this.supplier_name = supplier_name;
        this.phone = phone;
        this.email = email;
        this.address = address;
    }


    // --- Getters and Setters for all fields ---

    public int getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public String getSupplier_name() {
        return supplier_name;
    }

    public void setSupplier_name(String supplier_name) {
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
