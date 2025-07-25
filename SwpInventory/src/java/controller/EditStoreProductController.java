/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dao.CategoryDAO;
import dao.StoreProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;

import java.util.List;
import model.Product;
import model.StoreProduct;
import java.sql.Date;
import model.Categories;
import model.Category;

/**
 *
 * @author User
 */
@WebServlet(name = "EditStoreProductController", urlPatterns = {"/edit_product"})
@MultipartConfig
public class EditStoreProductController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String idRaw = request.getParameter("id");
        int did = Integer.parseInt(idRaw);
        HttpSession session = request.getSession();
        Integer storeId = (Integer) session.getAttribute("storeId");
        StoreProductDAO dao = new StoreProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        StoreProduct detail = dao.getStoreProductById(storeId, did);
        if (detail == null) {
            response.sendRedirect("store_product_list.jsp");
            return;
        }

        List<Categories> listStoreCategory = categoryDAO.getAllCategories();

        request.setAttribute("detail", detail);
        request.setAttribute("listStoreCategory", listStoreCategory);
        request.getRequestDispatcher("edit_store_product.jsp").forward(request, response);

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        try {
            int storeProductId = Integer.parseInt(request.getParameter("storeProductId"));
            int storeCategoryId = Integer.parseInt(request.getParameter("storeCategoryId"));
            int productId = Integer.parseInt(request.getParameter("productId"));
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String oldImage = request.getParameter("oldImage");

            // lấy ảnh từ form
            Part imagePart = request.getPart("image");
            String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();

            String imagePath;
            if (imageFileName == null || imageFileName.trim().isEmpty()) {
                // không chọn ảnh mới -> giữ ảnh cũ
                imagePath = oldImage;
            } else {
                // có ảnh mới -> lưu file
                String uploadPath = getServletContext().getRealPath("/") + "assets" + File.separator + "image";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }
                imagePart.write(uploadPath + File.separator + imageFileName);

                // chỉ lưu tên file trong DB
                imagePath = imageFileName;
            }

            // tạo đối tượng
            Product p = new Product();
            p.setId(productId);
            p.setName(name);
            p.setImage(imagePath);
            p.setDescription(description);

            StoreProduct sp = new StoreProduct();
            sp.setStoreProductId(storeProductId);
            sp.setStoreCategoryId(storeCategoryId);
            sp.setProduct(p);

            // update DB
            StoreProductDAO dao = new StoreProductDAO();
            dao.updateStoreProduct(sp);

            response.sendRedirect("store_product_list");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi cập nhật sản phẩm");
            request.getRequestDispatcher("edit_store_product.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
