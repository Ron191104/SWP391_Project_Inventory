/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class Product {

    private int id;
    private String name;
    private String barcode;
    private int category_id;
    private int supplier_id;
    private double price;
    private int quantity;
    private String unit;
    private Date manufacture_date;
    private Date expired_date;
    private String image;
    private String description;

    public Product() {
    }

    public Product(int id, String name, String barcode, int category_id, int supplier_id, double price, int quantity, String unit, Date manufacture_date, Date expired_date, String image, String description) {
        this.id = id;
        this.name = name;
        this.barcode = barcode;
        this.category_id = category_id;
        this.supplier_id = supplier_id;
        this.price = price;
        this.quantity = quantity;
        this.unit = unit;
        this.manufacture_date = manufacture_date;
        this.expired_date = expired_date;
        this.image = image;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(String barcode) {
        this.barcode = barcode;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }

    public int getSupplier_id() {
        return supplier_id;
    }

    public void setSupplier_id(int supplier_id) {
        this.supplier_id = supplier_id;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

  

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public Date getManufacture_date() {
        return manufacture_date;
    }

    public void setManufacture_date(Date manufacture_date) {
        this.manufacture_date = manufacture_date;
    }

    public Date getExpired_date() {
        return expired_date;
    }

    public void setExpired_date(Date expired_date) {
        this.expired_date = expired_date;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }



    @Override
    public String toString() {
        return "Product{" + "id=" + id + ", name=" + name + ", barcode=" + barcode + ", category_id=" + category_id + ", supplier_id=" + supplier_id + ", price=" + price + ", quantity=" + quantity + ", unit=" + unit + ", manufacture_date=" + manufacture_date + ", expired_date=" + expired_date + ", image=" + image + ", description=" + description + ", status=" + '}';
    }
    
    
    
}
