/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author User
 */
import java.util.List;
import model.Product;

public class TestProductDAO {
    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Product> list = dao.getAllProduct();
        System.out.println("✔ Tổng số sản phẩm lấy được: " + list.size());
        System.out.println("🏷 đang dùng ProductDAO ở: " + ProductDAO.class.getResource("ProductDAO.class"));
        System.out.println("🟢 ProductDAO đang chạy từ source này");

        for (Product p : list) {
            System.out.println("→ " + p.getId() + " | " + p.getName());
        }
    }
}

