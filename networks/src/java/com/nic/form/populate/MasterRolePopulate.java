package com.nic.form.populate;

import com.nic.validation.DataConnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

/** *
 * @author Rajesh Sharma
 */
public class MasterRolePopulate {
     public Map<String,String> getMasterRoleList() throws SQLException, IOException { 
       Map<String,String> masterRoleList = new TreeMap<String,String>();
       
       Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtMasterRole = null;
        ResultSet rstSetMasterRole = null;
        try {
            pstmtMasterRole = connection.prepareStatement("SELECT * from MASTER_ROLES WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetMasterRole = pstmtMasterRole.executeQuery();
            while (rstSetMasterRole.next()) {
                masterRoleList.put(rstSetMasterRole.getString("CODE"), rstSetMasterRole.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetMasterRole != null) {
                rstSetMasterRole.close();
            }
            if (pstmtMasterRole != null) {
                pstmtMasterRole.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetMasterRole != null) {
                rstSetMasterRole.close();
            }
            if (pstmtMasterRole != null) {
                pstmtMasterRole.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
       
       return masterRoleList;
   } 
}
