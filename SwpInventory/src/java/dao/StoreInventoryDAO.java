package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.StoreInventory;
import dal.DBConnect; // Đảm bảo rằng lớp DBConnect của bạn nằm trong gói dal
import model.CategoryStock;
public class StoreInventoryDAO {

    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;
    private Object model;
   

    // Phương thức mới để lấy tổng số bản ghi (cho phân trang)
    public int getTotalInventoryCount(String searchKeyword, String categoryId, String supplierId) {
        int count = 0;
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append("SELECT COUNT(p.product_id) ");
        queryBuilder.append("FROM products p ");
        queryBuilder.append("JOIN categories c ON p.category_id = c.category_id ");
        queryBuilder.append("JOIN suppliers s ON p.supplier_id = s.supplier_id ");
        queryBuilder.append("WHERE 1=1 "); // Mẹo để dễ dàng thêm các điều kiện AND

        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            queryBuilder.append("AND (p.product_name LIKE ? OR p.barcode LIKE ?) ");
        }
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            queryBuilder.append("AND c.category_id = ? ");
        }
        if (supplierId != null && !supplierId.trim().isEmpty()) {
            queryBuilder.append("AND s.supplier_id = ? ");
        }

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(queryBuilder.toString());
            int paramIndex = 1;
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
            }
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(categoryId));
            }
            if (supplierId != null && !supplierId.trim().isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(supplierId));
            }

            rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return count;
    }


    // Phương thức chính để lấy dữ liệu tồn kho với tìm kiếm, lọc, phân trang, sắp xếp
    public List<StoreInventory> getProductInventoryStats(
            String searchKeyword, String categoryId, String supplierId,
            String sortBy, String sortOrder, int pageIndex, int pageSize) {

        List<StoreInventory> list = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder();
        queryBuilder.append("SELECT\n");
        queryBuilder.append("    p.product_name AS [Tên sản phẩm],\n");
        queryBuilder.append("    c.category_name AS [Danh mục],\n");
        queryBuilder.append("    s.supplier_name AS [Nhà cung cấp],\n");
        queryBuilder.append("    p.quantity AS [SL Kho Tổng],\n");
        queryBuilder.append("    ISNULL((SELECT sp.quantity FROM store_products sp WHERE sp.product_id = p.product_id AND sp.store_id = 1), 0) AS [SL CN Cầu Giấy],\n");
        queryBuilder.append("    ISNULL((SELECT sp.quantity FROM store_products sp WHERE sp.product_id = p.product_id AND sp.store_id = 2), 0) AS [SL CN Quốc Oai],\n");
        queryBuilder.append("    (p.quantity + ISNULL((SELECT sp.quantity FROM store_products sp WHERE sp.product_id = p.product_id AND sp.store_id = 1), 0) + ISNULL((SELECT sp.quantity FROM store_products sp WHERE sp.product_id = p.product_id AND sp.store_id = 2), 0)) AS [Tổng Cộng],\n");
        queryBuilder.append("    p.unit AS [Đơn vị],\n");
        queryBuilder.append("    p.price AS [Giá nhập],\n");
        queryBuilder.append("    ISNULL((SELECT AVG(sp.price_out) FROM store_products sp WHERE sp.product_id = p.product_id AND sp.price_out > 0), 0) AS [Giá bán trung bình]\n");
        queryBuilder.append("FROM\n");
        queryBuilder.append("    products p\n");
        queryBuilder.append("JOIN\n");
        queryBuilder.append("    categories c ON p.category_id = c.category_id\n");
        queryBuilder.append("JOIN\n");
        queryBuilder.append("    suppliers s ON p.supplier_id = s.supplier_id\n");
        queryBuilder.append("WHERE 1=1 "); // Mẹo để dễ dàng thêm các điều kiện AND

        // Thêm điều kiện tìm kiếm
        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
            queryBuilder.append("AND (p.product_name LIKE ? OR p.barcode LIKE ?) ");
        }

        // Thêm điều kiện lọc theo danh mục
        if (categoryId != null && !categoryId.trim().isEmpty()) {
            queryBuilder.append("AND c.category_id = ? ");
        }

        // Thêm điều kiện lọc theo nhà cung cấp
        if (supplierId != null && !supplierId.trim().isEmpty()) {
            queryBuilder.append("AND s.supplier_id = ? ");
        }

        // Thêm sắp xếp
        String actualSortBy = "p.product_name"; // Mặc định sắp xếp theo tên sản phẩm
        if (sortBy != null && !sortBy.trim().isEmpty()) {
            switch (sortBy) {
                case "productName":
                    actualSortBy = "p.product_name";
                    break;
                case "categoryName":
                    actualSortBy = "c.category_name";
                    break;
                case "supplierName":
                    actualSortBy = "s.supplier_name";
                    break;
                case "totalQuantity":
                    actualSortBy = "[Tổng Cộng]"; // Sắp xếp theo alias của cột tính toán
                    break;
                case "priceIn":
                    actualSortBy = "p.price";
                    break;
                case "priceOut":
                    actualSortBy = "[Giá bán trung bình]"; // Sắp xếp theo alias của cột tính toán
                    break;
                // Thêm các trường hợp khác nếu bạn muốn sắp xếp theo cột nào nữa
                default:
                    actualSortBy = "p.product_name";
            }
        }
        String actualSortOrder = (sortOrder != null && sortOrder.equalsIgnoreCase("desc")) ? "DESC" : "ASC";
        queryBuilder.append("ORDER BY ").append(actualSortBy).append(" ").append(actualSortOrder).append("\n");

        // Thêm phân trang (SQL Server Syntax)
        queryBuilder.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;");

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(queryBuilder.toString());

            int paramIndex = 1;
            // Set tham số cho tìm kiếm
            if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
                ps.setString(paramIndex++, "%" + searchKeyword + "%");
            }
            // Set tham số cho lọc danh mục
            if (categoryId != null && !categoryId.trim().isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(categoryId));
            }
            // Set tham số cho lọc nhà cung cấp
            if (supplierId != null && !supplierId.trim().isEmpty()) {
                ps.setInt(paramIndex++, Integer.parseInt(supplierId));
            }
            
            // Set tham số cho phân trang
            ps.setInt(paramIndex++, (pageIndex - 1) * pageSize); // OFFSET
            ps.setInt(paramIndex++, pageSize);                   // FETCH NEXT

            rs = ps.executeQuery();
            while (rs.next()) {
                StoreInventory item = new StoreInventory();
                item.setProductName(rs.getString("Tên sản phẩm"));
                item.setCategoryName(rs.getString("Danh mục"));
                item.setSupplierName(rs.getString("Nhà cung cấp"));
                item.setQuantityMain(rs.getInt("SL Kho Tổng"));
                item.setQuantityCauGiay(rs.getInt("SL CN Cầu Giấy"));
                item.setQuantityQuocOai(rs.getInt("SL CN Quốc Oai"));
                item.setTotalQuantity(rs.getInt("Tổng Cộng"));
                item.setUnit(rs.getString("Đơn vị"));
                item.setPriceIn(rs.getDouble("Giá nhập"));
                item.setPriceOut(rs.getDouble("Giá bán trung bình"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // New methods to get categories and suppliers for dropdowns
    public List<String> getAllCategories() {
        List<String> categories = new ArrayList<>();
        String query = "SELECT category_name FROM categories ORDER BY category_name";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return categories;
    }

    public List<String> getAllSuppliers() {
        List<String> suppliers = new ArrayList<>();
        String query = "SELECT supplier_name FROM suppliers ORDER BY supplier_name";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                suppliers.add(rs.getString("supplier_name"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return suppliers;
    }

    // You might want to get category_id and supplier_id for filtering
    public List<model.Category> getCategoriesForFilter() {
        List<model.Category> categories = new ArrayList<>();
        String query = "SELECT category_id, category_name FROM categories ORDER BY category_name";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                categories.add(new model.Category(rs.getInt("category_id"), rs.getString("category_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return categories;
    }

    public List<model.Supplier> getSuppliersForFilter() {
        List<model.Supplier> suppliers = new ArrayList<>();
        String query = "SELECT supplier_id, supplier_name FROM suppliers ORDER BY supplier_name";
        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                suppliers.add(new model.Supplier(rs.getInt("supplier_id"), rs.getString("supplier_name")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return suppliers;
    }
    
    // Phương thức để lấy danh sách N sản phẩm tồn kho nhiều nhất
    public List<StoreInventory> getTopNMostStockedProducts(int limit) {
        List<StoreInventory> list = new ArrayList<>();
        // Câu truy vấn SQL để lấy Top N sản phẩm có tổng số lượng tồn kho cao nhất
        // Điều chỉnh lại query để tính tổng tồn kho chính xác hơn
        String query = "SELECT TOP (?) "
                     + "    p.product_name AS [Tên sản phẩm],\n"
                     + "    (ISNULL(p.quantity, 0) + ISNULL(SUM(sp.quantity), 0)) AS [Tổng Cộng]\n" // Sửa ở đây
                     + "FROM\n"
                     + "    products p\n"
                     + "LEFT JOIN\n" // Dùng LEFT JOIN để bao gồm cả sản phẩm chưa có trong store_products
                     + "    store_products sp ON p.product_id = sp.product_id\n"
                     + "GROUP BY\n" // Cần GROUP BY khi dùng SUM
                     + "    p.product_id, p.product_name, p.quantity\n" // Bao gồm p.quantity trong GROUP BY nếu dùng nó trực tiếp
                     + "ORDER BY\n"
                     + "    [Tổng Cộng] DESC;";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                StoreInventory item = new StoreInventory();
                item.setProductName(rs.getString("Tên sản phẩm"));
                item.setTotalQuantity(rs.getInt("Tổng Cộng"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // Phương thức để lấy danh sách N sản phẩm tồn kho ít nhất
    public List<StoreInventory> getTopNLeastStockedProducts(int limit) {
        List<StoreInventory> list = new ArrayList<>();
        String query = "SELECT TOP (?) "
                     + "    p.product_name AS [Tên sản phẩm],\n"
                     + "    (ISNULL(p.quantity, 0) + ISNULL(SUM(sp.quantity), 0)) AS [Tổng Cộng]\n" // Sửa ở đây
                     + "FROM\n"
                     + "    products p\n"
                     + "LEFT JOIN\n"
                     + "    store_products sp ON p.product_id = sp.product_id\n"
                     + "GROUP BY\n"
                     + "    p.product_id, p.product_name, p.quantity\n"
                     + "ORDER BY\n"
                     + "    [Tổng Cộng] ASC;"; // Sắp xếp tăng dần để lấy top N ít nhất
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            ps.setInt(1, limit);
            rs = ps.executeQuery();
            while (rs.next()) {
                StoreInventory item = new StoreInventory();
                item.setProductName(rs.getString("Tên sản phẩm"));
                item.setTotalQuantity(rs.getInt("Tổng Cộng"));
                list.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }

    // Phương thức để lấy tổng tồn kho theo danh mục
   public List<CategoryStock> getCategoryStockDistribution() {
        List<CategoryStock> list = new ArrayList<>();
        String query = "SELECT\n"
                     + "    c.category_name,\n"
                     + "    SUM(ISNULL(p.quantity, 0) + ISNULL(sp.quantity, 0)) AS TotalCategoryQuantity\n" // Đã chỉnh sửa
                     + "FROM\n"
                     + "    products p\n"
                     + "LEFT JOIN\n"
                     + "    categories c ON p.category_id = c.category_id\n"
                     + "LEFT JOIN\n"
                     + "    store_products sp ON p.product_id = sp.product_id\n" // Thêm join với store_products
                     + "GROUP BY\n"
                     + "    c.category_name\n"
                     + "ORDER BY\n"
                     + "    TotalCategoryQuantity DESC;";

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = new DBConnect().getConnection();
            ps = conn.prepareStatement(query);
            rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new CategoryStock(rs.getString("category_name"), rs.getInt("TotalCategoryQuantity")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return list;
    }
    
    
}