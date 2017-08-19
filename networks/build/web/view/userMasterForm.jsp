<%@page import = "com.nic.validation.DataConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="net.sf.xsshtmlfilter.HTMLFilter"%>
<%@page import="com.nic.utility.RandomSaltGenerator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:useBean id = "locationList" class = "com.nic.form.populate.LocationPopulate" scope = "page" />
<jsp:useBean id = "designationList" class = "com.nic.form.populate.DesignationPopulate" scope = "page" />
<jsp:useBean id = "masterRoleList" class = "com.nic.form.populate.MasterRolePopulate" scope = "page" />
<%@include file="header.jsp"%>
<%    HTMLFilter filter = new HTMLFilter();
    String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
    request.getSession().setAttribute("csrf_secureToken", secureToken);
    String location_Code = (String) session.getAttribute("locationCode");
%>
<body class="hold-transition skin-blue layout-top-nav">
    <div class="wrapper">
        <%@include file="top-nav.jsp"%>
        <!-- Full Width Column -->
        <div class="content-wrapper">                
            <section class="content">
                <section class="container">                        
                    <form class="form-horizontal" name="userMasterUIForm" enctype="multipart/form-data" id="userMasterUIForm" action="userMasterUISave" method="post">
                        <input type="hidden" name="secureToken" value="${csrf_security_token}" id="secureToken" />
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                New User's Profile
                                <font color="black" size="+2">&nbsp;&nbsp;&nbsp;${message}</font>
                            </div>
                            <div class="panel-body">
                                <div class="tab-content">
                                    <div class="row">
                                        <div class="col-md-4"><label for="userRoleCode">User Role :</label>
                                            <select name="userRoleCode" id="userRoleCode" class="form-control" required="true"> 
                                                <option value="" selected>Select User Role</option>
                                                <c:forEach var="userRoleCode" items="${masterRoleList.masterRoleList}"> 
                                                    <option VALUE="${userRoleCode.key}">${userRoleCode.value}</option> 
                                                </c:forEach> 
                                            </select><span class="help-inline"></span>
                                        </div> 
                                        <div class="col-md-4"><label for="userPass">User Password :</label>
                                            <input type="text" name="userPass" class="form-control" id="userPass"
                                                   placeholder="Enter User Password"  htmlEscape="true" required />
                                        </div> 
                                        <div class="control-label col-md-3">
                                            <div style="height: 10px; margin-top: 25px;">                                                
                                                <img name="viram" id="viram" alt="User Profile Image" class="img-thumbnail" style="width: 150px; height: 170px;"
                                                     src="data:image/jpeg;base64,${userImage}" onerror="this.src='../dist/img/avatar.png'"/>
                                                
                                                <input type='file' name="profileImage" onchange="readURL(this);" class="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><label for="userName">User Name :</label>
                                            <input type="text" name="userName" class="form-control" id="userName"
                                                   placeholder="Enter User Name"  htmlEscape="true" required />
                                        </div>  
                                        <div class="col-md-4"><label for="userDOB">Date of Birth :</label>
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" id="userDOB" name="userDOB" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="User's Date of Birth"/> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><label for="userGender">Gender :</label>
                                            <select name="userGender" id="userGender" class="form-control" required> 
                                                <option value="" selected>Select Gender</option>
                                                <option value="M">Male</option>
                                                <option value="F" >Female</option>
                                                <option value="T" >TransGender</option>
                                            </select><span class="help-inline"></span>
                                        </div>
                                        <div class="col-md-4"><label for="contactNo">Contact No :</label>
                                            <input type="text" name="contactNo" class="form-control" id="contactNo"
                                                   placeholder="Enter Contact No"  htmlEscape="true"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><label for="designationCode">Designation :</label>
                                            <select name="designationCode" id="designationCode" class="form-control" required> 
                                                <option value="" selected>Select Designation</option>
                                                <c:forEach var="designationCode" items="${designationList.designationList}"> 
                                                    <option VALUE="${designationCode.key}">${designationCode.value}</option> 
                                                </c:forEach>
                                            </select><span class="help-inline"></span>
                                        </div>
                                        <div class="col-md-4"><label for="email">E-Mail :</label>
                                            <input type="text" name="email" class="form-control" id="email"
                                                   placeholder="Enter E-Mail"  htmlEscape="true"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4"><label for="locationCode">Location :</label>
                                            <select name="locationCode" id="locationCode" class="form-control" required> 
                                                <option value="" selected>Select Location</option>
                                                <c:forEach var="locationCode" items="${locationList.locationList}"> 
                                                    <option VALUE="${locationCode.key}">${locationCode.value}</option> 
                                                </c:forEach> 
                                            </select><span class="help-inline"></span>
                                        </div>
                                        <div class="col-md-4"><label for="remarks">Remarks :</label>
                                            <input type="text" name="remarks" class="form-control" id="remarks"
                                                   placeholder="Enter Remarks"  htmlEscape="true" required/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <center>&nbsp;</center>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-12">
                                            <center><button type="submit" onclick="Submit()" class="btn btn-primary" data-original-title="Click to Add UserForm">Add User Profile Form</button></center>
                                        </div>
                                    </div>
                                </div> <!-- new-->    
                            </div>
                        </div>
                    </form>
                </section>
            </section>
        </div>
        <!-- /.container -->
    </div>
    <!-- /.content-wrapper -->
    <%@include file="footer.jsp"%>
    <!-- ./wrapper -->
    <%@include file="scripts.jsp"%>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>
</body>
<script>
                                                    $(document).ready(function () {
                                                        $("[data-mask]").inputmask();
                                                    });
</script>    
<script>
    function readURL(input) {
        if (input.files && input.files[0]) {
            var reader = new FileReader();
            reader.onload = function (e) {
                $('#viram')
                        .attr('src', e.target.result)
                        .width(150)
                        .height(200);
            };
            reader.readAsDataURL(input.files[0]);
        }
    }
</script>