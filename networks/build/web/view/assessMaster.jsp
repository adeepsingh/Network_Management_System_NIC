<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String assessCode, query, assessDisc, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
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
                            <h2 class="box-title"> Assess Master</h2>
                            <div class="box-tools pull-right">
                                <a href="#" id="addAssess"  class="btn btn-primary"  data-toggle="modal" 
                                   data-target="#addAssessModal"><i class="fa fa-plus-square"></i>&nbsp;Add New Assess</a>
                                <a href="#" id="editAssess" class="btn btn-primary" data-toggle="modal" 
                                   data-target="#editAssessModal"><i class="fa fa-edit"></i>&nbsp;Edit Assess</a>
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
                        <div class="box-body">
                            <%                    try {
                                    DataConnect con = new DataConnect();
                                    conn = con.getConnection();
                                    query = "  SELECT CODE,"
                                            + "  DESCRIPTION,DISPLAY_ORDER,NVL(ENTERED_REMARKS, 'NA') as ENTERED_REMARKS, "
                                            + "   ENTERED_BY,  NVL(to_char(ENTERED_ON,'DD/MM/YYYY'), 'NA') as ENTERED_ON,RECORD_STATUS"
                                            + " FROM MASTER_ASSESS_LEVEL ORDER BY DESCRIPTION ";

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
                                        Assess Code</center>
                                    </th>
                                    <th>
                                    <center>
                                        Assess Description</center>
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
                                                assessCode = rs.getString("CODE");
                                                assessDisc = rs.getString("DESCRIPTION");
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
                                        <input type="hidden"  id="assessCodeHidden" name="assessCodeHidden" >
                                        <font size="2"><span id="<%=i%>_assesscode"><%=assessCode%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_assessdisc"><%=assessDisc%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_assessdisplay"><%=displayOrder%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_assessremark"><%=enterRemarks%></span></font>
                                    </center>
                                    </td>
                                    <td>
                                    <center>
                                        <font size="2"><span id="<%=i%>_assessstatus">
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
                                                <input type="radio" name="assessRadio" id="<%=i%>" checked="" value="<%=i%>">
                                                <% } else {%>
                                                <input type="radio" name="assessRadio" id="<%=i%>" value="<%=i%>">
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
                                <div class="modal fade" id="addAssessModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                <h4 class="modal-title" id="myModalLabel">Add New Assess</h4>
                                            </div>
                                            <form class="form-horizontal" id="newAssessForm"  >
                                                <div class="modal-body">
                                                    <div class="box-body">
                                                        <div align="center"> <span style="color:#008000;" id="msgAddSuccess"></span> 
                                                            <span style="color:#008000;" id="msgAddError"></span>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="newassessNameField" class="col-sm-4 control-label">Assess Description</label>
                                                            <div class="col-sm-8">
                                                                <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="add">
                                                                <input type="text" class="form-control" id="newassessNameField" name="newassessNameField" placeholder="Enter Assess Discription">
                                                                <span class="help-inline" id="newAssessDiscError" style="color: red;">${error}</span>
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
                                                            <label for="newassessRemarks" class="col-sm-4 control-label">Remarks</label>
                                                            <div class="col-sm-8">
                                                                <input type="text" class="form-control" id="newassessRemarks" name="newassessRemarks" placeholder="Enter Remarks">
                                                                <span class="help-inline" id="newassessError" style="color: red;"></span> 
                                                            </div>
                                                        </div>
                                                    </div>
                                                   <!-- /.box-body -->
                                            </form>
                                        </div>
                                        <div class="modal-footer">
                                            <button type="submit" class="btn btn-primary" id="addAssessAction"  >Add Assess</button>
                                            <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>

                                        </div>
                                    </div>
                                </div>
                        </div>



                        <!-- form start -->

                        <div class="modal fade" id="editAssessModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                        <h4 class="modal-title" id="myModalLabel">Edit Assess</h4>
                                    </div>
                                    <form class="form-horizontal" id="editAssessForm" method="POST" >
                                        <div class="modal-body">                                          
                                            <div class="box-body">
                                                <div align="center"> <span style="color:#008000;" id="msgEditSuccess"></span> 
                                                    <span style="color:#008000;" id="msgEditError"></span>
                                                </div>
                                                <div class="form-group">
                                                    <label for="assessCodeField" class="col-sm-4 control-label">Assess Code</label>

                                                    <div class="col-sm-8">
                                                        <input type="hidden" class="form-control" id="hiddenAction" name="hiddenAction" value="edit">
                                                        <input type="text" class="form-control" id="assessCodeField" name="assessCodeField" placeholder=" " readonly="true">

                                                    </div>


                                                </div>

                                                <div class="form-group">
                                                    <label for="assessNameField" class="col-sm-4 control-label">Assess Name</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" id="assessNameField" name="assessNameField" placeholder="Enter Assess Discription">
                                                        <span class="help-inline" id="assessNameError" style="color: red;"></span> 
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
                                                    <label for="assessRemarks" class="col-sm-4 control-label">Remarks</label>

                                                    <div class="col-sm-8">
                                                        <input type="text" class="form-control" name="assessRemarks" id="assessRemarks" placeholder="Enter Remarks">
                                                        <span class="help-inline" id="assessRemarksError" style="color: red;"></span>
                                                    </div>


                                                </div>

                                            </div>
                                            <!-- /.box-body -->


                                        </div>

                                    </form>
                                    <div class="modal-footer">
                                        <button type="submit" id="editAssessAction" class="btn btn-primary">Save Changes</button>
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

                            $("#editAssess").click(function () {
                                var rd_id = $('input[name=assessRadio]:checked').val();
                                $("#assessCodeField").val($("#" + rd_id + "_assesscode").html());
                                $("#assessNameField").val($("#" + rd_id + "_assessdisc").html());
                                $("#displayOrder").val($("#" + rd_id + "_assessdisplay").html());
                                $("#assessRemarks").val($("#" + rd_id + "_assessremark").html());
                                // $("#recordStatusField").val($("#" + rd_id + "_assessstatus").html());
                            });



                            $('.modal').on('hidden.bs.modal', function () {
                                $("#editAssessForm")[0].reset();
                                $("#newAssessForm")[0].reset();
                            });

                            //-------------------------Add Code start---------------------------------------------
                            try {

                                $("#addAssessAction").click(function () {
                                    if ($('#newassessNameField').val() == '') {
                                        $('#newAssessDiscError').html("This field is required.");
                                        return false;
                                    } else {
                                        if (!(/^(?!\s*$)[a-zA-Z0-9-. ()]{3,50}$/.test($("#newassessNameField").val()))) {
                                            $('#newAssessDiscError').html("Alphabets, numeric & () allowed. Minimum length should be 3.");
                                            $("#newassessNameField").focus();
                                            return false;
                                        } else {
                                            $('#newAssessDiscError').empty();
                                        }

                                    }
                                    if ($('#newdisplayOrder').val() == '') {
                                        $('#newDisplayError').html("This field is required.");
                                        return false;
                                    } else {
                                        $('#newDisplayError').empty();
                                    }
                                    if ($('#newassessRemarks').val() == '') {
                                        $('#newassessError').html("This field is required.");
                                        return false;
                                    }
                                    else {
                                        if (!(/^[a-zA-Z./ ]+$/.test($("#newassessRemarks").val()))) {
                                            $('#newassessError').html(" Only alphabets and . Allowed");
                                            $("#newassessRemarks").focus();
                                            return false;
                                        } else {
                                            $('#newassessError').empty();
                                        }
                                    }

                                    $.ajax({
                                        type: 'POST',
                                        url: 'AssessMasterServlet',
                                        // data:  new FormData(this),
                                        data: $('#newAssessForm').serialize(),
                                        dataType: 'json',
                                        encode: true,
                                        success: function (result) {
                                            // alert("fgdg"+result.rsval);
                                            if (result.rsval == 1) {
                                                $('#msgAddSuccess').html("Assess successfully Added!");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            } else {
                                                $('#msgAddError').html("Error In Assess Add!");
                                            }

                                        },
                                        error: function (result)
                                        {
                                            alert("error: In Assess Add ");

                                        }
                                    });
                                });
                            }
                            catch (e) {
                                alert("EX : " + e);
                            }
                            //-----------------------Add Code End---------------------------------------------

                            //-------------------------Edit Code start---------------------------------------------
                            try {

                                $("#editAssessAction").click(function () {

                                    if ($('#assessNameField').val() == '') {
                                        $('#assessNameError').html("This field is required.");
                                        return false;
                                    } else {
                                        if (!(/^(?!\s*$)[a-zA-Z0-9-. ()]{3,50}$/.test($("#assessNameField").val()))) {
                                            $('#assessNameError').html("Alphabets, numeric & () allowed. Minimum length should be 3.");
                                            $("#assessNameField").focus();
                                            return false;
                                        } else {
                                            $('#assessNameError').empty();
                                        }

                                    }
                                    if ($('#displayOrder').val() == '') {
                                        $('#displayOrderError').html("This field is required.");
                                        return false;
                                    } else {
                                        $('#displayOrderError').empty();
                                    }
                                    if ($('#assessRemarks').val() == '') {
                                        $('#assessRemarksError').html("This field is required.");
                                        return false;
                                    }
                                    else {
                                        if (!(/^[a-zA-Z./ ]+$/.test($("#assessRemarks").val()))) {
                                            $('#assessRemarksError').html(" Only alphabets and . Allowed");
                                            $("#assessRemarks").focus();
                                            return false;
                                        } else {
                                            $('#assessRemarksError').empty();
                                        }
                                    }

                                    $.ajax({
                                        type: 'POST',
                                        url: 'AssessMasterServlet',
                                        // data:  new FormData(this),
                                        data: $('#editAssessForm').serialize(),
                                        dataType: 'json',
                                        encode: true,
                                        success: function (result) {

                                            if (result.updateStatus == 1) {
                                                $('#msgEditSuccess').html("Assess successfully Edited!");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            } else {
                                                $('#msgEditError').html("Error In Assess Edit!");
                                            }

                                        },
                                        error: function (result)
                                        {
                                            alert("error: In Assess Edit");

                                        }
                                    });
                                });
                            }
                            catch (e) {
                                alert("EX : " + e);
                            }
                            //-----------------------Edit Code End---------------------------------------------

                            //----deactivation code------------------------ 

                            $("#delete").click(function () {
                                var r = confirm("Are u sure to delete then press ok otherwise cancel");
                                if (r == true) {

                                    var rd_id = $('input[name=assessRadio]:checked').val();
                                    $("#assessCodeHidden").val($("#" + rd_id + "_assesscode").html());
                                    var code = $("#assessCodeHidden").val();

                                    $.ajax({
                                        type: "POST",
                                        url: "AssessMasterServlet?hiddenAction=delete&assessCodeDelete=" + code,
                                        dataType: 'json',
                                        encode: true,
                                        success: function (result) {

                                            if (result.finalStatus == 2) {

                                                $('#msgError1').html("Assess already deleted");
                                                //$('#msgError1').delay(1000).fadeOut();

                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            }
                                            else {

                                                $('#msgRight1').html("Assess successfully Deleted!");
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

                                    var rd_id = $('input[name=assessRadio]:checked').val();
                                    $("#assessCodeHidden").val($("#" + rd_id + "_assesscode").html());
                                    var code = $("#assessCodeHidden").val();

                                    $.ajax({
                                        type: "POST",
                                        url: "AssessMasterServlet?hiddenAction=restore&assessCodeRestore=" + code,
                                        dataType: 'json',
                                        encode: true,
                                        success: function (result) {
                                            if (result.finalStatusRe == 2) {

                                                $('#msgError1').html("Assess already Active");
                                                window.setTimeout(function () {
                                                    location.reload()
                                                }, 1000);
                                            }
                                            else {

                                                $('#msgRight1').html("Assess successfully Restored!");
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
