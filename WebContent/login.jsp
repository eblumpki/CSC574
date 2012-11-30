<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Email</title>
</head>
<body>
<%  
	if( session.getAttribute("message") != null )
		out.println(session.getAttribute("message").toString());
%>
<br/>
	<FORM METHOD=POST ACTION="authenticator.jsp">
Enter email_id:<INPUT TYPE=TEXT NAME=email_id SIZE=100><br/>

Enter password:<INPUT TYPE=PASSWORD NAME=password SIZE=100><br/>
<br/>
<INPUT type="radio" name="domain" value="mymail"> MyMail<br/>
<INPUT type="radio" name="domain" value="ncsu"> NCSU<br/>
<% session.setAttribute("path", "login"); %>
<P><INPUT TYPE=SUBMIT value="Log In">
</FORM>
<P>
<a href="new_account.jsp"><input type="button" name="Create New Account">Create New Account</a>
</body>
</html>