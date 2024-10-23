/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package isp392.blog;

/**
 *
 * @author GIGABYTE
 */
public class BlogError {

    private String blogIDErr;
    private String staffIDErr;
    private String titleErr;
    private String imageErr;
    private String statusErr;
    private String error;

    public BlogError() {
    }

    public BlogError(String blogIDErr, String staffIDErr, String titleErr, String imageErr, String statusErr, String error) {
        this.blogIDErr = blogIDErr;
        this.staffIDErr = staffIDErr;
        this.titleErr = titleErr;
        this.imageErr = imageErr;
        this.statusErr = statusErr;
        this.error = error;
    }

    public String getBlogIDErr() {
        return blogIDErr;
    }

    public void setBlogIDErr(String blogIDErr) {
        this.blogIDErr = blogIDErr;
    }

    public String getStaffIDErr() {
        return staffIDErr;
    }

    public void setStaffIDErr(String staffIDErr) {
        this.staffIDErr = staffIDErr;
    }

    public String getTitleErr() {
        return titleErr;
    }

    public void setTitleErr(String titleErr) {
        this.titleErr = titleErr;
    }

    public String getImageErr() {
        return imageErr;
    }

    public void setImageErr(String imageErr) {
        this.imageErr = imageErr;
    }

    public String getStatusErr() {
        return statusErr;
    }

    public void setStatusErr(String statusErr) {
        this.statusErr = statusErr;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }
    
    
}
