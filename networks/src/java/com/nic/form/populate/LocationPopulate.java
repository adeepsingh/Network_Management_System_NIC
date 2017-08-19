package com.nic.form.populate;

import com.nic.validation.DataConnect;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class LocationPopulate {
    public Map<String, String> getLocationList() throws SQLException, IOException {
        Map<String, String> locationList = new TreeMap<String, String>();
        Connection connection = DataConnect.getConnection();
        PreparedStatement pstmtLocation = null;
        ResultSet rstSetLocation = null;
        try {
            pstmtLocation = connection.prepareStatement("SELECT * FROM MASTER_LOCATION WHERE RECORD_STATUS = 'A' ORDER BY DESCRIPTION");
            rstSetLocation = pstmtLocation.executeQuery();
            while (rstSetLocation.next()) {
                locationList.put(rstSetLocation.getString("CODE"), rstSetLocation.getString("DESCRIPTION"));
            }
        } catch (SQLException _Ex) {
            if (rstSetLocation != null) {
                rstSetLocation.close();
            }
            if (pstmtLocation != null) {
                pstmtLocation.close();
            }
            if (connection != null) {
                connection.close();
            }
            System.out.println(_Ex);
        } finally {
            if (rstSetLocation != null) {
                rstSetLocation.close();
            }
            if (pstmtLocation != null) {
                pstmtLocation.close();
            }
            if (connection != null) {
                connection.close();
            }
        }
        return locationList;
    }
}