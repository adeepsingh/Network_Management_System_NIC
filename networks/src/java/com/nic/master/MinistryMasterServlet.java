package com.nic.master;

import com.nic.utility.GetMastersStatus;
import com.nic.utility.GetMaxCode;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
 *
 * @author Manju
 */
public class MinistryMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ResultSet rs = null;
        PreparedStatement stmtU = null, psEdit = null, psDelete = null, psRestore = null;
        String macAdr = "", ministryCode = "", userid = "", value = "locationSubcategory", ipAddress = "";
        int serialNumber = 0;
        boolean validate = true, validateEdit = true;
        HttpSession session = request.getSession();
        try {
            GetMastersStatus msterstatus = new GetMastersStatus();
            DataConnect utilityAct = new DataConnect();
            Connection con = utilityAct.getConnection();
            //---------------ip and mac------------------------
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

            // -----------------ip and amc end-------------------
            String hiddenAction = new HTMLFilter().filter(request.getParameter("hiddenAction"));
            //------------------Add Ministry Start---------------

            if (hiddenAction.equals("add")) {

                String newministryNameField = new HTMLFilter().filter(request.getParameter("newministryNameField"));
                String newLocationNameField = new HTMLFilter().filter(request.getParameter("newLocationNameField"));
               
                String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
                String newministryRemarks = new HTMLFilter().filter(request.getParameter("newministryRemarks"));
                userid = (String) session.getAttribute("userID");

                //----------------serial number , code----------------
                GetMaxCode mxc = new GetMaxCode();
                ministryCode = mxc.getMaxMinistryCode();

                /*GetSerialNumber srlnum = new GetSerialNumber();
            serialNumber = srlnum.getMaxSerial(value);*/
                //---------------------------------------------
                String query1 = " INSERT INTO MASTER_USER_MINISTRY"
                        + " ( SERIAL_NUMBER,LOCATION_CODE,CODE, DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                        + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS ) "
                        + " VALUES (MINISTRY_SEQ_SERIAL_NUMBER.NEXTVAL,?,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?) ";

                stmtU = con.prepareStatement(query1);
                // stmtU.setInt(1, serialNumber);
                stmtU.setString(1, newLocationNameField);
                stmtU.setString(2, ministryCode);
                stmtU.setString(3, newministryNameField);
                stmtU.setString(4, newdisplayOrder);
                stmtU.setString(5, macAdr);
                stmtU.setString(6, ipAddress);
                stmtU.setString(7, userid);
                stmtU.setString(8, newministryRemarks);
                stmtU.setString(9, "A");
               

                int rsval = stmtU.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("rsval", String.valueOf(rsval));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            } //------------------Add Ministry End  ---------------
            //---------------- Edit Ministry Start --------------------
            else if (hiddenAction.equals("edit")) {
                String locationCodeField = new HTMLFilter().filter(request.getParameter("locationCodeField"));
                String ministryNameField = new HTMLFilter().filter(request.getParameter("ministryNameField"));             
                String ministryCodeField = new HTMLFilter().filter(request.getParameter("ministryCodeField"));

                String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
                String ministryRemarks = new HTMLFilter().filter(request.getParameter("ministryRemarks"));

                String editMinistry = " update MASTER_USER_MINISTRY set DESCRIPTION=?, DISPLAY_ORDER=?, "
                        + "ENTERED_REMARKS=?,LOCATION_CODE=? where CODE= ? ";

                psEdit = con.prepareStatement(editMinistry);
                psEdit.setString(1, ministryNameField);              
                psEdit.setString(2, displayOrder);
                psEdit.setString(3, ministryRemarks);
                psEdit.setString(4, locationCodeField);
                psEdit.setString(5, ministryCodeField);

                psEdit.executeUpdate();
                int updateStatus = psEdit.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("updateStatus", String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            }

            //---------------- Edit Ministry End ----------------------
            //----------------------Delete Ministry Start-----------------------
            if (hiddenAction.equals("delete")) {
                String ministryStatus = "";
                int finalStatus = 0;
                String ministryCodeDelete = request.getParameter("ministryCodeDelete");

                ministryStatus = msterstatus.getMinistryStatus(ministryCodeDelete);
                if (ministryStatus.equals("D")) {

                    finalStatus = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatus", String.valueOf(finalStatus));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {

                    String deleteMinistry = " update MASTER_USER_MINISTRY set RECORD_STATUS=? "
                            + " where CODE= ? ";
                    psDelete = con.prepareStatement(deleteMinistry);
                    psDelete.setString(1, "D");
                    psDelete.setString(2, ministryCodeDelete);

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

            } //----------------------Delete Ministry End-----------------------
            //----------------------Restore Ministry Start-----------------------
            else if (hiddenAction.equals("restore")) {
                String ministryStatusRe = "";
                int finalStatusRe = 0;
                String ministryCodeRestore = request.getParameter("ministryCodeRestore");
                ministryStatusRe = msterstatus.getMinistryStatus(ministryCodeRestore);

                if (ministryStatusRe.equals("A")) {

                    finalStatusRe = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatusRe", String.valueOf(finalStatusRe));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String restoreMinistry = " update MASTER_USER_MINISTRY set RECORD_STATUS=? "
                            + " where CODE= ? ";

                    psRestore = con.prepareStatement(restoreMinistry);
                    psRestore.setString(1, "A");
                    psRestore.setString(2, ministryCodeRestore);
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
            //----------------------Restore Ministry End-----------------------

        } catch (Exception ex) {
            System.out.println("Exception" + ex);

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
