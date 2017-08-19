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
public class OSPopulate {
    public Map<String, String> getOsCode() throws SQLException, IOException {
        Map<String, String> osCode = new TreeMap<String, String>();
        Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtOs = null;
        ResultSet rstSetOs = null;
        try {
            pstmtOs = connection.prepareStatement("SELECT * from MASTER_OS WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetOs = pstmtOs.executeQuery();
            while (rstSetOs.next()) {
                osCode.put(rstSetOs.getString("CODE"), rstSetOs.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetOs != null) {
                rstSetOs.close();
            }
            if (pstmtOs != null) {
                pstmtOs.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetOs != null) {
                rstSetOs.close();
            }
            if (pstmtOs != null) {
                pstmtOs.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return osCode;
    }
}
