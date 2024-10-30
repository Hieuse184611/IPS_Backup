/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package isp392.blog;

import java.sql.Date;
import javafx.scene.chart.PieChart;

/**
 *
 * @author Hieu
 */
public class BlogDTO {

    private int blogID;
    private int staffID;
    private String title;
    private String image;
    private String description;
    private Date createDate;
    private boolean status;

    public BlogDTO() {
    }

    public BlogDTO(int blogID, int staffID, String title, String image, String description, Date createDate, boolean status) {
        this.blogID = blogID;
        this.staffID = staffID;
        this.title = title;
        this.image = image;
        this.description = description;
        this.createDate = createDate;
        this.status = status;
    }

    public int getBlogID() {
        return blogID;
    }

    public void setBlogID(int blogID) {
        this.blogID = blogID;
    }

    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
