<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "menuList" class = "com.nic.form.populate.MenuPopulate" scope = "page" />
<jsp:useBean id = "menuList1" class = "com.nic.form.populate.MenuPopulate" scope = "page" />
<html>
    <head>
        <%!
            Connection conn;
            Statement st = null;
            ResultSet rs = null;
            String query;
            String msgRight = "";
        %>
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
                            <h2 class="box-title">IP Address Update/Delete Form</h2>
                            <font color="black" size="+2">&nbsp;&nbsp;&nbsp;${message}</font>                            
                        </div>
                        <div align="center" >&nbsp;<span style="color:#008000;" id="msgRight1"></span> </div>
                        <div align="center" >&nbsp;<span style="color:#FF0000;" id="msgError1"></span> </div>
                        <div class="box-body">
                            <%                                try {
                                    DataConnect con = new DataConnect();
                                    String location = (String) session.getAttribute("locationCode");
                                    String ipaddress = "";
                                    conn = con.getConnection();
                                    query = "SELECT USER_IP_ADDRESS,USER_MAC_ADDRESS,USER_NAME,(SELECT DESCRIPTION FROM MASTER_USER_DEPARTMENT WHERE CODE = USER_DEPARTMENT) AS USER_DEPARTMENT,"
                                            + "(SELECT DESCRIPTION FROM MASTER_SECTION WHERE CODE = USER_SECTION) AS USER_SECTION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_DESIGNATION WHERE CODE = USER_DESIGNATION) AS USER_DESIGNATION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_USER_EMPLOYMENT_TYPE WHERE CODE = USER_EMPLOYMENT_TYPE) AS USER_EMPLOYMENT_TYPE,"
                                            + "(SELECT DESCRIPTION FROM MASTER_FLOOR WHERE CODE = FLOOR) AS FLOOR,"
                                            + "(SELECT DESCRIPTION FROM MASTER_LOCATION WHERE CODE = LOCATION) AS LOCATION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_DEVICE_TYPE WHERE CODE = DEVICE_TYPE) AS DEVICE_TYPE,"
                                            + "NVL((SELECT DESCRIPTION FROM MASTER_ASSESS_LEVEL WHERE CODE = ACCESS_LEVEL), ' ') AS ACCESS_LEVEL,"
                                            + "NVL(CONTACT_NUMBER, ' ') AS CONTACT_NUMBER,NVL(INTERCOM, ' ') INTERCOM, NVL(EMAIL_ID, ' ') EMAIL_ID,"
                                            + "(SELECT DESCRIPTION FROM MASTER_USER_MINISTRY WHERE CODE = USER_MINISTRY) AS USER_MINISTRY,"
                                            + "EMPLOYEE_CODE FROM IP_ADDRESS WHERE RECORD_STATUS = 'A' AND LOCATION=" + location;
                                    st = conn.createStatement();
                                    rs = st.executeQuery(query);
                                    int i = 1;
                            %>
                            <center>
                                <table id="example1" class="table table-bordered table-striped"  >
                                    <thead>
                                        <tr bgcolor="">
                                            <th><center>#</center></th>
                                    <th><center>Ip Address</center></th>
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
                                                ipaddress = rs.getString("USER_IP_ADDRESS");
                                        %>
                                        <tr>
                                            <td><center><%=i%>.</center></td>
                                    <td><font size="2"><span id="userMacAddress"><a href="ipPoolAssignUpdateForm.jsp?ipAddress=<%=ipaddress%>&locationcode='<%=location%>'"><%=ipaddress%></a></span></font></td>
                                    <td><font size="2"><span id="userMacAddress"><%=rs.getString("USER_MAC_ADDRESS")%></span></font></td>
                                    <td><font size="2"><span id="userName"><%=rs.getString("USER_NAME")%></span></font></td>
                                    <td><font size="2"><span id="userDepartment"><%=rs.getString("USER_DEPARTMENT")%></span></font></td>
                                    <td><font size="2"><span id="userSection"><%=rs.getString("USER_SECTION")%></span></font></td>
                                    <td><font size="2"><span id="userDesignation"><%=rs.getString("USER_DESIGNATION")%></span></font></td>
                                    <td><font size="2"><span id="userMinistry"><%=rs.getString("USER_MINISTRY")%></font>
                                    </td>
                                    <td><div class="radio">
                                            <label>
                                                <% if (i == 1) {%>
                                                <input type="radio" name="submenuRadio" id="<%=i%>" checked="" value="<%=i%>">
                                                <% } else {%>
                                                <input type="radio" name="submenuRadio" id="<%=i%>" value="<%=i%>">
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



                        <!-- form start -->
                        <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title" id="myModalLabel">Delete User IpAddress</h4>
                                    </div>
                                    <form class="form-horizontal" id="deleteUserIP" method="POST" >
                                        <div class="modal-body">                                          
                                            <div class="box-body">
                                                <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                    <span style="color:#008000;" id="msgEditError"></span>
                                                </div>
                                                <div class="form-group">
                                                    <label for="submenuCodeField" class="col-sm-4 control-label">Ip Address</label>

                                                    <div class="col-sm-8">
                                                        <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                        <input type="text" class="form-control" id="submenuCodeField" name="submenuCodeField" placeholder=" " readonly="true">
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- /.box-body -->
                                        </div>
                                    </form>
                                    <div class="modal-footer">
                                        <button type="button" id="editSubmenuAction" class="btn btn-primary">Delete</button>
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


