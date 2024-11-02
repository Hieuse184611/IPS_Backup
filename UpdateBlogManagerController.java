/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package isp392.controllers;

import isp392.blog.BlogDAO;
import isp392.blog.BlogDTO;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Paths;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import net.coobird.thumbnailator.Thumbnails;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50 // 50MB
)
//@WebServlet(name = "UpdateBlogManagerController", urlPatterns = {"/UpdateBlogManagerController"})
public class UpdateBlogManagerController extends HttpServlet {

    private static final String SUCCESS = "ShowAllBlogManager";
    private static final String ERROR = "ShowAllBlogManager";
    private static final String UPLOAD_DIRECTORY = "img";
    private static final int IMAGE_WIDTH = 500;
    private static final int IMAGE_HEIGHT = 500;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            Part filePart = request.getPart("blogImage");
            String title = request.getParameter("title");
            String description = request.getParameter("description");
            int blogID = Integer.parseInt(request.getParameter("blogID"));
            int staffID = Integer.parseInt(request.getParameter("staffID"));
            String createDate = request.getParameter("createDate");
            boolean status = Boolean.parseBoolean(request.getParameter("status"));
            String existingImage = request.getParameter("existingImage");
            String image = existingImage;
            String imagePath = "";
            String path = getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY;
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }
            if (filePart != null && filePart.getSize() > 0) {
                String fileName = UUID.randomUUID().toString() + "_" + Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                imagePath = UPLOAD_DIRECTORY + File.separator + fileName;
                File outputFile = new File(path + File.separator + fileName);

                // Resize the image
                Thumbnails.of(filePart.getInputStream())
                        .size(IMAGE_WIDTH, IMAGE_HEIGHT)
                        .toFile(outputFile);
                filePart.write(path + File.separator + fileName);
                image = imagePath;
            }

// Parse createDate with SimpleDateFormat
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date utilCreateDate = formatter.parse(createDate);
            Date sqlCreateDate = new Date(utilCreateDate.getTime()); // Convert to java.sql.Date

            BlogDAO blogDAO = new BlogDAO();
            BlogDTO blogDTO = new BlogDTO(blogID, staffID, title, image, description, sqlCreateDate, status);

            boolean isUpdated = blogDAO.updateBlog(blogDTO);
            if (isUpdated) {
                url = SUCCESS;
            }
        } catch (Exception e) {
            log("Error at UpdateBlogManagerController: " + e.toString());
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
