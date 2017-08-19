<%-- 
    Document   : menuMaster
    Created on : May 15, 2017, 10:57:23 AM
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
    String menuCode, query, menuName,menuActionPath,menuSubCategory, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Menu Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addMenu"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addMenuModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Menu</a>
                            <a href="#" id="editMenu" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editMenuModal"><i class="fa fa-edit"></i>&nbsp;Edit Menu</a>
                            <a id="delete" role="button" class="btn btn-primary" data-toggle="modal">
                            <i class="fa fa-trash-o"></i>&nbsp;Delete</a>
                            <a id="restore" role="button" class="btn btn-primary" data-toggle="modal">
                             <i class="fa fa-undo"></i>&nbsp;Restore</a>

                        </div>
                    </div>
                 
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

                                query = "  SELECT CATEGORY_CODE,HAS_SUBCATEGORIES,"
                                        + "  ACTION_PATH,CATEGORY_DESCRIPTION,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                        + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') as ENTERED_ON,RECORD_STATUS"
                                        + " FROM MASTER_MENU_CATEGORY ORDER BY CATEGORY_DESCRIPTION ";

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
                                    Menu Code</center>
                                </th>
                                <th>
                                <center>
                                    Menu Description</center>
                                </th>
                                 <th>
                                <center>
                                    Action Path</center>
                                </th>
                                 <th>
                                <center>
                                    SUBCATEGORIES</center>
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
                                            menuCode = rs.getString("CATEGORY_CODE");
                                            menuName = rs.getString("CATEGORY_DESCRIPTION");
                                             menuActionPath = rs.getString("ACTION_PATH");
                                               menuSubCategory = rs.getString("HAS_SUBCATEGORIES");
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
                                     <input type="hidden"  id="menuCodeHidden" name="menuCodeHidden" >
                                    <font size="2"><span id="<%=i%>_menucode"><%=menuCode%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_menuname"><%=menuName%></span></font>
                                </center>
                                </td>

                                <td> <center>
                                    <font size="2"><span id="<%=i%>_menuactionpath"><%=menuActionPath%></span></font>
                                </center>
                                </td>
                                <td> <center>
                                    <font size="2"><span id="<%=i%>_menusubcategory"><%=menuSubCategory%></span></font>
                                </center>
                                </td>

                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_menudisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_menuremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_menustatus">
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
                                            <input type="radio" name="menuRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="menuRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addMenuModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Menu</h4>
                                            </div>
                                              <form class="form-horizontal" id="newMenuForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="newmenuNameField" class="col-sm-4 control-label">Menu Description</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newmenuNameField" name="newmenuNameField" placeholder="Enter Menu Discription">
                                                       
                                                            <span class="help-inline" id="newMenuNameError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                     <div class="form-group">
                                                        <label for="newmenuActionPathField" class="col-sm-4 control-label">Menu Action Path</label>
                                                        <div class="col-sm-8">
                                               <input type="text" class="form-control" id="newmenuActionPathField" name="newmenuActionPathField" placeholder="Enter Menu Action Path">
                                                       <span class="help-inline" id="newMenuActionPathError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                      <div class="form-group">
                                                        <label for="newmenuSubCategoryField" class="col-sm-4 control-label">SubCategory</label>
                                                        <div class="col-sm-8">
                                               <input type="text" class="form-control" id="newmenuSubCategoryField" name="newmenuSubCategoryField" placeholder="Enter Menu SubCategory">
                                                       <span class="help-inline" id="newMenuSubCategoryError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                   
                                                    
                                                    <div class="form-group">
                                                        <label for="newdisplayOrder" class="col-sm-4 control-label">Display Order</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newdisplayOrder" name="newdisplayOrder" value="999" placeholder="Enter Display Order">
                                                           <span class="help-inline" id="newDisplayError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="newmenuRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newmenuRemarks" name="newmenuRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newmenuError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" id="addMenuAction"  >Add Menu</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editMenuModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
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
                                                        <label for="menuCodeField" class="col-sm-4 control-label">Menu Code</label>

                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                            <input type="text" class="form-control" id="menuCodeField" name="menuCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>

                                                    <div class="form-group">
                                                        <label for="menuNameField" class="col-sm-4 control-label">Menu Description</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="menuNameField" name="menuNameField" placeholder="Enter Menu Discription">
                                                          <span class="help-inline" id="menuNameError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                    
                                                       <div class="form-group">
                                                        <label for="menuActionPathField" class="col-sm-4 control-label">Menu Action Path</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="menuActionPathField" name="menuActionPathField" placeholder="Enter Menu ActionPath">
                                                          <span class="help-inline" id="menuActionPathError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                      <div class="form-group">
                                                        <label for="menuSubCategoryField" class="col-sm-4 control-label">Menu SubCategory</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="menuSubCategoryField" name="menuSubCategoryField" placeholder="Enter Menu SubCategory">
                                                          <span class="help-inline" id="menuSubCategoryError" style="color: red;"></span> 
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
                                                        <label for="menuRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="menuRemarks" id="menuRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="menuRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="button" id="editMenuAction" class="btn btn-primary">Save Changes</button>
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

                                    $("#editMenu").click(function () {
                                        var rd_id = $('input[name=menuRadio]:checked').val();
                                        $("#menuCodeField").val($("#" + rd_id + "_menucode").html());
                                        $("#menuNameField").val($("#" + rd_id + "_menuname").html());
                                          $("#menuActionPathField").val($("#" + rd_id + "_menuactionpath").html());
                                            $("#menuSubCategoryField").val($("#" + rd_id + "_menusubcategory").html());                                          
                                        $("#displayOrder").val($("#" + rd_id + "_menudisplay").html());
                                        $("#menuRemarks").val($("#" + rd_id + "_menuremark").html());
                                       // $("#recordStatusField").val($("#" + rd_id + "_menustatus").html());
                                    });



                                    $('.modal').on('hidden.bs.modal', function () {
                                        $("#editMenuForm")[0].reset();
                                        $("#newMenuForm")[0].reset();
                                    });

                                  //-------------------------Add Code start---------------------------------------------
                                    try{
                                        
                                        $("#addMenuAction").click(function () {
                                        if( $('#newmenuNameField').val()=='')	{
                                    $('#newMenuNameError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                // add ^(?!\s*$) for not all blank space
                                                if(!(/^(?!\s*$)[a-zA-Z ]{3,50}$/.test($("#newmenuNameField").val()))){
                                                      $('#newMenuNameError').html(" Only alphabets Allowed.Minimum length should be 3.");                                                  
                                                    $("#newmenuNameField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newMenuNameError').empty();                                                   	
                                            }
                                        }
                                            
                                             if( $('#newmenuActionPathField').val()=='')	{                                                
                                    $('#newMenuActionPathError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                 $('#newMenuActionPathError').html("");
                                            }
                                            
                                             if( $('#newmenuSubCategoryField').val()=='')	{                                                
                                    $('#newMenuSubCategoryError').html("This field is required.");
                                            return false; 		
                                            }else{
                                                  if(!(/^[NY]{0,1}$/.test($("#newmenuSubCategoryField").val()))){
                                                      $('#newMenuSubCategoryError').html(" Only alphabets Y or N Allowed.");                                                  
                                                    $("#newmenuSubCategoryField").focus();
                                                      return false; 
                                                }else{
                                                   $('#newMenuSubCategoryError').empty();                                                   	
                                            }
                                            }
                                            
                                             if( $('#newdisplayOrder').val()=='')	{
                                    $('#newDisplayError').html("This field is required.");
                                            return false; 		
                                            }else{
                                             if(!(/^[0-9]{0,3}$/.test($("#newdisplayOrder").val()))){
                                                      $('#newDisplayError').html(" Only numeric 0-9  allowed.Maximum length should be 3");                                                  
                                                    $("#newdisplayOrder").focus();
                                                      return false; 
                                                }else{                                                
                                                   $('#newDisplayError').empty();
                                               }	
                                            }
                                             if( $('#newmenuRemarks').val()=='')	{
                                    $('#newmenuError').html("This field is required.");
                                            return false; 		
                                            }
                                            else{
                                               if(!(/^[a-zA-Z./ ]+$/.test($("#newmenuRemarks").val()))){
                                                      $('#newmenuError').html(" Only alphabets and . Allowed");                                                  
                                                    $("#newmenuRemarks").focus();
                                                      return false; 
                                                }else{
                                                   $('#newmenuError').empty();                                                   	
                                            }   
                                            }
                                        
                                        $.ajax({
                                            type: 'POST',
                                          url: 'MenuMasterServlet',
                                         // data:  new FormData(this),
                                       data: $('#newMenuForm').serialize(),
                                            dataType: 'json',
                                            encode: true,
                                            success: function (result) {
                                               // alert("fgdg"+result.rsval);
                                                if(result.rsval==1){
                                                    $('#msgAddSuccess').html("Menu successfully Added!");                 
                                                        window.setTimeout(function(){location.reload()},1000);
                                                }else{
                                                   $('#msgAddError').html("Error In Menu Add!");  
                                                }
                                                
                                            },
                                            error: function(result) 
                                            {
                                                 alert("error: In Menu Add "); 
                                               
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
                                    }
                                  //-----------------------Edit Code End---------------------------------------------
                             
           //----deactivation code------------------------ 
           
    $("#delete").click(function () {       
         var r = confirm("Are u sure to delete then press ok otherwise cancel");
        if (r == true) {
    
          var rd_id = $('input[name=menuRadio]:checked').val();
               $("#menuCodeHidden").val($("#" + rd_id + "_menucode").html());
               var code=$("#menuCodeHidden").val();         
          
        $.ajax({
            type: "POST",
         url: "MenuMasterServlet?hiddenAction=delete&menuCodeDelete="+code,       
//            contentType: "application/json",
//            async: false, 
                    dataType: 'json',
                     encode: true,
            success: function (result) { 
               
                  if(result.finalStatus==2){
                    
                          $('#msgError1').html("Menu already deleted");  
                          	//$('#msgError1').delay(1000).fadeOut();

                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                      
                  $('#msgRight1').html("Menu successfully Deleted!");                
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
    
          var rd_id = $('input[name=menuRadio]:checked').val();
               $("#menuCodeHidden").val($("#" + rd_id + "_menucode").html());
               var code=$("#menuCodeHidden").val();         
          
        $.ajax({
            type: "POST",
          url: "MenuMasterServlet?hiddenAction=restore&menuCodeRestore="+code,
//            contentType: "application/json",
//            async: false,
             dataType: 'json',
                     encode: true,
            success: function (result) {               
                
                  if(result.finalStatusRe==2){
                   
                          $('#msgError1').html("Menu already Active");
                         // $('#msgError1').delay(1000).fadeOut();
                           window.setTimeout(function(){location.reload()},1000);
                        }
                   else{
                     
                  $('#msgRight1').html("Menu successfully Restored!");                
                   window.setTimeout(function(){location.reload()},1000);
                         }
                
                  // $('#msgRight1').html("Menu successfully Restored!");                  
                 //window.setTimeout(function(){location.reload()},1000);
                               
                
            }
        });
         } else {     
    }
    });
                                    
 });





                            </script>
                            </html>
