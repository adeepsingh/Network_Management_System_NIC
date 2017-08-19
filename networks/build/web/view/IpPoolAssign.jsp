<%@page import = "com.nic.validation.DataConnect"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="net.sf.xsshtmlfilter.HTMLFilter"%>
<%@page import="com.nic.utility.RandomSaltGenerator"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id = "locationList" class = "com.nic.form.populate.LocationPopulate" scope = "page" />
<!DOCTYPE html>
<html>
    <%@include file="header.jsp"%>
    <%    HTMLFilter filter = new HTMLFilter();
        String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
        request.getSession().setAttribute("csrf_secureToken", secureToken);
    %>
    <body class="hold-transition skin-blue layout-top-nav">
        <div class="wrapper">
            <%@include file="top-nav.jsp"%>
            <!-- Full Width Column -->
            <div class="content-wrapper">                
                <section class="content">
                    <section class="container">                        
                        <form class="form-horizontal" role="form" id="allocatedIPSegment" action="generateIPSegmentSave" method="post">
                            <input type="hidden" name="secureToken" value="${csrf_security_token}" id="secureToken" />
                            <div class="panel panel-primary">
                                <div class="panel-heading">
                                    Assign IP Pool<font size="+2" color="black" >&nbsp;&nbsp;&nbsp;${message}</font>
                                </div>
                                <div class="panel-body">
                                    <div class="tab-content">
                                        <div class="row">
                                            <div class="col-md-1">
                                                <font size="+3">10.25.</font>
                                            </div>
                                            <div class="col-md-1">
                                                <input type="text" name="ipPool" class="form-control" id="ipPool" onkeypress="segmentNo()" maxlength="3"
                                                       placeholder=""  htmlEscape="true" required />
                                            </div>
                                            <div class="col-md-10">
                                                <font size="+3">.(1-254)</font>
                                            </div>
                                        </div>                                        
                                        <div class="row">
                                            <div class="col-md-12">
                                                <center><button type="submit" onclick="Submit()" class="btn btn-primary" data-original-title="Click to Generate IP">Add IP Pool Form</button></center>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>      
                        </form>
                    </section>
                </section>
        <!-- /.container -->
    </div>
    <!-- /.content-wrapper -->
    <%@include file="footer.jsp"%>
</div>
<!-- ./wrapper -->
<%@include file="scripts.jsp"%>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.14.0/jquery.validate.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.extensions.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.date.extensions.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.numeric.extensions.js"></script>
<script src="../plugins/input-mask/jquery.inputmask.regex.extensions.js"></script>
</body>
<script>        
           function segmentNo(){          
            $('#ipPool').keypress(function(e) {
                var a = [];
                var k = e.which;

                for (i = 48; i < 58; i++)
                    a.push(i);

                if (!(a.indexOf(k)>=0))
                    e.preventDefault();
            });
        }
       </script>
 </html>

