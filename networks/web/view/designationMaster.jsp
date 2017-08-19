<%-- 
    Document   : designationMaster
    Created on : Jun 19, 2017, 11:24:41 PM
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
    String designationCode, query, designationDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                            <h2 class="box-title"> Designation Master</h2>

                            <div class="box-tools pull-right">

                                <a href="#" id="addDesignation"  class="btn btn-primary"  data-toggle="modal" 
                                   data-target="#addDesignationModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Designation</a>
                                <a href="#" id="editDesignation" class="btn btn-primary" data-toggle="modal" 
                                   data-target="#editDesignationModal"><i class="fa fa-edit"></i>&nbsp;Edit Designation</a>
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
                                            + " FROM MASTER_DESIGNATION ORDER BY DESCRIPTION ";

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
                                        Designation Code</center>
                                    </th>
                                    <th>
                                    <center>
                                        Designation Description</center>
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
                                                designationCode = rs.getString("CODE");

                                                designationDisc = rs.getString("DESCRIPTION");

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
                                        <input type="hidden"  id="designationCodeHidden" name="designationCodeHidden" >
                                        <font size="2"><span id="<%=i%>_designationcode"><%=designationCode%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_designationdisc"><%=designationDisc%></span></font>
                                    </center>
                                    </td>



                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_designationdisplay"><%=displayOrder%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_designationremark"><%=enterRemarks%></span></font>
                                    </center>
                                    </td>



                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_designationstatus">
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
                                                <input type="radio" name="designationRadio" id="<%=i%>" checked="" value="<%=i%>">
                                                <% } else {%>
                                                <input type="radio" name="designationRadio" id="<%=i%>" value="<%=i%>">
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

                                <div class="modal fade" id="addDesignationModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Designation</h4>
                                            </div>
                                            <form class="form-horizontal" id="newAssessForm"  >
                                                <div class="modal-body">
                                                    <div class="box-body">
                                                        <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                            <span style="color:#008000;" id="msgAddError"></span>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="newdesignationNameField" class="col-sm-4 control-label">Designation Description</label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                                <input type="text" class="form-control" id="newdesignationNameField" name="newdesignationNameField" placeholder="Enter Designation Description">

                                                                <span class="help-inline" id="newDesignationDiscError" style="color: red;">${error}</span>

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
                                                            <label for="newdesignationRemarks" class="col-sm-4 control-label">Remarks</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="newdesignationRemarks" name="newdesignationRemarks" placeholder="Enter Remarks">
                                                                <span class="help-inline" id="newdesignationError" style="color: red;"></span> 
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <!-- /.box-body -->
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary" id="addDesignationAction"  >Add Designation</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>

                                        </div>
                                    </div>
                                </div>
                        </div>



                        <!-- form start -->

                        <div class="modal fade" id="editDesignationModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title" id="myModalLabel">Edit Designation</h4>
                                    </div>
                                    <form class="form-horizontal" id="editDesignationForm" method="POST" >
                                        <div class="modal-body">                                          
                                            <div class="box-body">
                                                <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                    <span style="color:#008000;" id="msgEditError"></span>
                                                </div>
                                                <div class="form-group">
                                                    <label for="designationCodeField" class="col-sm-4 control-label">Designation Code</label>

                                                    <div class="col-sm-8">
                                                        <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                        <input type="text" class="form-control" id="designationCodeField" name="designationCodeField" placeholder=" " readonly="true">

                                                    </div>


                                                </div>

                                                <div class="form-group">
                                                    <label for="designationNameField" class="col-sm-4 control-label">Designation Name</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="DesignationNameField" name="DesignationNameField" placeholder="Enter Designation Discription">
                                                        <span class="help-inline" id="designationNameError" style="color: red;"></span> 
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
                                                    <label for="designationRemarks" class="col-sm-4 control-label">Remarks</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" name="designationRemarks" id="designationRemarks" placeholder="Enter Remarks">
                                                        <span class="help-inline" id="designationRemarksError" style="color: red;"></span>
                                                    </div>


                                                </div>

                                            </div>
                                            <!-- /.box-body -->


                                        </div>

                                    </form>
                                    <div class="modal-footer">
                                        <button type="submit" id="editDesignationAction" class="btn btn-primary">Save Changes</button>
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

                            $("#editDesignation").click(function () {
                                var rd_id = $('input[name=designationRadio]:checked').val();
                                $("#designationCodeField").val($("#" + rd_id + "_designationcode").html());
                                $("#designationNameField").val($("#" + rd_id + "_designationdisc").html());
                                $("#displayOrder").val($("#" + rd_id + "_designationdisplay").html());
                                $("#designationRemarks").val($("#" + rd_id + "_designationremark").html());
                                // $("#recordStatusField").val($("#" + rd_id + "_assessstatus").html());
                            });



                            $('.modal').on('hidden.bs.modal', function () {
                                $("#editDesignationForm")[0].reset();
                                $("#newDesignationForm")[0].reset();
                            });

                            //-------------------------Add Code start---------------------------------------------
                            try {

                                $("#addDesignationAction").click(function () {
                                    if ($('#newdesignationNameField').val() == '') {
                                        $('#newDesignationDiscError').html("This field is required.");
                                        return false;
                                    } else {
                                        if (!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#newdesignationNameField").val()))) {
                                            $('#newDesignationDiscError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");
                                            $("#newdesignationNameField").focus();
                                            return false;
                                        } else {
                                            $('#newDesignationDiscError').empty();
                                        }

                                    }
                                    if ($('#newdisplayOrder').val() == '') {
                                        $('#newDisplayError').html("This field is required.");
                                        return false;
                                    } else {
                                        $('#newDisplayError').empty();
                                    }
                                    if ($('#newdesignationRemarks').val() == '') {
                                        $('#newdesignationError').html("This field is required.");
                                        return false;
                                    } else {
                                        if (!(/^[a-zA-Z./ ]+$/.test($("#newdesignationRemarks").val()))) {
                                            $('#newdesignationError').html(" Only alphabets and . Allowed");
                                            $("#newdesignationRemarks").focus();
                                            return false;
                                        } else {
                                            $('#newdesignationError').empty();
                                        }
                                    }

                                    $.ajax({
                                        type: 'POST',
                                        url: 'DesignationMasterServlet',
                                        // data:  new FormData(this),
                                        data: $('#newDesignationForm').serialize(),
                                        dataType: 'json',
                                        encode: true,
                                        success: function (result) {
                                            // alert("fgdg"+result.rsval);
                                            if (result.rsval == 1) {
                                                $('#msgAddSuccess').html("Designation successfully Added!");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            } else {
                                                $('#msgAddError').html("Error In Designation Add!");
                                            }

                                        },
                                        error: function (result)
                                        {
                                            alert("error: In designation Add ");

                                        }
                                    });
                                });
                            } catch (e) {
                                alert("EX : " + e);
                            }
                            //-----------------------Add Code End---------------------------------------------

                            //-------------------------Edit Code start---------------------------------------------
                            try {

                                $("#editDesignationAction").click(function () {

                                    if ($('#designationNameField').val() == '') {
                                        $('#designationNameError').html("This field is required.");
                                        return false;
                                    } else {
                                        if (!(/^(?!\s*$)[a-zA-Z0-9-. ]{3,50}$/.test($("#designationNameField").val()))) {
                                            $('#designationNameError').html(" Only alphabets and numeric Allowed.Minimum length should be 3.");
                                            $("#designationNameField").focus();
                                            return false;
                                        } else {
                                            $('#designationNameError').empty();
                                        }

                                    }
                                    if ($('#displayOrder').val() == '') {
                                        $('#displayOrderError').html("This field is required.");
                                        return false;
                                    } else {
                                        $('#displayOrderError').empty();
                                    }
                                    if ($('#designationRemarks').val() == '') {
                                        $('#designationRemarksError').html("This field is required.");
                                        return false;
                                    } else {
                                        if (!(/^[a-zA-Z./ ]+$/.test($("#designationRemarks").val()))) {
                                            $('#designationRemarksError').html(" Only alphabets and . Allowed");
                                            $("#designationRemarks").focus();
                                            return false;
                                        } else {
                                            $('#designationRemarksError').empty();
                                        }
                                    }

                                    $.ajax({
                                        type: 'POST',
                                        url: 'DesignationMasterServlet',
                                        // data:  new FormData(this),
                                        data: $('#editDesignationForm').serialize(),
                                        dataType: 'json',
                                        encode: true,
                                        success: function (result) {

                                            if (result.updateStatus == 1) {
                                                $('#msgEditSuccess').html("Designation successfully Edited!");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            } else {
                                                $('#msgEditError').html("Error In Designation Edit!");
                                            }

                                        },
                                        error: function (result)
                                        {
                                            alert("error: In Designation Edit");

                                        }
                                    });
                                });
                            } catch (e) {
                                alert("EX : " + e);
                            }
                            //-----------------------Edit Code End---------------------------------------------

                            //----deactivation code------------------------ 

                            $("#delete").click(function () {
                                var r = confirm("Are u sure to delete then press ok otherwise cancel");
                                if (r == true) {

                                    var rd_id = $('input[name=designationRadio]:checked').val();
                                    $("#designationCodeHidden").val($("#" + rd_id + "_designationcode").html());
                                    var code = $("#designationCodeHidden").val();

                                    $.ajax({
                                        type: "POST",
                                        url: "DesignationMasterServlet?hiddenAction=delete&designationCodeDelete=" + code,
                                        dataType: 'json',
                                        encode: true,

                                        success: function (result) {

                                            if (result.finalStatus == 2) {

                                                $('#msgError1').html("Designation already deleted");
                                                //$('#msgError1').delay(1000).fadeOut();

                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            } else {

                                                $('#msgRight1').html("Designation successfully Deleted!");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
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

                                    var rd_id = $('input[name=designationRadio]:checked').val();
                                    $("#designationCodeHidden").val($("#" + rd_id + "_designationcode").html());
                                    var code = $("#designationCodeHidden").val();

                                    $.ajax({
                                        type: "POST",
                                        url: "DesignationMasterServlet?hiddenAction=restore&designationCodeRestore=" + code,
                                        dataType: 'json',
                                        encode: true,

                                        success: function (result) {
                                            if (result.finalStatusRe == 2) {

                                                $('#msgError1').html("Designation already Active");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            } else {

                                                $('#msgRight1').html("Designation successfully Restored!");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            }


                                        }
                                    });
                                } else {
                                }
                            });

                        });





                    </script>
                    </html>

