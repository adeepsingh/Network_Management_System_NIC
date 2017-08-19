<%-- 
    Document   : submenuMaster
    Created on : May 15, 2017, 01:52:23 PM
    Author     : Manju
--%>
<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "menuList" class = "com.nic.form.populate.MenuPopulate" scope = "page" />
<jsp:useBean id = "menuList1" class = "com.nic.form.populate.MenuPopulate" scope = "page" />
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String menuCode,menuDesc,submenuCode, query, submenuName,submenuActionPath, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Menu Subcategory Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addSubmenu"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addSubmenuModal" ><i class="fa fa-plus-square"></i>&nbsp;Add New Menu Subcategory</a>
                            <a href="#" id="editSubmenu" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editSubmenuModal"><i class="fa fa-edit"></i>&nbsp;Edit</a>
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

                                query = "  SELECT CATEGORY_CODE,"
                                     +"(SELECT CATEGORY_DESCRIPTION from MASTER_MENU_CATEGORY where CATEGORY_CODE=MCAT.CATEGORY_CODE ) as CATEGORY_DESCRIPTION,"
                                     + "SUBCATEGORY_CODE,"
                                     + "SUBCATEGORY_DESCRIPTION,ACTION_PATH,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                     + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') as ENTERED_ON,RECORD_STATUS"
                                     + " FROM MASTER_MENU_SUBCATEGORY MCAT ORDER BY CATEGORY_DESCRIPTION,SUBCATEGORY_DESCRIPTION ";

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
                                    Menu Subcategory Code</center>
                                </th>
                                  <th>
                                <center>
                                    Menu </center>
                                </th>
                                <th>
                                <center>
                                    Menu Subcategory </center>
                                </th>
                                 <th>
                                <center>
                                    Action Path</center>
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
                                            menuCode=rs.getString("CATEGORY_CODE");
                                            menuDesc=rs.getString("CATEGORY_DESCRIPTION");
                                            submenuCode = rs.getString("SUBCATEGORY_CODE");
                                            submenuName = rs.getString("SUBCATEGORY_DESCRIPTION");
                                             submenuActionPath = rs.getString("ACTION_PATH");
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
                                     <input type="hidden"  id="submenuCodeHidden" name="submenuCodeHidden" >
                                    <font size="2"><span id="<%=i%>_submenucode"><%=submenuCode%></span>
                                    <span id="<%=i%>_menucode" hidden="hidden"><%=menuCode%></span>
                                    </font>
                                </center>
                                </td>
                                 <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_menudesc"><%=menuDesc%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_submenuname"><%=submenuName%></span></font>
                                </center>
                                </td>

                                <td> <center>
                                    <font size="2"><span id="<%=i%>_submenuactionpath"><%=submenuActionPath%></span></font>
                                </center>
                                </td>

                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_submenudisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_submenuremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_submenustatus">
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
                                            <input type="radio" name="submenuRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="submenuRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addSubmenuModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Menu Subcategory</h4>
                                            </div>
                                              <form class="form-horizontal" id="newSubmenuForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                   
                                                      <div class="form-group">
                                                        <label for="newMenuNameField" class="col-sm-4 control-label">Menu Category</label>
                                                        <div class="col-sm-8">
                                                           
                                                 <select class="form-control" id="newMenuNameField"  name="newMenuNameField" >
                                                    <option  value="" selected="selected">--Select Menu Category--</option>
                                                     <c:forEach var="menuList" items="${menuList.menuCode}"> 
                                                        <option VALUE="${menuList.key}">${menuList.value}</option> 
                                                    </c:forEach> 
                                                </select>
                                                       
                                                            <span class="help-inline" id="newMenuNameError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label for="newsubmenuNameField" class="col-sm-4 control-label">Menu Subcategory Desc</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newsubmenuNameField" name="newsubmenuNameField" placeholder="Enter Discription">
                                                       
                                                            <span class="help-inline" id="newSubmenuNameError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                     <div class="form-group">
                                                 <label for="newsubmenuActionPathField" class="col-sm-4 control-label">Action Path</label>
                                                        <div class="col-sm-8">
                                               <input type="text" class="form-control" id="newsubmenuActionPathField" name="newsubmenuActionPathField" placeholder="Enter  Action Path">
                                                       <span class="help-inline" id="newSubmenuActionPathError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                   
                                                    
                                                    <div class="form-group">
                                                        <label for="newdisplayOrder" class="col-sm-4 control-label">Display Order</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newdisplayOrder" name="newdisplayOrder" value="999999" placeholder="Enter Display Order">
                                                           <span class="help-inline" id="newDisplayError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="newsubmenuRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newsubmenuRemarks" name="newsubmenuRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newsubmenuError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" id="addSubmenuAction"  >Add Subcategory</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editSubmenuModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Menu Subcategory</h4>
                                        </div>
                                         <form class="form-horizontal" id="editSubmenuForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="submenuCodeField" class="col-sm-4 control-label">Menu Subcategory Code</label>

                                                        <div class="col-sm-8">
                                  <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                  <input type="text" class="form-control" id="submenuCodeField" name="submenuCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>
                                                    
                                                     <div class="form-group">
                                                        <label for="menuCodeField" class="col-sm-4 control-label">Menu Category</label>
                                                        <div class="col-sm-8">
                                                           
                                                 <select class="form-control" id="menuCodeField"  name="menuCodeField" >
                                                    <option  value="" selected="selected">--Select Menu Category--</option>
                                                   <c:forEach var="menuList1" items="${menuList1.menuCode}"> 
                                                        <option VALUE="${menuList1.key}">${menuList1.value}</option> 
                                                    </c:forEach> 
                                                </select>
                                                       
                                                            <span class="help-inline" id="menuNameError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                    

                                                    <div class="form-group">
                                                        <label for="submenuNameField" class="col-sm-4 control-label">Menu Subcategory Desc</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="submenuNameField" name="submenuNameField" placeholder="Enter  Discription">
                                                          <span class="help-inline" id="submenuNameError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                    
                                                       <div class="form-group">
                                                        <label for="submenuActionPathField" class="col-sm-4 control-label">Action Path</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="submenuActionPathField" name="submenuActionPathField" placeholder="Enter Action Path">
                                                          <span class="help-inline" id="submenuActionPathError" style="color: red;"></span> 
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
                                                        <label for="submenuRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="submenuRemarks" id="submenuRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="submenuRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="button" id="editSubmenuAction" class="btn btn-primary">Save Changes</button>
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
    <script src="../scripts/submenuMasterJS.js"></script>                         
                           <!-- page script -->


                            <script>
                              
                            </script>
                            </html>

