import java.sql.*;
import java.util.*;
public class Task04 {
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
            sql="SELECT A_ID, AMOUNT,TYPE FROM TRANSACTIONS";
            System.out.println("Executing the query: " + sql);
            ResultSet rs=stmt.executeQuery(sql);
            int CIP=0,VIP=0,OP=0;

            HashMap<Integer,Long>Transactions=new HashMap<Integer, Long>();

            HashMap<Integer,Long>account_balance=new HashMap<Integer, Long>();
            while(rs.next())
            {
                int ID=rs.getInt("A_ID");
                Long amount=rs.getLong("AMOUNT");
                String type=rs.getString("TYPE");

                if(Transactions.get(ID)==null){
                    Transactions.put(ID,amount);
                }
                else{
                    Transactions.replace(ID,Transactions.get(ID)+amount);
                }
                if(account_balance.get(ID)==null){
                    if(type.equals("0")){
                        account_balance.put(ID,-amount);
                    }
                    else{
                        account_balance.put(ID,amount);
                    }
                }
                else{
                    if(type.equals("0")){
                        account_balance.replace(ID,account_balance.get(ID)-amount);
                    }
                    else{
                        account_balance.replace(ID,account_balance.get(ID)+amount);
                    }

                }
            }
            int exception=0;
            for(int i=1;i<=150;i++){
                if(Transactions.get(i)>5000000 && account_balance.get(i)>1000000){
                    CIP++;
                }
                else if(Transactions.get(i)>2500000 && Transactions.get(i)<4500000 && account_balance.get(i)>500000 && account_balance.get(i)<900000){
                    VIP++;
                }
                else if(Transactions.get(i)<1000000 && account_balance.get(i)<100000){
                    OP++;
                }
                else{
                    exception++;
                }
            }
            System.out.printf("CIP: " + CIP + ", VIP: " + VIP + " , OP: " + OP + ", No Category: " + exception + "\n");


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
