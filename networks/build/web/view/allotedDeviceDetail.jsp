<%@page import = "com.nic.validation.DataConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="net.sf.xsshtmlfilter.HTMLFilter"%>
<%@page import="com.nic.utility.RandomSaltGenerator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "locationList" class = "com.nic.form.populate.LocationPopulate" scope = "page" />
<jsp:useBean id = "floorList" class = "com.nic.form.populate.FloorPopulate" scope = "page" />
<jsp:useBean id = "deviceTypeList" class = "com.nic.form.populate.DeviceTypePopulate" scope = "page" />
<jsp:useBean id = "employeeTypeList" class = "com.nic.form.populate.EmployeeTypePopulate" scope = "page" />
<jsp:useBean id = "designationList" class = "com.nic.form.populate.DesignationPopulate" scope = "page" />
<jsp:useBean id = "assessLevelList" class = "com.nic.form.populate.AssessLevel" scope = "page" />

<jsp:useBean id = "osList" class = "com.nic.form.populate.OSPopulate" scope = "page" />
<jsp:useBean id = "ramList" class = "com.nic.form.populate.RamPopulate" scope = "page" />
<jsp:useBean id = "antiVirusList" class = "com.nic.form.populate.AntiVirusPopulate" scope = "page" />

<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <%    HTMLFilter filter = new HTMLFilter();
        String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
        request.getSession().setAttribute("csrf_secureToken", secureToken);

//        String location_Code = (String) session.getAttribute("locationCode");
        String ipAddress = request.getParameter("ipAddress");
    %>

    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">                
                <section class="content">
                    <section class="container">                        
                        <form class="form-horizontal" role="form" id="assignIPAddress" action="allocatedDeviceSave" method="post">
                            <input type="hidden" name="secureToken" value="${csrf_security_token}" id="secureToken" />
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Alloted Device Detail
                                    <font color="black" size="+2">&nbsp;&nbsp;&nbsp;${message}</font>
                                </div>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="row">
                                            <div class="col-md-4"><label for="name">Name :</label>
                                                <input type="text" path="name" name="name" class="form-control" id="name"
                                                       placeholder="Enter Name"  htmlEscape="true" required />
                                            </div>
                                            <div class="col-md-4"><label for="locationCode">Location :</label>
                                                <select name="locationCode" id="locationCode" onchange="showMinistry(this.value)" class="form-control" > 
                                                    <option value="" selected>Select Location</option>
                                                    <c:forEach var="locationCode" items="${locationList.locationList}"> 
                                                        <option VALUE="${locationCode.key}">${locationCode.value}</option> 
                                                    </c:forEach> 
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="ministryCode">User Ministry :</label>
                                                <div class="controls">
                                                    <select id="ministryCode" name="ministryCode" onchange="showDepartment(this.value)" class="form-control">
                                                        <option VALUE="">-- Select Ministry --</option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="departmentCode">Department :</label>
                                                <div class="controls">
                                                    <select name="departmentCode" id="departmentCode" onchange="showSection(this.value)" class="form-control" > 
                                                        <option value="" selected>-- Select Department --</option>
                                                    </select></div>
                                            </div>
                                            <div class="col-md-4"><label for="floorCode">Floor :</label>
                                                <select name="floorCode" id="floorCode" class="form-control" > 
                                                    <option value="" selected>Select Floor</option>
                                                    <c:forEach var="floorCode" items="${floorList.floorCode}"> 
                                                        <option VALUE="${floorCode.key}">${floorCode.value}</option> 
                                                    </c:forEach> 
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div class="col-md-4"><label for="sectionCode">Section :</label>
                                                <div class="controls">
                                                    <select name="sectionCode" id="sectionCode" class="form-control" > 
                                                        <option value="" selected>-- Select Section --</option>
                                                    </select><span class="help-inline"></span></div>
                                            </div></div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="designationCode">Designation :</label>
                                                <select name="designationCode" id="designationCode" class="form-control" > 
                                                    <option value="" selected>Select Designation</option>
                                                    <c:forEach var="designationCode" items="${designationList.designationList}"> 
                                                        <option VALUE="${designationCode.key}">${designationCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div class="col-md-4"><label for="empCode">Employee Code :</label>
                                                <input type="text" name="empCode" class="form-control" id="empCode"
                                                       placeholder="Enter Employee Code"  htmlEscape="true" required/>
                                            </div>
                                            <div class="col-md-4"><label for="contactNo">Contact No :</label>
                                                <input type="text" name="contactNo" class="form-control" id="contactNo"
                                                       placeholder="Enter Contact No"  htmlEscape="true" required/>
                                            </div>
                                        </div>    
                                        <div class="row">   
                                            <div class="col-md-4"><label for="InterComm">Inter-Comm :</label>
                                                <input type="text" name="InterComm" class="form-control" id="InterComm"
                                                       placeholder="Enter InterComm"  htmlEscape="true"/>
                                            </div>
                                            <div class="col-md-4"><label for="email">E-Mail :</label>
                                                <input type="text" name="email" class="form-control" id="email"
                                                       placeholder="Enter E-Mail"  htmlEscape="true" required/>
                                            </div>
                                            <div class="col-md-4"><label for="employeeTypeCode">Employee Type :</label>
                                                <select name="employeeTypeCode" id="employeeTypeCode" class="form-control" > 
                                                    <option value="" selected>Select Employee Type</option>
                                                    <c:forEach var="employeeTypeCode" items="${employeeTypeList.employeeTypeList}"> 
                                                        <option VALUE="${employeeTypeCode.key}">${employeeTypeCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="ipAddress">IP-Address :</label>
                                                <input type="text" class="form-control" value="<%=ipAddress%>" disabled/>
                                                <input type="hidden" name="ipAddress" class="form-control" id="ipAddress" value="<%=ipAddress%>"/>
                                            </div>
                                            <div class="col-md-4"><label for="macAddress">Mac Address :</label>
                                                <input type="text" name="macAddress" class="form-control" id="macAddress"
                                                       placeholder="Enter Mac Address" htmlEscape="true" maxlength="17" required/>
                                            </div>
                                            <div class="col-md-4"><label for="assessLevelCode">Assess Level :</label>
                                                <select name="assessLevelCode" id="assessLevelCode" class="form-control" > 
                                                    <option value="" selected>-- Select Assess Level --</option>
                                                    <c:forEach var="assessLevelCode" items="${assessLevelList.menuCode}"> 
                                                        <option VALUE="${assessLevelCode.key}">${assessLevelCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-md-4"><label for="activationDate">Date of Activation  :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <input type="text" id="activationDate" name="activationDate" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Date of Activation" required/> 
                                                </div>
                                            </div>
                                            <div class="col-md-4"><label for="deactivationDate">Date of DeActivation  :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <input type="text" id="deactivationDate" name="deactivationDate" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Date of DeActivation" required/> 
                                                </div>
                                            </div>
                                            <div class="col-md-4"><label for="remarks">Remarks :</label>
                                                <input type="text" name="remarks" class="form-control" id="remarks"
                                                       placeholder="Enter remarks" htmlEscape="true"/>
                                            </div>
                                            <div class="col-md-4">
                                            </div>
                                            <div class="col-md-4">
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="deviceTypeCode">Device Type :</label>
                                                <select name="deviceTypeCode" id="deviceTypeCode" class="form-control" > 
                                                    <option value="" selected>Select Device Type</option>
                                                    <c:forEach var="deviceTypeCode" items="${deviceTypeList.deviceTypeCode}"> 
                                                        <option VALUE="${deviceTypeCode.key}">${deviceTypeCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div id="01" class="addOn" style="display:none"> 
                                                <div class="col-md-4"><label for="osCode">Operating System :</label>
                                                    <select name="osCode" id="osCode" class="form-control" required> 
                                                        <option value="" selected>Select Operating System</option>
                                                        <c:forEach var="osCode" items="${osList.osCode}"> 
                                                            <option VALUE="${osCode.key}">${osCode.value}</option> 
                                                        </c:forEach>
                                                    </select><span class="help-inline"></span>
                                                </div>
                                                <div class="col-md-4"><label for="ramCode">Ram :</label>
                                                    <select name="ramCode" id="ramCode" class="form-control" required> 
                                                        <option value="" selected>Select Ram</option>
                                                        <c:forEach var="ramCode" items="${ramList.ramCode}"> 
                                                            <option VALUE="${ramCode.key}">${ramCode.value}</option> 
                                                        </c:forEach>
                                                    </select><span class="help-inline"></span>
                                                </div>
                                                <div class="col-md-4"><label for="antiVirusCode">Anti-Virus :</label>
                                                    <select name="antiVirusCode" id="addOnCode" class="form-control"  required> 
                                                        <option value="" selected>Select Anti-Virus</option>
                                                        <c:forEach var="antiVirusCode" items="${antiVirusList.antiVirusCode}"> 
                                                            <option VALUE="${antiVirusCode.key}">${antiVirusCode.value}</option> 
                                                        </c:forEach>
                                                    </select><span class="help-inline"></span>
                                                </div>   
                                            </div>


                                        </div>    
                                        <div class="row">
                                            <div class="col-md-12">
                                                <center>&nbsp;</center>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-12">
                                                <center><button type="submit" onclick="Submit()" class="btn btn-primary" data-original-title="Click to Add UserForm">Add User Form</button></center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>      
                        </form>
                    </section>
                </section>
            </div>
            <!-- /.container -->
        </div>
        <!-- /.content-wrapper -->
        <%@include file="footer.jsp"%>
    </div>
    <!-- ./wrapper -->
    <%@include file="scripts.jsp"%>
    <script src="../scripts/assignIPValidation.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>
</body>
<script type="text/javascript">
                                                    $(document).ready(function () {
                                                        $('#locationCode').change(function (event) {
                                                            var locationCode = $("select#locationCode").val();
                                                            $.get('getMinistryServlet', {
                                                                locationCode: locationCode
                                                            }, function (response) {

                                                                var select = $('#ministryCode');
                                                                select.find('option').remove();
                                                                $('<option>').val("").text("-- Select Ministry --").appendTo(select);
                                                                $.each(response, function (index, value) {
                                                                    $('<option>').val(index).text(value).appendTo(select);
                                                                });
                                                            });
                                                        });
                                                    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#ministryCode').change(function (event) {
            var ministryCode = $("select#ministryCode").val();
            $.get('getDepartmentServlet', {
                ministryCode: ministryCode
            }, function (response) {
                var select = $('#departmentCode');
                select.find('option').remove();
                $('<option>').val("").text("-- Select Department --").appendTo(select);
                $.each(response, function (index, value) {
                    $('<option>').val(index).text(value).appendTo(select);
                });
            });
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#departmentCode').change(function (event) {
            var departmentCode = $("select#departmentCode").val();
            $.get('getSectionServlet', {
                departmentCode: departmentCode
            }, function (response) {
                var select = $('#sectionCode');
                select.find('option').remove();
                $('<option>').val("").text("-- Select Section --").appendTo(select);
                $.each(response, function (index, value) {
                    $('<option>').val(index).text(value).appendTo(select);
                });
            });
        });
    });
</script>
<script>
    $(document).ready(function () {
        $('#deviceTypeCode').change(function () {
            $('.addOn').hide();
            $('#' + $(this).val()).show();
        });
    });
</script>
<script type="text/javascript">
    var macAddress = $("#macAddress");

//                                                    $(function () {
//                                                        $("#dialog-message").dialog({
//                                                            modal: true,
//                                                            buttons: {
//                                                                Ok: function () {
//                                                                    $(this).dialog("close");
//                                                                    alert("MAc address entered: " + macAddress.val());
//                                                                }
//                                                            }
//                                                        });
//                                                    });

    function formatMAC(e) {
        var r = /([a-f0-9]{2})([a-f0-9]{2})/i,
                str = e.target.value.replace(/[^a-f0-9]/ig, "");
        while (r.test(str)) {
            str = str.replace(r, '$1' + ':' + '$2');
        }
        e.target.value = str.slice(0, 17);
    };
    macAddress.on("keyup", formatMAC);
</script>
</html>
