
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
public class AntiVirusPopulate {
    public Map<String, String> getAntiVirusCode() throws SQLException, IOException {
        Map<String, String> antiVirusCode = new TreeMap<String, String>();
        Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtAntiVirus = null;
        ResultSet rstSetAntiVirus = null;
        try {
            pstmtAntiVirus = connection.prepareStatement("SELECT * from MASTER_ANTIVIRUS WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetAntiVirus = pstmtAntiVirus.executeQuery();
            while (rstSetAntiVirus.next()) {
                antiVirusCode.put(rstSetAntiVirus.getString("CODE"), rstSetAntiVirus.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetAntiVirus != null) {
                rstSetAntiVirus.close();
            }
            if (pstmtAntiVirus != null) {
                pstmtAntiVirus.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetAntiVirus != null) {
                rstSetAntiVirus.close();
            }
            if (pstmtAntiVirus != null) {
                pstmtAntiVirus.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return antiVirusCode;
    }
}
