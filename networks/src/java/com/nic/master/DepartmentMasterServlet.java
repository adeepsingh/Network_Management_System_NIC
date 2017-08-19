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
 * @author amar0_000
 */
public class DepartmentMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        ResultSet rs = null;
        PreparedStatement stmtU = null, psEdit = null, psDelete = null, psRestore = null;
        String macAdr = "", departmentCode = "", userid = "", value = "ministrySubcategory", ipAddress = "";
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
            //------------------Add Department Start---------------

            if (hiddenAction.equals("add")) {

                String newdepartmentNameField = new HTMLFilter().filter(request.getParameter("newdepartmentNameField"));
                String newMinistryNameField = new HTMLFilter().filter(request.getParameter("newMinistryNameField"));
               
                String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
                String newdepartmentRemarks = new HTMLFilter().filter(request.getParameter("newdepartmentRemarks"));
                userid = (String) session.getAttribute("userID");

                //----------------serial number , code----------------
                GetMaxCode mxc = new GetMaxCode();
                departmentCode = mxc.getMaxDepartmentCode();

                /*GetSerialNumber srlnum = new GetSerialNumber();
            serialNumber = srlnum.getMaxSerial(value);*/
                //---------------------------------------------
                String query1 = " INSERT INTO MASTER_USER_DEPARTMENT"
                        + " ( SERIAL_NUMBER,MINISTRY_CODE,CODE, DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                        + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS ) "
                        + " VALUES (DEPARTMENT_SEQ_SERIAL_NUMBER.NEXTVAL,?,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?) ";

                stmtU = con.prepareStatement(query1);
                // stmtU.setInt(1, serialNumber);
                stmtU.setString(1, newMinistryNameField);
                stmtU.setString(2, departmentCode);
                stmtU.setString(3, newdepartmentNameField);
                stmtU.setString(4, newdisplayOrder);
                stmtU.setString(5, macAdr);
                stmtU.setString(6, ipAddress);
                stmtU.setString(7, userid);
                stmtU.setString(8, newdepartmentRemarks);
                stmtU.setString(9, "A");
               

                int rsval = stmtU.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("rsval", String.valueOf(rsval));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            } //------------------Add Department End  ---------------
            //---------------- Edit Department Start --------------------
            else if (hiddenAction.equals("edit")) {
                String ministryCodeField = new HTMLFilter().filter(request.getParameter("ministryCodeField"));
                String departmentNameField = new HTMLFilter().filter(request.getParameter("departmentNameField"));             
                String departmentCodeField = new HTMLFilter().filter(request.getParameter("departmentCodeField"));

                String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
                String departmentRemarks = new HTMLFilter().filter(request.getParameter("departmentRemarks"));

                String editDepartment = " update MASTER_USER_DEPARTMENT set DESCRIPTION=?, DISPLAY_ORDER=?, "
                        + "ENTERED_REMARKS=?,MINISTRY_CODE=? where CODE= ? ";

                psEdit = con.prepareStatement(editDepartment);
                psEdit.setString(1, departmentNameField);              
                psEdit.setString(2, displayOrder);
                psEdit.setString(3, departmentRemarks);
                psEdit.setString(4, ministryCodeField);
                psEdit.setString(5, departmentCodeField);

                psEdit.executeUpdate();
                int updateStatus = psEdit.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("updateStatus", String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            }

            //---------------- Edit Department End ----------------------
            //----------------------Delete Department Start-----------------------
            if (hiddenAction.equals("delete")) {
                String departmentStatus = "";
                int finalStatus = 0;
                String departmentCodeDelete = request.getParameter("departmentCodeDelete");

                departmentStatus = msterstatus.getDepartmentStatus(departmentCodeDelete);
                if (departmentStatus.equals("D")) {

                    finalStatus = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatus", String.valueOf(finalStatus));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {

                    String deleteDepartment = " update MASTER_USER_DEPARTMENT set RECORD_STATUS=? "
                            + " where CODE= ? ";
                    psDelete = con.prepareStatement(deleteDepartment);
                    psDelete.setString(1, "D");
                    psDelete.setString(2, departmentCodeDelete);

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

            } //----------------------Delete Department End-----------------------
            //----------------------Restore Department Start-----------------------
            else if (hiddenAction.equals("restore")) {
                String departmentStatusRe = "";
                int finalStatusRe = 0;
                String departmentCodeRestore = request.getParameter("departmentCodeRestore");
                departmentStatusRe = msterstatus.getDepartmentStatus(departmentCodeRestore);

                if (departmentStatusRe.equals("A")) {

                    finalStatusRe = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatusRe", String.valueOf(finalStatusRe));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String restoreDepartment = " update MASTER_USER_DEPARTMENT set RECORD_STATUS=? "
                            + " where CODE= ? ";

                    psRestore = con.prepareStatement(restoreDepartment);
                    psRestore.setString(1, "A");
                    psRestore.setString(2, departmentCodeRestore);
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
            //----------------------Restore Department End-----------------------

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
