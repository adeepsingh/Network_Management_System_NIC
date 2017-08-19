package com.nic.master;

//import com.google.gson.JsonObject;
import com.nic.utility.GetMastersStatus;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.xsshtmlfilter.HTMLFilter;
import org.json.JSONObject;

/**
 *
 * @author Manju
 */
public class MainFormServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        //Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmtU = null, psEdit = null, psDelete = null, psRestore = null;

        int serialNumber = 0;
        boolean validate = true, validateEdit = true;
        HttpSession session = request.getSession();
        DataConnect utilityAct = new DataConnect();
        Connection con = utilityAct.getConnection();
        try {
            GetMastersStatus msterstatus = new GetMastersStatus();

            String hiddenAction = new HTMLFilter().filter(request.getParameter("submit"));

            if (hiddenAction.equals("true")) {
                boolean validateAdd = true;

                //----------------serial number , code----------------
//        
//            GetSerialNumber srlnum = new GetSerialNumber();
//            serialNumber = srlnum.getMaxSerial(value);
//           
                //---------------------------------------------
                String userName = new HTMLFilter().filter(request.getParameter("userName"));
                String userDepartment = new HTMLFilter().filter(request.getParameter("userDepartment"));
                String userSection = new HTMLFilter().filter(request.getParameter("userSection"));
                String userDesignation = new HTMLFilter().filter(request.getParameter("userDesignation"));
                String userIp = new HTMLFilter().filter(request.getParameter("userIp"));
                String userMac = new HTMLFilter().filter(request.getParameter("userMac"));
                String userEmployment = new HTMLFilter().filter(request.getParameter("userEmployment"));
                String floor = new HTMLFilter().filter(request.getParameter("floor"));
                String location = new HTMLFilter().filter(request.getParameter("location"));
                String deviceType = new HTMLFilter().filter(request.getParameter("deviceType"));
                String deviceIp = new HTMLFilter().filter(request.getParameter("deviceIp"));
                String deviceMac = new HTMLFilter().filter(request.getParameter("deviceMac"));
                String enteredBy = new HTMLFilter().filter(request.getParameter("enteredBy"));
                String enteredOn = new HTMLFilter().filter(request.getParameter("enteredOn"));
                String remarks = new HTMLFilter().filter(request.getParameter("remarks"));
                String recordStatus = new HTMLFilter().filter(request.getParameter("recordStatus"));
                String assessLevel = new HTMLFilter().filter(request.getParameter("assessLevel"));
                String contactNumber = new HTMLFilter().filter(request.getParameter("contactNumber"));
                String intercom = new HTMLFilter().filter(request.getParameter("intercom"));
                String email = new HTMLFilter().filter(request.getParameter("email"));
                String userMinistry = new HTMLFilter().filter(request.getParameter("userMinistry"));
                String empCode = new HTMLFilter().filter(request.getParameter("empCode"));
                String activation = new HTMLFilter().filter(request.getParameter("activation"));
                String deactivation = new HTMLFilter().filter(request.getParameter("deactivation"));
                String wing = new HTMLFilter().filter(request.getParameter("wing"));

                if (userName == null || userName.equals("")) {
                    validateAdd = false;
                }
                if (userDepartment == null || userDepartment.equals("")) {
                    validateAdd = false;
                }
                if (userSection == null || userSection.equals("")) {
                    validateAdd = false;
                }
                if (userDesignation == null || userDesignation.equals("")) {
                    validateAdd = false;
                }
                if (userIp == null || userIp.equals("")) {
                    validateAdd = false;
                }
                if (userMac == null || userMac.equals("")) {
                    validateAdd = false;
                }
                if (userEmployment == null || userEmployment.equals("")) {
                    validateAdd = false;
                }
                if (floor == null || floor.equals("")) {
                    validateAdd = false;
                }
                if (location == null || location.equals("")) {
                    validateAdd = false;
                }
                if (deviceType == null || deviceType.equals("")) {
                    validateAdd = false;
                }
                if (deviceIp == null || deviceIp.equals("")) {
                    validateAdd = false;
                }
                if (deviceMac == null || deviceMac.equals("")) {
                    validateAdd = false;
                }
                if (enteredBy == null || enteredBy.equals("")) {
                    validateAdd = false;
                }
                if (enteredOn == null || enteredOn.equals("")) {
                    validateAdd = false;
                }
                if (remarks == null || remarks.equals("")) {
                    validateAdd = false;
                }
                if (recordStatus == null || recordStatus.equals("")) {
                    validateAdd = false;
                }
                if (assessLevel == null || assessLevel.equals("")) {
                    validateAdd = false;
                }
                if (contactNumber == null || contactNumber.equals("")) {
                    validateAdd = false;
                }
                if (intercom == null || intercom.equals("")) {
                    validateAdd = false;
                }
                if (email == null || email.equals("")) {
                    validateAdd = false;
                }
                if (userMinistry == null || userMinistry.equals("")) {
                    validateAdd = false;
                }
                if (empCode == null || empCode.equals("")) {
                    validateAdd = false;
                }
                if (activation == null || activation.equals("")) {
                    validateAdd = false;
                }
                if (deactivation == null || deactivation.equals("")) {
                    validateAdd = false;
                }
                if (wing == null || wing.equals("")) {
                    validateAdd = false;
                }

                if (validateAdd) {

                    String query1 = " INSERT INTO MAIN_FORM"
                            + " ( SERIAL_NUMBER,USER_NAME,USER_DEPARTMENT,USER_SECTION,USER_DESIGNATION,USER_IP_ADDRESS,USER_MAC_ADDRESS,"
                            + "  USER_EMPLOYMENT_TYPE,FLOOR,LOCATION,DEVICE_TYPE,DEVICE_IP_ADDRESS,DEVICE_MAC_ADDRESS,ENTERED_BT ,ENTERED_ON"
                            + "  REMARKS,RECORD_STATUS,ASSESS_LEVEL,CONTACT_NUMBER,INTERCOM,EMAIL_ID,USER_MINISTRY,EMPLOYEE_CODE,"
                            + "  ACTIVATION_DATE,DEACTIVATION_DATE,WING ) "
                            + " VALUES (MAIN_FORM_SEQ_SERIAL_NUMBER.NEXTVAL,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?) ";

                    stmtU = con.prepareStatement(query1);
                    //  stmtU.setInt(1, serialNumber);
                    stmtU.setString(1, userName);
                    stmtU.setString(2, userDepartment);
                    stmtU.setString(3, userSection);
                    stmtU.setString(4, userDesignation);
                    stmtU.setString(5, userIp);
                    stmtU.setString(6, userMac);
                    stmtU.setString(7, userEmployment);
                    stmtU.setString(8, floor);
                    stmtU.setString(9, location);
                    stmtU.setString(10, deviceType);
                    stmtU.setString(11, deviceIp);
                    stmtU.setString(12, deviceMac);
                    stmtU.setString(13, enteredBy);
                    stmtU.setString(14, enteredOn);
                    stmtU.setString(15, remarks);
                    stmtU.setString(16, recordStatus);
                    stmtU.setString(17, assessLevel);
                    stmtU.setString(18, contactNumber);
                    stmtU.setString(19, intercom);
                    stmtU.setString(20, email);
                    stmtU.setString(21, userMinistry);
                    stmtU.setString(22, empCode);
                    stmtU.setString(23, activation);
                    stmtU.setString(24, deactivation);
                    stmtU.setString(25, wing);

                    int rsval = stmtU.executeUpdate();

                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("rsval", String.valueOf(rsval));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {

                    request.setAttribute("error", "Server Validation Error!!");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/mainForm.jsp");
                    rd.forward(request, response);
                }

            }

        } catch (Exception ex) {
            System.out.println("Exception" + ex);

        } finally {
            System.out.println("In finally block");
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(MainFormServlet.class.getName()).log(Level.SEVERE, null, ex);
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
