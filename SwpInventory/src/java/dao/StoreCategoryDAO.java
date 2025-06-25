/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import model.StoreCategory;
import model.StoreProduct;

/**
 *
 * @author ADMIN
 */
public class StoreCategoryDAO {

    java.sql.Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<StoreCategory> getAllStoreCategory(int storeId) {
        List<StoreCategory> list = new ArrayList<>();
        String query = "select*from store_categories where store_id=?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);

            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new StoreCategory(rs.getInt(1), rs.getInt(2), rs.getString(3)));
            }
        } catch (Exception e) {
            e.printStackTrace();

        }

        return list;
    }

    public void addStoreCategory(StoreCategory category) {
        String query = "insert into store_categories (store_id, category_name) values (?, ?)";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, category.getStoreId());
            ps.setString(2, category.getCategoryName());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public StoreCategory getStoreCategoryById(int categoryId, int storeId) {
        String query = "select*fROM store_categories WHERE store_category_id = ? and store_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, categoryId);
            ps.setInt(2, storeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return new StoreCategory(
                        rs.getInt(1),
                        rs.getInt(2),
                        rs.getString(3)
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateStoreCategory(int categoryId, int storeId, String name) {
        String query = "update store_categories set category_name = ? where store_category_id = ? and store_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setInt(2, categoryId);
            ps.setInt(3, storeId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteCategory(int storeId, int storeCategoryId) {

        try {
            con = DBConnect.getConnection();
            StoreCategoryDAO categoryDAO = new StoreCategoryDAO();

            int naCategoryId = categoryDAO.getNACategoryId(storeId);

            String updateProducts = "UPDATE store_products SET store_category_id = ? WHERE store_id = ? AND store_category_id = ?";
            ps = con.prepareStatement(updateProducts);
            ps.setInt(1, naCategoryId);
            ps.setInt(2, storeId);
            ps.setInt(3, storeCategoryId);
            ps.executeUpdate();

            String deleteQuery = "DELETE FROM store_categories WHERE store_id = ? AND store_category_id = ?";
            ps = con.prepareStatement(deleteQuery);
            ps.setInt(1, storeId);
            ps.setInt(2, storeCategoryId);
            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int getNACategoryId(int storeId) {
        String query = "SELECT store_category_id FROM store_categories WHERE store_id = ? AND category_name = 'N/A'";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<StoreCategory> getCategoriesByStoreId(int storeId) {
        List<StoreCategory> list = new ArrayList<>();
        String query = "select *from store_categories where store_id = ?";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            ps.setInt(1, storeId);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new StoreCategory(
                        rs.getInt("store_category_id"),
                        rs.getInt("store_id"),
                        rs.getString("category_name")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
