package model;

public class StoreInventory {

    private String productName;
    private String categoryName;
    private String supplierName;
    private int quantityMain;       // SL Kho Tổng
    private int quantityCauGiay;    // SL CN Cầu Giấy
    private int quantityQuocOai;    // SL CN Quốc Oai
    private int totalQuantity;      // Tổng Cộng
    private String unit;
    private double priceIn;         // Giá nhập
    private double priceOut;        // Giá bán (new field)

    public StoreInventory() {
    }

    // Constructor đầy đủ tham số
    public StoreInventory(String productName, String categoryName, String supplierName,
                          int quantityMain, int quantityCauGiay, int quantityQuocOai,
                          int totalQuantity, String unit, double priceIn, double priceOut) { // priceOut added
        this.productName = productName;
        this.categoryName = categoryName;
        this.supplierName = supplierName;
        this.quantityMain = quantityMain;
        this.quantityCauGiay = quantityCauGiay;
        this.quantityQuocOai = quantityQuocOai;
        this.totalQuantity = totalQuantity;
        this.unit = unit;
        this.priceIn = priceIn;
        this.priceOut = priceOut; // Initialize new field
    }

    // Getters and Setters
    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    public int getQuantityMain() {
        return quantityMain;
    }

    public void setQuantityMain(int quantityMain) {
        this.quantityMain = quantityMain;
    }

    public int getQuantityCauGiay() {
        return quantityCauGiay;
    }

    public void setQuantityCauGiay(int quantityCauGiay) {
        this.quantityCauGiay = quantityCauGiay;
    }

    public int getQuantityQuocOai() {
        return quantityQuocOai;
    }

    public void setQuantityQuocOai(int quantityQuocOai) {
        this.quantityQuocOai = quantityQuocOai;
    }

    public int getTotalQuantity() {
        return totalQuantity;
    }

    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit;
    }

    public double getPriceIn() {
        return priceIn;
    }

    public void setPriceIn(double priceIn) {
        this.priceIn = priceIn;
    }

    // New getter for priceOut
    public double getPriceOut() {
        return priceOut;
    }

    // New setter for priceOut
    public void setPriceOut(double priceOut) {
        this.priceOut = priceOut;
    }
}