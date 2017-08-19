<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String employmentTypeCode, query, employmentTypeDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Employment Type Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addEmploymentType"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addEmploymentTypeModal"><i class="fa fa-plus-square"></i>&nbsp;Add New EmploymentType</a>
                            <a href="#" id="editEmploymentType" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editEmploymentTypeModal"><i class="fa fa-edit"></i>&nbsp;Edit EmploymentType</a>
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
                                        + " FROM MASTER_USER_EMPLOYMENT_TYPE ORDER BY DESCRIPTION ";

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
                                    Employment Type Code</center>
                                </th>
                                <th>
                                <center>
                                    Employment Type Description</center>
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
                                            employmentTypeCode = rs.getString("CODE");

                                            employmentTypeDisc = rs.getString("DESCRIPTION");

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
                                     <input type="hidden"  id="employmentTypeCodeHidden" name="employmentTypeCodeHidden" >
                                    <font size="2"><span id="<%=i%>_employmentTypecode"><%=employmentTypeCode%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_employmentTypedisc"><%=employmentTypeDisc%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_employmentTypedisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_employmentTyperemark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_employmentTypestatus">
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
                                            <input type="radio" name="employmentTypeRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="employmentTypeRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addEmploymentTypeModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Employment Type</h4>
                                            </div>
                                              <form class="form-horizontal" id="newEmploymentTypeForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="newemploymentTypeNameField" class="col-sm-4 control-label">Employment Type Description</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newemploymentTypeNameField" name="newemploymentTypeNameField" placeholder="Enter EmploymentType Discription">
                                                       
                                                            <span class="help-inline" id="newEmploymentTypeDiscError" style="color: red;">${error}</span>
                 
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
                                                        <label for="newemploymentTypeRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newemploymentTypeRemarks" name="newemploymentTypeRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newemploymentTypeError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" id="addEmploymentTypeAction"  >Add Employment Type</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editEmploymentTypeModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Employment Type</h4>
                                        </div>
                                         <form class="form-horizontal" id="editEmploymentTypeForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="employmentTypeCodeField" class="col-sm-4 control-label">Employment Type Code</label>

                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                            <input type="text" class="form-control" id="employmentTypeCodeField" name="employmentTypeCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="employmentTypeNameField" class="col-sm-4 control-label">Employment Type Name</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="employmentTypeNameField" name="employmentTypeNameField" placeholder="Enter EmploymentType Description">
                                                          <span class="help-inline" id="employmentTypeNameError" style="color: red;"></span> 
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
                                                        <label for="employmentTypeRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="employmentTypeRemarks" id="employmentTypeRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="employmentTypeRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="submit" id="editEmploymentTypeAction" class="btn btn-primary">Save Changes</button>
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

                                    $("#editEmploymentType").click(function () {
                                        var rd_id = $('input[name=employmentTypeRadio]:checked').val();
                                        $("#employmentTypeCodeField").val($("#" + rd_id + "_employmentTypecode").html());
                                        $("#employmentTypeNameField").val($("#" + rd_id + "_employmentTypedisc").html());
                                        $("#displayOrder").val($("#" + rd_id + "_employmentTypedisplay").html());
                                        $("#employmentTypeRemarks").val($("#" + rd_id + "_employmentTyperemark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_employmentTypestatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editEmploymentTypeForm")[0].reset();
                                        $("#newEmploymentTypeForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addEmploymentTypeAction").click(function () {
                                        if( $('#newemploymentTypeNameField').val()=='')	{
                                    $('#newEmploymentTypeDiscError').html("This field is required.");
                                          return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#newemploymentTypeNameField").val()))){
                                                      $('#newEmploymentTypeDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#newemploymentTypeNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newEmploymentTypeDiscError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#newdisplayOrder').val()=='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#newDisplayError').empty();   
                                            }
                                             if( $('#newemploymentTypeRemarks').val()=='')	{
                                    $('#newemploymentTypeError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newemploymentTypeRemarks").val()))){
                                                      $('#newemploymentTypeError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newemploymentTypeRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newemploymentTypeError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'EmploymentTypeMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newEmploymentTypeForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("EmploymentType successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In EmploymentType Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In EmploymentType Add "); 
                                               
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
                                        
                                        $("#editEmploymentTypeAction").click(function () {
                                            
                                        if( $('#employmentTypeNameField').val()=='')	{
                                    $('#employmentTypeNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#employmentTypeNameField").val()))){
                                                      $('#employmentTypeNameError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#employmentTypeNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#employmentTypeNameError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#displayOrder').val()=='')	{
                                    $('#displayOrderError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#displayOrderError').empty();   
                                            }
                                             if( $('#employmentTypeRemarks').val()=='')	{
                                    $('#employmentTypeRemarksError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#employmentTypeRemarks").val()))){
                                                      $('#employmentTypeRemarksError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#employmentTypeRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#employmentTypeRemarksError').empty();                                                   	
                                            }     
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'EmploymentTypeMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#editEmploymentTypeForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                            
                                                if(result.updateStatus==1){
                                                    $('#msgEditSuccess').html("EmploymentType successfully Edited!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgEditError').html("Error In EmploymentType Edit!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In EmploymentType Edit"); 
                                               
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
    
          var rd_id = $('input[name=employmentTypeRadio]:checked').val();
               $("#employmentTypeCodeHidden").val($("#" + rd_id + "_employmentTypecode").html());
               var code=$("#employmentTypeCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "EmploymentTypeMasterServlet?hiddenAction=delete&employmentTypeCodeDelete="+code,
           dataType: 'json',
                     encode: true,
                     
            success: function (result) {            
                 
                  if(result.finalStatus==2){
                    
                          $('#msgError1').html("EmploymentType already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("EmploymentType successfully Deleted!");                
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
    
          var rd_id = $('input[name=employmentTypeRadio]:checked').val();
               $("#employmentTypeCodeHidden").val($("#" + rd_id + "_employmentTypecode").html());
               var code=$("#employmentTypeCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "EmploymentTypeMasterServlet?hiddenAction=restore&employmentTypeCodeRestore="+code,
           dataType: 'json',
                     encode: true,
            
            success: function (result) { 
                 if(result.finalStatusRe==2){
                   
                          $('#msgError1').html("EmploymentType already Active");                   
                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("EmploymentType successfully Restored!");                
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
