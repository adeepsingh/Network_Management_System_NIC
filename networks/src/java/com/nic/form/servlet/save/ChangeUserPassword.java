package com.nic.form.servlet.save;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.xsshtmlfilter.HTMLFilter;

import com.nic.utility.MacAdr;
import com.nic.validation.DataConnect;

public class ChangeUserPassword extends HttpServlet {

    private static final long serialVersionUID = 1L;

    public String getOldPassword(String oldPass, String userid, String location) {
        String msg = "NOTMATCHED";
        Connection connectOld = null;
        ResultSet checkInsert = null;
        try {
            connectOld = DataConnect.getConnection();
            String query = "SELECT * FROM  USER_TABLE WHERE CURRENT_PASSWORD = ? AND USER_CODE = ? AND LOCATION_CODE = ? ";

            PreparedStatement pstmtOld = connectOld.prepareStatement(query);
            pstmtOld.setString(1, oldPass);
            pstmtOld.setString(2, userid);
            pstmtOld.setString(3, location);
            checkInsert = pstmtOld.executeQuery();
            if (checkInsert.next()) {
                msg = "MATCHED";
            }
        } catch (Exception _EX) {
            System.out.println(_EX);
        } finally {
            if (checkInsert != null) {
                try {
                    checkInsert.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
            if (connectOld != null) {
                try {
                    connectOld.close();
                } catch (SQLException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }

        return msg;
    }

    public int generateIntSalt() {
        Random r = new Random();
        int salt = r.nextInt();
        return salt;
    }
    char[] hexChar = {
        '0', '1', '2', '3',
        '4', '5', '6', '7',
        '8', '9', 'a', 'b',
        'c', 'd', 'e', 'f'
    };

    public String toHexString(byte[] b) {
        StringBuilder sb = new StringBuilder(b.length * 2);
        for (int i = 0; i < b.length; i++) {
            sb.append(hexChar[(b[i] & 0xf0) >>> 4]);
            sb.append(hexChar[b[i] & 0x0f]);
        }
        return sb.toString();
    }

    byte[] digestIt(byte[] dataIn) {
        byte[] theDigest = null;
        try {
            MessageDigest messageDigest = MessageDigest.getInstance("MD5");
            messageDigest.reset();
            messageDigest.update(dataIn);
            theDigest = messageDigest.digest();
        } catch (NoSuchAlgorithmException e) {
            System.out.println(e);
        }
        return theDigest;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection connect = null;
        String infoMessage = "";
        String md5Password = "";
        HttpSession session = request.getSession();
        try {
            String csrf = new HTMLFilter().filter((String) session.getAttribute("csrf_secureToken"));
            String locationCode = new HTMLFilter().filter((String) session.getAttribute("locationCode"));
            String confirmPassword = new HTMLFilter().filter(request.getParameter("confirmPassword"));
            String oldPassword = new HTMLFilter().filter(request.getParameter("oldPassword"));
            String newPassword = new HTMLFilter().filter(request.getParameter("newPassword"));
            String macAdr = "";
            connect = DataConnect.getConnection();

            String userID = new HTMLFilter().filter((String) request.getSession(false).getAttribute("Username"));
            String ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
            try {
                MacAdr ma = new MacAdr();
                macAdr = (ma.getMac(ipAddress));
            } catch (Exception e) {
                System.out.println("ERRRR -- " + e);
            }

            byte[] dataBuffer = oldPassword.getBytes();
            byte[] theDigest = digestIt(dataBuffer);
            md5Password = toHexString(theDigest);
            String checkOldPass = getOldPassword(md5Password, userID, locationCode);
            if (checkOldPass.equals("MATCHED")) {
                if (confirmPassword.equals(newPassword) == false) {
                    String msg = confirmPassword + "::" + newPassword;
                    request.setAttribute("message", "New and Confirm Password Does not Matched!" + msg);
                    request.getRequestDispatcher("./changePassword.jsp").forward(request, response);
                } else {
                    byte[] dataBufferNew = newPassword.getBytes();
                    byte[] theDigestNew = digestIt(dataBufferNew);
                    String md5PasswordNew = toHexString(theDigestNew);
                    String querySegment = "UPDATE USER_TABLE SET CURRENT_PASSWORD = ?,CURRENT_PASSWORD_DATE = ? WHERE USER_CODE = ? AND LOCATION_CODE = ?";

                    PreparedStatement pstmt = connect.prepareStatement(querySegment);
                    pstmt.setString(1, md5PasswordNew);
                    pstmt.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                    pstmt.setString(3, userID);
                    pstmt.setString(4, locationCode);
                    pstmt.executeUpdate();

                    session.setAttribute("page", "./changePassword.jsp");
                    session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Password has been saved!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
                    response.sendRedirect("./changePassword.jsp");
                }

            } else {
                session.setAttribute("page", "./changePassword.jsp");
                session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Old Password doesn't matched!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
                response.sendRedirect("./changePassword.jsp");
            }

        } catch (SQLException _EX) {
            try {
                connect.rollback();
                if (connect != null) {
                    try {
                        connect.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(ChangeUserPassword.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                System.out.println("SQLException :: " + _EX);
                session.setAttribute("page", "./changePassword.jsp");
                session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Password has not been saved!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
                response.sendRedirect("./changePassword.jsp");
            } catch (SQLException ex) {
                Logger.getLogger(ChangeUserPassword.class.getName()).log(Level.SEVERE, null, ex);
            }

        } catch (Exception _EX) {
            try {
                connect.rollback();
                if (connect != null) {
                    try {
                        connect.close();
                    } catch (SQLException ex) {
                        Logger.getLogger(ChangeUserPassword.class.getName()).log(Level.SEVERE, null, ex);
                    }
                }
                System.out.println("IOException ::" + _EX);
                session.setAttribute("page", "./changePassword.jsp");
                session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Error Occur to Save the Password!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
                response.sendRedirect("./changePassword.jsp");
            } catch (SQLException ex) {
                Logger.getLogger(ChangeUserPassword.class.getName()).log(Level.SEVERE, null, ex);
            }
        } finally {
            if (connect != null) {
                try {
                    connect.close();
                } catch (SQLException ex) {
                    Logger.getLogger(ChangeUserPassword.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
