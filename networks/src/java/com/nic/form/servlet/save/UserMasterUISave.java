package com.nic.form.servlet.save;

import com.nic.utility.MacAdr;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.io.InputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Random;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import net.sf.xsshtmlfilter.HTMLFilter;

public class UserMasterUISave extends HttpServlet {

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
        HttpSession session = request.getSession();
        String csrf = new HTMLFilter().filter((String) session.getAttribute("csrf_secureToken"));
        String secureToken = new HTMLFilter().filter(request.getParameter("secureToken"));
        String macAdr = "";

        String userCode = "";
        String userName = new HTMLFilter().filter(request.getParameter("userName"));
        String userGender = new HTMLFilter().filter(request.getParameter("userGender"));
        String userDOB = new HTMLFilter().filter(request.getParameter("userDOB"));
        String designationCode = new HTMLFilter().filter(request.getParameter("designationCode"));
        String contactNo = new HTMLFilter().filter(request.getParameter("contactNo"));
        String locationCode = new HTMLFilter().filter(request.getParameter("locationCode"));
        String email = new HTMLFilter().filter(request.getParameter("email"));
        String userRoleCode = new HTMLFilter().filter(request.getParameter("userRoleCode"));
        String remarks = new HTMLFilter().filter(request.getParameter("remarks"));
        String userPass = new HTMLFilter().filter(request.getParameter("userPass"));
        byte[] dataBufferNew = userPass.getBytes();
        byte[] theDigestNew = digestIt(dataBufferNew);
        userPass = toHexString(theDigestNew);
        
        InputStream inputStream = null; // input stream of the upload file

        // obtains the upload file part in this multipart request
        Part filePart = request.getPart("profileImage");
        if (filePart != null) {
            // prints out some information for debugging
//            System.out.println(filePart.getName());
//            System.out.println(filePart.getSize());
//            System.out.println(filePart.getContentType());

            // obtains input stream of the upload file
            inputStream = filePart.getInputStream();
        }

        Connection connect = DataConnect.getConnection(); // connection to the database
        String message = null;  // message will be sent back to client

        try {
            String computerNumber = getComputerNumber(locationCode).trim();
            StringBuffer ss1 = new StringBuffer(computerNumber);
            while (ss1.length() < 3) {
                ss1.insert(0, '0');
            }
            computerNumber = ss1.toString();
            userCode = locationCode + userRoleCode + computerNumber;
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

            // constructs SQL statement
            String sql = "INSERT INTO USER_TABLE (SERIAL_NUMBER, USER_CODE, USER_NAME, GENDER_CODE, "
                    + "DATE_OF_BIRTH, DESIGNATION_CODE, JOIN_DATE, EMAIL_ID, CONTACT_TELEPHONE, USER_PHOTOGRAPH, "
                    + "MAC_ADDRESS,CREATED_BY,CREATED_DATE,CREATED_REMARKS,CURRENT_PASSWORD_DATE,"
                    + "ACTIVE_SINCE, HEAD_USER,LOCATION_CODE,USER_ROLE,CURRENT_PASSWORD) VALUES (USER_TABLE_SEQ.NEXTVAL,?, ?, ?,"
                    + "TO_DATE(?,'dd/MM/yyyy'),?,CURRENT_TIMESTAMP,?,?,?,"
                    + "?,?,CURRENT_TIMESTAMP,?,CURRENT_TIMESTAMP,"
                    + "CURRENT_TIMESTAMP,?,?,?,?)";
            PreparedStatement statement = connect.prepareStatement(sql);
            statement.setString(1, userCode);
            statement.setString(2, userName);
            statement.setString(3, userGender);
            statement.setString(4, userDOB);
            statement.setString(5, designationCode);
            statement.setString(6, email);
            statement.setString(7, contactNo);
            if (inputStream != null) {
                // fetches input stream of the upload file for the blob column
                statement.setBlob(8, inputStream);
            }
            statement.setString(9, macAdr);
            statement.setString(10, userID);
            statement.setString(11, remarks);
            statement.setString(12, userID);
            statement.setString(13, locationCode);
            statement.setString(14, userRoleCode);
            statement.setString(15, userPass);

            // sends the statement to the database server
            int row = statement.executeUpdate();
            if (row > 0) {
                message = "User Created Successfully. User ID is ";
            }
        } catch (SQLException ex) {
            message = "ERROR: " + ex.getMessage();
            ex.printStackTrace();
        } finally {
            if (connect != null) {
                // closes the database connection
                try {
                    connect.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
            // sets the message in request scope
            request.setAttribute("message", message + " :: " + userCode);

            // forwards to the message page
            //getServletContext().getRequestDispatcher("/view/resultForm.jsp").forward(request, response);
            response.sendRedirect("./resultForm.jsp?message=" + message + " :: " + userCode);
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
    String getComputerNumber(String locationID) throws SQLException {
        Calendar now = Calendar.getInstance();
        int year = now.get(Calendar.YEAR);
        String code = null;
        Connection conCount = null;
        PreparedStatement pstCount = null;
        ResultSet rstCount = null;
        try {
            conCount = DataConnect.getConnection();
            String query = "SELECT NVL(MAX(CAST(SUBSTR(USER_CODE, 5, 3) AS NUMBER)),0) AS VALUE FROM USER_TABLE WHERE LOCATION_CODE =" + locationID;
            pstCount = conCount.prepareStatement(query);
            rstCount = pstCount.executeQuery();
            if (rstCount.next()) {
                code = String.valueOf(rstCount.getInt("VALUE") + 1);
            }
        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            if (rstCount != null) {
                try {
                    rstCount.close();
                } catch (SQLException _EX) {
                    System.out.println(_EX);
                }
            }
            if (pstCount != null) {
                try {
                    pstCount.close();
                } catch (SQLException _EX) {
                    System.out.println(_EX);
                }
            }
            if (conCount != null) {
                try {
                    conCount.close();
                } catch (SQLException _EX) {
                    System.out.println(_EX);
                }
            }
        }
        return code;
    }

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
