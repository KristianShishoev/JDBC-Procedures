import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Procedures {

    public static void getProductByPartOfName(Connection conn, String part) throws SQLException {
        CallableStatement callStmt = conn.prepareCall("{call by_name_part(?)}");
        callStmt.setString(1, part);

        callStmt.execute();
        ResultSet rs = callStmt.getResultSet();

        System.out.println("RESULT FROM by_name_part\n");
        while (rs.next()) {
            System.out.printf("%2d | %-20s | %-20s | %.2f | %-12s | %.2f\n",
                    rs.getInt("id"),
                    rs.getString("product_name"),
                    rs.getString("product_desc"),
                    rs.getFloat("weight"),
                    rs.getString("barcode"),
                    rs.getFloat("price"));
        }

        callStmt.close();
    }
}
