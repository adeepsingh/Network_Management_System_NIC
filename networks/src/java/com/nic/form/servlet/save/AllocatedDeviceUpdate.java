package com.nic.form.servlet.save;

import com.nic.utility.MacAdr;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.xsshtmlfilter.HTMLFilter;

public class AllocatedDeviceUpdate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();
        String csrf = new HTMLFilter().filter((String) session.getAttribute("csrf_secureToken"));
        String secureToken = new HTMLFilter().filter(request.getParameter("secureToken"));
        String macAdr = "";
        String name = new HTMLFilter().filter(request.getParameter("name"));
        String ministryCode = new HTMLFilter().filter(request.getParameter("ministryCode"));
        String locationCode = new HTMLFilter().filter(request.getParameter("locationCode"));
        String departmentCode = new HTMLFilter().filter(request.getParameter("departmentCode"));
        String floorCode = new HTMLFilter().filter(request.getParameter("floorCode"));
        String sectionCode = new HTMLFilter().filter(request.getParameter("sectionCode"));
        String designationCode = new HTMLFilter().filter(request.getParameter("designationCode"));
        String empCode = new HTMLFilter().filter(request.getParameter("empCode"));
        String contactNo = new HTMLFilter().filter(request.getParameter("contactNo"));
        String InterComm = new HTMLFilter().filter(request.getParameter("InterComm"));
        String email = new HTMLFilter().filter(request.getParameter("email"));
        String employeeTypeCode = new HTMLFilter().filter(request.getParameter("employeeTypeCode"));
        String userIpAddress = new HTMLFilter().filter(request.getParameter("ipAddress"));
        String macAddress = new HTMLFilter().filter(request.getParameter("macAddress"));
        String deviceTypeCode = new HTMLFilter().filter(request.getParameter("deviceTypeCode"));
        String assessLevelCode = new HTMLFilter().filter(request.getParameter("assessLevelCode"));
        String activationDate = new HTMLFilter().filter(request.getParameter("activationDate"));
        String remarks = new HTMLFilter().filter(request.getParameter("remarks"));
        String deactivationDate = new HTMLFilter().filter(request.getParameter("deactivationDate"));
        String ramCode = new HTMLFilter().filter(request.getParameter("ramCode"));
        String antiVirusCode = new HTMLFilter().filter(request.getParameter("antiVirusCode"));
        String osCode = new HTMLFilter().filter(request.getParameter("osCode"));
        Connection connect = DataConnect.getConnection();
        try {
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
            StringBuilder ss1 = new StringBuilder(deviceTypeCode);
            while (ss1.length() < 2) {
                ss1.insert(0, '0');
            }
            deviceTypeCode = ss1.toString();
            if (!"01".equals(deviceTypeCode)) {
                ramCode = "";
                antiVirusCode = "";
                osCode = "";
            }
            String queryrenewal = "UPDATE IP_ADDRESS SET "
                    + "USER_NAME = ?, "
                    + "USER_DEPARTMENT=?, "
                    + "USER_SECTION=?, "
                    + "USER_DESIGNATION=?, "
                    + "USER_MAC_ADDRESS=?, "
                    + "USER_EMPLOYMENT_TYPE=?, "
                    + "FLOOR=?, "
                    + "LOCATION=?, "
                    + "DEVICE_TYPE=?, "
                    + "MAC_ADDRESS=?, "
                    + "ENTERED_BY=?, "
                    + "ENTERED_REMARKS=?, "
                    + "ENTERED_ON=?, "
                    + "ACCESS_LEVEL=?, "
                    + "CONTACT_NUMBER=?, "
                    + "INTERCOM=?, "
                    + "EMAIL_ID=?, "
                    + "USER_MINISTRY=?, "
                    + "EMPLOYEE_CODE=?, "
                    + "ACTIVATION_DATE=TO_TIMESTAMP(?,'dd/MM/yyyy'), "
                    + "DEACTIVATION_DATE=TO_TIMESTAMP(?,'dd/MM/yyyy'), "
                    + "MACHINE_OS=?, "
                    + "MACHINE_RAM=?, "
                    + "MACHINE_ANTIVIRUS=?, "
                    + "FLAG = 'U', "
                    + "IP_ADDRESS = ?"
                    + " WHERE USER_IP_ADDRESS = ? AND LOCATION = ? AND RECORD_STATUS='A'";

            PreparedStatement pstmt = connect.prepareStatement(queryrenewal);
            pstmt.setString(1, name);
            pstmt.setString(2, departmentCode);
            pstmt.setString(3, sectionCode);
            pstmt.setString(4, designationCode);
            pstmt.setString(5, macAddress);
            pstmt.setString(6, employeeTypeCode);
            pstmt.setString(7, floorCode);
            pstmt.setString(8, locationCode);
            pstmt.setString(9, deviceTypeCode);
            pstmt.setString(10, macAdr);
            pstmt.setString(11, userID);
            pstmt.setString(12, remarks);
            pstmt.setTimestamp(13, new Timestamp(System.currentTimeMillis()));
            pstmt.setString(14, assessLevelCode);
            pstmt.setString(15, contactNo);
            pstmt.setString(16, InterComm);
            pstmt.setString(17, email);
            pstmt.setString(18, ministryCode);
            pstmt.setString(19, empCode);
            pstmt.setString(20, activationDate);
            pstmt.setString(21, deactivationDate);
            pstmt.setString(22, osCode);
            pstmt.setString(23, ramCode);
            pstmt.setString(24, antiVirusCode);
            pstmt.setString(25, ipAddress);
            pstmt.setString(26, userIpAddress);
            pstmt.setString(27, locationCode);            
            pstmt.executeUpdate();

//            request.setAttribute("message", "IP Address Updated Successfully!");
//            request.getRequestDispatcher("./successful.jsp").forward(request, response);
            session.setAttribute("page", "./ippoolAssignUpdateModule.jsp");
            session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Record Updated Successfully!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
            response.sendRedirect("./ippoolAssignUpdateModule.jsp");

        } catch (SQLException _EX) {
//            System.out.println("SQLException :: " + _EX);
//            request.setAttribute("message", "IP Address Not Updated!");
//            request.setAttribute("page", "./ippoolAssignUpdateModule.jsp");
            session.setAttribute("page", "./ippoolAssignUpdateModule.jsp");
            session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Record Not Updated!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
            response.sendRedirect("./ippoolAssignUpdateModule.jsp");
//            request.getRequestDispatcher("./ipPoolAssignUpdate.jsp").forward(request, response);

        } catch (IOException _EX) {
            session.setAttribute("page", "./ippoolAssignUpdateModule.jsp");
            session.setAttribute("message", "<div id=\"message\" width=\"50%\"><div class=\"alert alert-success\">Record Not Updated!<button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-hidden=\"true\">×</button></div> </div>");
            response.sendRedirect("./ippoolAssignUpdateModule.jsp");
            
//            System.out.println("IOException ::" + _EX);
//            request.setAttribute("error", "");
//            RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/ipPoolAssignUpdate.jsp");
//            rd.forward(request, response);
        } finally {
            if (connect != null) {
                try {
                    connect.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AllocatedDeviceUpdate.class.getName()).log(Level.SEVERE, null, ex);
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
