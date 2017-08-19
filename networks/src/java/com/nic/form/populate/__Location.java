/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.nic.form.populate;

import com.nic.validation.DataConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class __Location {
     Connection connection;
    private PreparedStatement psmnt;
    private ResultSet results;

    public Map<String,String> getMenuCode() throws Exception {        
        Map<String, String> menuCode = new TreeMap<String, String>();
        try {
            connection = DataConnect.getConnection();
            String query = "SELECT CODE,DESCRIPTION FROM MASTER_LOCATION "
                    + "WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION";
            psmnt = connection.prepareStatement(query);
            results = psmnt.executeQuery();
            while (results.next()) {
               menuCode.put(results.getString("CODE"), results.getString("DESCRIPTION"));
            }
        } catch (SQLException _EX) {
            System.out.println("Exception - Country.java - "+_EX);                    
        } finally {
            if (results != null) {
                results.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return menuCode;
    }
    
}
