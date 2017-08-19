<%-- 
    Document   : deviceMaster
    Created on : May 23, 2017, 10:12:07 AM
    Author     : Manju
--%>
<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String deviceCode, query, deviceDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
String msgRight="";
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
                        <h2 class="box-title"> Device Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addDevice"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addDeviceModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Device</a>
                            <a href="#" id="editDevice" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editDeviceModal"><i class="fa fa-edit"></i>&nbsp;Edit Device</a>
                            <a id="delete" role="button" class="btn btn-primary" data-toggle="modal">
                            <i class="fa fa-trash-o"></i>&nbsp;Delete</a>
                            <a id="restore" role="button" class="btn btn-primary" data-toggle="modal">
                             <i class="fa fa-undo"></i>&nbsp;Restore</a>

                        </div>
                    </div>
                 

                                      <c:if test="${msgRight!=''}">
                       <div align="center" style="color:#008000;" > ${msgRight}</div>
                    </c:if>
                    
                    <div align="center" >&nbsp;<span style="color:#008000;" id="msgRight1"></span> </div>
                     <div align="center" >&nbsp;<span style="color:#FF0000;" id="msgError1"></span> </div>
<!--                    <div class="alert alert-success alert-dismissible" id="msg" hidden="hidden">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
                <span ></span>
              </div>            -->
                    
                    <div class="box-body">
                        <%                    try {
                                DataConnect con = new DataConnect();
                                conn = con.getConnection();

                                query = "  SELECT CODE,"
                                        + "  DESCRIPTION,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                        + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') as ENTERED_ON,RECORD_STATUS"
                                        + " FROM MASTER_DEVICE_TYPE ORDER BY DESCRIPTION ";

                                st = conn.createStatement();
                                rs = st.executeQuery(query);
                                int i = 1;
                        %>
                        <center>

                            <table  id="example1" class="table table-bordered table-striped"  >

                                <thead>
                                    <tr bgcolor="">
                                        <th>
                                <center>
                                    #</center>
                                </th>

                                <th>
                                <center>
                                    Device Code</center>
                                </th>
                                <th>
                                <center>
                                    Device Description</center>
                                </th>
                                <th>
                                <center>
                                    Display Order</center>
                                </th>
                                <th>
                                <center>
                                    Entered Remarks</center>
                                </th>


                                <th>
                                <center>
                                    Record Status</center>
                                </th>
                                <th>

                                </th>



                                </tr>
                                </thead>
                                <tbody>
                                    <%
                                        while (rs.next()) {
                                            deviceCode = rs.getString("CODE");

                                            deviceDisc = rs.getString("DESCRIPTION");

                                            displayOrder = rs.getString("DISPLAY_ORDER");

                                            recordStatus = rs.getString("RECORD_STATUS");
                                            enterRemarks = rs.getString("ENTERED_REMARKS");
                                            enterBy = rs.getString("ENTERED_BY");
                                            enterDate = rs.getString("ENTERED_ON");


                                    %>

                                    <tr>
                                        <td>
                                <center><%=i%>.
                                </center>
                                </td>


                                <td>
                                <center>
                                     <input type="hidden"  id="deviceCodeHidden" name="deviceCodeHidden" >
                                    <font size="2"><span id="<%=i%>_devicecode"><%=deviceCode%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_devicedisc"><%=deviceDisc%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_devicedisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_deviceremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_devicestatus">
                                        <%if(recordStatus.equals("A")){ %>
                                         <img src="../img/active.png" style="width: 20px; height: 20px;" />
                                        <%}else if(recordStatus.equals("D")){ %>
                                          <img src="../img/deactive.png" style="width: 20px; height: 20px;" />
                                        <% }%>
                                       </span></font>
                                </center>
                                </td>

                                <td>
                                <center>
                                    <div class="radio">
                                        <label>
                                            <% if (i == 1) {%>
                                            <input type="radio" name="deviceRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="deviceRadio" id="<%=i%>" value="<%=i%>">
                                            <%}%>
                                        </label>
                                    </div>
                                </center>
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
                           
                                <div class="modal fade" id="addDeviceModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Device</h4>
                                            </div>
                                              <form class="form-horizontal" id="newDeviceForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="newdeviceNameField" class="col-sm-4 control-label">Device Discription</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newdeviceNameField" name="newdeviceNameField" placeholder="Enter Device Discription">
                                                       
                                                            <span class="help-inline" id="newDeviceDiscError" style="color: red;">${error}</span>
                 
                                                        </div>
                                                    </div>
                                                   
                                                    
                                                    <div class="form-group">
                                                        <label for="newdisplayOrder" class="col-sm-4 control-label">Display Order</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newdisplayOrder" name="newdisplayOrder" value="99" placeholder="Enter Display Order">
                                                           <span class="help-inline" id="newDisplayError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="newdeviceRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newdeviceRemarks" name="newdeviceRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newdeviceError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" id="addDeviceAction"  >Add Device</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editDeviceModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Device</h4>
                                        </div>
                                         <form class="form-horizontal" id="editDeviceForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="deviceCodeField" class="col-sm-4 control-label">Device Code</label>

                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                            <input type="text" class="form-control" id="deviceCodeField" name="deviceCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="deviceNameField" class="col-sm-4 control-label">Device Name</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="deviceNameField" name="deviceNameField" placeholder="Enter Device Discription">
                                                          <span class="help-inline" id="deviceNameError" style="color: red;"></span> 
                                                        </div>


                                                    </div>
                                                    <div class="form-group">
                                                        <label for="displayOrder" class="col-sm-4 control-label">Display Order</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="displayOrder" id="displayOrder" placeholder="Enter Display Order">
                                                            <span class="help-inline" id="displayOrderError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="deviceRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="deviceRemarks" id="deviceRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="deviceRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="submit" id="editDeviceAction" class="btn btn-primary">Save Changes</button>
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

                                    $("#editDevice").click(function () {
                                        var rd_id = $('input[name=deviceRadio]:checked').val();
                                        $("#deviceCodeField").val($("#" + rd_id + "_devicecode").html());
                                        $("#deviceNameField").val($("#" + rd_id + "_devicedisc").html());
                                        $("#displayOrder").val($("#" + rd_id + "_devicedisplay").html());
                                        $("#deviceRemarks").val($("#" + rd_id + "_deviceremark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_devicestatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editDeviceForm")[0].reset();
                                        $("#newDeviceForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addDeviceAction").click(function () {
                                        if( $('#newdeviceNameField').val()=='')	{
                                    $('#newDeviceDiscError').html("This field is required.");
                                          return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#newdeviceNameField").val()))){
                                                      $('#newDeviceDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#newdeviceNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newDeviceDiscError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#newdisplayOrder').val()=='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#newDisplayError').empty();   
                                            }
                                             if( $('#newdeviceRemarks').val()=='')	{
                                    $('#newdeviceError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newdeviceRemarks").val()))){
                                                      $('#newdeviceError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newdeviceRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newdeviceError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'DeviceMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newDeviceForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("Device successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In Device Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Device Add "); 
                                               
                                            }
                                      });
                                    });
                                    }
                                    catch(e){
                                        alert("EX : "+e);
                                    }
                                  //-----------------------Add Code End---------------------------------------------
                                  
                                    //-------------------------Edit Code start---------------------------------------------
                                    try{
                                        
                                        $("#editDeviceAction").click(function () {
                                            
                                        if( $('#deviceNameField').val()=='')	{
                                    $('#deviceNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#deviceNameField").val()))){
                                                      $('#deviceNameError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#deviceNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#deviceNameError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#displayOrder').val()=='')	{
                                    $('#displayOrderError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#displayOrderError').empty();   
                                            }
                                             if( $('#deviceRemarks').val()=='')	{
                                    $('#deviceRemarksError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#deviceRemarks").val()))){
                                                      $('#deviceRemarksError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#deviceRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#deviceRemarksError').empty();                                                   	
                                            }     
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'DeviceMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#editDeviceForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                            
                                                if(result.updateStatus==1){
                                                    $('#msgEditSuccess').html("Device successfully Edited!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgEditError').html("Error In Device Edit!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Device Edit"); 
                                               
                                            }
                                      });
                                    });
                                    }
                                    catch(e){
                                        alert("EX : "+e);
                                    }
                                  //-----------------------Edit Code End---------------------------------------------
                             
           //----deactivation code------------------------ 
           
    $("#delete").click(function () {       
         var r = confirm("Are u sure to delete then press ok otherwise cancel");
        if (r == true) {
    
          var rd_id = $('input[name=deviceRadio]:checked').val();
               $("#deviceCodeHidden").val($("#" + rd_id + "_devicecode").html());
               var code=$("#deviceCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "DeviceMasterServlet?hiddenAction=delete&deviceCodeDelete="+code,
           dataType: 'json',
                     encode: true,
                     
            success: function (result) {            
                 
                  if(result.finalStatus==2){
                    
                          $('#msgError1').html("Device already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("Device successfully Deleted!");                
                   window.setTimeout(function(){location.reload()},1000);
                         }
            }
        });
         } else {     
    }
    });
   //-------------------------activation code------------------------ 
    
  $("#restore").click(function () {       
         var r = confirm("Are You sure to restore then press ok otherwise cancel");
        if (r == true) {
    
          var rd_id = $('input[name=deviceRadio]:checked').val();
               $("#deviceCodeHidden").val($("#" + rd_id + "_devicecode").html());
               var code=$("#deviceCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "DeviceMasterServlet?hiddenAction=restore&deviceCodeRestore="+code,
           dataType: 'json',
                     encode: true,
            
            success: function (result) { 
                 if(result.finalStatusRe==2){
                   
                          $('#msgError1').html("Device already Active");                   
                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("Device successfully Restored!");                
                   window.setTimeout(function(){location.reload()},1000);
                         }
                
                
            }
        });
         } else {     
    }
    });
                                    
 });





                            </script>
                            </html>
