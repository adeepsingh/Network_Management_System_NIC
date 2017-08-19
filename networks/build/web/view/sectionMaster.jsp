<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "departmentList" class = "com.nic.form.populate.DepartmentPopulate" scope = "page" />
<jsp:useBean id = "departmentList1" class = "com.nic.form.populate.DepartmentPopulate" scope = "page" />
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String departmentCode, departmentDesc, sectionCode, query, sectionName, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                            <h2 class="box-title"> Section Master</h2>
                            <div class="box-tools pull-right">
                                <a href="#" id="addSection"  class="btn btn-primary"  data-toggle="modal" 
                                   data-target="#addSectionModal" ><i class="fa fa-plus-square"></i>&nbsp;Add New Section</a>
                                <a href="#" id="editSection" class="btn btn-primary" data-toggle="modal" 
                                   data-target="#editSectionModal"><i class="fa fa-edit"></i>&nbsp;Edit</a>
                                <a id="delete" role="button" class="btn btn-primary" data-toggle="modal">
                                    <i class="fa fa-trash-o"></i>&nbsp;Delete</a>
                                <a id="restore" role="button" class="btn btn-primary" data-toggle="modal">
                                    <i class="fa fa-undo"></i>&nbsp;Restore</a>
                            </div>
                        </div>

                        <div align="center" >&nbsp;<span style="color:#008000;" id="msgRight1"></span> </div>
                        <div align="center" >&nbsp;<span style="color:#FF0000;" id="msgError1"></span> </div>
                        <div class="box-body">
                            <%                    try {
                                    DataConnect con = new DataConnect();
                                    conn = con.getConnection();

                                    query = "  SELECT DEPARTMENT_CODE,"
                                            + "(SELECT DESCRIPTION from MASTER_USER_DEPARTMENT where CODE=MCAT.DEPARTMENT_CODE ) as DEPARTMENT_DESCRIPTION,"
                                            + "CODE,"
                                            + "DESCRIPTION,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                            + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') as ENTERED_ON,RECORD_STATUS"
                                            + " FROM MASTER_SECTION MCAT ORDER BY DEPARTMENT_DESCRIPTION,DESCRIPTION ";

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
                                        Section Code</center>
                                    </th>
                                    <th>
                                    <center>
                                        Department </center>
                                    </th>
                                    <th>
                                    <center>
                                        Section Name</center>
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
                                                departmentCode = rs.getString("DEPARTMENT_CODE");
                                                departmentDesc = rs.getString("DEPARTMENT_DESCRIPTION");
                                                sectionCode = rs.getString("CODE");
                                                sectionName = rs.getString("DESCRIPTION");

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
                                        <input type="hidden"  id="sectionCodeHidden" name="sectionCodeHidden" >
                                        <font size="2"><span id="<%=i%>_sectioncode"><%=sectionCode%></span>
                                        <span id="<%=i%>_departmentcode" hidden="hidden"><%=departmentCode%></span>
                                        </font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_departmentdesc"><%=departmentDesc%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_sectionname"><%=sectionName%></span></font>
                                    </center>
                                    </td>    

                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_sectiondisplay"><%=displayOrder%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_sectionremark"><%=enterRemarks%></span></font>
                                    </center>
                                    </td>



                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_sectionstatus">
                                            <%if (recordStatus.equals("A")) { %>
                                            <img src="../img/active.png" style="width: 20px; height: 20px;" />
                                            <%} else if (recordStatus.equals("D")) { %>
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
                                                <input type="radio" name="sectionRadio" id="<%=i%>" checked="" value="<%=i%>">
                                                <% } else {%>
                                                <input type="radio" name="sectionRadio" id="<%=i%>" value="<%=i%>">
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

                                <div class="modal fade" id="addSectionModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Section</h4>
                                            </div>
                                            <form class="form-horizontal" id="newSectionForm"  >
                                                <div class="modal-body">
                                                    <div class="box-body">
                                                        <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                            <span style="color:#008000;" id="msgAddError"></span>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="newDepartmentNameField" class="col-sm-4 control-label">Department Name</label>
                                                            <div class="col-sm-8">

                                                                <select class="form-control" id="newDepartmentNameField"  name="newDepartmentNameField" >
                                                                    <option  value="" selected="selected">--Select Department Category--</option>
                                                                    <c:forEach var="departmentList" items="${departmentList.departmentList}"> 
                                                                        <option VALUE="${departmentList.key}">${departmentList.value}</option> 
                                                                    </c:forEach> 
                                                                </select>

                                                                <span class="help-inline" id="newDepartmentNameError" style="color: red;"></span>

                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="newsectionNameField" class="col-sm-4 control-label">Section Name</label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                                <input type="text" class="form-control" id="newsectionNameField" name="newsectionNameField" placeholder="Enter Name of Section">

                                                                <span class="help-inline" id="newSectionNameError" style="color: red;"></span>

                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="newdisplayOrder" class="col-sm-4 control-label">Display Order</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="newdisplayOrder" name="newdisplayOrder" value="9999" placeholder="Enter Display Order">
                                                                <span class="help-inline" id="newDisplayError" style="color: red;"></span> 
                                                            </div>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="newsectionRemarks" class="col-sm-4 control-label">Remarks</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="newsectionRemarks" name="newsectionRemarks" placeholder="Enter Remarks">
                                                                <span class="help-inline" id="newsectionError" style="color: red;"></span> 
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- /.box-body -->
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" id="addSectionAction"  >Add Section</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>

                                        </div>
                                    </div>
                                </div>
                        </div>



                        <!-- form start -->

                        <div class="modal fade" id="editSectionModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title" id="myModalLabel">Edit Section</h4>
                                    </div>
                                    <form class="form-horizontal" id="editSectionForm" method="POST" >
                                        <div class="modal-body">                                          
                                            <div class="box-body">
                                                <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                    <span style="color:#008000;" id="msgEditError"></span>
                                                </div>
                                                <div class="form-group">
                                                    <label for="sectionCodeField" class="col-sm-4 control-label">Section Code</label>

                                                    <div class="col-sm-8">
                                                        <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                        <input type="text" class="form-control" id="sectionCodeField" name="sectionCodeField" placeholder=" " readonly="true">

                                                    </div>


                                                </div>

                                                <div class="form-group">
                                                    <label for="departmentCodeField" class="col-sm-4 control-label">Department Name</label>
                                                    <div class="col-sm-8">

                                                        <select class="form-control" id="departmentCodeField"  name="departmentCodeField" >
                                                            <option  value="" selected="selected">--Select Department Category--</option>
                                                            <c:forEach var="departmentList1" items="${departmentList1.departmentList}"> 
                                                                <option VALUE="${departmentList1.key}">${departmentList1.value}</option> 
                                                            </c:forEach> 
                                                        </select>

                                                        <span class="help-inline" id="departmentNameError" style="color: red;"></span>

                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="sectionNameField" class="col-sm-4 control-label">Section Name</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="sectionNameField" name="sectionNameField" placeholder="Enter  Discription">
                                                        <span class="help-inline" id="sectionNameError" style="color: red;"></span> 
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
                                                    <label for="sectionRemarks" class="col-sm-4 control-label">Remarks</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" name="sectionRemarks" id="sectionRemarks" placeholder="Enter Remarks">
                                                        <span class="help-inline" id="sectionRemarksError" style="color: red;"></span>
                                                    </div>


                                                </div>

                                            </div>
                                            <!-- /.box-body -->


                                        </div>

                                    </form>
                                    <div class="modal-footer">
                                        <button type="button" id="editSectionAction" class="btn btn-primary">Save Changes</button>
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
                    <script src="../scripts/sectionMasterJS.js"></script>                         
                    <!-- page script -->


                    <script>

                    </script>
                    </html>

