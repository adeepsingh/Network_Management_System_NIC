<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String ipAddress, query, userName, macAddress, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
    String msgRight = "";
%>
<html>
    <head>
    </head>
    <%@include file="header.jsp"%>
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <div class="content-wrapper">
                <!-- Main content -->
                <section class="content">
                    <!-- Default box -->
                    <div class="box">
                        <div class="box-header with-border">
                            <h2 class="box-title">Ip Address Update/Delete Form</h2>


                            <div class="box-tools pull-right">
                                <a id="delete" role="button" class="btn btn-primary" data-toggle="modal">
                                    <i class="fa fa-trash-o"></i>&nbsp;Delete</a>
                            </div>
                        </div>
                        ${message}
                        <c:remove var="message" scope="session" />
                        <div align="center" >&nbsp;<span style="color:#008000;" id="msgRight1"></span> </div>
                        <div align="center" >&nbsp;<span style="color:#FF0000;" id="msgError1"></span> </div>
                        <div class="box-body">
                            <%                    try {
                                    DataConnect con = new DataConnect();
                                    String location = (String) session.getAttribute("locationCode");
                                    conn = con.getConnection();
                                    query = "SELECT USER_IP_ADDRESS,USER_MAC_ADDRESS,USER_NAME,(SELECT DESCRIPTION FROM MASTER_USER_DEPARTMENT WHERE CODE = USER_DEPARTMENT) AS USER_DEPARTMENT,"
                                            + "(SELECT DESCRIPTION FROM MASTER_SECTION WHERE CODE = USER_SECTION) AS USER_SECTION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_DESIGNATION WHERE CODE = USER_DESIGNATION) AS USER_DESIGNATION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_USER_EMPLOYMENT_TYPE WHERE CODE = USER_EMPLOYMENT_TYPE) AS USER_EMPLOYMENT_TYPE,"
                                            + "(SELECT DESCRIPTION FROM MASTER_FLOOR WHERE CODE = FLOOR) AS FLOOR,"
                                            + "(SELECT DESCRIPTION FROM MASTER_LOCATION WHERE CODE = LOCATION) AS LOCATION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_DEVICE_TYPE WHERE CODE = DEVICE_TYPE) AS DEVICE_TYPE,"
                                            + "(SELECT DESCRIPTION FROM MASTER_ASSESS_LEVEL WHERE CODE = ACCESS_LEVEL) AS ACCESS_LEVEL,"
                                            + "CONTACT_NUMBER,INTERCOM,EMAIL_ID,"
                                            + "(SELECT DESCRIPTION FROM MASTER_USER_MINISTRY WHERE CODE = USER_MINISTRY) AS USER_MINISTRY, "
                                            + "LOCATION||SUBSTR(USER_IP_ADDRESS, 7, 3)||LPAD(SUBSTR(USER_IP_ADDRESS, 11, 3), 3, 0) AS ORDER_SEQ, "
                                            + "EMPLOYEE_CODE FROM IP_ADDRESS WHERE RECORD_STATUS = 'A' AND FLAG <> 'D' AND LOCATION=" + location + " ORDER BY ORDER_SEQ";
                                    st = conn.createStatement();
                                    rs = st.executeQuery(query);
                                    int i = 1;
                            %>
                            <center>

                                <table  id="example1" class="table table-bordered table-striped"  >

                                    <thead>
                                        <tr bgcolor="">
                                            <th><center>#</center></th>
                                    <th><center>IP Address</center></th>
                                    <th><center>Mac Address</center></th>
                                    <th><center>User Name</center></th>
                                    <th><center>User Department</center></th>
                                    <th><center>User Section</center></th>
                                    <th><center>User Designation</center></th>
                                    <th><center>User Ministry</center></th>
                                    <th></th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                        <%
                                            while (rs.next()) {
                                                ipAddress = rs.getString("USER_IP_ADDRESS");
                                                macAddress = rs.getString("USER_MAC_ADDRESS");
                                                userName = rs.getString("USER_NAME");

                                        %>
                                        <tr>
                                            <td><center><%=i%>.</center></td>
                                    <td>
                                        <span hidden="hidden"><%=rs.getString("ORDER_SEQ")%></span>
                                        <input type="hidden"  id="ipAddHidden" name="ipAddHidden" >
                                        <input type="hidden"  id="locHidden" name="locHidden" >
                                        <input type="hidden"  id="userName" name="userName" >
                                        <font size="2"><span id="<%=i%>_userIPAddress" hidden="hidden" ><%=ipAddress%></span>
                                        <a href="ipPoolAssignUpdateForm.jsp?ipAddress=<%=ipAddress%>&locationcode='<%=location%>'"><%=ipAddress%></a>
                                        <span id="<%=i%>_locationHidden" hidden="hidden"><%=location%></a></span></font></td>
                                    <td><font size="2"><span id="<%=i%>_userMacAddress"><%=macAddress%></span></font></td>
                                    <td><font size="2"><span id="<%=i%>_userName"><%=userName%></span></font></td>
                                    <td><font size="2"><span id="<%=i%>_userDepartment"><%=rs.getString("USER_DEPARTMENT")%></span></font></td>
                                    <td><font size="2"><span id="<%=i%>_userSection"><%=rs.getString("USER_SECTION")%></span></font></td>
                                    <td><font size="2"><span id="<%=i%>_userDesignation"><%=rs.getString("USER_DESIGNATION")%></span></font></td>
                                    <td><font size="2"><span id="<%=i%>_userMinistry"><%=rs.getString("USER_MINISTRY")%></font>
                                    </td>
                                    <td><div class="radio">
                                            <label>
                                                <% if (i == 1) {%>
                                                <input type="radio" name="ipModuleRadio" id="<%=i%>" checked="" value="<%=i%>">
                                                <% } else {%>
                                                <input type="radio" name="ipModuleRadio" id="<%=i%>" value="<%=i%>">
                                                <%}%>
                                            </label>
                                        </div>
                                    </td>
                                    </tr>
                                    <%
                                            i++;
                                        }
                                    %>
                                    </tbody>


                                </table>
                                <input type="hidden" name="counter" value="<%=i%>">
                                <%
                                        //}
                                    } catch (Exception ex) {
                                        System.out.println("Exception ex:" + ex);
                                    } finally {
                                        if (rs != null) {
                                            try {
                                                rs.close();
                                            } catch (Exception e) {
                                                ;
                                            }
                                            rs = null;
                                        }
                                        if (st != null) {
                                            try {
                                                st.close();
                                            } catch (Exception e) {
                                                ;
                                            }
                                            st = null;
                                        }
                                    }
                                %>
                                </div>
                                </div>
                                </section>
                                </div>



                                <!-- form start -->

                                <div class="modal fade" id="editIPModuleModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Edit Menu</h4>
                                            </div>
                                            <form class="form-horizontal" id="editMenuForm" method="POST" >
                                                <div class="modal-body">                                          
                                                    <div class="box-body">
                                                        <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                            <span style="color:#008000;" id="msgEditError"></span>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="ipAddressField" class="col-sm-4 control-label">IP Address</label>

                                                            <div class="col-sm-8">
                                                                <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                                <input type="text" class="form-control" id="ipAddressField" name="ipAddressField" placeholder=" " readonly="true">

                                                            </div>

                                                        </div>
                                                        <div class="form-group">
                                                            <label for="macAddressField" class="col-sm-4 control-label">Mac Address</label>

                                                            <div class="col-sm-8">

                                                                <input type="text" class="form-control" id="macAddressField" name="macAddressField" placeholder=" " >

                                                            </div>

                                                        </div>

                                                        <div class="form-group">
                                                            <label for="userNameField" class="col-sm-4 control-label">User Name</label>

                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="userNameField" name="userNameField" placeholder="Enter User Name">
                                                                <span class="help-inline" id="userNameError" style="color: red;"></span> 
                                                            </div>
                                                        </div>








                                                    </div>
                                                    <!-- /.box-body -->


                                                </div>

                                            </form>
                                            <div class="modal-footer">
                                                <button type="button" id="editIPModuleAction" class="btn btn-primary">Save Changes</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>                                           
                                            </div>

                                        </div>
                                    </div>
                                </div>


                        </div>


                        <!-- /.content-wrapper -->
                        <%@include file="footer.jsp"%>
                        </body>

                        <!-- <%@include file="scripts.jsp"%>-->
                        <script src="../plugins/input-mask/jquery.inputmask.js"></script>
                        <script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
                        <script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
                        <script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
                        <script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>

                        <!-- page script -->


                        <script>
                            $(document).ready(function () {

                                $("#example1").DataTable({
                                    "bLengthChange": false,
                                    "bFilter": true,
                                    "bInfo": false,
                                    "bAutoWidth": false});

                                $("#editIPModule").click(function () {
                                    var rd_id = $('input[name=ipModuleRadio]:checked').val();
                                    $("#ipAddressField").val($("#" + rd_id + "_userIPAddress").html());
                                    $("#macAddressField").val($("#" + rd_id + "_userMacAddress").html());
                                    $("#userNameField").val($("#" + rd_id + "_userName").html());
                                    //$("#menuSubCategoryField").val($("#" + rd_id + "_menusubcategory").html());                                          
                                    //    $("#displayOrder").val($("#" + rd_id + "_menudisplay").html());
                                    // $("#menuRemarks").val($("#" + rd_id + "_menuremark").html());
                                    // $("#recordStatusField").val($("#" + rd_id + "_menustatus").html());
                                });



                                $('.modal').on('hidden.bs.modal', function () {
                                    $("#editMenuForm")[0].reset();
                                    //$("#newMenuForm")[0].reset();
                                });



                                //-------------------------Edit Code start---------------------------------------------
                                /* try{
                                 
                                 $("#editMenuAction").click(function () {
                                 
                                 if( $('#menuNameField').val()=='')	{
                                 $('#menuNameError').html("This field is required.");
                                 return false; 		
                                 }else{
                                 if(!(/^[a-zA-Z ]{3,50}$/.test($("#menuNameField").val()))){
                                 $('#menuNameError').html(" Only alphabets Allowed");                                                  
                                 $("#menuNameField").focus();
                                 return false; 
                                 }else{
                                 $('#menuNameError').empty();                                                   	
                                 }                                                   	
                                 }
                                 
                                 if( $('#menuActionPathField').val()=='')	{
                                 $('#menuActionPathError').html("This field is required.");
                                 return false; 		
                                 }
                                 if( $('#menuSubCategoryField').val()=='')	{
                                 $('#menuSubCategoryError').html("This field is required.");
                                 return false; 		
                                 }else{
                                 if(!(/^[NY]{0,1}$/.test($("#menuSubCategoryField").val()))){
                                 $('#menuSubCategoryError').html(" Only alphabets Y or N Allowed.");                                                  
                                 $("#menuSubCategoryField").focus();
                                 return false; 
                                 }else{
                                 $('#menuSubCategoryError').empty();                                                   	
                                 }
                                 }
                                 
                                 if( $('#displayOrder').val()=='')	{
                                 $('#displayOrderError').html("This field is required.");
                                 return false; 		
                                 }else{
                                 if(!(/^[0-9]{0,3}$/.test($("#displayOrder").val()))){
                                 $('#displayOrderError').html(" Only numeric 0-9 and 3 digit allowed ");                                                  
                                 $("#displayOrder").focus();
                                 return false; 
                                 }else{                                                
                                 $('#displayOrderError').empty();
                                 }
                                 }
                                 if( $('#menuRemarks').val()=='')	{
                                 $('#menuRemarksError').html("This field is required.");
                                 return false; 		
                                 }
                                 else{
                                 if(!(/^[a-zA-Z./ ]+$/.test($("#menuRemarks").val()))){
                                 $('#menuRemarksError').html(" Only alphabets and . Allowed");                                                  
                                 $("#menuRemarks").focus();
                                 return false; 
                                 }else{
                                 $('#menuRemarksError').empty();                                                   	
                                 }    
                                 }
                                 
                                 $.ajax({
                                 type: 'POST',
                                 url: 'MenuMasterServlet',
                                 // data:  new FormData(this),
                                 data: $('#editMenuForm').serialize(),
                                 dataType: 'json',
                                 encode: true,
                                 success: function (result) {
                                 
                                 if(result.updateStatus==1){
                                 $('#msgEditSuccess').html("Menu successfully Edited!");                 
                                 window.setTimeout(function(){location.reload()},1000);
                                 }else{
                                 $('#msgEditError').html("Error In Menu Edit!");  
                                 }
                                 
                                 },
                                 error: function(result) 
                                 {
                                 alert("error: In Menu Edit"); 
                                 
                                 }
                                 });
                                 });
                                 }
                                 catch(e){
                                 alert("EX : "+e);
                                 }*/
                                //-----------------------Edit Code End---------------------------------------------

                                //----deactivation code------------------------ 

                                $("#delete").click(function () {
                                    var r = confirm("Are u sure to delete then press ok otherwise cancel");
                                    if (r == true) {
                                        // alert("11"+rd_id);

                                        var rd_id = $('input[name=ipModuleRadio]:checked').val();
                                        $("#ipAddHidden").val($("#" + rd_id + "_userIPAddress").html());
                                        var ipaddress = $("#ipAddHidden").val();

                                        $("#locHidden").val($("#" + rd_id + "_locationHidden").html());
                                        var locationn = $("#locHidden").val();


                                        $("#userName").val($("#" + rd_id + "_userName").html());
                                        var userName = $("#userName").val();

                                        $.ajax({
                                            type: "POST",
                                            //  url: "MenuMasterServlet?hiddenAction=delete&menuCodeDelete="+code,   
                                            url: "IPDeleteServlet?locationn=" + locationn + "&ipAddress=" + ipaddress + "&userName=" + userName,
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {

                                                if (result.finalStatus === 2) {

                                                    $('#msgError1').html("IP already deleted");
                                                    window.setTimeout(function () {
                                                        location.reload()
                                                    }, 1000);
                                                }
                                                else {

                                                    $('#msgRight1').html("IP successfully Deleted!");
                                                    window.setTimeout(function () {
                                                        location.reload()
                                                    }, 1000);

                                                }
                                            }
                                        });
                                    } else {
                                    }
                                });




                            });





                        </script>
                        </html>
