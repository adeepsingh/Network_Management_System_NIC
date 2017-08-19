/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nic.utility;

import com.nic.validation.DataConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Manju
 */
public class GetSerialNumber {
    
     public int getMaxSerial(String value)  throws Exception
	{
		
		
                int maxSerial=0;		
		String query = null;
		Connection con=null;
		PreparedStatement	psmnt=null;
		ResultSet	results =null;
	
		
		try{
			DataConnect utilityAct=new DataConnect();
			con=utilityAct.getConnection();
		if(value.equals("state")){
                  query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_STATES";
                    
                }
                if(value.equals("offence")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_CATEGORY_OF_OFFENSE";
                    
                }
                 if(value.equals("purpose")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_PURPOSE";
                    
                }
                  if(value.equals("country")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_COUNTRIES";
                    
                }
                  if(value.equals("district")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_DISTRICTS";
                    
                }
                  if(value.equals("menuCategory")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_MENU_CATEGORY";
                    
                }
                   if(value.equals("menuSubcategory")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_MENU_SUBCATEGORY";
                    
                }
                     if(value.equals("reasonToSender")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_REASON_RETURN_TO_SENDER";
                    
                }
                     if(value.equals("reasonToMHA")){
                     query="select max(SERIAL_NUMBER) as  SERIAL_NUMBER from MASTER_REASON_RETURNED_TO_MHA";
                    
                }
                   
                  
                
              
                
		psmnt = con.prepareStatement(query);
		results = psmnt.executeQuery();
			if(results.next()){
				maxSerial=results.getInt("SERIAL_NUMBER")+1;
				
			}
	  
			}
			catch (Exception e){}
			finally{
				
				if(results!=null) { try{results.close();}catch(Exception e){;}results=null; }
				if(psmnt!=null) { try{psmnt.close();}catch(Exception e){;}psmnt=null; }
				if(con!=null) { try{con.close();}catch(Exception e){;}con=null; }
		   }
			return maxSerial;
		}
    
    
    
    
    
    
}
