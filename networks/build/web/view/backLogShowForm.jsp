<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<%!
    Connection conn;
    Statement st = null;
    ResultSet rs = null;
    String query, userName, macAddress, enterBy, enterDate, displayOrder, recordStatus, enterRemarks;
    String msgRight = "";

%>
<%
HTMLFilter filter = new HTMLFilter();
String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
request.getSession().setAttribute("csrf_secureToken", secureToken);
String ipAddress = request.getParameter("ipAddress");
String locationcode = request.getParameter("locationcode");
%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
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
                            <h2 class="box-title">Ip Address Status and BackLog Form</h2>
                        </div>
                            <%                    try {
                                    DataConnect con = new DataConnect();
                                    String location = (String) session.getAttribute("locationCode");
                                    conn = con.getConnection();
                                    query = "SELECT USER_IP_ADDRESS,USER_MAC_ADDRESS,USER_NAME,USER_DEPARTMENT,USER_SECTION,"
                                            + "USER_DESIGNATION,USER_EMPLOYMENT_TYPE,FLOOR,LOCATION,DEVICE_TYPE,ACCESS_LEVEL,"
                                            + "NVL(CONTACT_NUMBER, ' ') AS CONTACT_NUMBER, NVL(INTERCOM, ' ') INTERCOM, NVL(EMAIL_ID, ' ') AS EMAIL_ID, USER_MINISTRY, "
                                            + "NVL(EMPLOYEE_CODE, ' ') EMPLOYEE_CODE,NVL(ENTERED_REMARKS, ' ') AS ENTERED_REMARKS,NVL(MACHINE_OS, ' ') AS MACHINE_OS, NVL(MACHINE_RAM, ' ') MACHINE_RAM,"
                                            + "NVL(MACHINE_ANTIVIRUS, ' ') AS MACHINE_ANTIVIRUS, "
                                            + "TO_CHAR(ACTIVATION_DATE, 'DD/MM/YYYY') AS ACTIVATION_DATE, TO_CHAR(DEACTIVATION_DATE, 'DD/MM/YYYY') AS DEACTIVATION_DATE,"
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
                                            + "(SELECT DESCRIPTION FROM MASTER_ANTIVIRUS WHERE CODE = MACHINE_ANTIVIRUS) AS MACHINE_ANTIVIRUS_NAME, "
                                            + "DECODE (FLAG, 'U', 'Updated','D', 'Deleted','I', 'New Record') Flag,NVL((SELECT USER_NAME FROM USER_TABLE WHERE USER_CODE = ENTERED_BY), 'Imported from auditip') AS ENTERED_BY "
                                            + " FROM IP_ADDRESS_LOG "
                                            + "WHERE USER_IP_ADDRESS = '" + ipAddress + "' AND LOCATION = " + locationcode +" ORDER BY FLAG_DATE ASC ";
                                    st = conn.createStatement();
                                    rs = st.executeQuery(query);
                                    int i = 1;
                            %>
                               <table id="example" class="display" cellspacing="0" width="100%">
                                   <thead><tr bgcolor="">
                                     <th>#</th>
                                    <th>IP Address</th>
                                    <th>Mac Address</th>
                                    <th>User Name</th>
                                    <th>User Department</th>
                                    <th>User Section</th>
                                    <th>User Designation</th>
                                    <th>User Ministry</th>
                                    <th>Record Status</th>
                                    <th>Processed By</th>
                                    <th>Remarks</th>
                                    </tr></thead>
                                    <tfoot><tr bgcolor="">
                                    <th>#</th>
                                    <th>IP Address</th>
                                    <th>Mac Address</th>
                                    <th>User Name</th>
                                    <th>User Department</th>
                                    <th>User Section</th>
                                    <th>User Designation</th>
                                    <th>User Ministry</th>
                                    <th>Record Status</th>
                                    <th>Processed By</th>
                                    <th>Remarks</th>
                                    </tr></tfoot>
                                    <tbody>
                                        <%
                                            while (rs.next()) {
                                                ipAddress = rs.getString("USER_IP_ADDRESS");
                                                macAddress = rs.getString("USER_MAC_ADDRESS");
                                                userName = rs.getString("USER_NAME");
                                        %>
                                        <tr>
                                            <td><center><%=i%>.</center></td>
                                    <td>
                                        <input type="hidden"  id="ipAddHidden" name="ipAddHidden" >
                                        <input type="hidden"  id="locHidden" name="locHidden" >
                                        <input type="hidden"  id="userName" name="userName" >
                                        <font size="2"><span id="<%=i%>_userIPAddress"><%=ipAddress%></a></a></span>
                                        <span id="<%=i%>_locationHidden" hidden="hidden"><%=location%></a></span></font></td>
                                    <td><%=macAddress%></td>
                                    <td><%=userName%></td>
                                    <td><%=rs.getString("USER_DEPARTMENT_NAME")%></td>
                                    <td><%=rs.getString("USER_SECTION_NAME")%></td>
                                    <td><%=rs.getString("USER_DESIGNATION_NAME")%></td>
                                    <td><%=rs.getString("USER_MINISTRY_NAME")%></td>
                                    <td><%=rs.getString("FLAG")%></td>
                                    <td><%=rs.getString("ENTERED_BY")%></td>
                                    <td><%=rs.getString("ENTERED_REMARKS")%></td>
                                    
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
                        </div>
                        <!-- /.content-wrapper -->
                        <%@include file="footer.jsp"%>
                        </div>
                        <%@include file="scripts.jsp"%>
                        </body>
<script  type="text/javascript">
$(document).ready(function() {
    var table = $('#example').DataTable( { 
        "scrollY": "350px",
        "paging": false
    } );
 
    $('a.toggle-vis').on( 'click', function (e) {
        e.preventDefault();
        // Get the column API object
        var column = table.column( $(this).attr('data-column') );
        // Toggle the visibility
        column.visible( ! column.visible() );
    } );
} );
</script>     							
</html>