<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Account Creation</title>
</head>
<body>
	<%		
		if(session.getAttribute("passwd_check") != null)
			if(session.getAttribute("passwd_check").equals("notequal"))
				out.println("Password don't match");						
	%>
	<FORM METHOD=POST ACTION="authenticator.jsp">
		<INPUT type="radio" name="domain" value="mymail"> MyMail<br/>
		<INPUT type="radio" name="domain" value="ncsu"> NCSU<br/>		
		<table>
			<tr>
				<td>Username: </td><td><input type="text" name="email_id"></td><td>domain</td>
			</tr>
			<tr>
				<td>Password: </td><td><input type="password" name="password"></td>
			</tr>
			<tr>
				<td>Confirm Password: </td><td><input type="password" name="conf_password"></td>
			</tr>
		</table>
		<% session.setAttribute("path", "new_account"); %>
	<P><INPUT TYPE=SUBMIT value="Create Account">
	</FORM>
</body>
</html>
