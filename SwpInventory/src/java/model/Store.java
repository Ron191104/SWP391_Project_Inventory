/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author ADMIN
 */
public class Store {

    private int storeId;
    private String storeName;
    private String address;
    private String phone;
    private String email;

    public Store() {
    }

    public Store(int storeId, String storeName, String address, String phone, String email) {
        this.storeId = storeId;
        this.storeName = storeName;
        this.address = address;
        this.phone = phone;
        this.email=email;
    }

    public int getStoreId() {
        return storeId;
    }

    public void setStoreId(int storeId) {
        this.storeId = storeId;
    }

    public String getStoreName() {
        return storeName;
    }

    public void setStoreName(String storeName) {
        this.storeName = storeName;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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
    

    @Override
    public String toString() {
        return "Store{" + "storeId=" + storeId + ", storeName=" + storeName + ", address=" + address + ", phone=" + phone + '}';
    }

}
