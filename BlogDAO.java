 /*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package isp392.blog;

import isp392.brand.BrandDTO;
import isp392.user.UserDTO;
import isp392.utils.DBUtils;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import static jdk.nashorn.internal.objects.NativeString.search;

/**
 *
 * @author ThinhHoang
 */
public class BlogDAO {

    private static final String GET_LIST_BLOG = "SELECT * FROM Blog WHERE Status = 1"; 
    private static final String VIEW_BLOG_DETAIL = "SELECT * FROM Blog WHERE BlogID = ?";
    private static final String GET_BLOG_BY_ID = "SELECT * FROM Blog WHERE BlogID = ?";
    private static final String GET_BLOG_TOP3_NEWEST = "SELECT TOP 3 * FROM Blog WHERE Status = 1 ORDER BY CreateDate DESC ";
    private static final String SHOW_ALL_BLOG_MANAGER = "SELECT * FROM Blog ";
    private static final String SHOW_BLOG_HOME = "SELECT * FROM Blog WHERE Status = 1 ";
    private static final String GET_BLOG_RECENT = "SELECT TOP 3 * FROM Blog WHERE Status = 1 ORDER BY CreateDate DESC ";

    private static final String CREATE_BLOG = "INSERT INTO Blog (StaffID, Title, Image, Description, CreateDate, Status) VALUES (?,?,?,?,?,?)";
    private static final String UPDATE_BLOG = "UPDATE Blog SET  Title = ?, Image = ?, Description = ?, CreateDate = ?, Status = ? WHERE BlogID = ?";

    public List<BlogDTO> getListBlog() throws ClassCastException, SQLException, ClassNotFoundException {
        List<BlogDTO> listBlog = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_LIST_BLOG);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int blogID = rs.getInt("BlogID");
                    int staffID = rs.getInt("StaffID");
                    String title = rs.getString("Title");
                    String description = rs.getString("Description");
                    String image = rs.getString("Image");
                    Date createDate = rs.getDate("CreateDate");
                    boolean status = rs.getBoolean("Status");
                    listBlog.add(new BlogDTO(blogID, staffID, title, image, description, createDate, status));
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listBlog;
    }

    public List<BlogDTO> getListBlogManagement() throws SQLException, ClassNotFoundException {
        List<BlogDTO> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(SHOW_ALL_BLOG_MANAGER);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int blogID = rs.getInt("BlogID");
                    int staffID = rs.getInt("StaffID");
                    String title = rs.getString("Title");
                    String description = rs.getString("Description");
                    String image = rs.getString("Image");
                    Date createDate = rs.getDate("CreateDate");
                    boolean status = rs.getBoolean("Status");
                    BlogDTO newBlog = new BlogDTO(blogID, staffID, title, image, description, createDate, status);
                    list.add(newBlog);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }

    public BlogDTO getBlogByID(int blogID) throws ClassNotFoundException, SQLException {
        BlogDTO blog = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BLOG_BY_ID);
                ptm.setInt(1, blogID);
                rs = ptm.executeQuery();
                if (rs.next()) {
                    int staffID = rs.getInt("StaffID");
                    String title = rs.getString("Title");
                    String image = rs.getString("Image");
                    String description = rs.getString("Description");
                    Date createDate = rs.getDate("DreateDate");
                    boolean status = rs.getBoolean("Status");
                    blog = new BlogDTO(blogID, staffID, title, image, description, createDate, status);
                }
            }
        } finally {
            DBUtils.closeConnection3(conn, ptm, rs);
        }
        return blog;
    }

    public List<BlogDTO> getNewestBlog() throws ClassNotFoundException, SQLException {
        List<BlogDTO> listNewest = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BLOG_TOP3_NEWEST);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int blogID = rs.getInt("BlogID");
                    int staffID = rs.getInt("StaffID");
                    String title = rs.getString("Title");
                    String image = rs.getString("Image");
                    String description = rs.getString("Description");
                    Date createDate = rs.getDate("CreateDate");
                    boolean status = rs.getBoolean("Status");
                    listNewest.add(new BlogDTO(blogID, staffID, title, image, description, createDate, status));
                }
            }
        } finally {
            DBUtils.closeConnection3(conn, ptm, rs);
        }
        return listNewest;
    }
    public List<BlogDTO> getRecentBlog() throws ClassNotFoundException, SQLException {
        List<BlogDTO> listRecent = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(GET_BLOG_RECENT);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int blogID = rs.getInt("BlogID");
                    int staffID = rs.getInt("StaffID");
                    String title = rs.getString("Title");
                    String image = rs.getString("Image");
                    String description = rs.getString("Description");
                    Date createDate = rs.getDate("CreateDate");
                    boolean status = rs.getBoolean("Status");
                    listRecent.add(new BlogDTO(blogID, staffID, title, image, description, createDate, status));
                }
            }
        } finally {
            DBUtils.closeConnection3(conn, ptm, rs);
        }
        return listRecent;
    }

    public BlogDTO viewBlogDetail(int blogID) throws ClassNotFoundException, SQLException {
        BlogDTO listBlog = null;
        Connection conn = null;
        PreparedStatement ptm = null;
        ResultSet rs = null;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(VIEW_BLOG_DETAIL);
                ptm.setInt(1, blogID);
                rs = ptm.executeQuery();
                while (rs.next()) {
                    int staffID = rs.getInt("StaffID");
                    String title = rs.getString("Title");
                    String description = rs.getString("Description");
                    String image = rs.getString("Image");
                    Date createDate = rs.getDate("CreateDate");
                    boolean status = rs.getBoolean("Status");
                    listBlog = new BlogDTO(blogID, staffID, title, image, description, createDate, status);
                }
            }
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return listBlog;
    }

    public boolean updateBlog(BlogDTO blogDTO) throws ClassNotFoundException, SQLException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
//            UPDATE Blog SET  Title = ?, Image = ?, Description = ?, CreateDate = ?, Status = ? WHERE BlogID = ?
            if (conn != null) {
                ptm = conn.prepareStatement(UPDATE_BLOG);
                ptm.setString(1, blogDTO.getTitle());
                ptm.setString(2, blogDTO.getImage());
                ptm.setString(3, blogDTO.getDescription());
                ptm.setDate(4, blogDTO.getCreateDate());
                ptm.setBoolean(5, blogDTO.isStatus());
                ptm.setInt(6, blogDTO.getBlogID());
                check = ptm.executeUpdate() > 0;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean createBlog( int staffID, String title, String image, String description, Date createDate, boolean status) throws SQLException, ClassNotFoundException {
        Connection conn = null;
        PreparedStatement ptm = null;
        boolean check = false;
        try {
            conn = DBUtils.getConnection();
            if (conn != null) {
                ptm = conn.prepareStatement(CREATE_BLOG);
                //INSERT INTO Blog (StaffID, Title, Image, Description, CreateDate, Status) VALUES (?,?,?,?,?,?)
                ptm.setInt(1, staffID);
                ptm.setString(2, title);
                ptm.setString(3, image);
                ptm.setString(4, description);
                ptm.setDate(5, createDate);
                ptm.setBoolean(6, status);
                check = ptm.executeUpdate() > 0;
            }
        } finally {
            if (ptm != null) {
                ptm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
