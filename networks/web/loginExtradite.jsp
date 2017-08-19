<%@page import="net.sf.xsshtmlfilter.HTMLFilter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <script type="text/javascript">
            setTimeout(function () {
                window.location.reload(1);
            }, 2000000);
        </script>
        <%
            HTMLFilter Filter = new HTMLFilter();
            String test = (String) session.getAttribute("userID");
            if (test != null) {
                response.sendRedirect("view/homePage.jsp");
            }
            String username = "";
            if (request.getParameter("username") != null) {
                username = Filter.filter(request.getParameter("username"));
            }
            String pathB = request.getContextPath();
            String servletCall = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + pathB + "/Captcha";
        %>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>NDCC NETWORKS</title>
        <!-- Tell the browser to be responsive to screen width -->
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <!-- Bootstrap 3.3.6 -->
        <link rel="stylesheet" href="bootstrap/css/bootstrap.min.css">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
        <!-- Ionicons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
        <!-- Theme style -->
        <link rel="stylesheet" href="dist/css/AdminLTE.min.css">
        <!-- iCheck -->
        <link rel="stylesheet" href="plugins/iCheck/square/blue.css">

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
    </head>
    <body class="hold-transition login-page">
        <div class="login-box">
            <div class="login-logo">
                <a href="#"><b>NDCC NETWORKS</b> </a>
            </div>
            <!-- /.login-logo -->
            <div class="login-box-body">
                <p class="login-box-msg">Sign in to start your session</p>
                    <!--<div class="alert alert-danger alert-dismissible"></div>-->  
                <div align="center" style="color:#AD8C08;">${viram}</div>
                <form action="Acceptance" method="post">
                    <div class="form-group has-feedback">
                        <input type="text" class="form-control" placeholder="User ID" value="<%=username%>" name="username" required=""> 
                        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <input type="password" class="form-control" placeholder="Password" name="password" required="">
                        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
                    </div>
                    <div class="form-group has-feedback">
                        <center><img src='<%=servletCall%>'></center>
                    </div>
                    <div class="form-group has-feedback">
                        <input type="text" class="form-control" name="code" maxlength="7" size="28" placeholder="Enter Code" required=""/>
                        <span style="display:none"><input type="text" readonly name="secureToken" value="${secureToken}" /></span>   
                    </div>    
                    <div class="row">
                        <div class="col-xs-8">                            
                        </div>
                        <!-- /.col -->
                        <div class="col-xs-4">
                            <button type="submit" class="btn btn-primary btn-block btn-flat">Sign In</button>
                        </div>
                        <!-- /.col -->
                    </div>
                </form>
            </div>
            <!-- /.login-box-body -->
        </div>
        <!-- /.login-box -->
        <!-- jQuery 2.2.0 -->
        <script src="plugins/jQuery/jquery-2.2.3.min.js"></script>
        <!-- Bootstrap 3.3.6 -->
        <script src="bootstrap/js/bootstrap.min.js"></script>
        <!-- iCheck -->
        <script src="plugins/iCheck/icheck.min.js"></script>
        <script>
            $(function () {
                $('input').iCheck({
                    checkboxClass: 'icheckbox_square-blue',
                    radioClass: 'iradio_square-blue',
                    increaseArea: '20%' // optional
                });
            });
        </script>
    </body>
</html>
