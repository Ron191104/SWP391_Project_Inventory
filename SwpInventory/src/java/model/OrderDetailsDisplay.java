package model;

public class OrderDetailsDisplay {
    private int orderId;
    private String productName;
    private int quantity;
    private String unit;
    private double price;

    public OrderDetailsDisplay() {}

    public OrderDetailsDisplay(int orderId, String productName, int quantity, String unit, double price) {
        this.orderId = orderId;
        this.productName = productName;
        this.quantity = quantity;
        this.unit = unit;
        this.price = price;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }
}
