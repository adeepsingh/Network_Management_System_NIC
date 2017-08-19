<%-- 
    Document   : WMaster
    Created on : Jun 20, 2017, 12:36:27 PM
    Author     : acer
--%>

<%@page import="java.sql.Connection"%>
<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String wingCode, query, wingDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Wing Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addWing"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addWingModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Wing</a>
                            <a href="#" id="editWing" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editWingModal"><i class="fa fa-edit"></i>&nbsp;Edit Wing</a>
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
                                        + " FROM MASTER_WING ORDER BY DESCRIPTION ";

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
                                    Wing Code</center>
                                </th>
                                <th>
                                <center>
                                    Wing Description</center>
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
                                            wingCode = rs.getString("CODE");

                                            wingDisc = rs.getString("DESCRIPTION");

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
                                     <input type="hidden"  id="wingCodeHidden" name="wingCodeHidden" >
                                    <font size="2"><span id="<%=i%>_wingcode"><%=wingCode%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_wingdisc"><%=wingDisc%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_wingdisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_wingremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_wingstatus">
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
                                            <input type="radio" name="wingRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="wingRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addWingModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Wing</h4>
                                            </div>
                                              <form class="form-horizontal" id="newWingForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="newwingNameField" class="col-sm-4 control-label">Wing Description</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newwingNameField" name="newwingNameField" placeholder="Enter wing Discription">
                                                       
                                                            <span class="help-inline" id="newWingDiscError" style="color: red;">${error}</span>
                 
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
                                                        <label for="newwingRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newwingRemarks" name="newwingRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newwingError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" id="addWingAction"  >Add Wing</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editWingModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Wing</h4>
                                        </div>
                                         <form class="form-horizontal" id="editWingForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="wingCodeField" class="col-sm-4 control-label">Wing Code</label>

                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                            <input type="text" class="form-control" id="wingCodeField" name="wingCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="wingNameField" class="col-sm-4 control-label">Wing Name</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="wingNameField" name="wingNameField" placeholder="Enter Wing Discription">
                                                          <span class="help-inline" id="wingNameError" style="color: red;"></span> 
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
                                                        <label for="wingRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="wingRemarks" id="wingRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="wingRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="submit" id="editWingAction" class="btn btn-primary">Save Changes</button>
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

                                    $("#editWing").click(function () {
                                        var rd_id = $('input[name=wingRadio]:checked').val();
                                        $("#wingCodeField").val($("#" + rd_id + "_wingcode").html());
                                        $("#wingNameField").val($("#" + rd_id + "_wingdisc").html());
                                        $("#displayOrder").val($("#" + rd_id + "_wingdisplay").html());
                                        $("#wingRemarks").val($("#" + rd_id + "_wingremark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_wingstatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editWingForm")[0].reset();
                                        $("#newWingForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addWingAction").click(function () {
                                        if( $('#newwingNameField').val()=='')	{
                                    $('#newWingDiscError').html("This field is required.");
                                          return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#newwingNameField").val()))){
                                                      $('#newWingDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#newwingNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newWingDiscError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#newdisplayOrder').val()=='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#newDisplayError').empty();   
                                            }
                                             if( $('#newwingRemarks').val()=='')	{
                                    $('#newwingError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newwingRemarks").val()))){
                                                      $('#newwingError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newwingRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newwingError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'WingMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newWingForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("Wing successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In Wing Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Wing Add "); 
                                               
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
                                        
                                        $("#editWingAction").click(function () {
                                            
                                        if( $('#wingNameField').val()=='')	{
                                    $('#wingNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#wingNameField").val()))){
                                                      $('#wingNameError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#wingNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#wingNameError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#displayOrder').val()=='')	{
                                    $('#displayOrderError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#displayOrderError').empty();   
                                            }
                                             if( $('#wingRemarks').val()=='')	{
                                    $('#wingRemarksError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#wingRemarks").val()))){
                                                      $('#wingRemarksError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#wingRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#wingRemarksError').empty();                                                   	
                                            }     
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'WingMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#editWingForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                            
                                                if(result.updateStatus==1){
                                                    $('#msgEditSuccess').html("Wing successfully Edited!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgEditError').html("Error In Wing Edit!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Wing Edit"); 
                                               
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
    
          var rd_id = $('input[name=wingRadio]:checked').val();
               $("#wingCodeHidden").val($("#" + rd_id + "_wingcode").html());
               var code=$("#wingCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "WingMasterServlet?hiddenAction=delete&wingCodeDelete="+code,
           dataType: 'json',
                     encode: true,
                     
            success: function (result) {            
                 
                  if(result.finalStatus==2){
                    
                          $('#msgError1').html("Wing already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("Wing successfully Deleted!");                
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
    
          var rd_id = $('input[name=wingRadio]:checked').val();
               $("#wingCodeHidden").val($("#" + rd_id + "_wingcode").html());
               var code=$("#wingCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "WingMasterServlet?hiddenAction=restore&wingCodeRestore="+code,
           dataType: 'json',
                     encode: true,
            
            success: function (result) { 
                 if(result.finalStatusRe==2){
                   
                          $('#msgError1').html("Wing already Active");                   
                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("Wing successfully Restored!");                
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
