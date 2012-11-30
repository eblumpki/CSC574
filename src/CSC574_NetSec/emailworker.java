package CSC574_NetSec;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class emailworker {
	
	static final String url = "jdbc:mysql://localhost:3306/email";
	
	 public static void insert_email(String email_id, String sender, 
	          String date, String subject, String message) {
	      try {

	          String insert = "INSERT INTO email_table(email_id, sender, date, subject, message)" +
	                  "VALUES (?, ?, now(), ?, ?)";

	          Class.forName("com.mysql.jdbc.Driver");
	          Connection con = DriverManager.getConnection(url, "root", "sagar");
	 
	          PreparedStatement ps = con.prepareStatement(insert);

	          ps.setString(1, email_id);
	          ps.setString(2, sender);
	          //ps.setString(3, date);
	          ps.setString(3, subject);
	          ps.setString(4, message);
	          ps.executeUpdate();
	          con.close();

	      } catch (Exception ex) {
	          Logger.getLogger(emailworker.class.getName()).log(
	                           Level.SEVERE, null, ex);
	      }
	  }
	/*
	public static List GetMails() {

	      List<String> list = new ArrayList<String>();

	      try {

	          Class.forName("com.mysql.jdbc.Driver");
	          Connection con = DriverManager.getConnection(url, "root", "");

	          Statement stmt = con.createStatement();

	          ResultSet result = stmt.executeQuery("SELECT * FROM email_table");

	          while(result.next())
	          {
	             list.add(result.getString("email_id"));
	             list.add(result.getString("sender"));
	             list.add(result.getString("date"));
	             list.add(result.getString("subject"));
	             list.add(result.getString("message"));
	          } 

	          con.close();

	      } catch (Exception ex) {
	          Logger.getLogger(emailworker.class.getName()).log( 
	                           Level.SEVERE, null, ex);
	      }
	          return list;
	  }
	  */
}
