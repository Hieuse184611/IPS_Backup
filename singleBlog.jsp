<%-- 
    Document   : singleBlog
    Created on : Oct 16, 2024, 2:43:34 PM
    Author     : User
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <title>MultiShop - Online Shop Website Template</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">

        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.gstatic.com">
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap" rel="stylesheet">  

        <!-- Font Awesome -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">

        <!-- Libraries Stylesheet -->
        <link href="lib/animate/animate.min.css" rel="stylesheet">
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <style>
            .blog-post {
                background-color: #fff;
                border-radius: 8px; 
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); 
                padding: 20px; 
            }

            img {
                border-radius: 8px; 
            }

            .blog-post p {
                margin-bottom: 15px;
            }

            blockquote {
                padding: 15px;
                background-color: #e9ecef;
                border-left: 5px solid #007bff;
                margin-bottom: 30px;
            }
            .sidebar .list-group-item {
                border-radius: 8px;
                margin-bottom: 10px;
                transition: background-color 0.3s ease;
            }

            .sidebar .list-group-item:hover {
                background-color: #f1f1f1;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            /* Sidebar Title Styling */
            .sidebar-title {
                font-size: 18px;
                font-weight: 600;
                color: #343a40;
                border-bottom: 2px solid orange;
                padding-bottom: 10px;
                margin-bottom: 15px;
            }


            .recent-post img {
                border-radius: 5px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .recent-post .post-title {
                font-size: 16px;
                font-weight: 500;
                color: #007bff;
            }

            .recent-post:hover .post-title {
                color: #0056b3;
                text-decoration: none;
            }

            .list-group-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px;
                border-radius: 5px;
                transition: background-color 0.3s ease;
            }

            .list-group-item:hover {
                background-color: #f8f9fa;
            }


            .tag-cloud {
                padding: 15px;
                background-color: transparent;
                border-radius: 10px; /* Bo góc cho khối tag cloud */

            }

            .tags {
                display: flex;
                flex-wrap: wrap; 
                gap: 10px; 
            }

            .tag-item {
                font-size: 14px;
                color: orange;
                background-color: white;
                padding: 8px 15px;
                border-radius: 10px;
                text-decoration: none;
                transition: background-color 0.3s ease, color 0.3s ease; 
            }

            .tag-item:hover {
                background-color: orange; 
                color: #fff; 
            }

        </style>
    </head>
    <body>
        <!-- Topbar Start -->
        <div class="container-fluid">
            <div class="row bg-secondary py-1 px-xl-5">
                <div class="col-lg-6 d-none d-lg-block">
                    <div class="d-inline-flex align-items-center h-100">
                        <a class="text-body mr-3" href="MGR_Dashboard.jsp">MANAGER</a>
                        <a class="text-body mr-3" href="">Contact</a>
                        <a class="text-body mr-3" href="">Help</a>
                        <a class="text-body mr-3" href="">FAQs</a>
                    </div>
                </div>
                <div class="col-lg-6 text-center text-lg-right">
                    <div class="d-inline-flex align-items-center">
                        <div class="btn-group">
                            <button type="button" class="btn btn-sm btn-light dropdown-toggle" data-toggle="dropdown">My Account</button>
                            <div class="dropdown-menu dropdown-menu-right">
                                <a class="dropdown-item btn" type="button" href="signin.jsp">Sign in</a>
                                <a class="dropdown-item btn" type="button" href="signup.jsp">Sign up</a>
                                <a class="dropdown-item btn" type="button" href="MainController?action=Signout">Sign out</a>                                
                            </div>
                        </div>                                            
                    </div>
                    <div class="d-inline-flex align-items-center d-block d-lg-none">
                        <a href="" class="btn px-0 ml-2">
                            <i class="fas fa-heart text-dark"></i>
                            <span class="badge text-dark border border-dark rounded-circle" style="padding-bottom: 2px;">0</span>
                        </a>
                        <a href="" class="btn px-0 ml-2">
                            <i class="fas fa-shopping-cart text-dark"></i>
                            <span class="badge text-dark border border-dark rounded-circle" style="padding-bottom: 2px;">0</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="row align-items-center bg-light py-3 px-xl-5 d-none d-lg-flex">
                <div class="col-lg-4">
                    <a href="home.jsp" class="text-decoration-none">
                        <span class="h1 text-uppercase text-primary bg-dark px-2">IS</span>
                        <span class="h1 text-uppercase text-dark bg-primary px-2 ml-n1">Perfume</span>
                    </a>
                </div>
                <div class="col-lg-4 col-6 text-left">
                    <form action="">
                        <div class="input-group">
                            <form action="MainController" method="POST">
                                <input type="text" class="form-control" placeholder="Search for products" name="search">
                                <div class="input-group-append">
                                    <span class="input-group-text bg-transparent text-primary" style="padding-bottom: 5px ">                                 
                                        <button name="action" value="Seacrh" type="submit" class="btn btn-block" style="padding: 0"><i class="fa fa-search"></i></button>
                                    </span>
                                </div>
                            </form>
                        </div>
                    </form>
                </div>
                <div class="col-lg-4 col-6 text-right">
                    <p class="m-0">Customer Service</p>
                    <h5 class="m-0">+012 345 6789</h5>
                </div>
            </div>
        </div>
        <!-- Topbar End -->

        <!-- Navbar Start -->
        <form action="MainController">
            <div class="container-fluid bg-dark mb-30">
                <div class="row px-xl-5">
                    <div class="col-lg-3 d-none d-lg-block">
                        <a class="btn d-flex align-items-center justify-content-between bg-primary w-100" data-toggle="collapse" href="#navbar-vertical" style="height: 65px; padding: 0 30px;">
                            <h6 class="text-dark m-0"><i class="fa fa-bars mr-2"></i>Category</h6>
                            <i class="fa fa-angle-down text-dark"></i>
                        </a>
                        <nav class="collapse position-absolute navbar navbar-vertical navbar-light align-items-start p-0 bg-light" id="navbar-vertical" style="width: calc(100% - 30px); z-index: 999;">
                            <div class="navbar-nav w-100">
                                <c:forEach var="Category" items="${sessionScope.LIST_CATEGORY}">
                                    <a href="MainController?action=Category&Category=${Category.categoryID}" class="nav-item nav-link">${Category.name}</a>
                                </c:forEach>
                            </div>
                        </nav>
                    </div>
                    <div class="col-lg-9">
                        <nav class="navbar navbar-expand-lg bg-dark navbar-dark py-3 py-lg-0 px-0">
                            <a href="" class="text-decoration-none d-block d-lg-none">
                                <span class="h1 text-uppercase text-dark bg-light px-2">Multi</span>
                                <span class="h1 text-uppercase text-light bg-primary px-2 ml-n1">Shop</span>
                            </a>
                            <button type="button" class="navbar-toggler" data-toggle="collapse" data-target="#navbarCollapse">
                                <span class="navbar-toggler-icon"></span>
                            </button>
                            <div class="collapse navbar-collapse justify-content-between" id="navbarCollapse">
                                <div class="navbar-nav mr-auto py-0">
                                    <a href="home.jsp" class="nav-item nav-link ">Home</a>
                                    <a href="shopping.jsp" class="nav-item nav-link">Shop</a>
                                    <a href="productDetail.jsp" class="nav-item nav-link">Shop Detail</a>
                                    <div class="nav-item dropdown">
                                        <a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown">Pages <i class="fa fa-angle-down mt-1"></i></a>
                                        <div class="dropdown-menu bg-primary rounded-0 border-0 m-0">
                                            <a href="cart.jsp" class="dropdown-item">Shopping Cart</a>
                                            <a href="checkout.jsp" class="dropdown-item">Checkout</a>
                                        </div>
                                    </div>
                                    <a href="MainController?action=NavigateBlog" class="nav-item nav-link active">Blog</a>
                                    <a href="orderStatus.jsp" class="nav-item nav-link">Order Status</a>
                                </div>
                                <div class="navbar-nav ml-auto py-0 d-none d-lg-block">                            
                                    <a href="cart.jsp" class="btn px-0 ml-3">
                                        <i class="fas fa-shopping-cart text-primary"></i>
                                        <span class="badge text-secondary border border-secondary rounded-circle" style="padding-bottom: 2px;">0</span>
                                    </a>
                                </div>
                            </div>
                        </nav>
                    </div>
                </div>
            </div>
        </form>
        <!-- Navbar End -->

        <!-- Breadcrumb Start -->
        <div class="container-fluid">
            <div class="row px-xl-5">
                <div class="col-12">
                    <nav class="breadcrumb bg-light mb-30">
                        <a class="breadcrumb-item text-dark" href="#">Home</a>
                        <span class="breadcrumb-item active">Blog</span>
                    </nav>
                </div>
            </div>
        </div>
        <!-- Breadcrumb End -->

        <!-- Blog Posts -->
        <div class="container p-0">
            <div class="row">
                <!-- Blog Content Start -->

                <div class="col-lg-8">
                    <div class="blog-post">
                        <img src="${requestScope.BLOG_DETAIL.image}" alt="Blog Post Image" class="img-fluid">
                        <h2 class="mt-4">${requestScope.BLOG_DETAIL.title}</h2>
                        <p class="text-muted">${requestScope.BLOG_DETAIL.createDate} by <a href="#"> ${requestScope.BLOG_DETAIL.staffID}</a></p>
                        <p>${requestScope.BLOG_DETAIL.description}</p>

                        <!--                            <h4>Subheading</h4>
                                                    <p>Curabitur vitae dolor sit amet felis venenatis pharetra. </p>
                                                    <p>Quisque vitae velit nec augue vehicula viverra id eu lorem.</p>                   
                                                    <blockquote class="blockquote">
                                                        <p class="mb-0">"This is a sample blockquote, to highlight a quote or a key message within the article."</p>
                                                        <footer class="blockquote-footer">Source or Author</footer>
                                                    </blockquote>
                                                    <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. .</p>

                                                    <h4>Conclusion</h4>
                                                    <p>In conclusion, Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>-->

                        <div class="back-to-blog">
                            <a href="MainController?action=NavigateBlog" class="btn btn-primary">Back to Blog</a>
                        </div>
                    </div>
                </div>
                <!-- Blog Content End -->

                <!-- Sidebar Start -->
                <div class="col-lg-4 sidebar">
                    <!-- Recent Posts Section -->
                    <div class="recent-posts mb-5">
                        <h4 class="sidebar-title mb-4">New Posts</h4>
                        <c:forEach var="blog" items="${requestScope.BLOG_RECENT_LIST}" >
                            <div class="list-group mb-5">
                                <a href="MainController?action=ViewBlogDetail&blogID=${blog.blogID}" class="list-group-item-blog list-group-item-action d-flex">
                                    <img src="${blog.image}" class="img-thumbnail" style="width: 60px; height: 60px;" alt="Blog Post Image">
                                    <div class="ml-3">
                                        <h5>${blog.title}</h5>
                                        <p class="text-muted">${blog.createDate}</p>
                                    </div>
                                </a>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Categories Section -->
                    <div class="categories mb-5">
                        <h4 class="sidebar-title mb-4">Popular Categories</h4>
                        <ul class="list-group">
                            <li class="list-group-item">
                                <a href="#">Technology</a> <span class="badge badge-primary float-right">10</span>
                            </li>
                            <li class="list-group-item">
                                <a href="#">Business</a> <span class="badge badge-primary float-right">8</span>
                            </li>
                            <li class="list-group-item">
                                <a href="#">Lifestyle</a> <span class="badge badge-primary float-right">5</span>
                            </li>
                        </ul>
                    </div>

                    <!-- Tag Cloud Section -->
                    <div class="tag-cloud mb-5">
                        <h4 class="sidebar-title mb-4">Tag Cloud</h4>
                        <div class="tags d-flex flex-wrap">
                            <a href="#" class="tag-item">Technology</a>
                            <a href="#" class="tag-item">Business</a>
                            <a href="#" class="tag-item">Marketing</a>
                            <a href="#" class="tag-item">AI</a>
                            <a href="#" class="tag-item">Startups</a>
                            <a href="#" class="tag-item">Development</a>
                            <a href="#" class="tag-item">Innovation</a>
                        </div>
                    </div>

                </div>
                <!-- Sidebar End -->
            </div>
        </div>
        <!-- Blog End -->

        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-secondary mt-5 pt-5">
            <div class="row px-xl-5 pt-5">
                <div class="col-lg-4 col-md-12 mb-5 pr-3 pr-xl-5">
                    <h5 class="text-secondary text-uppercase mb-4">Get In Touch</h5>
                    <p class="mb-4">No dolore ipsum accusam no lorem. Invidunt sed clita kasd clita et et dolor sed dolor. Rebum tempor no vero est magna amet no</p>
                    <p class="mb-2"><i class="fa fa-map-marker-alt text-primary mr-3"></i>123 Street, New York, USA</p>
                    <p class="mb-2"><i class="fa fa-envelope text-primary mr-3"></i>info@example.com</p>
                    <p class="mb-0"><i class="fa fa-phone-alt text-primary mr-3"></i>+012 345 67890</p>
                </div>
                <div class="col-lg-8 col-md-12">
                    <div class="row">
                        <div class="col-md-4 mb-5">
                            <h5 class="text-secondary text-uppercase mb-4">Quick Shop</h5>
                            <div class="d-flex flex-column justify-content-start">
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Home</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Shop Detail</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Checkout</a>
                                <a class="text-secondary" href="#"><i class="fa fa-angle-right mr-2"></i>Contact Us</a>
                            </div>
                        </div>
                        <div class="col-md-4 mb-5">
                            <h5 class="text-secondary text-uppercase mb-4">My Account</h5>
                            <div class="d-flex flex-column justify-content-start">
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Home</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Our Shop</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Shop Detail</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Shopping Cart</a>
                                <a class="text-secondary mb-2" href="#"><i class="fa fa-angle-right mr-2"></i>Checkout</a>
                                <a class="text-secondary" href="#"><i class="fa fa-angle-right mr-2"></i>Contact Us</a>
                            </div>
                        </div>
                        <div class="col-md-4 mb-5">
                            <h5 class="text-secondary text-uppercase mb-4">Newsletter</h5>
                            <p>Duo stet tempor ipsum sit amet magna ipsum tempor est</p>
                            <form action="">
                                <div class="input-group">
                                    <input type="text" class="form-control" placeholder="Your Email Address">
                                    <div class="input-group-append">
                                        <button class="btn btn-primary">Sign Up</button>
                                    </div>
                                </div>
                            </form>
                            <h6 class="text-secondary text-uppercase mt-4 mb-3">Follow Us</h6>
                            <div class="d-flex">
                                <a class="btn btn-primary btn-square mr-2" href="#"><i class="fab fa-twitter"></i></a>
                                <a class="btn btn-primary btn-square mr-2" href="#"><i class="fab fa-facebook-f"></i></a>
                                <a class="btn btn-primary btn-square mr-2" href="#"><i class="fab fa-linkedin-in"></i></a>
                                <a class="btn btn-primary btn-square" href="#"><i class="fab fa-instagram"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row border-top mx-xl-5 py-4" style="border-color: rgba(256, 256, 256, .1) !important;">
                <div class="col-md-6 px-xl-0">
                    <p class="mb-md-0 text-center text-md-left text-secondary">
                        &copy; <a class="text-primary" href="#">Domain</a>. All Rights Reserved. Designed
                        by
                        <a class="text-primary" href="https://htmlcodex.com">HTML Codex</a>
                    </p>
                </div>
                <div class="col-md-6 px-xl-0 text-center text-md-right">
                    <img class="img-fluid" src="img/payments.png" alt="">
                </div>
            </div>           
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-primary back-to-top"><i class="fa fa-angle-double-up"></i></a>


        <!-- JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!-- Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

        <!-- Template Javascript -->
        <script src="js/main.js"></script>
    </body>
</html>
