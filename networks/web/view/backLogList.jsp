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
    String ipAddress, query, userName, macAddress;
    String msgRight = "";
%>
<%
    HTMLFilter filter = new HTMLFilter();
    String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
    request.getSession().setAttribute("csrf_secureToken", secureToken);
%>
<html>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.10.15/css/jquery.dataTables.min.css">
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
                        <div class="box-body">
                            <%                    try {
                                    DataConnect con = new DataConnect();
                                    String location = (String) session.getAttribute("locationCode");
                                    conn = con.getConnection();
                                    query = "SELECT USER_IP_ADDRESS,USER_MAC_ADDRESS,USER_NAME,(SELECT DESCRIPTION FROM MASTER_USER_DEPARTMENT WHERE CODE = USER_DEPARTMENT) AS USER_DEPARTMENT,"
                                            + "(SELECT DESCRIPTION FROM MASTER_SECTION WHERE CODE = USER_SECTION) AS USER_SECTION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_DESIGNATION WHERE CODE = USER_DESIGNATION) AS USER_DESIGNATION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_USER_EMPLOYMENT_TYPE WHERE CODE = USER_EMPLOYMENT_TYPE) AS USER_EMPLOYMENT_TYPE,"
                                            + "(SELECT DESCRIPTION FROM MASTER_FLOOR WHERE CODE = FLOOR) AS FLOOR,"
                                            + "(SELECT DESCRIPTION FROM MASTER_LOCATION WHERE CODE = LOCATION) AS LOCATION,"
                                            + "(SELECT DESCRIPTION FROM MASTER_DEVICE_TYPE WHERE CODE = DEVICE_TYPE) AS DEVICE_TYPE,"
                                            + "(SELECT DESCRIPTION FROM MASTER_ASSESS_LEVEL WHERE CODE = ACCESS_LEVEL) AS ACCESS_LEVEL,"
                                            + "CONTACT_NUMBER,INTERCOM,EMAIL_ID,"
                                            + "DECODE (RECORD_STATUS, 'A', 'Active','D', 'De-Active') RECORD_STATUS, "
                                            + "(SELECT DESCRIPTION FROM MASTER_USER_MINISTRY WHERE CODE = USER_MINISTRY) AS USER_MINISTRY,"
                                            + "EMPLOYEE_CODE,NVL((SELECT USER_NAME FROM USER_TABLE WHERE USER_CODE = ENTERED_BY), 'Imported from auditip') AS ENTERED_BY, "
                                            + "LOCATION||SUBSTR(USER_IP_ADDRESS, 7, 3)||LPAD(SUBSTR(USER_IP_ADDRESS, 11, 3), 3, 0) AS ORDER_SEQ "
                                            + " FROM IP_ADDRESS WHERE RECORD_STATUS = 'A' AND FLAG <> 'D' AND LOCATION=" + location + "ORDER BY ORDER_SEQ";
                                    st = conn.createStatement();
                                    rs = st.executeQuery(query);
                                    int i = 1;
                            %>
                            <div>
                                Column Selection(Optional): <a class="toggle-vis" data-column="0">#</a> - <a class="toggle-vis" data-column="1">IP Address</a> - <a class="toggle-vis" data-column=
                                                                                                                                                                    "2">Mac Address</a> - <a class="toggle-vis" data-column="3">User Name</a> - <a class="toggle-vis" data-column="4">User Department</a> - 
                                                                                                                                                                    <a class="toggle-vis" data-column="5">User Section</a> - 
                                                                                                                                                                    <a class="toggle-vis" data-column="6">User Designation</a> - 
                                                                                                                                                                    <a class="toggle-vis" data-column="7">User Ministry</a> - 
                                                                                                                                                                    <a class="toggle-vis" data-column="8">Processed By</a>
                            </div>  
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
                                        <th>Processed By</th>
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
                                        <th>Processed By</th>
                                    </tr></tfoot>
                                <tbody>
                                    <%
                                        while (rs.next()) {                                            
                                    %>
                                    <tr>
                                        <td><center><%=i%>.</center></td>
                                <td>
                                    <span hidden="hidden"><%=rs.getString("ORDER_SEQ")%></span>
                                    <input type="hidden"  id="ipAddHidden" name="ipAddHidden" >
                                    <input type="hidden"  id="locHidden" name="locHidden" >
                                    <input type="hidden"  id="userName" name="userName" >
                                    <a href="backLogShowForm.jsp?ipAddress=<%=rs.getString("USER_IP_ADDRESS")%>&locationcode='<%=location%>'"><%=rs.getString("USER_IP_ADDRESS")%></a></a>
                                    </td>
                                <td><%=rs.getString("USER_MAC_ADDRESS")%></td>
                                <td><%=rs.getString("USER_NAME")%></td>
                                <td><%=rs.getString("USER_DEPARTMENT")%></td>
                                <td><%=rs.getString("USER_SECTION")%></td>
                                <td><%=rs.getString("USER_DESIGNATION")%></td>
                                <td><%=rs.getString("USER_MINISTRY")%></td>
                                <td><%=rs.getString("ENTERED_BY")%></td>
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
<script type="text/javascript">
    $(document).ready(function () {
        var table = $('#example').DataTable({
            "scrollY": "350px",
            "paging": false
        });
        $('a.toggle-vis').on('click', function (e) {
            e.preventDefault();
            // Get the column API object
            var column = table.column($(this).attr('data-column'));
            // Toggle the visibility
            column.visible(!column.visible());
        });
    });
</script>     						
</html>