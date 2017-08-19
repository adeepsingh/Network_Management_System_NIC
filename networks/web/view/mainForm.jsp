<%-- 
    Document   : mainForm
    Created on : Jun 30, 2017, 12:40:14 PM
    Author     : acer
--%>


<%@page import="net.sf.xsshtmlfilter.HTMLFilter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>

<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "menuList" class = "com.nic.form.populate.AssessLevel" scope = "page" />
<jsp:useBean id = "menuList1" class = "com.nic.form.populate.UserDepartment" scope = "page" />
<jsp:useBean id = "menuList2" class = "com.nic.form.populate.UserSection" scope = "page" />
<jsp:useBean id = "menuList3" class = "com.nic.form.populate.UserDesignation" scope = "page" />
<jsp:useBean id = "menuList4" class = "com.nic.form.populate.UserEmployment" scope = "page" />
<jsp:useBean id = "menuList5" class = "com.nic.form.populate.Floor" scope = "page" />
<jsp:useBean id = "menuList6" class = "com.nic.form.populate.Location" scope = "page" />
<jsp:useBean id = "menuList7" class = "com.nic.form.populate.DeviceType" scope = "page" />
<jsp:useBean id = "menuList8" class = "com.nic.form.populate.UserMinistry" scope = "page" />
<jsp:useBean id = "menuList9" class = "com.nic.form.populate.Wing" scope = "page" />
<html>
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>MAIN FORM</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.7 -->
        <link rel="stylesheet" href="../../bower_components/bootstrap/dist/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="../../bower_components/font-awesome/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="../../bower_components/Ionicons/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="../../dist/css/AdminLTE.min.css">
        <!-- AdminLTE Skins. Choose a skin from the css/skins
             folder instead of downloading all of them to reduce the load. -->
        <link rel="stylesheet" href="../../dist/css/skins/_all-skins.min.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->

        <!-- Google Font -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">
    </head>
    <body>
        <%@include file="header.jsp"%>

    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <div class="content-wrapper">

                <section class="content">
                    <div class="container">
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                USER DETAILS
                            </div>
                            <div class="panel-body">

                                <form class="form-horizontal" role="form" 
                                      id="userdetails" method="post" action="/MainFormServlet"> 
                                    <input type="hidden" name="secureToken" value="" id="secureToken" />
                                    <input type="hidden" name="formType" class="form-control" id="formType" value="10"/>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>User Name</label>
                                            <input type="text" class="form-control" id="userName" maxlength="20" name="userName" placeholder="Enter user Name">
                                        </div>
                                        <div class="col-md-4">
                                            <label>User Department</label>
                                            <select class="form-control" id="userDepartment"  name="userDepartment" >
                                                <option  value="" selected="selected">User Department</option>
                                                <c:forEach var="menuList1" items="${menuList1.menuCode}"> 
                                                    <option VALUE="${menuList1.key}">${menuList1.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label>User Section</label>
                                            <select class="form-control" id="userSection"  name="userSection" >
                                                <option  value="" selected="selected">User Section</option>
                                                <c:forEach var="menuList2" items="${menuList2.menuCode}"> 
                                                    <option VALUE="${menuList2.key}">${menuList2.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>


                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>User Designation</label>
                                            <select class="form-control" id="userDesignation"  name="userDesignation" >
                                                <option  value="" selected="selected">User Designation</option>
                                                <c:forEach var="menuList3" items="${menuList3.menuCode}"> 
                                                    <option VALUE="${menuList3.key}">${menuList3.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label>User IP Address</label>
                                            <input type="text" class="form-control" id="userIp" name="userIp" data-inputmask="'alias': " data-mask="true" placeholder="Enter user IP Address">
                                        </div>
                                        <div class="col-md-4">
                                            <label>User MAC Address</label>
                                            <input type="text" class="form-control" id="userMac" maxlength="20" name="userMac" placeholder="Enter user MAC Address">
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>User Employment Type</label>
                                            <select class="form-control" id="userEmployment"  name="userEmployment" >
                                                <option  value="" selected="selected">User Employment Type</option>
                                                <c:forEach var="menuList4" items="${menuList4.menuCode}"> 
                                                    <option VALUE="${menuList4.key}">${menuList4.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label>Floor</label>
                                            <select class="form-control" id="floor"  name="floor" >
                                                <option  value="" selected="selected">Floor</option>
                                                <c:forEach var="menuList5" items="${menuList5.menuCode}"> 
                                                    <option VALUE="${menuList5.key}">${menuList5.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label>Location</label>
                                            <select class="form-control" id="location"  name="location" >
                                                <option  value="" selected="selected">Location</option>
                                                <c:forEach var="menuList6" items="${menuList6.menuCode}"> 
                                                    <option VALUE="${menuList6.key}">${menuList6.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>Device Type</label>
                                            <select class="form-control" id="deviceType"  name="deviceType" >
                                                <option  value="" selected="selected">Device Type</option>
                                                <c:forEach var="menuList7" items="${menuList7.menuCode}"> 
                                                    <option VALUE="${menuList7.key}">${menuList7.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                        <div class="col-md-4">
                                            <label>Device IP Address</label>
                                            <input type="text" class="form-control" id="deviceIp" maxlength="20" name="deviceIp" placeholder="Enter Device IP Address">
                                        </div>
                                        <div class="col-md-4">
                                            <label>Device MAC Address</label>
                                            <input type="text" class="form-control" id="deviceMac" maxlength="20" name="deviceMac" placeholder="Enter Device MAC Address"> 
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>Entered By</label>
                                            <input type="text" class="form-control" id="enteredBy" maxlength="20" name="enteredBy" placeholder="Enter Name">
                                        </div>
                                        <div class="col-md-4">
                                            <label>Entered On</label>
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" id="enteredOn" name="enteredOn" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Enter Date" />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label>Remarks</label>
                                            <input type="text" class="form-control" id="remarks" maxlength="100" name="remarks" placeholder="Enter Remarks">
                                        </div>


                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>Record Status</label>
                                            <input type="text" class="form-control" maxlength="1" id="recordStatus" name="recordStatus" placeholder="Enter Record Status">
                                        </div>

                                        <div class="col-md-4">

                                            <label>Assess Level</label>
                                            <select class="form-control" id="assessLevel"  name="assessLevel" >
                                                <option  value="" selected="selected">Assess Level</option>
                                                <c:forEach var="menuList" items="${menuList.menuCode}"> 
                                                    <option VALUE="${menuList.key}">${menuList.value}</option> 
                                                </c:forEach> 
                                            </select>


                                        </div>
                                        <div class="col-md-4">
                                            <label >Contact Number</label>
                                            <input type="text" class="form-control" maxlength="10" id="contactNumber" name="contactNumber" placeholder="Enter Contact Number">
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>Intercom</label>
                                            <input type="text" class="form-control" maxlength="20" id="intercom" name="intercom" placeholder="Enter Intercom">
                                        </div>
                                        <div class="col-md-4">
                                            <label>Email ID</label>
                                            <input type="email" class="form-control" id="email" name="email" data-inputmask="'alias': 'abc@def.ghi'" data-mask="true" placeholder="Enter Email ID">
                                        </div>
                                        <div class="col-md-4">
                                            <label>User Ministry</label>
                                            <select class="form-control" id="userMinistry"  name="userMinistry" >
                                                <option  value="" selected="selected">User Ministry</option>
                                                <c:forEach var="menuList8" items="${menuList8.menuCode}"> 
                                                    <option VALUE="${menuList8.key}">${menuList8.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>Employee Code</label>
                                            <input type="text" class="form-control" id="empCode" name="empCode" placeholder="Enter Employee Code">
                                        </div>
                                        <div class="col-md-4">
                                            <label>Activation Date</label>
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" id="activation" name="activation" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Enter Activation Date" />
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <label>Deactivation Date</label>
                                            <div class="input-group">
                                                <div class="input-group-addon">
                                                    <i class="fa fa-calendar"></i>
                                                </div>
                                                <input type="text" id="deactivation" name="deactivation" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Enter Deactivation Date" />
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <label>Wing</label>
                                            <select class="form-control" id="wing"  name="wing" >
                                                <option  value="" selected="selected">Wing</option>
                                                <c:forEach var="menuList9" items="${menuList9.menuCode}"> 
                                                    <option VALUE="${menuList9.key}">${menuList9.value}</option> 
                                                </c:forEach> 
                                            </select>
                                        </div>
                                    </div>
                                            <div class="row">

                                                <div class="col-md-4">

                                                </div>
                                                <div class="col-md-4">
                                                    <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" id="adddata"  >submit</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">reset</button>
                                                    </div>
                                                </div> 
                                                <div class="col-md-4">

                                                </div>
                                            </div>
                                            </form>
                                        </div>
                                    </div>

                            </div>
                            </section>
                        
                            <!-- /.container -->
                        
                        <!-- /.content-wrapper -->

                    </div>
                    </body>
                    <!-- ./wrapper -->
                    <!-- jQuery 2.2.3 -->
                    <script src="../plugins/jQuery/jquery-2.2.3.min.js"></script>
                    <!-- Bootstrap 3.3.6 -->
                    <script src="../bootstrap/js/bootstrap.min.js"></script>
                    <!-- DataTables -->
                    <script src="../plugins/datatables/jquery.dataTables.min.js"></script>
                    <script src="../plugins/datatables/dataTables.bootstrap.min.js"></script>
                    <!-- SlimScroll -->
                    <script src="../plugins/slimScroll/jquery.slimscroll.min.js"></script>
                    <!-- FastClick -->
                    <script src="../plugins/fastclick/fastclick.js"></script>
                    <!-- AdminLTE App -->
                    <script src="../dist/js/app.min.js"></script>
                    <!-- AdminLTE for demo purposes -->
                    <script src="../dist/js/demo.js"></script>
                    <!-- iCheck -->
                    <script src="../plugins/iCheck/icheck.min.js"></script>
                    <script>
                        $(function () {
                            $('input').iCheck({
                                checkboxClass: 'icheckbox_square-blue',
                                radioClass: 'iradio_square-blue',
                                increaseArea: '20%' // optional
                            });
                            $("[data-mask]").inputmask();
                            $(selector).inputmask("email");
                            $('.ip_address').mask('099.099.099.099');
                        });
                        try{
                                        
                                        $("#adddata").click(function () {
                                        if( $('#userName').val()=='')	{
                                    $('#newFormDiscError').html("This field is required.");
                                          return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#userName").val()))){
                                                      $('#newFormDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 20.");                                                  
                                                    $("#userName").focus();
                                                      return false; 
                                                }else{
                                                   $('#newFormDiscError').empty();                                                   	
                                            }
                                                   	
                                            }
                                        }
                                    $.ajax({
                                            type: 'POST',
                                          url: 'MainFormServlet',
                                         // data:  new FormData(this),
                                       data: $('#userdetails').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("Details successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In EmploymentType Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In user details Add "); 
                                               
                                            }
                                      });
                                    });
                                    }
                                    catch(e){
                                        alert("EX : "+e);
                                    }
                    </script>


                    <!-- /.login-box -->
                    <%@include file="footer.jsp"%>
                    </body>

                    <!-- <%@include file="scripts.jsp"%>-->
                    <script src="../plugins/input-mask/jquery.inputmask.js"></script>
                    <script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
                    <script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
                    <script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
                    <script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>
                    </body>
                    </html>

