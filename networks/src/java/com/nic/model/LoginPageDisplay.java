package com.nic.model;

import com.nic.utility.RandomSaltGenerator;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.security.NoSuchAlgorithmException;
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
import net.sf.xsshtmlfilter.HTMLFilter;

/**
 * @author Pawan Arora
 */
public class LoginPageDisplay extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException {
        HTMLFilter filter = new HTMLFilter();

        String secureToken = filter.filter(RandomSaltGenerator.generateSalt());
        String salt = filter.filter(RandomSaltGenerator.generateSalt());
        Connection connect = null;
        ResultSet resultSets = null;
        try {            
            connect = DataConnect.getConnection();
            String query = "SELECT SYSDATE FROM DUAL";
            PreparedStatement preparedStatement = connect.prepareStatement(query);
            resultSets = preparedStatement.executeQuery();
            if (resultSets.next()) {
                System.out.println("Connection Ok.");
                request.getSession().setAttribute("csrf_secureToken", secureToken);
                request.getSession().setAttribute("salt", salt);

                request.setAttribute("secureToken", secureToken);
                request.setAttribute("salt", salt);
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/loginExtradite.jsp");
                rd.forward(request, response);
            }
        } catch (Exception _EX) {
            System.out.println("Exception - Connection Refused - "+_EX);
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginPageDisplay.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(LoginPageDisplay.class.getName()).log(Level.SEVERE, null, ex);
        }
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