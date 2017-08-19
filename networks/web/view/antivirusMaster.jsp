<%-- 
    Document   : antivirusMaster
    Created on : Jul 26, 2017, 11:11:07 AM
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
    String antivirusCode, query, antivirusDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Antivirus Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addAntivirus"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addAntivirusModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Antivirus</a>
                            <a href="#" id="editAntivirus" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editAntivirusModal"><i class="fa fa-edit"></i>&nbsp;Edit Antivirus</a>
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
                                        + " FROM MASTER_ANTIVIRUS ORDER BY DESCRIPTION ";

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
                                    Antivirus Code</center>
                                </th>
                                <th>
                                <center>
                                    Antivirus Description</center>
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
                                            antivirusCode = rs.getString("CODE");

                                            antivirusDisc = rs.getString("DESCRIPTION");

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
                                     <input type="hidden"  id="antivirusCodeHidden" name="antivirusCodeHidden" >
                                    <font size="2"><span id="<%=i%>_antiviruscode"><%=antivirusCode%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_antivirusdisc"><%=antivirusDisc%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_antivirusdisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_antivirusremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_antivirusstatus">
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
                                            <input type="radio" name="antivirusRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="antivirusRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addAntivirusModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Antivirus</h4>
                                            </div>
                                              <form class="form-horizontal" id="newAntivirusForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="newantivirusNameField" class="col-sm-4 control-label">Antivirus Discription</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newantivirusNameField" name="newantivirusNameField" placeholder="Enter Antivirus Discription">
                                                       
                                                            <span class="help-inline" id="newAntivirusDiscError" style="color: red;">${error}</span>
                 
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
                                                        <label for="newantivirusRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newantivirusRemarks" name="newantivirusRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newantivirusError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="submit" class="btn btn-primary" id="addAntivirusAction"  >Add Antivirus</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editAntivirusModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Antivirus</h4>
                                        </div>
                                         <form class="form-horizontal" id="editAntivirusForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="antivirusCodeField" class="col-sm-4 control-label">Antivirus Code</label>

                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                            <input type="text" class="form-control" id="antivirusCodeField" name="antivirusCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="antivirusNameField" class="col-sm-4 control-label">Antivirus Name</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="antivirusNameField" name="antivirusNameField" placeholder="Enter Antivirus Discription">
                                                          <span class="help-inline" id="antivirusNameError" style="color: red;"></span> 
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
                                                        <label for="antivirusRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="antivirusRemarks" id="antivirusRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="antivirusRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="submit" id="editAntivirusAction" class="btn btn-primary">Save Changes</button>
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

                                    $("#editAntivirus").click(function () {
                                        var rd_id = $('input[name=antivirusRadio]:checked').val();
                                        $("#antivirusCodeField").val($("#" + rd_id + "_antiviruscode").html());
                                        $("#antivirusNameField").val($("#" + rd_id + "_antivirusdisc").html());
                                        $("#displayOrder").val($("#" + rd_id + "_antivirusdisplay").html());
                                        $("#antivirusRemarks").val($("#" + rd_id + "_antivirusremark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_antivirusstatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editAntivirusForm")[0].reset();
                                        $("#newAntivirusForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addAntivirusAction").click(function () {
                                        if( $('#newantivirusNameField').val()=='')	{
                                    $('#newAntivirusDiscError').html("This field is required.");
                                          return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#newantivirusNameField").val()))){
                                                      $('#newAntivirusDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#newantivirusNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newAntivirusDiscError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#newdisplayOrder').val()=='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#newDisplayError').empty();   
                                            }
                                             if( $('#newantivirusRemarks').val()=='')	{
                                    $('#newantivirusError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newantivirusRemarks").val()))){
                                                      $('#newantivirusError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newantivirusRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newantivirusError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'AntivirusMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newAntivirusForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("Antivirus successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In Antivirus Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Antivirus Add "); 
                                               
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
                                        
                                        $("#editAntivirusAction").click(function () {
                                            
                                        if( $('#antivirusNameField').val()=='')	{
                                    $('#antivirusNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                   if(!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#antivirusNameField").val()))){
                                                      $('#antivirusNameError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");                                                  
                                                    $("#antivirusNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#antivirusNameError').empty();                                                   	
                                            }
                                                   	
                                            }
                                             if( $('#displayOrder').val()=='')	{
                                    $('#displayOrderError').html("This field is required.");
                                            return false; 		
                                            }else{
                                               $('#displayOrderError').empty();   
                                            }
                                             if( $('#antivirusRemarks').val()=='')	{
                                    $('#antivirusRemarksError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#antivirusRemarks").val()))){
                                                      $('#antivirusRemarksError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#antivirusRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#antivirusRemarksError').empty();                                                   	
                                            }     
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'AntivirusMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#editAntivirusForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                            
                                                if(result.updateStatus==1){
                                                    $('#msgEditSuccess').html("Antivirus successfully Edited!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgEditError').html("Error In Antivirus Edit!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Antivirus Edit"); 
                                               
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
    
          var rd_id = $('input[name=antivirusRadio]:checked').val();
               $("#antivirusCodeHidden").val($("#" + rd_id + "_antiviruscode").html());
               var code=$("#antivirusCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "AntivirusMasterServlet?hiddenAction=delete&antivirusCodeDelete="+code,
           dataType: 'json',
                     encode: true,
                     
            success: function (result) {            
                 
                  if(result.finalStatus==2){
                    
                          $('#msgError1').html("Antivirus already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("Antivirus successfully Deleted!");                
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
    
          var rd_id = $('input[name=antivirusRadio]:checked').val();
               $("#antivirusCodeHidden").val($("#" + rd_id + "_antiviruscode").html());
               var code=$("#antivirusCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "AntivirusMasterServlet?hiddenAction=restore&antivirusCodeRestore="+code,
           dataType: 'json',
                     encode: true,
            
            success: function (result) { 
                 if(result.finalStatusRe==2){
                   
                          $('#msgError1').html("Antivirus already Active");                   
                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("Antivirus successfully Restored!");                
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
