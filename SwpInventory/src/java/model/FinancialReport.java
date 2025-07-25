package model;

public class FinancialReport {
    private String timeLabel;
    private double revenue;
    private double cost;
    private double profit;
    private int saleOrders;
    private int stockInOrders;
    private double profitMargin;

    public FinancialReport(String timeLabel, double revenue, double cost, double profit, int saleOrders, int stockInOrders, double profitMargin) {
        this.timeLabel = timeLabel;
        this.revenue = revenue;
        this.cost = cost;
        this.profit = profit;
        this.saleOrders = saleOrders;
        this.stockInOrders = stockInOrders;
        this.profitMargin = profitMargin;
    }

    public String getTimeLabel() {
        return timeLabel;
    }

    public double getRevenue() {
        return revenue;
    }

    public double getCost() {
        return cost;
    }

    public double getProfit() {
        return profit;
    }

    public int getSaleOrders() {
        return saleOrders;
    }

    public int getStockInOrders() {
        return stockInOrders;
    }

    public double getProfitMargin() {
        return profitMargin;
    }
}
