package com.nic.form.populate;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class GetMinistryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    Connection connection = null;
    PreparedStatement pstmtMinistry = null;
    ResultSet rstSetMinistry = null;
    String json = "Please Get The Key";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String locationCode = request.getParameter("locationCode");
        Map<String, String> ministry = new TreeMap<String, String>();
        try {
            connection = com.nic.validation.DataConnect.getConnection();
            pstmtMinistry = connection.prepareStatement("SELECT * FROM MASTER_USER_MINISTRY WHERE LOCATION_CODE = ? AND RECORD_STATUS = ? ORDER BY DESCRIPTION");
            pstmtMinistry.setString(1, locationCode);
            pstmtMinistry.setString(2, "A");
            rstSetMinistry = pstmtMinistry.executeQuery();
            while (rstSetMinistry.next()) {
                ministry.put(rstSetMinistry.getString("CODE"), rstSetMinistry.getString("DESCRIPTION"));
            }
            
        } catch (Exception _Ex) {
            System.out.println("Error Here..GetMinistryServlet.." + _Ex);
        } finally {
            if (rstSetMinistry != null) {
                try {
                    rstSetMinistry.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GetMinistryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (pstmtMinistry != null) {
                try {
                    pstmtMinistry.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GetMinistryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
            if (connection != null) {
                try {
                    connection.close();
                } catch (SQLException ex) {
                    Logger.getLogger(GetMinistryServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
        Gson gson = new GsonBuilder().create();
        json = gson.toJson(ministry);
        response.setContentType("application/json");
        response.getWriter().write(json);
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
