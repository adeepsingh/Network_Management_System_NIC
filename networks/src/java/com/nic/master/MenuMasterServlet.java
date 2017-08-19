
package com.nic.master;



import com.nic.utility.GetMastersStatus;
import com.nic.utility.GetMaxCode;
import com.nic.validation.DataConnect;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
public class MenuMasterServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
             
        ResultSet rs = null;
        PreparedStatement stmtU = null,psEdit=null,psDelete=null,psRestore=null;
         String macAdr = "", menuCode = "", userid = "", value = "menuCategory",ipAddress="";
        int serialNumber = 0;
         boolean validate=true,validateEdit=true;   
           HttpSession session = request.getSession();
        try  {
              GetMastersStatus msterstatus=new GetMastersStatus();
             DataConnect utilityAct=new DataConnect();
			Connection con=utilityAct.getConnection();
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
            //------------------Add Menu Start---------------
            
            if(hiddenAction.equals("add")){
               
                 //----------------serial number , code----------------
            GetMaxCode mxc = new GetMaxCode();
            menuCode = mxc.getMaxMenuCode();
            System.out.println("menuCode"+menuCode);
         
        
            /*GetSerialNumber srlnum = new GetSerialNumber();
            serialNumber = srlnum.getMaxSerial(value);*/
           
          
            //---------------------------------------------
           String newmenuNameField = new HTMLFilter().filter(request.getParameter("newmenuNameField"));
            String newmenuActionPathField = new HTMLFilter().filter(request.getParameter("newmenuActionPathField")); 
              String newmenuSubCategoryField = new HTMLFilter().filter(request.getParameter("newmenuSubCategoryField"));   
            String newdisplayOrder = new HTMLFilter().filter(request.getParameter("newdisplayOrder"));
            String newmenuRemarks = new HTMLFilter().filter(request.getParameter("newmenuRemarks"));
            userid = (String) session.getAttribute("userID");
            
            String query1 = " INSERT INTO MASTER_MENU_CATEGORY"
                    + " ( SERIAL_NUMBER,CATEGORY_CODE, CATEGORY_DESCRIPTION, DISPLAY_ORDER, MAC_ADDRESS, IP_ADDRESS, ENTERED_BY ,"
                    + "  ENTERED_ON, ENTERED_REMARKS, RECORD_STATUS,ACTION_PATH,HAS_SUBCATEGORIES ) "
                    + " VALUES (MENU_SEQ_SERIAL_NUMBER.NEXTVAL,?,?, ?,?,?,?, CURRENT_TIMESTAMP,?,?,?,?) "; 
                       
            stmtU = con.prepareStatement(query1);
            // stmtU.setInt(1, serialNumber);
            stmtU.setString(1, menuCode);
             stmtU.setString(2, newmenuNameField);
              stmtU.setString(3, newdisplayOrder);
               stmtU.setString(4, macAdr);
                stmtU.setString(5, ipAddress);
                 stmtU.setString(6, userid);
                  stmtU.setString(7, newmenuRemarks);
                  stmtU.setString(8, "A");
                   stmtU.setString(9, newmenuActionPathField);
                       stmtU.setString(10, newmenuSubCategoryField);
          
            int rsval = stmtU.executeUpdate();
          
               
                JSONObject jsonobj= new JSONObject();
                jsonobj.put("rsval",String.valueOf(rsval));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
             
        }
            //------------------Add Menu End  ---------------
            
            //---------------- Edit Menu Start --------------------
              
            else if(hiddenAction.equals("edit")){
                
                  String menuNameField = new HTMLFilter().filter(request.getParameter("menuNameField"));
             String menuActionPathField = new HTMLFilter().filter(request.getParameter("menuActionPathField"));
               String menuSubCategoryField = new HTMLFilter().filter(request.getParameter("menuSubCategoryField"));
              String menuCodeField = new HTMLFilter().filter(request.getParameter("menuCodeField"));         
             String displayOrder = new HTMLFilter().filter(request.getParameter("displayOrder"));
              String menuRemarks = new HTMLFilter().filter(request.getParameter("menuRemarks"));
             
              
     String  editMenu=" update MASTER_MENU_CATEGORY set CATEGORY_DESCRIPTION=?,ACTION_PATH=?,HAS_SUBCATEGORIES=?, DISPLAY_ORDER=?, "
             + "ENTERED_REMARKS=? where CATEGORY_CODE= ? ";
    
         psEdit =con.prepareStatement(editMenu);
         psEdit.setString(1, menuNameField);
           psEdit.setString(2, menuActionPathField);
            psEdit.setString(3, menuSubCategoryField);
           psEdit.setString(4, displayOrder);
             psEdit.setString(5, menuRemarks);
               psEdit.setString(6, menuCodeField);
         
         psEdit.executeUpdate(); 
         int updateStatus=psEdit.executeUpdate();
        
               
                JSONObject jsonobj= new JSONObject();
                jsonobj.put("updateStatus",String.valueOf(updateStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
               
             }  
             
                 
            //---------------- Edit Menu End ----------------------
            
            
              
               //----------------------Delete Menu Start-----------------------
              if(hiddenAction.equals("delete")){
                  String menuStatus="";
                  int finalStatus=0;
                  String menuCodeDelete = request.getParameter("menuCodeDelete");
                  
                  menuStatus=msterstatus.getMenuStatus(menuCodeDelete);
                  if(menuStatus.equals("D")){
                    
                      finalStatus=2;
                       JSONObject jsonobj= new JSONObject();
                jsonobj.put("finalStatus",String.valueOf(finalStatus));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
                  }else{
                      
             String  deleteMenu=" update MASTER_MENU_CATEGORY set RECORD_STATUS=? "
             + " where CATEGORY_CODE= ? ";     
         psDelete =con.prepareStatement(deleteMenu);
         psDelete.setString(1, "D");
           psDelete.setString(2, menuCodeDelete);           
        
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
                 //----------------------Delete Menu End-----------------------
              
                 //----------------------Restore Menu Start-----------------------
             else if(hiddenAction.equals("restore")){
                 String menuStatusRe="";
                  int finalStatusRe=0;
                  String menuCodeRestore = request.getParameter("menuCodeRestore");
           menuStatusRe=msterstatus.getMenuStatus(menuCodeRestore);
           
                  if(menuStatusRe.equals("A")){
                   
                      finalStatusRe=2;
                       JSONObject jsonobj= new JSONObject();
                jsonobj.put("finalStatusRe",String.valueOf(finalStatusRe));
                PrintWriter out = response.getWriter();
                out.write(jsonobj.toString());
                out.close();
                  }else{
             String  restoreMenu=" update MASTER_MENU_CATEGORY set RECORD_STATUS=? "
             + " where CATEGORY_CODE= ? ";
    
         psRestore =con.prepareStatement(restoreMenu);
         psRestore.setString(1, "A");
           psRestore.setString(2, menuCodeRestore);
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
                 //----------------------Restore Menu End-----------------------
             
             
           
        }
        catch(Exception ex){
            System.out.println("Exception"+ex);
            
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
