<%@page import = "com.nic.validation.DataConnect"%>
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
                            <h2 class="headline text-red">500</h2>
                            <div class="error-content">
                                <h3><i class="fa fa-warning text-red"></i> Oops! Something went wrong.</h3>
                                <p>
                                    We will work on fixing that right away.
                                    Meanwhile, you may <a href="../../index.html">return to dashboard</a> or try using the search form.
                                </p>
                            </div>
                        </div>
                        <!-- /.error-page -->
                    </section>
                    <!-- /.content -->
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