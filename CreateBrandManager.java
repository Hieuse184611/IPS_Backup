/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package isp392.controllers;

import isp392.brand.BrandDAO;
import isp392.brand.BrandError;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import net.coobird.thumbnailator.Thumbnails;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
public class CreateBrandManager extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "img";
    private static final String ERROR = "MGR_CreateBrand.jsp";
    private static final String SUCCESS = "ShowAllBrandManager";
    private static final int IMAGE_WIDTH = 500;
    private static final int IMAGE_HEIGHT = 500;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        BrandDAO dao = new BrandDAO();
        BrandError brandErr = new BrandError();
        String url = ERROR;
        boolean validation = true;
        try {
            Part filePart = request.getPart("brandImage");
            String name = request.getParameter("brandName");
            String description = request.getParameter("description");
            boolean status = true;
            int managerID = 4;

            if (validation) {
                String imagePath = "";
                String path = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
                File uploadDir = new File(path);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // Tạo tên ảnh ngẫu nhiên và lưu ảnh
                String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                imagePath = UPLOAD_DIRECTORY + File.separator + fileName;
                File outputFile = new File(path + File.separator + fileName);

                // Resize ảnh
                Thumbnails.of(filePart.getInputStream())
                        .size(IMAGE_WIDTH, IMAGE_HEIGHT)
                        .toFile(outputFile);
                filePart.write(path + File.separator + fileName);

                // Gọi DAO để thêm brand vào database
                boolean check = dao.addBrand(name, description, imagePath, managerID, status);
                if (check) {
                    url = SUCCESS; // Điều hướng về trang quản lý brand sau khi thành công
                }
            } else {
                request.setAttribute("ERROR", brandErr);
            }
        } catch (IOException | ClassNotFoundException | SQLException | ServletException e) {
            log("Error at CreateBrandManager: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
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
