package com.pageturners.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // H2 Database for testing (comment out for production MySQL)
    private static final String URL = "jdbc:h2:mem:pageturners_db;DB_CLOSE_DELAY=-1;INIT=RUNSCRIPT FROM 'classpath:/schema.sql'";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "";
    
    // MySQL Configuration (uncomment for production)
    // private static final String URL = "jdbc:mysql://localhost:3306/pageturners_db";
    // private static final String USERNAME = "root";
    // private static final String PASSWORD = "password";
    
    static {
        try {
            // Load H2 driver for testing
            Class.forName("org.h2.Driver");
            // For MySQL, use: Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Database JDBC Driver not found", e);
        }
    }
    
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}