package com.nic.validation;

import java.sql.Connection;

public class DataConnect {

    private static final String dbDriver = "oracle.jdbc.OracleDriver";

//    private static final String dbUrl = "jdbc:oracle:thin:@10.247.46.105:1521:arms";
    private static final String dbUrl = "jdbc:oracle:thin:@10.25.200.9:1521:arms";
    private static final String dbUserName = "networks";
    private static final String dbIdentifier = "networks";

    public static Connection getConnection() {
        java.sql.Connection conn = null;
        try {
            Class.forName(dbDriver).newInstance();
            conn = java.sql.DriverManager.getConnection(dbUrl, dbUserName, dbIdentifier);
        } catch (Exception _EX) {
            System.out.print("Exception - DataConnect.java - "+_EX);
        }
        return conn;
    }
}