<%-- 
    Document   : departmentMaster
    Created on : July 17, 2017, 01:52:23 PM
    Author     : Manju
--%>
<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "ministryList" class = "com.nic.form.populate.MinistryPopulate" scope = "page" />
<jsp:useBean id = "ministryList1" class = "com.nic.form.populate.MinistryPopulate" scope = "page" />
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String ministryCode,ministryDesc,departmentCode, query, departmentName, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                        <h2 class="box-title"> Department Master</h2>
                          
                        <div class="box-tools pull-right">
                          
                            <a href="#" id="addDepartment"  class="btn btn-primary"  data-toggle="modal" 
                               data-target="#addDepartmentModal" ><i class="fa fa-plus-square"></i>&nbsp;Add New Department</a>
                            <a href="#" id="editDepartment" class="btn btn-primary" data-toggle="modal" 
                               data-target="#editDepartmentModal"><i class="fa fa-edit"></i>&nbsp;Edit</a>
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

                                query = "  SELECT MINISTRY_CODE,"
                                     +"(SELECT DESCRIPTION from MASTER_USER_MINISTRY where CODE=MCAT.MINISTRY_CODE ) as MINISTRY_DESCRIPTION,"
                                     + "CODE,"
                                     + "DESCRIPTION,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                     + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') as ENTERED_ON,RECORD_STATUS"
                                     + " FROM MASTER_USER_DEPARTMENT MCAT ORDER BY MINISTRY_DESCRIPTION,DESCRIPTION ";

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
                                    Department Code</center>
                                </th>
                                  <th>
                                <center>
                                    Ministry </center>
                                </th>
                                <th>
                                <center>
                                    Department Name</center>
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
                                            ministryCode=rs.getString("MINISTRY_CODE");
                                            ministryDesc=rs.getString("MINISTRY_DESCRIPTION");
                                            departmentCode = rs.getString("CODE");
                                            departmentName = rs.getString("DESCRIPTION");
                                            
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
                                     <input type="hidden"  id="departmentCodeHidden" name="departmentCodeHidden" >
                                    <font size="2"><span id="<%=i%>_departmentcode"><%=departmentCode%></span>
                                    <span id="<%=i%>_ministrycode" hidden="hidden"><%=ministryCode%></span>
                                    </font>
                                </center>
                                </td>
                                 <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_ministrydesc"><%=ministryDesc%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_departmentname"><%=departmentName%></span></font>
                                </center>
                                </td>    

                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_departmentdisplay"><%=displayOrder%></span></font>
                                </center>
                                </td>
                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_departmentremark"><%=enterRemarks%></span></font>
                                </center>
                                </td>



                                <td>
                                <center>
                                    <font size="2"><span id="<%=i%>_departmentstatus">
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
                                            <input type="radio" name="departmentRadio" id="<%=i%>" checked="" value="<%=i%>">
                                            <% } else {%>
                                            <input type="radio" name="departmentRadio" id="<%=i%>" value="<%=i%>">
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
                           
                                <div class="modal fade" id="addDepartmentModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Department</h4>
                                            </div>
                                              <form class="form-horizontal" id="newDepartmentForm"  >
                                            <div class="modal-body">
                                                <div class="box-body">
                                                    <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                         <span style="color:#008000;" id="msgAddError"></span>
                                                  </div>
                                                   
                                                      <div class="form-group">
                                                        <label for="newMinistryNameField" class="col-sm-4 control-label">Ministry Name</label>
                                                        <div class="col-sm-8">
                                                           
                                                 <select class="form-control" id="newMinistryNameField"  name="newMinistryNameField" >
                                                    <option  value="" selected="selected">--Select Ministry Category--</option>
                                                     <c:forEach var="ministryList" items="${ministryList.ministryList}"> 
                                                        <option VALUE="${ministryList.key}">${ministryList.value}</option> 
                                                    </c:forEach> 
                                                </select>
                                                       
                                                            <span class="help-inline" id="newMinistryNameError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                    
                                                    <div class="form-group">
                                                        <label for="newdepartmentNameField" class="col-sm-4 control-label">Department Name</label>
                                                        <div class="col-sm-8">
                                                            <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                            <input type="text" class="form-control" id="newdepartmentNameField" name="newdepartmentNameField" placeholder="Enter Name of Department">
                                                       
                                                            <span class="help-inline" id="newDepartmentNameError" style="color: red;"></span>
                 
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
                                                        <label for="newdepartmentRemarks" class="col-sm-4 control-label">Remarks</label>
                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="newdepartmentRemarks" name="newdepartmentRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="newdepartmentError" style="color: red;"></span> 
                                                        </div>
                                                    </div>
                                                </div>
                                                
                                                <!-- /.box-body -->
                                                 </form>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-primary" id="addDepartmentAction"  >Add Department</button>
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                            
                                            </div>
                                        </div>
                                    </div>
                                </div>
                           

                            
                              <!-- form start -->
                                          
                            <div class="modal fade" id="editDepartmentModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                            <h4 class="modal-title" id="myModalLabel">Edit Department</h4>
                                        </div>
                                         <form class="form-horizontal" id="editDepartmentForm" method="POST" >
                                        <div class="modal-body">                                          
                                                <div class="box-body">
                                                     <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                         <span style="color:#008000;" id="msgEditError"></span>
                                                  </div>
                                                    <div class="form-group">
                                                        <label for="departmentCodeField" class="col-sm-4 control-label">Department Code</label>

                                                        <div class="col-sm-8">
                                  <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                  <input type="text" class="form-control" id="departmentCodeField" name="departmentCodeField" placeholder=" " readonly="true">
                                                            
                                                        </div>


                                                    </div>
                                                    
                                                     <div class="form-group">
                                                        <label for="ministryCodeField" class="col-sm-4 control-label">Ministry Name</label>
                                                        <div class="col-sm-8">
                                                           
                                                 <select class="form-control" id="ministryCodeField"  name="ministryCodeField" >
                                                    <option  value="" selected="selected">--Select Ministry Category--</option>
                                                   <c:forEach var="ministryList1" items="${ministryList1.ministryList}"> 
                                                        <option VALUE="${ministryList1.key}">${ministryList1.value}</option> 
                                                    </c:forEach> 
                                                </select>
                                                       
                                                            <span class="help-inline" id="ministryNameError" style="color: red;"></span>
                 
                                                        </div>
                                                    </div>
                                                    

                                                    <div class="form-group">
                                                        <label for="departmentNameField" class="col-sm-4 control-label">Department Name</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" id="departmentNameField" name="departmentNameField" placeholder="Enter  Discription">
                                                          <span class="help-inline" id="departmentNameError" style="color: red;"></span> 
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
                                                        <label for="departmentRemarks" class="col-sm-4 control-label">Remarks</label>

                                                        <div class="col-sm-8">
                                                            <input type="text" class="form-control" name="departmentRemarks" id="departmentRemarks" placeholder="Enter Remarks">
                                                             <span class="help-inline" id="departmentRemarksError" style="color: red;"></span>
                                                        </div>


                                                    </div>

                                                </div>
                                                <!-- /.box-body -->


                                        </div>

                                              </form>
                                        <div class="modal-footer">
                                             <button type="button" id="editDepartmentAction" class="btn btn-primary">Save Changes</button>
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
    <script src="../scripts/departmentMasterJS.js"></script>                         
                           <!-- page script -->


                            <script>
                              
                            </script>
                            </html>

