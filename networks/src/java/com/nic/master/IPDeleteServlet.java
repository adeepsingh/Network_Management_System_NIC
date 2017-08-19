package com.nic.master;

import com.nic.utility.GetMastersStatus;
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
import net.sf.xsshtmlfilter.HTMLFilter;
import org.json.JSONObject;

public class IPDeleteServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        DataConnect utilityAct = new DataConnect();
        Connection con = utilityAct.getConnection();
        PreparedStatement ipDelete = null;
        try {
            String ipAssignStatus = "";
            int finalStatus = 0;
            String userID = new HTMLFilter().filter((String) request.getSession(false).getAttribute("Username"));
            GetMastersStatus msterstatus = new GetMastersStatus();
            String ipaddress = request.getParameter("ipAddress");
            String location = request.getParameter("locationn");

            String userName = request.getParameter("userName");
            String ipAddress1 = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress1 == null) {
                ipAddress1 = request.getRemoteAddr();
            }
            String macAdr = "";
            try {
                MacAdr ma = new MacAdr();
                macAdr = (ma.getMac(ipAddress1));
            } catch (Exception e) {
                System.out.println("ERRRR -- " + e);
            }
            ipAssignStatus = msterstatus.getIPAssignStatus(ipaddress, location, userName);
            if (ipAssignStatus.equals("D")) {

                finalStatus = 2;
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("finalStatus", String.valueOf(finalStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
            } else {
//             String  deleteIPAssign=" update IP_ADDRESS set RECORD_STATUS=? "
//             + " where USER_IP_ADDRESS=? and LOCATION=? and USER_NAME=? ";
                String deleteIPAssign = "UPDATE IP_ADDRESS SET "
                        + "ENTERED_BY = ?, "
                        + "ENTERED_ON = ?, "
                        + "FLAG = 'D', "
                        + "RECORD_STATUS = 'D', "
                        + "IP_ADDRESS = ?, "
                        + "MAC_ADDRESS = ? "
                        + "WHERE USER_IP_ADDRESS = ? and LOCATION = ? ";
                con.setAutoCommit(false);
                ipDelete = con.prepareStatement(deleteIPAssign);
                
                ipDelete.setString(1, userID);
                ipDelete.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
                ipDelete.setString(3, ipAddress1);
                ipDelete.setString(4, macAdr);
                ipDelete.setString(5, ipaddress);
                ipDelete.setString(6, location);
                int deleteStatus = ipDelete.executeUpdate();

                if (deleteStatus >= 1) {
                    deleteIPAssign = "DELETE FROM IP_ADDRESS "
                            + "WHERE USER_IP_ADDRESS = ? and LOCATION = ? ";
                ipDelete = con.prepareStatement(deleteIPAssign);
                ipDelete.setString(1, ipaddress);
                ipDelete.setString(2, location);
                deleteStatus = ipDelete.executeUpdate();
            }

            if (deleteStatus >= 1) {
                con.commit();
                finalStatus = 1;
                JSONObject jsonobj = new JSONObject();
                jsonobj.put("finalStatus", String.valueOf(finalStatus));

                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();

            } else {
                con.rollback();
            }
        }
    }
    catch (Exception ex

    
        ) {
            System.out.println("Exception" + ex);

    }

    
        finally {
            System.out.println("In finally block");
        if (con != null) {
            try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(FloorMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
