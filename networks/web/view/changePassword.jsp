<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <%    HTMLFilter filter = new HTMLFilter();
        String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
        request.getSession().setAttribute("csrf_secureToken", secureToken);
    %>
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">
                <div class="container">
                    <section class="content">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">
                                    <i class="fa fa-info-circle"></i> Change Password - 
                                </h3>
                            </div>                        
                            <div class="panel-body">
                                ${message}
                                <c:remove var="message" scope="session" />
                                <div class="row">
                                    <div class="col-md-3">
                                        <form id="changePasswordBean" name="changePasswordForm" role="form" action="changeUserPassword" method="post">                                    
                                            <div class="form-group" id="oldPassword">
                                                <label>Old Password:</label>
                                                <input id="oldPassword" name="oldPassword" type="password" class="form-control" value="">
                                                <span class="help-inline"></span>
                                            </div>
                                            <div class="form-group" id="newPassword">
                                                <label>New Password:</label>
                                                <input id="newPassword" name="newPassword" type="password" pattern="^(?=(.*\d){2})(?=.*[a-zA-Z]{2})(?=.*[!@#$%])[0-9a-zA-Z!@#$%]{8,32}" class="form-control" required>
                                                <span class="help-inline"></span>
                                            </div>
                                            <div class="form-group" id="confirmPassword">
                                                <label>Confirm Password:</label>
                                                <input id="confirmPassword" name="confirmPassword" type="password" pattern="^(?=(.*\d){2})(?=.*[a-zA-Z]{2})(?=.*[!@#$%])[0-9a-zA-Z!@#$%]{8,32}" class="form-control" required>
                                                <span class="help-inline"></span>
                                            </div>
                                            <div class="form-group">
                                                <button type="submit" class="btn btn-primary" id="submit">Submit</button>
                                                <button type="reset" class="btn btn-primary" id="reset">Reset</button>
                                            </div>
                                        </form> 
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-12">
                                        <div class="panel panel-info">
                                            <div class="panel-heading">
                                                <h3 class="panel-title">
                                                    <i class="fa fa-info-circle"></i> Password Policy
                                                </h3>
                                            </div>
                                            <div class="panel-body">
                                                <ol start="1">
                                                    <li>Password must contain at least two alphabets.</li>
                                                    <li>Password must contain at least two numerals.</li>
                                                    <li>Password must contain at least two special characters out of !@#$%^*?_~</li>
                                                    <li>Password's length should be between 8 to 32 characters.</li>
                                                </ol>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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