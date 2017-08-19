<%-- 
    Document   : floorMaster
    Created on : May 19, 2017, 04:51:07 PM
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
    String floorCode, query, floorDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Floor Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addFloor"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addFloorModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Floor</a>
                            <a href="#" id="editFloor" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editFloorModal"><i class="fa fa-edit"></i>&nbsp;Edit Floor</a>
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
                                        + " FROM MASTER_FLOOR ORDER BY DESCRIPTION ";

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
                                    Floor Code</center>
                                </th>
                                <th>
                                <center>
                                    Floor Description</center>
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
                                            floorCode = rs.getString("CODE");

                                            floorDisc = rs.getString("DESCRIPTION");

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
                                     <input type="hidden"  id="floorCodeHidden" name="floorCodeHidden" >
                                    <font size="2"><span id="<%=i%>_floorcode"><%=floorCode%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_floordisc"><%=floorDisc%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_floordisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_floorremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_floorstatus">
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
                                            <input type="radio" name="floorRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="floorRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addFloorModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Floor</h4>
                                            </div>
                                              <form class="form-horizontal" id="newFloorForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="newfloorNameField" class="col-sm-4 control-label">Floor Discription</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newfloorNameField" name="newfloorNameField" placeholder="Enter Floor Discription">
                                                       
                                                            <span class="help-inline" id="newFloorDiscError" style="color: red;">${error}</span>
                 
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
                                                        <label for="newfloorRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newfloorRemarks" name="newfloorRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newfloorError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" id="addFloorAction"  >Add Floor</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editFloorModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Floor</h4>
                                        </div>
                                         <form class="form-horizontal" id="editFloorForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="floorCodeField" class="col-sm-4 control-label">Floor Code</label>

                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                            <input type="text" class="form-control" id="floorCodeField" name="floorCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="floorNameField" class="col-sm-4 control-label">Floor Name</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="floorNameField" name="floorNameField" placeholder="Enter Floor Discription">
                                                          <span class="help-inline" id="floorNameError" style="color: red;"></span> 
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
                                                        <label for="floorRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="floorRemarks" id="floorRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="floorRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="submit" id="editFloorAction" class="btn btn-primary">Save Changes</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>                                           
                                        </div>
                                      
                                    </div>
                                </div>
                            </div>
                                                 

         </div>
                           

                            <!-- /.content-wrapper -->
                            <%@include file="footer.jsp"%>
                             </body>

                             <%@include file="scripts.jsp"%>
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

                                    $("#editFloor").click(function () {
                                        var rd_id = $('input[name=floorRadio]:checked').val();
                                        $("#floorCodeField").val($("#" + rd_id + "_floorcode").html());
                                        $("#floorNameField").val($("#" + rd_id + "_floordisc").html());
                                        $("#displayOrder").val($("#" + rd_id + "_floordisplay").html());
                                        $("#floorRemarks").val($("#" + rd_id + "_floorremark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_floorstatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editFloorForm")[0].reset();
                                        $("#newFloorForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addFloorAction").click(function () {
                                        if( $('#newfloorNameField').val()==='')	{
                                    $('#newFloorDiscError').html("This field is required.");
                                          return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#newfloorNameField").val()))){
                                                      $('#newFloorDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#newfloorNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newFloorDiscError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#newdisplayOrder').val()==='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#newDisplayError').empty();   
                                            }
                                             if( $('#newfloorRemarks').val()==='')	{
                                    $('#newfloorError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newfloorRemarks").val()))){
                                                      $('#newfloorError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newfloorRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newfloorError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'FloorMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newFloorForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval===1){
                                                    $('#msgAddSuccess').html("Floor successfully Added!");                 
                                                        window.setTimeout(function(){location.reload();},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In Floor Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Floor Add "); 
                                               
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
                                        
                                        $("#editFloorAction").click(function () {
                                            
                                        if( $('#floorNameField').val()==='')	{
                                    $('#floorNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#floorNameField").val()))){
                                                      $('#floorNameError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#floorNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#floorNameError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#displayOrder').val()==='')	{
                                    $('#displayOrderError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#displayOrderError').empty();   
                                            }
                                             if( $('#floorRemarks').val()==='')	{
                                    $('#floorRemarksError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#floorRemarks").val()))){
                                                      $('#floorRemarksError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#floorRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#floorRemarksError').empty();                                                   	
                                            }     
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'FloorMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#editFloorForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                            
                                                if(result.updateStatus===1){
                                                    $('#msgEditSuccess').html("Floor successfully Edited!");                 
                                                        window.setTimeout(function(){location.reload();},1000);
                                                }else{
                                                   $('#msgEditError').html("Error In Floor Edit!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Floor Edit"); 
                                               
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
        if (r === true) {
    
          var rd_id = $('input[name=floorRadio]:checked').val();
               $("#floorCodeHidden").val($("#" + rd_id + "_floorcode").html());
               var code=$("#floorCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "FloorMasterServlet?hiddenAction=delete&floorCodeDelete="+code,
           dataType: 'json',
                     encode: true,
                     
            success: function (result) {            
                 
                  if(result.finalStatus===2){
                    
                          $('#msgError1').html("Floor already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload();},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("Floor successfully Deleted!");                
                   window.setTimeout(function(){location.reload();},1000);
                         }
            }
        });
         } else {     
    }
    });
   //-------------------------activation code------------------------ 
    
  $("#restore").click(function () {       
         var r = confirm("Are You sure to restore then press ok otherwise cancel");
        if (r === true) {
    
          var rd_id = $('input[name=floorRadio]:checked').val();
               $("#floorCodeHidden").val($("#" + rd_id + "_floorcode").html());
               var code=$("#floorCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "FloorMasterServlet?hiddenAction=restore&floorCodeRestore="+code,
           dataType: 'json',
                     encode: true,
            
            success: function (result) { 
                 if(result.finalStatusRe===2){
                   
                          $('#msgError1').html("Floor already Active");                   
                           window.setTimeout(function(){location.reload();},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("Floor successfully Restored!");                
                   window.setTimeout(function(){location.reload();},1000);
                         }
                
                
            }
        });
         } else {     
    }
    });
                                    
 });





                            </script>
                            </html>
