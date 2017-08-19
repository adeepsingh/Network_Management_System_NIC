
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
public class DeviceTypePopulate {
   public Map<String, String> getDeviceTypeCode() throws SQLException, IOException {
        Map<String, String> deviceTypeCode = new TreeMap<String, String>();
        Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtDeviceType = null;
        ResultSet rstSetDeviceType = null;
        try {
            pstmtDeviceType = connection.prepareStatement("SELECT * from MASTER_DEVICE_TYPE WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetDeviceType = pstmtDeviceType.executeQuery();
            while (rstSetDeviceType.next()) {
                deviceTypeCode.put(rstSetDeviceType.getString("CODE"), rstSetDeviceType.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetDeviceType != null) {
                rstSetDeviceType.close();
            }
            if (pstmtDeviceType != null) {
                pstmtDeviceType.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetDeviceType != null) {
                rstSetDeviceType.close();
            }
            if (pstmtDeviceType != null) {
                pstmtDeviceType.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return deviceTypeCode;
    }  
}
