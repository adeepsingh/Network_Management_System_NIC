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
public class SubmenuMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ResultSet rs = null;
        PreparedStatement stmtU = null, psEdit = null, psDelete = null, psRestore = null;
        String macAdr = "", submenuCode = "", userid = "", value = "menuSubcategory", ipAddress = "";
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
            //------------------Add Submenu Start---------------

            if (hiddenAction.equals("add")) {

                String newsubmenuNameField = new HTMLFilter().filter(request.getParameter("newsubmenuNameField"));
                String newMenuNameField = new HTMLFilter().filter(request.getParameter("newMenuNameField"));
                String newsubmenuActionPathField = new HTMLFilter().filter(request.getParameter("newsubmenuActionPathField"));
                String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
                String newsubmenuRemarks = new HTMLFilter().filter(request.getParameter("newsubmenuRemarks"));
                userid = (String) session.getAttribute("userID");

                //----------------serial number , code----------------
                GetMaxCode mxc = new GetMaxCode();
                submenuCode = mxc.getMaxSubmenuCode(newMenuNameField);

                /*GetSerialNumber srlnum = new GetSerialNumber();
            serialNumber = srlnum.getMaxSerial(value);*/
                //---------------------------------------------
                String query1 = " INSERT INTO MASTER_MENU_SUBCATEGORY"
                        + " ( SERIAL_NUMBER,CATEGORY_CODE,SUBCATEGORY_CODE, SUBCATEGORY_DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                        + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS,ACTION_PATH ) "
                        + " VALUES (SUBMENU_SEQ_SERIAL_NUMBER.NEXTVAL,?,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?,?) ";

                stmtU = con.prepareStatement(query1);
                // stmtU.setInt(1, serialNumber);
                stmtU.setString(1, newMenuNameField);
                stmtU.setString(2, submenuCode);
                stmtU.setString(3, newsubmenuNameField);
                stmtU.setString(4, newdisplayOrder);
                stmtU.setString(5, macAdr);
                stmtU.setString(6, ipAddress);
                stmtU.setString(7, userid);
                stmtU.setString(8, newsubmenuRemarks);
                stmtU.setString(9, "A");
                stmtU.setString(10, newsubmenuActionPathField);

                int rsval = stmtU.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("rsval", String.valueOf(rsval));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            } //------------------Add Submenu End  ---------------
            //---------------- Edit Submenu Start --------------------
            else if (hiddenAction.equals("edit")) {
                String menuCodeField = new HTMLFilter().filter(request.getParameter("menuCodeField"));
                String submenuNameField = new HTMLFilter().filter(request.getParameter("submenuNameField"));
                String submenuActionPathField = new HTMLFilter().filter(request.getParameter("submenuActionPathField"));
                String submenuCodeField = new HTMLFilter().filter(request.getParameter("submenuCodeField"));

                String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
                String submenuRemarks = new HTMLFilter().filter(request.getParameter("submenuRemarks"));

                String editSubmenu = " update MASTER_MENU_SUBCATEGORY set SUBCATEGORY_DESCRIPTION=?,ACTION_PATH=?, DISPLAY_ORDER=?, "
                        + "ENTERED_REMARKS=?,CATEGORY_CODE=? where SUBCATEGORY_CODE= ? ";

                psEdit = con.prepareStatement(editSubmenu);
                psEdit.setString(1, submenuNameField);
                psEdit.setString(2, submenuActionPathField);
                psEdit.setString(3, displayOrder);
                psEdit.setString(4, submenuRemarks);
                psEdit.setString(5, menuCodeField);
                psEdit.setString(6, submenuCodeField);

                psEdit.executeUpdate();
                int updateStatus = psEdit.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("updateStatus", String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            }

            //---------------- Edit Submenu End ----------------------
            //----------------------Delete Submenu Start-----------------------
            if (hiddenAction.equals("delete")) {
                String submenuStatus = "";
                int finalStatus = 0;
                String submenuCodeDelete = request.getParameter("submenuCodeDelete");

                submenuStatus = msterstatus.getSubmenuStatus(submenuCodeDelete);
                if (submenuStatus.equals("D")) {

                    finalStatus = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatus", String.valueOf(finalStatus));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {

                    String deleteSubmenu = " update MASTER_MENU_SUBCATEGORY set RECORD_STATUS=? "
                            + " where SUBCATEGORY_CODE= ? ";
                    psDelete = con.prepareStatement(deleteSubmenu);
                    psDelete.setString(1, "D");
                    psDelete.setString(2, submenuCodeDelete);

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

            } //----------------------Delete Submenu End-----------------------
            //----------------------Restore Submenu Start-----------------------
            else if (hiddenAction.equals("restore")) {
                String submenuStatusRe = "";
                int finalStatusRe = 0;
                String submenuCodeRestore = request.getParameter("submenuCodeRestore");
                submenuStatusRe = msterstatus.getSubmenuStatus(submenuCodeRestore);

                if (submenuStatusRe.equals("A")) {

                    finalStatusRe = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatusRe", String.valueOf(finalStatusRe));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String restoreSubmenu = " update MASTER_MENU_SUBCATEGORY set RECORD_STATUS=? "
                            + " where SUBCATEGORY_CODE= ? ";

                    psRestore = con.prepareStatement(restoreSubmenu);
                    psRestore.setString(1, "A");
                    psRestore.setString(2, submenuCodeRestore);
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
            //----------------------Restore Submenu End-----------------------

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
