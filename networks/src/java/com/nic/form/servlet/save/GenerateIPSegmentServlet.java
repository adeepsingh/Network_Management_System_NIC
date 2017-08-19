
package com.nic.form.servlet.save;

import com.nic.utility.MacAdr;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
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

/** *
 * @author Rajesh Sharma
 */
public class GenerateIPSegmentServlet extends HttpServlet {
 protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        Connection connect = null;
        try{
            HttpSession session = request.getSession();
        String csrf = new HTMLFilter().filter((String) session.getAttribute("csrf_secureToken"));
        String locationCode = new HTMLFilter().filter((String) session.getAttribute("locationCode"));
        String secureToken = new HTMLFilter().filter(request.getParameter("secureToken"));
        String macAdr = "";
        String ipPool = new HTMLFilter().filter(request.getParameter("ipPool"));
        connect = DataConnect.getConnection();
        
            String userID = new HTMLFilter().filter((String)request.getSession(false).getAttribute("Username"));
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
            connect.setAutoCommit(false);
            String querySegment = "INSERT INTO ASSIGNED_SEGMENTS(SEGMENT,MAC_ADDRESS,IP_ADDRESS,ENTERED_BY,ENTERED_ON,ENTERED_REMARKS,LOCATION_CODE)"
                    + " VALUES(?,?,?,?,CURRENT_TIMESTAMP,?,?)"; 
            
            PreparedStatement pstmt = connect.prepareStatement(querySegment);
            pstmt.setString(1, ipPool);
            pstmt.setString(2, macAdr);
            pstmt.setString(3, ipAddress);
            pstmt.setString(4, userID);
            pstmt.setString(5, "OK.");
            pstmt.setString(6, locationCode);
            int checkInsert = pstmt.executeUpdate(); 

            if(checkInsert>0){
                String queryPool = "INSERT INTO IP_POOL(IP_ADDRESS,LOCATION_CODE) VALUES(?,?)"; 
            PreparedStatement pstmtPool = connect.prepareStatement(queryPool);
            for(int i=1;i<=254;i++){
            pstmtPool.setString(1, "10.25."+ipPool+"."+String.valueOf(i));
            pstmtPool.setString(2, locationCode);
            pstmtPool.executeUpdate(); 
            connect.commit();
            }
            } else {
                connect.rollback();
                if(connect != null)try {
                connect.close();
            } catch (SQLException ex) {
                Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
                request.setAttribute("message", "Ip Poll Segment has not been saved!");
            request.getRequestDispatcher("./IpPoolAssign.jsp").forward(request, response);
            }
           /* response.setHeader("Pragma", "No-cache");
            response.setHeader("Cache-Control", "no-cache");
            response.setDateHeader("Expires", 1); */
            if(connect != null)try {
                connect.close();
            } catch (SQLException ex) {
                Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("message", "Ip Poll Segment has been saved!");
            request.getRequestDispatcher("./IpPoolAssign.jsp").forward(request, response);
            
        }catch (SQLException _EX) {
            try {
                connect.rollback();
                if(connect != null)try {
                    connect.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                System.out.println("SQLException :: "+_EX);
                request.setAttribute("message", "Ip Poll Segment has not been saved!");
                request.getRequestDispatcher("./IpPoolAssign.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
        } catch (IOException _EX) {
            try {
                connect.rollback();
                if(connect != null)try {
                    connect.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                System.out.println("IOException ::"+_EX);
                request.setAttribute("message", "Error Occur to Save the Form!");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/IpPoolAssign.jsp");
                rd.forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } catch (Exception _EX) {
            try {
                connect.rollback();
                if(connect != null)try {
                    connect.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                System.out.println("IOException ::"+_EX);
                request.setAttribute("message", "Error Occur to Save the Form!");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/IpPoolAssign.jsp");
                rd.forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } finally {
            if(connect != null)try {
                connect.close();
            } catch (SQLException ex) {
                Logger.getLogger(GenerateIPSegmentServlet.class.getName()).log(Level.SEVERE, null, ex);
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
