
package com.nic.form.populate;

import com.nic.validation.DataConnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class SectionPopulate {
    public Map<String,String> getSectionList() throws SQLException, IOException { 
       Map<String,String> sectionList = new TreeMap<String,String>();
       
       Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtPurpose = null;
        ResultSet rstSetPurpose = null;
        try {
            pstmtPurpose = connection.prepareStatement("SELECT * from MASTER_SECTION WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetPurpose = pstmtPurpose.executeQuery();
            while (rstSetPurpose.next()) {
                sectionList.put(rstSetPurpose.getString("CODE"), rstSetPurpose.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetPurpose != null) {
                rstSetPurpose.close();
            }
            if (pstmtPurpose != null) {
                pstmtPurpose.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetPurpose != null) {
                rstSetPurpose.close();
            }
            if (pstmtPurpose != null) {
                pstmtPurpose.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
       
       return sectionList;
   } 
}
