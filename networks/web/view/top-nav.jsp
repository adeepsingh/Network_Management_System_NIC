<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import = "com.nic.validation.DataConnect"%>
<%@ page import = "java.sql.*" %>
<%@ page import = "javax.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<jsp:useBean id="connect" scope="page" class="com.nic.validation.DataConnect" />
<script type="text/javascript">
    window.history.forward();
    function preventBack() {
        window.history.forward(1);
    }
</script>
<%
    Connection connection = null;
    PreparedStatement statementCategory = null, statementSubCategory = null,
            statementUsers = null, statementProjectDetails = null;
    ResultSet resultCategory = null, resultSubCategory = null,
            resultSetUsers = null, resultSetProjectDetails = null;
    
    String userid = (String) session.getAttribute("userID");
    String user_role = (String) session.getAttribute("user_role");
    String locationCode = (String) session.getAttribute("locationCode");
    if(userid == null) {
        response.sendRedirect("../logSessionOut.jsp");        
    }
%>
<header class="main-header">
    <nav class="navbar navbar-static-top">
        <div class="container">
            <div class="navbar-header">
                <a href="homepage.jsp" class="navbar-brand"><b>NIC</b> | Network System</a>
                <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-collapse">
                    <i class="fa fa-bars"></i>
                </button>
            </div>

            <% try { %>
            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse pull-left" id="navbar-collapse">
                <ul class="nav navbar-nav">                    
                    <%
                        connection = connect.getConnection();
                        String query = "SELECT CATEGORY_CODE, CATEGORY_DESCRIPTION, HAS_SUBCATEGORIES, ACTION_PATH FROM MASTER_MENU_CATEGORY WHERE RECORD_STATUS = 'A' ORDER BY DISPLAY_ORDER";
                        statementCategory = connection.prepareStatement(query);
                        resultCategory = statementCategory.executeQuery();
                        while (resultCategory.next()) {
                            if (resultCategory.getString("HAS_SUBCATEGORIES").equals("N")) {
                    %>
                    <li><a href="<%=resultCategory.getString("ACTION_PATH")%>"><%=resultCategory.getString("CATEGORY_DESCRIPTION")%><span class="sr-only">(current)</span></a></li>
                        <%
                        } else if (resultCategory.getString("HAS_SUBCATEGORIES").equals("Y")) {
                        %>
                    <li class="dropdown">
                        <a href="<%=resultCategory.getString("ACTION_PATH")%>" class="dropdown-toggle" data-toggle="dropdown"><%=resultCategory.getString("CATEGORY_DESCRIPTION")%><span class="caret"></span></a>
                        <ul class="dropdown-menu" role="menu">
                            <%
                                query = "SELECT SC.SUBCATEGORY_CODE, SC.SUBCATEGORY_DESCRIPTION, SC.ACTION_PATH FROM MASTER_MENU_SUBCATEGORY SC, "
                                        + "MASTER_ROLE_AND_MENU RM WHERE SC.RECORD_STATUS = 'A' AND RM.RECORD_STATUS = 'A' AND RM.SUBMENU_CODE = SC.SUBCATEGORY_CODE "
                                        + "AND RM.ROLE_CODE = ? AND CATEGORY_CODE = ? ORDER BY SC.DISPLAY_ORDER ";
                                statementSubCategory = connection.prepareStatement(query);
                                statementSubCategory.setString(1, user_role);
                                statementSubCategory.setString(2, resultCategory.getString("CATEGORY_CODE"));
                                resultSubCategory = statementSubCategory.executeQuery();
                                if (resultSubCategory.next()) {
                                    do {
                            %>
                            <li><a href="<%=resultSubCategory.getString("ACTION_PATH")%>"><%=resultSubCategory.getString("SUBCATEGORY_DESCRIPTION")%></a></li>
                                <%
                                        } while (resultSubCategory.next());
                                    }
                                %>
                        </ul>
                    </li>
                    <%
                            }
                        }
                    %>
                </ul>                
            </div>
            <% } catch (Exception _EX) {
                    System.out.println(_EX);
                }
            %>
            <!-- /.navbar-collapse -->
            <!-- Navbar Right Menu -->
            <% try { %>
            <div class="navbar-custom-menu">
                <ul class="nav navbar-nav">
                    <%
                        connection = connect.getConnection();
                        String query = "SELECT USER_CODE, USER_NAME, TO_CHAR(ACTIVE_SINCE, 'dd/mm/yyyy hh:mi.ss') AS ACTIVE_SINCE, "
                                + "(SELECT DESCRIPTION FROM MASTER_ROLES WHERE CODE = UT.USER_ROLE) AS DESIGNATION "
                                + "FROM USER_TABLE UT WHERE USER_CODE = ?";
                        statementUsers = connection.prepareStatement(query);
                        statementUsers.setString(1, userid);
                        resultSetUsers = statementUsers.executeQuery();
                        if (resultSetUsers.next()) {
                    %>
                    <!-- User Account Menu -->
                    <li class="dropdown user user-menu">
                        <!-- Menu Toggle Button -->
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <!-- The user image in the navbar-->
                            <img src="imageDisplay.jsp" class="user-image" alt="User Image">
                            <!-- hidden-xs hides the username on small devices so only the image appears. -->
                            <span class="hidden-xs"><%=resultSetUsers.getString("USER_CODE")%></span>
                        </a>
                        <ul class="dropdown-menu">
                            <!-- The user image in the menu -->
                            <li class="user-header">
                                <img src="imageDisplay.jsp" class="img-circle" alt="User Image">
                                <p>
                                    <%=resultSetUsers.getString("USER_NAME")%><br/>
                                    <%=resultSetUsers.getString("DESIGNATION")%>
                                    <small>Member since <%=resultSetUsers.getString("ACTIVE_SINCE")%></small>
                                </p>
                            </li>
                            <!-- Menu Footer-->
                            <li class="user-footer">
                                <div class="pull-left">
                                    <a href="changePassword.jsp" class="btn btn-default btn-flat">Change Password</a>
                                </div>
                                <div class="pull-right">
                                    <a href="../logSessionOut.jsp" class="btn btn-default btn-flat">Sign out</a>
                                </div>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
            <% }
                } catch (Exception _EX) {
                    System.out.println(_EX);
                }
            %>
            <!-- /.navbar-custom-menu -->
        </div>
        <!-- /.container-fluid -->
    </nav>
</header>