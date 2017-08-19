package com.nic.master;

//import com.google.gson.JsonObject;
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
 *
 * @author Manju
 */
public class AssessMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        System.out.println(" In AssessMasterServlet -- ");
        System.out.println(" newassessNameField 1 " + request.getParameter("newassessNameField"));
        //Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmtU = null, psEdit = null, psDelete = null, psRestore = null;
        String macAdr = "", assessCode = "", userid = "", value = "assess", ipAddress = "";
        int serialNumber = 0;
        boolean validate = true, validateEdit = true;
        HttpSession session = request.getSession();
        DataConnect utilityAct = new DataConnect();
        Connection con = utilityAct.getConnection();
        try {
            GetMastersStatus msterstatus = new GetMastersStatus();

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
            //------------------Add Assess Start---------------

            if (hiddenAction.equals("add")) {
                boolean validateAdd = true;
                //----------------serial number , code----------------
                GetMaxCode mxc = new GetMaxCode();
                assessCode = mxc.getMaxAssessCode();

//        
//            GetSerialNumber srlnum = new GetSerialNumber();
//            serialNumber = srlnum.getMaxSerial(value);
//           
                //---------------------------------------------
                String newassessNameField = new HTMLFilter().filter(request.getParameter("newassessNameField"));
                String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
                String newassessRemarks = new HTMLFilter().filter(request.getParameter("newassessRemarks"));
                userid = (String) session.getAttribute("userID");
                if (newassessNameField == null || newassessNameField.equals("")) {
                    validateAdd = false;
                }
                if (newdisplayOrder == null || newdisplayOrder.equals("")) {
                    validateAdd = false;
                }
                if (newassessRemarks == null || newassessRemarks.equals("")) {
                    validateAdd = false;
                }

                if (validateAdd) {

                    String query1 = " INSERT INTO MASTER_ASSESS_LEVEL"
                            + " ( SERIAL_NUMBER,CODE, DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                            + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS ) "
                            + " VALUES (ASSESS_LEVEL_SEQ_SERIAL_NUMBER.NEXTVAL,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?) ";

                    stmtU = con.prepareStatement(query1);
                    //  stmtU.setInt(1, serialNumber);
                    stmtU.setString(1, assessCode);
                    stmtU.setString(2, newassessNameField);
                    stmtU.setString(3, newdisplayOrder);
                    stmtU.setString(4, macAdr);
                    stmtU.setString(5, ipAddress);
                    stmtU.setString(6, userid);
                    stmtU.setString(7, newassessRemarks);
                    stmtU.setString(8, "A");

                    int rsval = stmtU.executeUpdate();

                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("rsval", String.valueOf(rsval));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {

                    request.setAttribute("error", "Server Validation Error!!");
                    RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/assessMaster.jsp");
                    rd.forward(request, response);
                }

            } //------------------Add Assess End  ---------------
            //---------------- Edit Assess Start --------------------
            else if (hiddenAction.equals("edit")) {

                String assessNameField = new HTMLFilter().filter(request.getParameter("assessNameField"));
                String assessCodeField = new HTMLFilter().filter(request.getParameter("assessCodeField"));

                String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
                String assessRemarks = new HTMLFilter().filter(request.getParameter("assessRemarks"));

                String editOffence = " update MASTER_ASSESS_LEVEL set DESCRIPTION=?, DISPLAY_ORDER=?, "
                        + "ENTERED_REMARKS=? where CODE= ? ";

                psEdit = con.prepareStatement(editOffence);
                psEdit.setString(1, assessNameField);
                psEdit.setString(2, displayOrder);
                psEdit.setString(3, assessRemarks);
                psEdit.setString(4, assessCodeField);

                psEdit.executeUpdate();
                int updateStatus = psEdit.executeUpdate();

                JSONObject jsonobj = new JSONObject();
                jsonobj.put("updateStatus", String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            }

            //---------------- Edit Assess End ----------------------
            //----------------------Delete Assess Start-----------------------
            if (hiddenAction.equals("delete")) {
                String assessStatus = "";
                int finalStatus = 0;
                String assessCodeDelete = request.getParameter("assessCodeDelete");

                assessStatus = msterstatus.getAssessStatus(assessCodeDelete);
                if (assessStatus.equals("D")) {

                    finalStatus = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatus", String.valueOf(finalStatus));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String deleteAssess = " update MASTER_ASSESS_LEVEL set RECORD_STATUS=? "
                            + " where CODE= ? ";
                    psDelete = con.prepareStatement(deleteAssess);
                    psDelete.setString(1, "D");
                    psDelete.setString(2, assessCodeDelete);

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
            } //----------------------Delete Assess End-----------------------
            //----------------------Restore Assess Start-----------------------
            else if (hiddenAction.equals("restore")) {
                String assessStatusRe = "";
                int finalStatusRe = 0;
                String assessCodeRestore = request.getParameter("assessCodeRestore");
                assessStatusRe = msterstatus.getAssessStatus(assessCodeRestore);

                if (assessStatusRe.equals("A")) {

                    finalStatusRe = 2;
                    JSONObject jsonobj = new JSONObject();
                    jsonobj.put("finalStatusRe", String.valueOf(finalStatusRe));
                    PrintWriter out = response.getWriter();
                    out.write(jsonobj.toString());
                    out.close();
                } else {
                    String restoreAssess = " update MASTER_ASSESS_LEVEL set RECORD_STATUS=? "
                            + " where CODE= ? ";

                    psRestore = con.prepareStatement(restoreAssess);
                    psRestore.setString(1, "A");
                    psRestore.setString(2, assessCodeRestore);

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
            //----------------------Restore Assess End-----------------------

        } catch (Exception ex) {
            System.out.println("Exception" + ex);

        } finally {
            System.out.println("In finally block");
            if (con != null) {
                try {
                    con.close();
                } catch (SQLException ex) {
                    Logger.getLogger(AssessMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
