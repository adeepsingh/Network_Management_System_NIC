<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">
                <div class="container">
                    <div class="box">
                        <div class="box-header">
                            <h3 class="box-title">List of free IP Address - </h3>
                            ${message}
                            <c:remove var="message" scope="session" />
                        </div>
                        <!-- /.box-header -->
                        <div class="box-body">
                            <table id="example1" class="table table-bordered table-striped">
                                <thead>
                                    <tr>
                                        <th>IP Address</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <%
                                            String location = (String) session.getAttribute("locationCode");
                                            connection = connect.getConnection();
                                            String query = "SELECT IP_ADDRESS, LOCATION_CODE, LOCATION_CODE||SUBSTR(IP_ADDRESS, 7, 3)||LPAD(SUBSTR(IP_ADDRESS, 11, 3), 3, 0) FROM IP_POOL WHERE ASSIGNED_STATUS = 'N' AND LOCATION_CODE = ? ORDER BY 3";
                                            PreparedStatement listOfIPs = connection.prepareStatement(query);
                                            listOfIPs.setString(1, locationCode);
                                            ResultSet listOfIP = listOfIPs.executeQuery();

                                            while (listOfIP.next()) {
                                        %>
                                        <td>
                                            <span hidden="hidden"><%=listOfIP.getString(3)%></span>
                                            <a href="allotedDeviceDetail.jsp?ipAddress=<%=listOfIP.getString("IP_ADDRESS")%>" class="btn btn-primary"><%=listOfIP.getString("IP_ADDRESS")%></a>
                                        </td>

                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>
                        <!-- /.box-body -->
                    </div>
                </div>
                <!-- /.container -->
            </div>
            <!-- /.content-wrapper -->
            <%@include file="footer.jsp"%>
        </div>
        <!-- ./wrapper -->
        <%@include file="scripts.jsp"%>
        <script type="text/javascript">
            $(function () {
                $('#example1').DataTable({
                    "paging": true,
                    "lengthChange": true,
                    "searching": true,
                    "ordering": true,
                    "info": true,
                    "autoWidth": false
                });
            });
        </script>
    </body>
</h