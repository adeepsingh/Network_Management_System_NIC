
<%@ page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">
                <div class="container">
                    <!-- Main content -->
                    <section class="content">
                        <div class="error-page">
                            <h2 class="headline text-yellow"> 404</h2>
                            <div class="error-content">
                                <h3><i class="fa fa-warning text-yellow"></i> Oops! Page not found.</h3>
                                <p>
                                    We could not find the page you were looking for.
                                    Meanwhile, you may <a href="homepage.jsp">return to home page</a> or try logging in again.
                                </p>
                            </div>
                            <!-- /.error-content -->
                        </div>
                        <!-- /.error-page -->
                    </section>
                </div>
                <!-- /.container -->
            </div>
            <!-- /.content-wrapper -->
            <%@include file="footer.jsp"%>
        </div>
        <!-- ./wrapper -->
        <%@include file="scripts.jsp"%>
    </body>
</html>