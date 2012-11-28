<%@page import="myproject.emailworker" import="java.sql.*" import="java.util.logging.Level" import="java.util.logging.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ include file="db_config.jsp" %>
<%
	//Object obj = request.getSession().getAttribute("email_id");
	//out.print(obj);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Compose Email</title>
</head>
<body>
<%
  String sender = (String) request.getSession().getAttribute("email_id");
  String email_id = request.getParameter("email_id");
  //String date = request.getParameter("date");
  String date ="";
  String subject = request.getParameter("subject");
  String message = request.getParameter("message");
  if (sender != null && email_id !=null) {
	  //emailworker.insert_email(email_id,sender,date,subject,message);
      //.BooksWorker.Insert(author, title, year, remark);
      try {

	          String insert = "INSERT INTO email_table(email_id, sender, date, subject, message)" +
	                  "VALUES (?, ?, now(), ?, ?)";

	          Class.forName("com.mysql.jdbc.Driver");
	          Connection con = DriverManager.getConnection(url, db_user, db_pass);
	 
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
%>

<br> <br> <br>

<form method="post" action="email_compose.jsp">
<table>
<tr>    
<td>To</td><td><input type="text" name="email_id"></td>
</tr>
<tr>
<td>Subject</td><td><input type="text" name="subject"></td>
</tr>
<tr>
<td>Body</td><td> <input type="text" name="message"></td>
</tr>
</table>

<br>
<input type="submit" value="send">
</form>
<A HREF="email_interface.jsp">Inbox</A>
</body>
</html>