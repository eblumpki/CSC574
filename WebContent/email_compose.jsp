<%@page import="CSC574_NetSec.emailworker"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	  emailworker.insert_email(email_id,sender,date,subject,message);
      //.BooksWorker.Insert(author, title, year, remark);
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
</body>
</html>