<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="net.sf.xsshtmlfilter.HTMLFilter"%>
<%@page import="com.nic.utility.RandomSaltGenerator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <%@include file="header.jsp"%>
    <%    HTMLFilter filter = new HTMLFilter();
        String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
        request.getSession().setAttribute("csrf_secureToken", secureToken);
        String location_Code = (String) session.getAttribute("locationCode");
        String message = request.getParameter("message");
    %>
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">                
                <section class="content">
                    <section class="container">                        
                        
                   <div id="result">
                    <h3><%=message%></h3>
                </div>
                    </section>
                </section>
            </div>
            <!-- /.container -->
        </div>
        <!-- /.content-wrapper -->
      <%@include file="footer.jsp"%>
    <!-- ./wrapper -->
    <%@include file="scripts.jsp"%>
    <script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
    <script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>
</body>
