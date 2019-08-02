import java.sql.*;

public class Main {

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost/furniture";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
            Procedures.getProductByPartOfName(conn, "Sofa");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
