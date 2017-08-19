<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%
    Blob image = null;
    Connection con = null;
    byte[] imgData = null;
    Statement stmt = null;
    ResultSet rs = null;
    try {
        String userCode = (String) session.getAttribute("userID");
        con = com.nic.validation.DataConnect.getConnection();
        stmt = con.createStatement();
        rs = stmt.executeQuery("SELECT USER_PHOTOGRAPH FROM USER_TABLE WHERE USER_CODE = '" + userCode + "'");
        if (rs.next()) {
            image = rs.getBlob(1);
            if (image == null) {
                rs = stmt.executeQuery("SELECT IMAGE_CONTENT FROM MASTER_IMAGES WHERE CODE = '10'");
                if (rs.next()) {
                    image = rs.getBlob(1);
                }
            }
            imgData = image.getBytes(1, (int) image.length());
        } else {
                out.println("Unable To Display image");
                return;
            }        
        // display the image
        response.setContentType("image/jpg");
        OutputStream o = response.getOutputStream();
        o.write(imgData);
        o.flush();        
        o.close();
    } catch (Exception e) {
        out.println("Unable To Display image");
        out.println("Image Display Error=" + e.getMessage());
        return;
    } finally {
        try {
            rs.close();
            stmt.close();
            con.close();
        } catch (SQLException _Ex) {
            System.out.println(_Ex);
        }
    }
%>