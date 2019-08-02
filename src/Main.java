import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Main {

    private static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String DB_URL = "jdbc:mysql://localhost/furniture";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    public static void main(String[] args) {
        try (Connection conn = DriverManager.getConnection(DB_URL, USERNAME, PASSWORD)) {
            Procedures procs = new Procedures();
            procs.setConn(conn);

            procs.getProductByPartOfName("Sofa");
            System.out.println("\n\n");
            procs.getByDeliveryNote("TR45343456235334352");
            System.out.println("\n\n");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
