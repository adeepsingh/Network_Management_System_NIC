
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
public class DeviceMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
         System.out.println(" In DeviceMasterServlet -- ");
            System.out.println(" newdeviceNameField 1 "+request.getParameter("newdeviceNameField"));
         //Connection con = null;
        ResultSet rs = null;
        PreparedStatement stmtU = null,psEdit=null,psDelete=null,psRestore=null;
         String macAdr = "", deviceCode = "", userid = "", value = "device",ipAddress="";
        int serialNumber = 0;
         boolean validate=true,validateEdit=true;   
           HttpSession session = request.getSession();
             DataConnect utilityAct=new DataConnect();
			Connection con=utilityAct.getConnection();
        try  {
            GetMastersStatus msterstatus=new GetMastersStatus();
           
            //---------------ip and mac------------------------
             ipAddress = request.getHeader("X-FORWARDED-FOR");
            if (ipAddress == null) {
                ipAddress = request.getRemoteAddr();
            }
           
              try{					   
		    MacAdr ma = new MacAdr();
						   
		macAdr=(ma.getMac(ipAddress));
						   
		}catch(Exception e){
		 System.out.println("ERRRR -- "+e);
		}            
            
            // -----------------ip and amc end-------------------
              String hiddenAction = new HTMLFilter().filter(request.getParameter("hiddenAction"));
            //------------------Add Device Start---------------
            
            if(hiddenAction.equals("add")){
               boolean validateAdd=true;
                 //----------------serial number , code----------------
            GetMaxCode mxc = new GetMaxCode();
            deviceCode = mxc.getMaxDeviceCode();
         
//        
//            GetSerialNumber srlnum = new GetSerialNumber();
//            serialNumber = srlnum.getMaxSerial(value);
//           
          
            //---------------------------------------------
           String newdeviceNameField = new HTMLFilter().filter(request.getParameter("newdeviceNameField"));
            String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
            String newdeviceRemarks = new HTMLFilter().filter(request.getParameter("newdeviceRemarks"));
            userid = (String) session.getAttribute("userID");
              if (newdeviceNameField == null || newdeviceNameField.equals("")) {
            validateAdd=false;
        }
        if (newdisplayOrder == null || newdisplayOrder.equals("")) {
            validateAdd= false;
        }
         if (newdeviceRemarks == null || newdeviceRemarks.equals("")) {
            validateAdd= false;
        }
            
               if(validateAdd){           
            
            
            String query1 = " INSERT INTO MASTER_DEVICE_TYPE"
                    + " ( SERIAL_NUMBER,CODE, DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                    + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS ) "
                    + " VALUES (DEVICE_TYPE_SEQ_SERIAL_NUMBER.NEXTVAL,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?) "; 
                       
            stmtU = con.prepareStatement(query1);
           //  stmtU.setInt(1, serialNumber);
            stmtU.setString(1, deviceCode);
             stmtU.setString(2, newdeviceNameField);
              stmtU.setString(3, newdisplayOrder);
               stmtU.setString(4, macAdr);
                stmtU.setString(5, ipAddress);
                 stmtU.setString(6, userid);
                  stmtU.setString(7, newdeviceRemarks);
                  stmtU.setString(8, "A");
          
            int rsval = stmtU.executeUpdate();
          
                JSONObject jsonobj= new JSONObject();
                jsonobj.put("rsval",String.valueOf(rsval));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
               }else{
                  
                    request.setAttribute("error", "Server Validation Error!!");
                RequestDispatcher rd = getServletContext().getRequestDispatcher("/view/deviceMaster.jsp");
                rd.forward(request, response);
               }
             
        }
            //------------------Add Device End  ---------------
            
            //---------------- Edit Device Start --------------------
              
            else if(hiddenAction.equals("edit")){
                
                  String deviceNameField = new HTMLFilter().filter(request.getParameter("deviceNameField"));
             String deviceCodeField = new HTMLFilter().filter(request.getParameter("deviceCodeField"));
         
             String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
              String deviceRemarks = new HTMLFilter().filter(request.getParameter("deviceRemarks"));
             
              
     String  editOffence=" update MASTER_DEVICE_TYPE set DESCRIPTION=?, DISPLAY_ORDER=?, "
             + "ENTERED_REMARKS=? where CODE= ? ";
    
         psEdit =con.prepareStatement(editOffence);
         psEdit.setString(1, deviceNameField);
           psEdit.setString(2, displayOrder);
             psEdit.setString(3, deviceRemarks);
               psEdit.setString(4, deviceCodeField);
         
         psEdit.executeUpdate(); 
         int updateStatus=psEdit.executeUpdate();
        
               
                JSONObject jsonobj= new JSONObject();
                jsonobj.put("updateStatus",String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
               
             }  
             
                 
            //---------------- Edit Device End ----------------------
            
            
              
               //----------------------Delete Device Start-----------------------
              if(hiddenAction.equals("delete")){  
                   String deviceStatus="";
                  int finalStatus=0;
                  String deviceCodeDelete = request.getParameter("deviceCodeDelete"); 
                     
                  deviceStatus=msterstatus.getDeviceStatus(deviceCodeDelete);
                  if(deviceStatus.equals("D")){
                    
                      finalStatus=2;
                       JSONObject jsonobj= new JSONObject();
                jsonobj.put("finalStatus",String.valueOf(finalStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
                  }else{
             String  deleteDevice=" update MASTER_DEVICE_TYPE set RECORD_STATUS=? "
             + " where CODE= ? ";     
         psDelete =con.prepareStatement(deleteDevice);
         psDelete.setString(1, "D");
           psDelete.setString(2, deviceCodeDelete);           
        
         int deleteStatus=psDelete.executeUpdate();
        
         if(deleteStatus>=1){             
              finalStatus=1;
                JSONObject jsonobj= new JSONObject();
                jsonobj.put("finalStatus",String.valueOf(finalStatus));
                
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
 
         } 
                  }
             }
                 //----------------------Delete Device End-----------------------
              
                 //----------------------Restore Device Start-----------------------
             else if(hiddenAction.equals("restore")){
                 String deviceStatusRe="";
                  int finalStatusRe=0;
                  String deviceCodeRestore = request.getParameter("deviceCodeRestore");
            deviceStatusRe=msterstatus.getDeviceStatus(deviceCodeRestore);
           
                  if(deviceStatusRe.equals("A")){
                   
                      finalStatusRe=2;
                       JSONObject jsonobj= new JSONObject();
                jsonobj.put("finalStatusRe",String.valueOf(finalStatusRe));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
                  }else{
             String  restoreDevice=" update MASTER_DEVICE_TYPE set RECORD_STATUS=? "
             + " where CODE= ? ";
    
         psRestore =con.prepareStatement(restoreDevice);
         psRestore.setString(1, "A");
           psRestore.setString(2, deviceCodeRestore);
            
         
        int restoreStatus= psRestore.executeUpdate(); 
          if(restoreStatus>=1){
             finalStatusRe=1;
                JSONObject jsonobj= new JSONObject();
                jsonobj.put("finalStatusRe",String.valueOf(finalStatusRe));
                
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
         }
                  }
             }
                 //----------------------Restore Device End-----------------------
             
             
           
        }
        catch(Exception ex){
            System.out.println("Exception"+ex);
            
        }
        finally{
            System.out.println("In finally block");
            if(con != null)try {
                con.close();
            } catch (SQLException ex) {
                Logger.getLogger(DeviceMasterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
