

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;

import com.sun.jdi.connect.spi.Connection;
import dal.DBConnect;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Product;
import dao.ProductDAO;
import java.lang.System.Logger;
import java.lang.System.Logger.Level;

/**
 *
 * @author ADMIN
 */
public class ProductDAO {

    java.sql.Connection con = null;


    PreparedStatement ps = null;
    ResultSet rs = null;

    public List<Product> getAllProduct() {
        List<Product> list = new ArrayList<>();
        String query = "select * from Products";
        try {
            con = DBConnect.getConnection();
            ps = con.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {


                list.add(new Product(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getInt(4),
                        rs.getInt(5), rs.getDouble(6), rs.getInt(7), rs.getString(8),
                        rs.getDate(9), rs.getDate(10), rs.getString(11), rs.getString(12)));
            }
        } catch (Exception e) {

        }

        return list;
    }



}
