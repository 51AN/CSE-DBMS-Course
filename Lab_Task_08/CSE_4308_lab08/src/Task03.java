import java.sql.*;
public class Task03 {

    static final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    static final String DB_URL= "jdbc:oracle:thin:@localhost:1521:xe";
    static final String USER="s200042151";
    static final String PASS="cse4308";
    public static void main (String args[])
    {
        Connection conn=null;
        Statement stmt=null;
        try
        {
            Class.forName(JDBC_DRIVER);
            System.out.println("Connecting to database");
            conn=DriverManager.getConnection(DB_URL, USER, PASS);
            System.out.println("Creating statement");
            stmt=conn.createStatement();
            String sql;
            sql="SELECT a_id,amount,type,EXTRACT( YEAR FROM DTM) as year FROM TRANSACTIONS  GROUP BY a_id,amount,type,EXTRACT( YEAR FROM DTM) HAVING EXTRACT( YEAR FROM DTM) = '2020'";
            System.out.println("Executing the query: " + sql);
            System.out.print("Transactions that occurred in 2020 : \n");
            ResultSet rs=stmt.executeQuery(sql);
            while(rs.next())
            {

                int account=rs.getInt("a_id");
                int Amount=rs.getInt("amount");
                String type=rs.getString("type");

                System.out.print(Amount + " taka has been");
                if(type.charAt(0)=='0')
                    System.out.print(" deposited to");
                else
                    System.out.print(" taken out from ");
                System.out.println("account " + account);




            }

            rs.close();
            stmt.close();
            conn.close();
            System.out.println("\nThank you for banking with us!");
        }
        catch(SQLException se)
        {
            se.printStackTrace();
        }
        catch(Exception e)
        {
            e.printStackTrace();
        }
    }

}
