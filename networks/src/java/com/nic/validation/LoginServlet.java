package com.nic.validation;

import com.nic.form.validation.Login_validations;
import com.nic.utility.RandomSaltGenerator;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.xsshtmlfilter.HTMLFilter;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
            throws ServletException, IOException, NoSuchAlgorithmException {

        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        String md5Password = "";
        String csrf = new HTMLFilter().filter((String) session.getAttribute("csrf_secureToken"));
        String secureToken = new HTMLFilter().filter(request.getParameter("secureToken"));
        String new_secure = new HTMLFilter().filter(RandomSaltGenerator.generateSalt());
        request.getSession().setAttribute("csrf_secureToken", new_secure);
        request.setAttribute("secureToken", new_secure);
        if (csrf != null && secureToken != null) {
            if (csrf.equals(secureToken)) {
                Login_validations validate = new Login_validations();
                boolean status = validate.validations(request, response);
                if (status) {
                    Connection con = null;
                    ResultSet rs = null;
                    PreparedStatement stmtU = null;
                    try {
                        con = DataConnect.getConnection();
                        String Username = new HTMLFilter().filter(request.getParameter("username"));
                        System.out.println(Username);
                        String opwd = new HTMLFilter().filter(request.getParameter("password"));
                        final String LoginSuccess = "view/homepage.jsp";
                        final String LoginFailed = "index.jsp";
                        final String FirstLogin = "view/changePassword.jsp";
                        String redirectLogin = LoginFailed;
                        String captcha = (String) session.getAttribute("captcha");

                        String code = (String) request.getParameter("code");
                        if (captcha != null && code != null) {
                            if (captcha.equals(code)) {

                                if (Username != null) {
                                    byte[] dataBuffer = opwd.getBytes();
                                    byte[] theDigest = digestIt(dataBuffer);
                                    md5Password = toHexString(theDigest);
                                    String stmt = "SELECT * FROM USER_TABLE WHERE USER_CODE=? AND RECORD_STATUS = 'A'";
                                    stmtU = con.prepareStatement(stmt);
                                    stmtU.setString(1, Username.trim());
                                    rs = stmtU.executeQuery();
                                    boolean rs_isNotEmpty = rs.next();
                                    if (rs_isNotEmpty && md5Password.equals(rs.getString("CURRENT_PASSWORD"))) {
                                        session.invalidate();
                                        session = request.getSession();
                                        session.setAttribute("userID", Username);
                                        session.setAttribute("login_name", rs.getString("USER_NAME"));
                                        session.setAttribute("user_role", rs.getString("USER_ROLE"));
                                        session.setAttribute("locationCode", rs.getString("LOCATION_CODE"));
                                        session.setAttribute("login_user_designation", rs.getString("DESIGNATION_CODE"));
                                        if (rs.getString("RECORD_STATUS").equals("A")) {
                                            redirectLogin = LoginSuccess;
                                        } else {
                                            redirectLogin = FirstLogin;
                                        }
                                        Date date = new Date();
                                        System.out.println("\nLOGIN DETAILS - " + request.getParameter("username") + date.toString());
                                        session.setAttribute("Username", Username);
                                        session.setMaxInactiveInterval(30 * 60);

                                        rs.close();
                                        con.close();
                                        response.sendRedirect(response.encodeRedirectURL(redirectLogin));
                                    } else {
                                        request.setAttribute("viram", "Invalid UserID/Password");
                                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/LoginPageDisplay");
                                        rd.include(request, response);
                                    }
                                } else {
                                    request.setAttribute("viram", "Invalid UserID/Password");
                                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/LoginPageDisplay");
                                    rd.include(request, response);
                                }

                            } else {
                                request.setAttribute("viram", "Invalid Security Code");
                                RequestDispatcher rd = getServletContext().getRequestDispatcher("/LoginPageDisplay");
                                rd.include(request, response);
                            }
                        }
                    } catch (Exception _EX) {
                        System.out.println(_EX);
                        request.setAttribute("viram", "Invalid UserID/Password");
                        RequestDispatcher rd = getServletContext().getRequestDispatcher("/LoginPageDisplay");
                        rd.include(request, response);
                    } finally {
                        if (rs != null) {
                            try {
                                rs.close();
                            } catch (SQLException _EX) {
                                System.out.println(_EX);
                            }
                        }
                        if (stmtU != null) {
                            try {
                                stmtU.close();
                            } catch (SQLException _EX) {
                                System.out.println(_EX);
                            }
                        }
                        if (con != null) {
                            try {
                                con.close();
                            } catch (SQLException _EX) {
                                System.out.println(_EX);
                            }
                        }

                    }
                } else {

                    request.setAttribute("viram", "Validation Error!!");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("./view/index.jsp");
                    rd.forward(request, response);
                }
            }
        } else {
            request.setAttribute("viram", "Some Unexpected Error Occured.");
            RequestDispatcher rd = getServletContext().getRequestDispatcher("./view/index.jsp");
            rd.forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
