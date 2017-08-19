package com.nic.master;

import com.nic.utility.GetMastersStatus;
import com.nic.utility.GetMaxCode;
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
import com.nic.utility.MacAdr;

/**
 * @author Manju
 */
public class LocationMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmtU = null, psEdit = null, psDelete = null, psRestore = null;
        String macAdr = "", locationCode = "", userid = "", value = "location", ipAddress = "";
        int serialNumber = 0;
        boolean validate = true, validateEdit = true;
        HttpSession session = request.getSession();
        DataConnect utilityAct = new DataConnect();
        Connection con = utilityAct.getConnection();
        try {
            GetMastersStatus msterstatus = new GetMastersStatus();
            ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
            try {
                MacAdr ma = new MacAdr();
                macAdr = (ma.getMac(ipAddress));
            } catch (Exception e) {
                System.out.println("ERRRR -- " + e);
            }
            String hiddenAction = new HTMLFilter().filter(request.getParameter("hiddenAction"));
            if (hiddenAction.equals("add")) {
                boolean validateAdd = true;
                GetMaxCode mxc = new GetMaxCode();
                locationCode = mxc.getMaxLocationCode();
                String newlocationNameField = new HTMLFilter().filter(request.getParameter("newlocationNameField"));
                String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
                String newlocationRemarks = new HTMLFilter().filter(request.getParameter("newlocationRemarks"));
                userid = (String) session.getAttribute("userID");
                if (newlocationNameField == null || newlocationNameField.equals("")) {
                    validateAdd = false;
                }
                if (newdisplayOrder == null || newdisplayOrder.equals("")) {
                    validateAdd = false;
                }
                if (newlocationRemarks == null || newlocationRemarks.equals("")) {
                    validateAdd = false;
                }

                if (validateAdd) {

                    String query1 = " INSERT INTO MASTER_LOCATION"
                            + " ( SERIAL_NUMBER,CODE, DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                            + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS ) "
                            + " VALUES (LOCATION_SEQ_SERIAL_NUMBER.NEXTVAL,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?) ";

                    stmtU = con.prepareStatement(query1);
                    stmtU.setString(1, locationCode);
                    stmtU.setString(2, newlocationNameField);
                    stmtU.setString(3, newdisplayOrder);
                    stmtU.setString(4, macAdr);
                    stmtU.setString(5, ipAddress);
                    stmtU.setString(6, userid);
                    stmtU.setString(7, newlocationRemarks);
                    stmtU.setString(8, "A");

                    int rsval = stmtU.executeUpdate();

                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("rsval", String.valueOf(rsval));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {

                    request.setAttribute("error", "Server Validation Error!!");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/locationMaster.jsp");
                    rd.forward(request, response);
                }

            } else if (hiddenAction.equals("edit")) {

                String locationNameField = new HTMLFilter().filter(request.getParameter("locationNameField"));
                String locationCodeField = new HTMLFilter().filter(request.getParameter("locationCodeField"));

                String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
                String locationRemarks = new HTMLFilter().filter(request.getParameter("locationRemarks"));

                String editOffence = " update MASTER_LOCATION set DESCRIPTION=?, DISPLAY_ORDER=?, "
                        + "ENTERED_REMARKS=? where CODE= ? ";

                psEdit = con.prepareStatement(editOffence);
                psEdit.setString(1, locationNameField);
                psEdit.setString(2, displayOrder);
                psEdit.setString(3, locationRemarks);
                psEdit.setString(4, locationCodeField);

                psEdit.executeUpdate();
                int updateStatus = psEdit.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("updateStatus", String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            }

            if (hiddenAction.equals("delete")) {
                String locationStatus = "";
                int finalStatus = 0;
                String locationCodeDelete = request.getParameter("locationCodeDelete");

                locationStatus = msterstatus.getLocationStatus(locationCodeDelete);
                if (locationStatus.equals("D")) {

                    finalStatus = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatus", String.valueOf(finalStatus));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String deleteLocation = " update MASTER_LOCATION set RECORD_STATUS=? "
                            + " where CODE= ? ";
                    psDelete = con.prepareStatement(deleteLocation);
                    psDelete.setString(1, "D");
                    psDelete.setString(2, locationCodeDelete);

                    int deleteStatus = psDelete.executeUpdate();

                    if (deleteStatus >= 1) {
                        finalStatus = 1;
                        JSONObject jsonobj = new JSONObject();
                        jsonobj.put("finalStatus", String.valueOf(finalStatus));

                        PrintWriter out = response.getWriter();
                        out.write(jsonobj.toString());
                        out.close();

                    }
                }
            } else if (hiddenAction.equals("restore")) {
                String locationStatusRe = "";
                int finalStatusRe = 0;
                String locationCodeRestore = request.getParameter("locationCodeRestore");
                locationStatusRe = msterstatus.getLocationStatus(locationCodeRestore);

                if (locationStatusRe.equals("A")) {

                    finalStatusRe = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatusRe", String.valueOf(finalStatusRe));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String restoreLocation = " update MASTER_LOCATION set RECORD_STATUS=? "
                            + " where CODE= ? ";

                    psRestore = con.prepareStatement(restoreLocation);
                    psRestore.setString(1, "A");
                    psRestore.setString(2, locationCodeRestore);

                    int restoreStatus = psRestore.executeUpdate();
                    if (restoreStatus >= 1) {
                        finalStatusRe = 1;
                        JSONObject jsonobj = new JSONObject();
                        jsonobj.put("finalStatusRe", String.valueOf(finalStatusRe));

                        PrintWriter out = response.getWriter();
                        out.write(jsonobj.toString());
                        out.close();
                    }
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
                    Logger.getLogger(LocationMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
