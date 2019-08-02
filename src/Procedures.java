import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Procedures {

    private Connection conn;
    private CallableStatement callStmt;

    public void setConn(Connection conn) {
        this.conn = conn;
    }

    public void getProductByPartOfName(String part) throws SQLException {
        ResultSet rs = getResultSetFrom("{call by_name_part(?)}", part);

        System.out.printf("RESULT FROM by_name_part\n%2s | %-20s | %-20s | %s | %-12s | %s\n",
            "id", "Product Name", "Description", "Weight", "Barcode", "Price");
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

    public void getByDeliveryNote(String delivNote) throws SQLException {
        ResultSet rs = getResultSetFrom("{call by_delivery_note_num(?)}", delivNote);

        System.out.printf("RESULT FROM by_delivery_note_num\n%-20s | %-7s | %-20s\n",
                "Product", "Price", "Buyer");
        while (rs.next()) {
            System.out.printf("%-20s | %.2f | %-20s\n",
                    rs.getString("Product"),
                    rs.getFloat("Price"),
                    rs.getString("Buyer"));
        }

        callStmt.close();
    }

    private ResultSet getResultSetFrom(String callStr, String... args) throws SQLException {
        callStmt = conn.prepareCall(callStr);

        int index = 0;
        for (String arg : args) {
            callStmt.setString(++index, arg);
        }

        callStmt.execute();
        return callStmt.getResultSet();
    }
}











