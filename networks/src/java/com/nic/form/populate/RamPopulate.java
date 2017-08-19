
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
public class RamPopulate {
    public Map<String, String> getRamCode() throws SQLException, IOException {
        Map<String, String> ramCode = new TreeMap<String, String>();
        Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtRam = null;
        ResultSet rstSetRam = null;
        try {
            pstmtRam = connection.prepareStatement("SELECT * from MASTER_RAM WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetRam = pstmtRam.executeQuery();
            while (rstSetRam.next()) {
                ramCode.put(rstSetRam.getString("CODE"), rstSetRam.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetRam != null) {
                rstSetRam.close();
            }
            if (pstmtRam != null) {
                pstmtRam.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetRam != null) {
                rstSetRam.close();
            }
            if (pstmtRam != null) {
                pstmtRam.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return ramCode;
    }
}
