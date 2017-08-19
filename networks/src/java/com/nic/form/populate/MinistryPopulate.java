package com.nic.form.populate;

import com.nic.validation.DataConnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class MinistryPopulate {
    public Map<String,String> getMinistryList() throws SQLException, IOException { 
       Map<String,String> ministryList = new TreeMap<String,String>();
       
       Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtFloor = null;
        ResultSet rstSetFloor = null;
        try {
            pstmtFloor = connection.prepareStatement("SELECT * from MASTER_USER_MINISTRY WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetFloor = pstmtFloor.executeQuery();
            while (rstSetFloor.next()) {
                ministryList.put(rstSetFloor.getString("CODE"), rstSetFloor.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetFloor != null) {
                rstSetFloor.close();
            }
            if (pstmtFloor != null) {
                pstmtFloor.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetFloor != null) {
                rstSetFloor.close();
            }
            if (pstmtFloor != null) {
                pstmtFloor.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
       
       return ministryList;
   } 
}
