package com.nic.utility;

import com.nic.validation.DataConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GetMastersStatus {

    public String getLocationStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_LOCATION WHERE CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }
        return recordStatus;
    }

    public String getFloorStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_FLOOR WHERE CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }
        return recordStatus;
    }

    public String getAssessStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_ASSESS_LEVEL WHERE CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }
        return recordStatus;
    }

    public String getDeviceStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_DEVICE_TYPE WHERE CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }
        return recordStatus;
    }

    public String getMenuStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_MENU_CATEGORY WHERE CATEGORY_CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }
        return recordStatus;
    }

    public String getSubmenuStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_MENU_SUBCATEGORY WHERE SUBCATEGORY_CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

    public String getMinistryStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_USER_MINISTRY WHERE CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

    public String getDepartmentStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_USER_DEPARTMENT WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }

            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }

            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }

        }

        return recordStatus;
    }

    public String getSectionStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_SECTION WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

        //-----------------------------26/7/2017----------------------------------------
    public String getOsStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_OS WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

    public String getAntivirusStatus(String code) throws Exception {
        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select RECORD_STATUS from MASTER_ANTIVIRUS WHERE CODE=?";
            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {
                recordStatus = results.getString("RECORD_STATUS");
            }
        } catch (Exception e) {
        } finally {
            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

    public String getRamStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_RAM WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }
public String getWingStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_WING WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

public String getEmploymentTypeStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_USER_EMPLOYMENT_TYPE WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

public String getDesignationStatus(String code) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from MASTER_DESIGNATION WHERE CODE=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, code);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }


public String getIPAssignStatus(String ipAddress,String location,String userName) throws Exception {

        String query = null, recordStatus = "";
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select RECORD_STATUS from IP_ADDRESS WHERE USER_IP_ADDRESS=? and LOCATION=? and USER_NAME=?";

            psmnt = con.prepareStatement(query);
            psmnt.setString(1, ipAddress);
                psmnt.setString(2, location);
                    psmnt.setString(3, userName);
            results = psmnt.executeQuery();
            if (results.next()) {

                recordStatus = results.getString("RECORD_STATUS");

            }
        } catch (Exception e) {
        } finally {

            if (results != null) {
                try {
                    results.close();
                } catch (Exception e) {;
                }
                results = null;
            }
            if (psmnt != null) {
                try {
                    psmnt.close();
                } catch (Exception e) {;
                }
                psmnt = null;
            }
            if (con != null) {
                try {
                    con.close();
                } catch (Exception e) {;
                }
                con = null;
            }
        }

        return recordStatus;

    }

    

    
}
