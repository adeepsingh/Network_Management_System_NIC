package com.nic.utility;

import com.nic.validation.DataConnect;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class GetMaxCode {
    public String getMaxLocationCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_LOCATION";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxFloorCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_FLOOR";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxAssessCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_ASSESS_LEVEL";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxDeviceCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_DEVICE_TYPE";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxMenuCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CATEGORY_CODE)) as CATEGORY_CODE from MASTER_MENU_CATEGORY";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CATEGORY_CODE") + 1;

            }
            maxCode = String.format("%3s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxSubmenuCode(String catCode) throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(SUBCATEGORY_CODE)) as SUBCATEGORY_CODE from MASTER_MENU_SUBCATEGORY ";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("SUBCATEGORY_CODE") + 1;

            }
            maxCode = String.format("%6s", Integer.toString(maxCode1)).replace(' ', '0');

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
        return maxCode;

    }

    public String getMaxMinistryCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_USER_MINISTRY";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxSectionCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_SECTION";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%4s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxDepartmentCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_USER_DEPARTMENT";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {
                maxCode1 = results.getInt("CODE") + 1;
            }
            maxCode = String.format("%3s", Integer.toString(maxCode1)).replace(' ', '0');
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

        return maxCode;

    }
    //------------------26/7/2017---------------------------

    public String getMaxOsCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_OS";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%3s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxAntivirusCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_ANTIVIRUS";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {

                maxCode1 = results.getInt("CODE") + 1;

            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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

        return maxCode;

    }

    public String getMaxRamCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;
        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();
            query = "select max(to_number(CODE)) as CODE from MASTER_RAM";
            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {
                maxCode1 = results.getInt("CODE") + 1;
            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');

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
        return maxCode;
    }
     public String getMaxDesignationCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_DESIGNATION";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {
                maxCode1 = results.getInt("CODE") + 1;
            }
            maxCode = String.format("%3s", Integer.toString(maxCode1)).replace(' ', '0');
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

        return maxCode;

    }
     
     public String getMaxWingCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_WING";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {
                maxCode1 = results.getInt("CODE") + 1;
            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');
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

        return maxCode;

    }
     
     public String getMaxEmploymentTypeCode() throws Exception {
        String maxCode = null;
        int maxCode1 = 0;

        String query = null;
        Connection con = null;
        PreparedStatement psmnt = null;
        ResultSet results = null;

        try {
            DataConnect utilityAct = new DataConnect();
            con = utilityAct.getConnection();

            query = "select max(to_number(CODE)) as CODE from MASTER_USER_EMPLOYMENT_TYPE";

            psmnt = con.prepareStatement(query);
            results = psmnt.executeQuery();
            if (results.next()) {
                maxCode1 = results.getInt("CODE") + 1;
            }
            maxCode = String.format("%2s", Integer.toString(maxCode1)).replace(' ', '0');
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

        return maxCode;

    }
}