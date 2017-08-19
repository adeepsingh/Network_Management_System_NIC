<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "locationList" class = "com.nic.form.populate.LocationPopulate" scope = "page" />
<jsp:useBean id = "locationList1" class = "com.nic.form.populate.LocationPopulate" scope = "page" />
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String locationCode, locationDesc, ministryCode, query, ministryName, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                            <h2 class="box-title"> Ministry Master</h2>

                            <div class="box-tools pull-right">

                                <a href="#" id="addMinistry"  class="btn btn-primary"  data-toggle="modal" 
                                   data-target="#addMinistryModal" ><i class="fa fa-plus-square"></i>&nbsp;Add New Ministry</a>
                                <a href="#" id="editMinistry" class="btn btn-primary" data-toggle="modal" 
                                   data-target="#editMinistryModal"><i class="fa fa-edit"></i>&nbsp;Edit</a>
                                <a id="delete" role="button" class="btn btn-primary" data-toggle="modal">
                                    <i class="fa fa-trash-o"></i>&nbsp;Delete</a>
                                <a id="restore" role="button" class="btn btn-primary" data-toggle="modal">
                                    <i class="fa fa-undo"></i>&nbsp;Restore</a>

                            </div>
                        </div>

                        <div align="center" >&nbsp;<span style="color:#008000;" id="msgRight1"></span> </div>
                        <div align="center" >&nbsp;<span style="color:#FF0000;" id="msgError1"></span> </div>
                        <div class="box-body">
                            <%                                
                            String location_Code = (String) session.getAttribute("locationCode");
                            try {
                                    DataConnect con = new DataConnect();
                                    conn = con.getConnection();

                                    query = "  SELECT LOCATION_CODE,"
                                            + "(SELECT DESCRIPTION from MASTER_LOCATION where CODE=MCAT.LOCATION_CODE ) as LOCATION_DESCRIPTION,"
                                            + "CODE,"
                                            + "DESCRIPTION,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                            + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') AS ENTERED_ON, RECORD_STATUS "
                                            + " FROM MASTER_USER_MINISTRY MCAT WHERE LOCATION_CODE = '"+location_Code+"' ORDER BY LOCATION_DESCRIPTION, DESCRIPTION  ";

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
                                        Ministry Code</center>
                                    </th>
                                    <th>
                                    <center>
                                        Location </center>
                                    </th>
                                    <th>
                                    <center>
                                        Ministry Name</center>
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
                                                locationCode = rs.getString("LOCATION_CODE");
                                                locationDesc = rs.getString("LOCATION_DESCRIPTION");
                                                ministryCode = rs.getString("CODE");
                                                ministryName = rs.getString("DESCRIPTION");

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
                                        <input type="hidden"  id="ministryCodeHidden" name="ministryCodeHidden" >
                                        <font size="2"><span id="<%=i%>_ministrycode"><%=ministryCode%></span>
                                        <span id="<%=i%>_locationcode" hidden="hidden"><%=locationCode%></span>
                                        </font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_locationdesc"><%=locationDesc%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_ministryname"><%=ministryName%></span></font>
                                    </center>
                                    </td>    

                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_ministrydisplay"><%=displayOrder%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_ministryremark"><%=enterRemarks%></span></font>
                                    </center>
                                    </td>



                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_ministrystatus">
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
                                                <input type="radio" name="ministryRadio" id="<%=i%>" checked="" value="<%=i%>">
                                                <% } else {%>
                                                <input type="radio" name="ministryRadio" id="<%=i%>" value="<%=i%>">
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

                                <div class="modal fade" id="addMinistryModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Ministry</h4>
                                            </div>
                                            <form class="form-horizontal" id="newMinistryForm"  >
                                                <div class="modal-body">
                                                    <div class="box-body">
                                                        <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                            <span style="color:#008000;" id="msgAddError"></span>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="newLocationNameField" class="col-sm-4 control-label">Location Name</label>
                                                            <div class="col-sm-8">

                                                                <select class="form-control" id="newLocationNameField"  name="newLocationNameField" >
                                                                    <option  value="" selected="selected">--Select Location Category--</option>
                                                                    <c:forEach var="locationList" items="${locationList.locationList}"> 
                                                                        <option VALUE="${locationList.key}">${locationList.value}</option> 
                                                                    </c:forEach> 
                                                                </select>

                                                                <span class="help-inline" id="newLocationNameError" style="color: red;"></span>

                                                            </div>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="newministryNameField" class="col-sm-4 control-label">Ministry Name</label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                                <input type="text" class="form-control" id="newministryNameField" name="newministryNameField" placeholder="Enter Name of Ministry">

                                                                <span class="help-inline" id="newMinistryNameError" style="color: red;"></span>

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
                                                            <label for="newministryRemarks" class="col-sm-4 control-label">Remarks</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="newministryRemarks" name="newministryRemarks" placeholder="Enter Remarks">
                                                                <span class="help-inline" id="newministryError" style="color: red;"></span> 
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- /.box-body -->
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="button" class="btn btn-primary" id="addMinistryAction"  >Add Ministry</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>

                                        </div>
                                    </div>
                                </div>
                        </div>



                        <!-- form start -->

                        <div class="modal fade" id="editMinistryModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title" id="myModalLabel">Edit Ministry</h4>
                                    </div>
                                    <form class="form-horizontal" id="editMinistryForm" method="POST" >
                                        <div class="modal-body">                                          
                                            <div class="box-body">
                                                <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                    <span style="color:#008000;" id="msgEditError"></span>
                                                </div>
                                                <div class="form-group">
                                                    <label for="ministryCodeField" class="col-sm-4 control-label">Ministry Code</label>

                                                    <div class="col-sm-8">
                                                        <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                        <input type="text" class="form-control" id="ministryCodeField" name="ministryCodeField" placeholder=" " readonly="true">

                                                    </div>


                                                </div>

                                                <div class="form-group">
                                                    <label for="locationCodeField" class="col-sm-4 control-label">Location Name</label>
                                                    <div class="col-sm-8">

                                                        <select class="form-control" id="locationCodeField"  name="locationCodeField" >
                                                            <option  value="" selected="selected">--Select Location Category--</option>
                                                            <c:forEach var="locationList1" items="${locationList1.locationList}"> 
                                                                <option VALUE="${locationList1.key}">${locationList1.value}</option> 
                                                            </c:forEach> 
                                                        </select>

                                                        <span class="help-inline" id="locationNameError" style="color: red;"></span>

                                                    </div>
                                                </div>


                                                <div class="form-group">
                                                    <label for="ministryNameField" class="col-sm-4 control-label">Ministry Name</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="ministryNameField" name="ministryNameField" placeholder="Enter  Discription">
                                                        <span class="help-inline" id="ministryNameError" style="color: red;"></span> 
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
                                                    <label for="ministryRemarks" class="col-sm-4 control-label">Remarks</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" name="ministryRemarks" id="ministryRemarks" placeholder="Enter Remarks">
                                                        <span class="help-inline" id="ministryRemarksError" style="color: red;"></span>
                                                    </div>


                                                </div>

                                            </div>
                                            <!-- /.box-body -->


                                        </div>

                                    </form>
                                    <div class="modal-footer">
                                        <button type="button" id="editMinistryAction" class="btn btn-primary">Save Changes</button>
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
                    <script src="../scripts/ministryMasterJS.js"></script>                         
                    <!-- page script -->


                    <script>

                    </script>
                    </html>

