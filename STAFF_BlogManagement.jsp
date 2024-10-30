<%-- 
    Document   : STAFF_BlogManagement
    Created on : Oct 16, 2024, 12:36:23 PM
    Author     : User
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>DASHMIN - Bootstrap Admin Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="" name="keywords">
        <meta content="" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

        <!-- Customized Bootstrap Stylesheet -->
        <link href="dashmin/css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="dashmin/css/style.css" rel="stylesheet">
    </head>

    <body>
        <div class="container-fluid position-relative bg-white d-flex p-0">
            <!-- Spinner Start -->
            <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                    <span class="sr-only">Loading...</span>
                </div>
            </div>
            <!-- Spinner End -->


            <!-- Sidebar Start -->
            <div class="sidebar pe-4 pb-3">
                <nav class="navbar bg-light navbar-light">
                    <a href="" class="navbar-brand mx-4 mb-3">
                        <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>DASHMIN</h3>
                    </a>
                    <div class="d-flex align-items-center ms-4 mb-4">
                        <div class="position-relative">
                            <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                            <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                        </div>
                        <div class="ms-3">
                            <h6 class="mb-0">Jhon Doe</h6>
                            <span>Admin</span>
                        </div>
                    </div>
                    <div class="navbar-nav w-100">
                        <a href="STAFF_OrderManagement.jsp" class="nav-item nav-link "><i class="fa fa-shipping-fast me-2"></i>Manage Order</a>                     
                        <a href="" class="nav-item nav-link active"><i class="fa fa-pencil-alt me-2"></i>Manage Blog</a>      
                    </div>
                </nav>
            </div>
            <!-- Sidebar End -->


            <!-- Content Start -->
            <div class="content">
                <!-- Navbar Start -->
                <nav class="navbar navbar-expand bg-light navbar-light sticky-top px-4 py-0">
                    <a href="" class="navbar-brand d-flex d-lg-none me-4">
                        <h2 class="text-primary mb-0"><i class="fa fa-hashtag"></i></h2>
                    </a>
                    <a href="#" class="sidebar-toggler flex-shrink-0">
                        <i class="fa fa-bars"></i>
                    </a>
                    <form class="d-none d-md-flex ms-4" action="MainController" method="POST">
                        <input class="form-control border-0" type="text" placeholder="Search" name="">
                        <button class="btn btn-primary" type="submit" name="action" value="" style="margin-left: 10px;">
                            <svg class="w-6 h-6 text-gray-800 dark:text-white" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                            <path stroke="currentColor" stroke-linecap="round" stroke-width="2" d="m21 21-3.5-3.5M17 10a7 7 0 1 1-14 0 7 7 0 0 1 14 0Z"/>
                            </svg>
                        </button>
                    </form>
                    <div class="navbar-nav align-items-center ms-auto">
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-envelope me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Message</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <div class="d-flex align-items-center">
                                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                        <div class="ms-2">
                                            <h6 class="fw-normal mb-0">Jhon send you a message</h6>
                                            <small>15 minutes ago</small>
                                        </div>
                                    </div>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item text-center">See all message</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <i class="fa fa-bell me-lg-2"></i>
                                <span class="d-none d-lg-inline-flex">Notificatin</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">
                                    <h6 class="fw-normal mb-0">Profile updated</h6>
                                    <small>15 minutes ago</small>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <h6 class="fw-normal mb-0">New user added</h6>
                                    <small>15 minutes ago</small>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item">
                                    <h6 class="fw-normal mb-0">Password changed</h6>
                                    <small>15 minutes ago</small>
                                </a>
                                <hr class="dropdown-divider">
                                <a href="#" class="dropdown-item text-center">See all notifications</a>
                            </div>
                        </div>
                        <div class="nav-item dropdown">
                            <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown">
                                <img class="rounded-circle me-lg-2" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                                <span class="d-none d-lg-inline-flex">John Doe</span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-end bg-light border-0 rounded-0 rounded-bottom m-0">
                                <a href="#" class="dropdown-item">My Profile</a>
                                <a href="#" class="dropdown-item">Settings</a>
                                <a href="#" class="dropdown-item">Log Out</a>
                            </div>
                        </div>
                    </div>
                </nav>
                <!-- Navbar End -->

                <!-- Blank Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="row vh-100 bg-light rounded align-items-center justify-content-center mx-0 " style="height: auto !important">
                        <div class="table-responsive">
                            <div class="col-sm-12 col-xl-12">
                                <div class="bg-light rounded h-100 p-4">
                                    <div class="d-flex align-items-center justify-content-between mb-4">
                                        <h6 class="mb-0">Blog Management</h6>
                                        <a href="STAFF_CreateBlog.jsp" class="btn btn-primary">Create new Blog</a>
                                    </div>


                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th scope="col">BlogID</th>
                                                <th scope="col">StaffID</th>
                                                <th scope="col">Title</th>
                                                <th scope="col">Description</th>
                                                <th scope="col">Image</th>
                                                <th scope="col">CreateDate</th>
                                                <th scope="col">Status</th>
                                                <!--<th scope="col">Edit</th>-->
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="blog" items="${requestScope.SHOW_BLOG_MANAGEMENT}">
                                                <tr>
                                                    <td>${blog.blogID}</td>
                                                    <td>${blog.staffID}</td>
                                                    <td>${blog.title}</td>
                                                    <td>${blog.description}</td>                                                
                                                    <td><img src="${blog.image}" style="width: 80px; height: 80px; margin-right: 10px;"></td>
                                                    <td>${blog.createDate}</td>
                                                    <td>${blog.status == true ? "Available" : "Unavailable"}</td>
                                                    <td>

                                                        <a class="" data-bs-toggle="modal" data-bs-target="#updateModal-${blog.blogID}">
                                                            <svg class="w-6 h-6 text-gray-800" aria-hidden="true" xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="none" viewBox="0 0 24 24">
                                                            <path stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="m14.304 4.844 2.852 2.852M7 7H4a1 1 0 0 0-1 1v10a1 1 0 0 0 1 1h11a1 1 0 0 0 1-1v-4.5m2.409-9.91a2.017 2.017 0 0 1 0 2.853l-6.844 6.844L8 14l.713-3.565 6.844-6.844a2.015 2.015 0 0 1 2.852 0Z"/>
                                                            </svg>
                                                        </a>
                                                        <!-- Modal Update -->
                                                        <div class="modal fade" id="updateModal-${blog.blogID}" tabindex="-1" aria-labelledby="upda`teModalLabel" aria-hidden="true" >
                                                            <div class="modal-dialog">
                                                                <div class="modal-content" style="border-radius: 24px;">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="updateModalLabel">Blog Management</h1>
                                                                        <button type="button" class="btn btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                                    </div>
                                                                    <form action="UpdateBlogManagerController" method="post" enctype="multipart/form-data">
                                                                        <div class="modal-body">
                                                                            <input type="hidden" value="${blog.staffID}" name ="staffID">
                                                                            <input type="hidden" value="${blog.blogID}" name ="blogID">
                                                                            <div class="mb-3">
                                                                                <label  class="form-label">Title</label>
                                                                                <input type="text" class="form-control" value="${blog.title}" name="title" >                                                                   
                                                                            </div>
                                                                            <div class="form-floating mb-3">
                                                                                <textarea class="form-control" style="height: 100px;"
                                                                                          id="floatingTextarea" name="description">${blog.description}</textarea>
                                                                                <label for="floatingTextarea">Description</label>
                                                                            </div>     
                                                                            <div class="mb-3">
                                                                                <input type="hidden" value="${blog.image}" name="existingImage">
                                                                                <label for="formFileMultiple" class="form-label">Image</label>
                                                                                <input class="form-control" type="file" id="formFileMultiple" multiple name="blogImage">
                                                                            </div>
                                                                            <select name="status" class="form-select mb-3 form-control" aria-label="Default select example">
                                                                                <option value="true" ${blog.status == true ? 'selected="selected"' : ''}>Available</option>
                                                                                <option value="false" ${blog.status == false ? 'selected="selected"' : ''}>Unavailable</option>
                                                                            </select>                                                                      
                                                                            <div class="row mb-3">
                                                                                <label  class="col-sm-2 col-form-label">Create Date</label>
                                                                                <div class="col-sm-10">
                                                                                    <input type="date" class="form-control" name="createDate" value="${blog.createDate}"> 
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                        <div class="modal-footer">
                                                                            <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                                                            <button type="submit" name="action" value="UpdateBlogManager" class="btn btn-primary">Update</button>
                                                                            <input type="hidden" name="action" value="ShowAllBlogManager"/>
                                                                        </div>
                                                                    </form>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Blank End -->


                <!-- Footer Start -->
                <div class="container-fluid pt-4 px-4">
                    <div class="bg-light rounded-top p-4">
                        <div class="row">
                            <div class="col-12 col-sm-6 text-center text-sm-start">
                                &copy; <a href="#">Your Site Name</a>, All Right Reserved. 
                            </div>
                            <div class="col-12 col-sm-6 text-center text-sm-end">
                                <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                                Designed By <a href="https://htmlcodex.com">HTML Codex</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Footer End -->
            </div>
            <!-- Content End -->


            <!-- Back to Top -->
            <a href="#" class="btn btn-lg btn-primary btn-lg-square back-to-top"><i class="bi bi-arrow-up"></i></a>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="dashmin/lib/chart/chart.min.js"></script>
        <script src="dashmin/lib/easing/easing.min.js"></script>
        <script src="dashmin/lib/waypoints/waypoints.min.js"></script>
        <script src="dashmin/lib/owlcarousel/owl.carousel.min.js"></script>
        <script src="dashmin/lib/tempusdominus/js/moment.min.js"></script>
        <script src="dashmin/lib/tempusdominus/js/moment-timezone.min.js"></script>
        <script src="dashmin/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

        <!-- Template Javascript -->
        <script src="dashmin/js/main.js"></script>
    </body>
</html>