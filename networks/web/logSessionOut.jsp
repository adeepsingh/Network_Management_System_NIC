<%
    try {
//        com.nic.form.validation.Audit audit = new com.nic.form.validation.Audit();
//        audit.Audit_Details(session.getAttribute("userID").toString(), session.getAttribute("ip_address").toString(),
//                "LogOut", session.getAttribute("role").toString(), "S");
    } catch (Exception _EX) {
        System.out.println("Audit Trails Exception!!" + _EX);
    }

    session.removeAttribute("userID");
    session.removeAttribute("login_name");
    session.removeAttribute("login_user_designation");
    session.removeAttribute("csrf");
    session.invalidate();
    response.sendRedirect("index.jsp");
%>