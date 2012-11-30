<%@page import="CSC574_NetSec.hash_sha512"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.*" import="java.sql.*" import="java.util.logging.Level" import="java.util.logging.Logger" %>
	

   <%  
   
   String username = request.getParameter("email_id");
   String password = request.getParameter("password");
   String conf_password = request.getParameter("conf_password");
   String domain = request.getParameter("domain");
   java.util.Random r = new java.util.Random();
   Integer rand = r.nextInt();
   String salt = rand.toString();
   ResultSet result;
   
   //if(request.getParameter("email_id")==null || request.getParameter("password")==null || request.getParameter("domain")==null)
   if(password==null || username==null || domain==null)
   {	   
	   session.setAttribute("message","Enter complete details");
	   response.sendRedirect("login.jsp");
	   return;
   }
   else
   {	  
	   password = password.toString();
	   username = username.toString();
	   domain = domain.toString();
   }
   
   String url = "jdbc:mysql://localhost:3306/csc574";
   Class.forName("com.mysql.jdbc.Driver");
   Connection con = DriverManager.getConnection(url, "root", "eblumpki");
   Statement stmt = con.createStatement();
   
   String passwd_check="";
   String path="";
   String temphash="";
   String passwd_hash = hash_sha512.computehash(password+salt);
   out.println(hash_sha512.computehash("hello"));
   out.println("."+hash_sha512.computehash("hello"));
   path = session.getAttribute("path").toString();
   
	/*if(domain.equals("ncsu")){
		request.setAttribute("email_id", username);
		request.setAttribute("password", password);
		request.setAttribute("conf_password", conf_password);
		request.setAttribute("path", path);
		response.sendRedirect("https://localhost:9443/CSC574_NetSec_NCSU/authenticator.jsp");
	}*/
	if(domain.equals("mymail")){
   		if(path.equals("new_account"))
   		{
	   		if (password.equals(conf_password))   
		   		session.setAttribute("passwd_check", passwd_check); 	 
	   		else
	   		{
		   		passwd_check = "notequal";
		   		session.setAttribute("passwd_check", passwd_check);
		   		response.sendRedirect("new_account.jsp");
		   		return;
	   		}	  	  
	   
	   		//if(domain.equals("mymail"))
	   		//{	
		   // ROUTE TO ANOTHER SERVER HERE
		   // 
		   //asdasd
		   if(stmt.execute("INSERT INTO login_mymail(email_id, hash_passwd, salt, last_login, no_of_retries)" + "values('"+username+"', '"+passwd_hash+"', '"+salt+"', '"+new java.sql.Timestamp(new java.util.Date().getTime())+"', '3')")){
			   	session.setAttribute("message", "Email ID already exists");
			   	response.sendRedirect("login.jsp");
			   	return;
			   	//out.println("Account Not Created");
		   }
		   else
			   out.println("Account Created");
	   //}
	   /*else if(domain.equals("ncsu"))
	   {		   		   
		   if(stmt.execute("INSERT INTO login_ncsu(id, email_id, hash_passwd, salt)" + "values("+null+", '"+username+"', '"+add_passwd_hash+"', '"+salt+"')"))
		   	out.println("Account Not Created");
		   else
		   	out.println("Account Created");
	   }*/
	   //else
		  // out.println("Nothing happened");
   		}
   		else
   		{

		if(domain.equals("mymail"))
	      	result = stmt.executeQuery("SELECT * FROM login_mymail where email_id='"+username+"'");
		//else
		else
		{
			result=stmt.executeQuery("SELECT * FROM login_ncsu"); //just so that the errors of not initializing are not displayed
			session.setAttribute("message","Select either of the radio buttons");
			response.sendRedirect("login.jsp");
			return;
		}
		//result = stmt.executeQuery("SELECT * FROM login_ncsu");
		String temp_salt = "";
		String temp_passwd_salt = "";
		// Compute hash here
		while(result.next())
		{
			temp_salt = result.getString("salt");
			temp_passwd_salt = hash_sha512.computehash(password+temp_salt);
			if(temp_passwd_salt.equals(result.getString("hash_passwd")))
			{
				stmt.execute("UPDATE login_mymail SET no_of_retries= 3 where email_id = '"+username+"'");
					session.setAttribute("email_id", username+"@mymail.com");
				response.sendRedirect("email_interface.jsp");
				return;
			}
			else
			{
				if(result.getString("email_id").equals(username))
				{
						if(result.getInt("no_of_retries")==0)
						{							
							session.setAttribute("message", "Your Account has been locked. Contact System Admin to unlock it.");
							response.sendRedirect("login.jsp");
							return;
						}
						else
						{
							int a = result.getInt("no_of_retries");
							a = a-1;
							//result.updateInt("no_of_retries", a-1);
							stmt.execute("UPDATE login_mymail SET no_of_retries= "+a+" where email_id = '"+username+"'");
						}
						session.setAttribute("message", "Incorrect password1");
						response.sendRedirect("login.jsp");
						return;
				}
				session.setAttribute("message", "Incorrect ID or password2");
				response.sendRedirect("login.jsp");
				return;
			}
   		}
		session.setAttribute("message", "Incorrect ID or password3");
		response.sendRedirect("login.jsp");
		return;	
   		}
   }
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<% if(request.getParameter("domain").toString().equals("ncsu")){ %>
<BODY onLoad="document.forms[0].submit();">
<%}else{ %>
<body>
<%} if(session.getAttribute("path").toString().equals("login")){ %>
<br/><FORM METHOD=POST ACTION="https://localhost:9443/CSC574_NetSec_NCSU/authenticator.jsp" STYLE="visibility:hidden;">
Enter email_id:<INPUT TYPE=TEXT NAME=email_id SIZE=100 value="<%=username %>"><br/>
Enter password:<INPUT TYPE=PASSWORD NAME=password SIZE=100 value="<%=password %>"><br/>
<INPUT TYPE=TEXT NAME=path SIZE=100 value="<%=path %>"><br/>
<INPUT type="radio" name="domain" value="mymail"> MyMail<br/>
<INPUT type="radio" name="domain" value="ncsu" checked> NCSU<br/>
<INPUT TYPE=SUBMIT value="Log In">
</FORM>
<%} else{ %>
<FORM METHOD=POST ACTION="https://localhost:9443/CSC574_NetSec_NCSU/authenticator.jsp" STYLE="visibility:hidden;">
	<INPUT type="radio" name="domain" value="mymail"> MyMail<br/>
	<INPUT type="radio" name="domain" value="ncsu" checked> NCSU<br/>		
	<input type="text" name="email_id" value="<%=username %>">
	<INPUT TYPE=TEXT NAME=path SIZE=100 value="<%=path %>"><br/>
	<input type="password" name="password" value="<%=password %>">
	<input type="password" name="conf_password" value="<%=conf_password %>">
	<INPUT TYPE=SUBMIT value="Create Account">
</FORM>
<%}%>
</body>
</html>