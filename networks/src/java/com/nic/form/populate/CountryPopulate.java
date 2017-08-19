
package com.nic.form.populate;

import com.nic.validation.DataConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;

/**
 *
 * @author Rajesh Sharma
 */
public class CountryPopulate {
    Connection connection;
    private PreparedStatement psmnt;
    private ResultSet results;

    public Map<String,String> getCountryCode() throws Exception {        
        Map<String, String> countryCode = new TreeMap<String, String>();
        try {
            connection = DataConnect.getConnection();
            String query = "SELECT COUNTRY_CODE,COUNTRY_NAME FROM MASTER_COUNTRIES "
                    + "WHERE RECORD_STATUS = 'A' ORDER BY COUNTRY_NAME";
            psmnt = connection.prepareStatement(query);
            results = psmnt.executeQuery();
            while (results.next()) {
               countryCode.put(results.getString("COUNTRY_CODE"), results.getString("COUNTRY_NAME"));
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
        return countryCode;
    }
}
