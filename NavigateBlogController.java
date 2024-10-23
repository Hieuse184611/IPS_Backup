/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package isp392.controllers;

import isp392.blog.BlogDAO;
import isp392.blog.BlogDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class NavigateBlogController extends HttpServlet {

    private static final String SUCCESS = "blog.jsp";
    private static final String ERROR = "HomeController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            BlogDAO blogDAO = new BlogDAO();
            List<BlogDTO> blogList = blogDAO.getListBlog();
            if (blogList != null && !blogList.isEmpty()) {
                request.setAttribute("BLOG_LIST", blogList);
            } else {
                request.setAttribute("ERROR", "No blogs found.");
            }

            List<BlogDTO> newestBlog = blogDAO.getNewestBlog();
            if (newestBlog != null && !newestBlog.isEmpty()) {
                request.setAttribute("BLOG_NEWEST_LIST", newestBlog);
            } else {
                request.setAttribute("ERROR", "No blogs found.");
            }
//            List<BlogDTO> detailBlog = blogDAO.getBlogByID(0);
//            if (detailBlog != null && !detailBlog.isEmpty()) {
//                request.setAttribute("BLOG_DETAIL", detailBlog);
//            } else {
//                request.setAttribute("ERROR", "No blogs found.");
//            }
            url = SUCCESS;
        } catch (Exception e) {
            log("Error at NavigateBlogController: " + e.toString());
            request.setAttribute("ERROR", "An unexpected error occurred.");
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
