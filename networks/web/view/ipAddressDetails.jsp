<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:useBean id = "purposeList" class = "com.nic.form.populate.PurposePopulate" scope = "page" />
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <!-- ADD THE CLASS layout-top-nav TO REMOVE THE SIDEBAR. -->
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">
                <div class="container">
                    <!-- Content Header (Page header) -->
                    <section class="content-header">

                    </section>
                    <!-- Main content -->
                    <section class="content">
                        <div class="container">
                            <div class="panel panel-primary">
                                <div class="panel-heading">

                                </div>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <form class="form-horizontal" action="" role="form" id="" method="post">
                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label for="name">User's Name</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="name" placeholder="Enter User Name">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">User's IP Address</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="ipAddress" placeholder="Enter IP Address">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">User's MAC Address</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="macAddress" placeholder="Enter MAC Address">
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label for="name">User's Employee Code</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="name" placeholder="Enter User Name">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">User's Contact Number</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="ipAddress" placeholder="Enter IP Address">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">User's Email ID</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="macAddress" placeholder="Enter MAC Address">
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label for="name">User's Department</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="name" placeholder="Enter User Name">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">User's Sections</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="ipAddress" placeholder="Enter IP Address">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">User's Designation</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="macAddress" placeholder="Enter MAC Address">
                                                </div>
                                            </div>

                                            <div class="row">
                                                <div class="col-md-4">
                                                    <label for="deviceType">User's Access Level</label>
                                                    <option  value="" selected="selected"> Select </option>
                                                    <c:forEach var="purposeList" items="${purposeList.purposeCode}"> 
                                                        <option VALUE="${purposeList.key}">${purposeList.value}</option> 
                                                    </c:forEach>
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">Activation Date</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="ipAddress" placeholder="Enter IP Address">
                                                </div>
                                                <div class="col-md-4">
                                                    <label for="name">Deactivation Date</label>
                                                    <input type="text" class="form-control" id="name" maxlength="20" name="macAddress" placeholder="Enter MAC Address">
                                                </div>
                                            </div>
                                        </form>                                    
                                    </div>
                                </div>
                            </div>
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