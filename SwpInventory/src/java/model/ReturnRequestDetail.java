package model;

public class ReturnRequestDetail {

    private int returnId;
    private int productId;
    private int quantity;

    private String productName;  
    private String unit;         
    private double price;        

    public ReturnRequestDetail() {
    }

    public ReturnRequestDetail(int returnId, int productId, int quantity) {
        this.returnId = returnId;
        this.productId = productId;
        this.quantity = quantity;
    }

    public int getReturnId() {
        return returnId;
    }

    public void setReturnId(int returnId) {
        this.returnId = returnId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
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
