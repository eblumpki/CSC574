<%@page import="CSC574_NetSec.emailworker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String email_id = request.getParameter( "email_id" );
   session.setAttribute( "email_id", email_id );
%>
<%@ page import="java.util.*" import="java.sql.*" import="java.util.logging.Level" import="java.util.logging.Logger" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Your Emails</title>
</head>
<body>
<table>
<tr>
<th>Email ID</th>
<th>Sender</th>
<th>Date</th>
<th>Subject</th>
<th>Message</th>
</tr> 
<%

  //List list = emailworker.GetMails();
  //int id = 0;
  String box = null;

  List<String> list = new ArrayList<String>();
  
  
  String url = "jdbc:mysql://localhost:3306/email";
  
  try {

      Class.forName("com.mysql.jdbc.Driver");
      Connection con = DriverManager.getConnection(url, "root", "sagar");

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
  
  Iterator<String> it = list.iterator();

  while (it.hasNext()) {
      //id = Integer.parseInt(it.next());
      out.print("<tr>");
      for (int i = 0; i < 5; i++) {
          out.print("<td>");
          out.print(it.next());
          out.print("</td>");
  		}
  //out.print("<td>");
  //box = "<input name=r" + id + " type='checkbox'>";
  //out.print(box);
  //out.print("</td>");
  out.print("</tr>");
 }
%>
 
</table>
<A HREF="email_compose.jsp">Compose</A>
</body>
</html>