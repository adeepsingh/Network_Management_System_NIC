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
        String ipAddress = request.getParameter("ipAddress");
        String locationcode = request.getParameter("locationcode");

        Connection connectionOpen = null;
        PreparedStatement preStatement = null;
        ResultSet rstSet = null;


    %>

    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">                
                <section class="content">
                    <section class="container">                        
                        <form class="form-horizontal" role="form" id="updateIPAddress" action="allocatedDeviceUpdate" method="post">
                            <input type="hidden" name="secureToken" value="${csrf_security_token}" id="secureToken" />
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    IP Address Update Form
                                    ${message}
                                </div>
                                <%                                        try {
                                        DataConnect dataConnect = new DataConnect();
                                        connectionOpen = dataConnect.getConnection();
                                        String sqlQuery = "SELECT NVL(USER_IP_ADDRESS , '#') USER_IP_ADDRESS, "
                                                + "NVL(USER_MAC_ADDRESS, '#') USER_MAC_ADDRESS, "
                                                + "NVL(USER_NAME, '#') USER_NAME, "
                                                + "NVL(USER_DEPARTMENT, '#') USER_DEPARTMENT, "
                                                + "NVL(USER_SECTION, '#') USER_SECTION, "
                                                + "NVL(USER_DESIGNATION, '#') USER_DESIGNATION, "
                                                + "NVL(USER_EMPLOYMENT_TYPE, '#') USER_EMPLOYMENT_TYPE,"
                                                + "NVL(FLOOR, '#') FLOOR, "
                                                + "NVL(LOCATION, '#') LOCATION, "
                                                + "NVL(DEVICE_TYPE, '#') DEVICE_TYPE,"
                                                + "NVL(ACCESS_LEVEL, '#') ACCESS_LEVEL, "
                                                + "NVL(CONTACT_NUMBER, '#') AS CONTACT_NUMBER, "
                                                + "NVL(INTERCOM, '#') INTERCOM, "
                                                + "NVL(EMAIL_ID, '#') AS EMAIL_ID, "
                                                + "NVL(USER_MINISTRY, '#') USER_MINISTRY, "
                                                + "NVL(EMPLOYEE_CODE, '#') EMPLOYEE_CODE, "
                                                + "NVL(ENTERED_REMARKS, '#') AS ENTERED_REMARKS, "
                                                + "NVL(MACHINE_OS, '#') AS MACHINE_OS, "
                                                + "NVL(MACHINE_RAM, '#') MACHINE_RAM, "
                                                + "NVL(MACHINE_ANTIVIRUS, '#') AS MACHINE_ANTIVIRUS, "
                                                + "TO_CHAR(ACTIVATION_DATE, 'DD/MM/YYYY') AS ACTIVATION_DATE, "
                                                + "TO_CHAR(DEACTIVATION_DATE, 'DD/MM/YYYY') AS DEACTIVATION_DATE, "
                                                + "(SELECT DESCRIPTION FROM MASTER_SECTION WHERE CODE = USER_SECTION) AS USER_SECTION_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_DESIGNATION WHERE CODE = USER_DESIGNATION) AS USER_DESIGNATION_NAME,"
                                                + "NVL((SELECT DESCRIPTION FROM MASTER_USER_EMPLOYMENT_TYPE WHERE CODE = USER_EMPLOYMENT_TYPE), ' ') AS USER_EMPLOYMENT_TYPE_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_FLOOR WHERE CODE = FLOOR) AS FLOOR_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_LOCATION WHERE CODE = LOCATION) AS LOCATION_NAME,"
                                                + "NVL((SELECT DESCRIPTION FROM MASTER_DEVICE_TYPE WHERE CODE = DEVICE_TYPE), ' ') AS DEVICE_TYPE_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_ASSESS_LEVEL WHERE CODE = ACCESS_LEVEL) AS ASSESS_LEVEL_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_USER_MINISTRY WHERE CODE = USER_MINISTRY) AS USER_MINISTRY_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_USER_DEPARTMENT WHERE CODE = USER_DEPARTMENT) AS USER_DEPARTMENT_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_OS WHERE CODE = MACHINE_OS) AS MACHINE_OS_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_RAM WHERE CODE = MACHINE_RAM) AS MACHINE_RAM_NAME,"
                                                + "(SELECT DESCRIPTION FROM MASTER_ANTIVIRUS WHERE CODE = MACHINE_ANTIVIRUS) AS MACHINE_ANTIVIRUS_NAME "
                                                + "FROM IP_ADDRESS "
                                                + "WHERE RECORD_STATUS = 'A' AND USER_IP_ADDRESS = '" + ipAddress + "' AND LOCATION = " + locationcode;

                                        preStatement = connectionOpen.prepareStatement(sqlQuery);
                                        rstSet = preStatement.executeQuery();

                                        if (rstSet.next()) {
                                %>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="row">
                                            <div class="col-md-4"><label for="name">Name :</label>
                                                <input type="text" name="name" value="<%=rstSet.getString("USER_NAME")%>" class="form-control" id="name"
                                                       placeholder="Enter Name"  htmlEscape="true" required />
                                            </div>
                                            <div class="col-md-4"><label for="locationCode">Location :</label>
                                                <select name="locationCode" id="locationCode" onchange="showMinistry(this.value)" class="form-control" > 
                                                    <option value="<%=rstSet.getString("LOCATION")%>" selected><%=rstSet.getString("LOCATION_NAME")%></option>
                                                    <option value="" > -- SELECT LOCATION -- </option>
                                                    <c:forEach var="locationCode" items="${locationList.locationList}"> 
                                                        <option VALUE="${locationCode.key}">${locationCode.value}</option> 
                                                    </c:forEach> 
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div class="col-md-4">
                                                <label for="ministryCode">User Ministry :</label>
                                                <div class="controls">
                                                    <select id="ministryCode" name="ministryCode" onchange="showDepartment(this.value)" class="form-control">
                                                        <option VALUE="<%=rstSet.getString("USER_MINISTRY")%>" selected><%=rstSet.getString("USER_MINISTRY_NAME")%></option>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="departmentCode">Department :</label>
                                                <div class="controls">
                                                    <select name="departmentCode" id="departmentCode" onchange="showSection(this.value)" class="form-control" > 
                                                        <option value="<%=rstSet.getString("USER_DEPARTMENT")%>" selected><%=rstSet.getString("USER_DEPARTMENT_NAME")%></option>
                                                    </select></div>
                                            </div>
                                            <div class="col-md-4"><label for="floorCode">Floor :</label>
                                                <select name="floorCode" id="floorCode" class="form-control" > 
                                                    <option value="<%=rstSet.getString("FLOOR")%>" selected><%=rstSet.getString("FLOOR_NAME")%></option>
                                                    <c:forEach var="floorCode" items="${floorList.floorCode}"> 
                                                        <option VALUE="${floorCode.key}">${floorCode.value}</option> 
                                                    </c:forEach> 
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div class="col-md-4"><label for="sectionCode">Section :</label>
                                                <div class="controls">
                                                    <select name="sectionCode" id="sectionCode" class="form-control" > 
                                                        <option value="<%=rstSet.getString("USER_SECTION")%>" selected><%=rstSet.getString("USER_SECTION_NAME")%></option>
                                                    </select><span class="help-inline"></span></div>
                                            </div></div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="designationCode">Designation :</label>
                                                <select name="designationCode" id="designationCode" class="form-control" > 
                                                    <option value="<%=rstSet.getString("USER_DESIGNATION")%>" selected><%=rstSet.getString("USER_DESIGNATION_NAME")%></option>
                                                    <c:forEach var="designationCode" items="${designationList.designationList}"> 
                                                        <option VALUE="${designationCode.key}">${designationCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div class="col-md-4"><label for="empCode">Employee Code :</label>
                                                <%if (rstSet.getString("EMPLOYEE_CODE").equals("#") || rstSet.getString("EMPLOYEE_CODE").equals(" ")) { %>
                                                <input type="text" name="empCode" value="" class="form-control" id="empCode"
                                                       placeholder="Enter Employee Code"  htmlEscape="true" required/>
                                                <% } else {%>
                                                <input type="text" name="empCode" value="<%=rstSet.getString("EMPLOYEE_CODE")%>" class="form-control" id="empCode"
                                                       placeholder="Enter Employee Code"  htmlEscape="true" required/>
                                                <% } %>
                                            </div>
                                            <div class="col-md-4"><label for="contactNo">Contact No :</label>
                                                <%if (rstSet.getString("CONTACT_NUMBER").equals("#") || rstSet.getString("CONTACT_NUMBER").equals(" ")) { %>
                                                <input type="text" name="contactNo" value="" class="form-control" id="contactNo"
                                                       placeholder="Enter Contact No"  htmlEscape="true" required/>
                                                <% } else {%>
                                                <input type="text" name="contactNo" value="<%=rstSet.getString("CONTACT_NUMBER")%>" class="form-control" id="contactNo"
                                                       placeholder="Enter Contact No"  htmlEscape="true" required/>
                                                <% } %>
                                            </div>
                                        </div>    
                                        <div class="row">   
                                            <div class="col-md-4"><label for="InterComm">Inter-Comm :</label>
                                                <%if (rstSet.getString("INTERCOM").equals("#") || rstSet.getString("INTERCOM").equals(" ")) { %>
                                                <input type="text" name="InterComm" value="" class="form-control" id="InterComm"
                                                       placeholder="Enter InterComm"  htmlEscape="true" required minlength="3"/>
                                                <% } else {%>
                                                <input type="text" name="InterComm" value="<%=rstSet.getString("INTERCOM")%>" class="form-control" id="InterComm"
                                                       placeholder="Enter InterComm"  htmlEscape="true" required minlength="3"/>
                                                <% } %>
                                            </div>
                                            <div class="col-md-4"><label for="email">E-Mail :</label>
                                                <%if (rstSet.getString("EMAIL_ID").equals("#") || rstSet.getString("EMAIL_ID").equals(" ")) { %>
                                                <input type="text" name="email" class="form-control" value="" id="email"
                                                       placeholder="Enter E-Mail"  htmlEscape="true" required/>
                                                <% } else {%>
                                                <input type="text" name="email" class="form-control" value="<%=rstSet.getString("EMAIL_ID")%>" id="email"
                                                       placeholder="Enter E-Mail"  htmlEscape="true" required/>
                                                <% } %>
                                            </div>
                                            <div class="col-md-4"><label for="employeeTypeCode">Employee Type :</label>
                                                <select name="employeeTypeCode" id="employeeTypeCode" class="form-control" > 
                                                    <%if (rstSet.getString("USER_EMPLOYMENT_TYPE").equals("#") || rstSet.getString("USER_EMPLOYMENT_TYPE").equals(" ")) { %>
                                                    <option value="" selected>-- Select Employment Type --</option>
                                                    <% } else {%>
                                                    <option value="<%=rstSet.getString("USER_EMPLOYMENT_TYPE")%>" selected><%=rstSet.getString("USER_EMPLOYMENT_TYPE_NAME")%></option>
                                                    <% }%>
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
                                                <input type="text" name="macAddress" value="<%=rstSet.getString("USER_MAC_ADDRESS")%>" class="form-control" id="macAddress"
                                                       placeholder="Enter Mac Address" htmlEscape="true" maxlength="17" minlength="17" required/>
                                            </div>
                                            <div class="col-md-4"><label for="assessLevelCode">Assess Level :</label>
                                                <select name="assessLevelCode" id="assessLevel" class="form-control" required> 
                                                    <option value="<%=rstSet.getString("ACCESS_LEVEL")%>" selected><%=rstSet.getString("ASSESS_LEVEL_NAME")%></option>
                                                    <c:forEach var="assessLevelCode" items="${assessLevelList.menuCode}"> 
                                                        <option VALUE="${assessLevelCode.key}">${assessLevelCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>           
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="activationDate">Date of Activation :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <input type="text" id="activationDate" value="<%=rstSet.getString("ACTIVATION_DATE")%>" name="activationDate" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Date of Activation" required/> 
                                                </div>
                                            </div>
                                            <div class="col-md-4"><label for="deactivationDate">Date of DeActivation  :</label>
                                                <div class="input-group">
                                                    <div class="input-group-addon">
                                                        <i class="fa fa-calendar"></i>
                                                    </div>
                                                    <input type="text" id="deactivationDate" value="<%=rstSet.getString("DEACTIVATION_DATE")%>" name="deactivationDate" class="form-control" data-inputmask="'alias': 'dd/mm/yyyy'" data-mask="true" placeholder="Date of DeActivation" required/> 
                                                </div>
                                            </div>
                                            <div class="col-md-4"><label for="remarks">Remarks :</label>
                                                <%if (rstSet.getString("ENTERED_REMARKS").equals("#") || rstSet.getString("ENTERED_REMARKS").equals(" ")) { %>
                                                <input type="text" name="remarks" value="" class="form-control" id="remarks"
                                                       placeholder="Enter remarks" htmlEscape="true" required minlength="3"/>
                                                <% } else {%>
                                                <input type="text" name="remarks" value="<%=rstSet.getString("ENTERED_REMARKS")%>" class="form-control" id="remarks"
                                                       placeholder="Enter remarks" htmlEscape="true" required minlength="3"/>
                                                <% } %>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-4"><label for="deviceTypeCode">Device Type :</label>
                                                <select name="deviceTypeCode" id="deviceTypeCode" class="form-control" required>
                                                    <%if (rstSet.getString("DEVICE_TYPE").equals("#")) { %>
                                                    <option value="" selected>-- Select Device Type --</option>
                                                    <% } else {%>
                                                    <option value="<%=rstSet.getString("DEVICE_TYPE")%>" selected><%=rstSet.getString("DEVICE_TYPE_NAME")%></option>
                                                    <% }%>
                                                    <c:forEach var="deviceTypeCode" items="${deviceTypeList.deviceTypeCode}"> 
                                                        <option VALUE="${deviceTypeCode.key}">${deviceTypeCode.value}</option> 
                                                    </c:forEach>
                                                </select><span class="help-inline"></span>
                                            </div>
                                            <div id="01" class="addOn" style="display:none"> 
                                                <div class="col-md-4"><label for="osCode">Operating System :</label>
                                                    <select name="osCode" id="osCode" class="form-control" required> 
                                                        <%if (rstSet.getString("MACHINE_OS").equals("#")) { %>
                                                        <option value="" selected>-- Select Operating System --</option>
                                                        <% } else {%>
                                                        <option value="<%=rstSet.getString("MACHINE_OS")%>" selected><%=rstSet.getString("MACHINE_OS_NAME")%></option>
                                                        <% }%>                                                        
                                                        <c:forEach var="osCode" items="${osList.osCode}"> 
                                                            <option VALUE="${osCode.key}">${osCode.value}</option> 
                                                        </c:forEach>
                                                    </select><span class="help-inline"></span>
                                                </div>
                                                <div class="col-md-4"><label for="ramCode">Ram :</label>
                                                    <select name="ramCode" id="ramCode" class="form-control" required> 
                                                        <%if (rstSet.getString("MACHINE_RAM").equals("#")) { %>
                                                        <option value="" selected>-- Select RAM --</option>
                                                        <% } else {%>
                                                        <option value="<%=rstSet.getString("MACHINE_RAM")%>" selected><%=rstSet.getString("MACHINE_RAM_NAME")%></option>
                                                        <% }%>                                                        
                                                        <c:forEach var="ramCode" items="${ramList.ramCode}"> 
                                                            <option VALUE="${ramCode.key}">${ramCode.value}</option> 
                                                        </c:forEach>
                                                    </select><span class="help-inline"></span>
                                                </div>
                                                <div class="col-md-4"><label for="antiVirusCode">Anti-Virus :</label>
                                                    <select name="antiVirusCode" id="antiVirusCode" class="form-control" required> 
                                                        <%if (rstSet.getString("MACHINE_ANTIVIRUS").equals("#")) { %>
                                                        <option value="" selected>-- Select Anti-virus -- </option>
                                                        <% } else { %>
                                                        <option value="<%=rstSet.getString("MACHINE_ANTIVIRUS")%>" selected><%=rstSet.getString("MACHINE_ANTIVIRUS_NAME")%></option>
                                                        <% }%>
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
                                                <center><button type="submit" onclick="Submit()" class="btn btn-primary" data-original-title="Click to Update UserForm">Update User Form</button></center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%

                                    } else {
                                        out.println("Not Found!!!!");
                                    }
                                %>
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
    <script src="../scripts/updateIPValidation.js"></script>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>
</body>
<%
    } catch (Exception _EX) {
        if (connectionOpen != null) {
            connectionOpen.close();
        }
        out.println("Error!! ipPoolAssignUpdateForm " + _EX);
    } finally {
        if (connectionOpen != null) {
            connectionOpen.close();
        }
    }
%>
<script type="text/javascript">
                                                    $(document).ready(function () {
                                                        $('#locationCode').change(function (event) {
                                                            var locationCode = $("select#locationCode").val();
                                                            $.get('getMinistryServlet', {
                                                                //sportsName: sports
                                                                locationCode: locationCode
                                                            }, function (response) {

                                                                var select = $('#ministryCode');
                                                                select.find('option').remove();
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
//        $(function () {
//            $("#dialog-message").dialog({
//                modal: true,
//                buttons: {
//                    Ok: function () {
//                        $(this).dialog("close");
//                        alert("MAc address entered: " + macAddress.val());
//                    }
//                }
//            });
//        });

        function formatMAC(e) {
            var r = /([a-f0-9]{2})([a-f0-9]{2})/i,
                    str = e.target.value.replace(/[^a-f0-9]/ig, "");
            while (r.test(str)) {
                str = str.replace(r, '$1' + ':' + '$2');
            }
            e.target.value = str.slice(0, 17);
        }
        ;

        macAddress.on("keyup", formatMAC);
    </script>
</html>

