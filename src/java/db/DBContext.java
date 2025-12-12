package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBContext {
    private static final String URL = "jdbc:postgresql://localhost:5432/seminar";
    private static final String USER = "postgres";
    private static final String PASSWORD = "1";

    public static Connection getConnection(){
        Connection con = null;
        try {
            //Loading PostgreSQL driver
            Class.forName("org.postgresql.Driver");
            //Creating a connection
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return con;
    }
}
