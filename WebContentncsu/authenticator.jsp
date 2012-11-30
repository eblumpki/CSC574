<%@page import="CSC574_NetSec_NCSU.hash_sha512"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@ page import="java.util.*" import="java.sql.*" import="java.util.logging.Level" import="java.util.logging.Logger" %>
	

<%  
	String username = request.getParameter("email_id").toString();
	String password = request.getParameter("password").toString();
	String path = request.getParameter("path").toString();
	String conf_password = "";
	if(request.getParameter("conf_password") != null)
		conf_password = request.getParameter("conf_password").toString();
	java.util.Random r = new java.util.Random();
	Integer rand = r.nextInt();
	String salt = rand.toString();
	ResultSet result;
	
   //if(request.getParameter("email_id")==null || request.getParameter("password")==null || request.getParameter("domain")==null)
   if(password==null || username==null)
   {	   
	   session.setAttribute("message","Enter complete details");
	   response.sendRedirect("https://localhost:8443/CSC574_NetSec/login.jsp");
	   return;
   }
   else
   {	  
	   password = password.toString();
	   username = username.toString();
   }
   
   	String url = "jdbc:mysql://localhost:3306/csc574ncsu";
   	Class.forName("com.mysql.jdbc.Driver");
   	Connection con = DriverManager.getConnection(url, "root", "eblumpki");
   	Statement stmt = con.createStatement();
   
   String passwd_check="";  
   String temphash="";
   String passwd_hash = hash_sha512.computehash(password+salt);
   out.println(hash_sha512.computehash("hello"));
   out.println("."+hash_sha512.computehash("hello"));
   
   		if(path.equals("new_account"))
   		{
	   		if (password.equals(conf_password))   
		   		session.setAttribute("passwd_check", passwd_check); 	 
	   		else
	   		{
		   		passwd_check = "notequal";
		   		session.setAttribute("passwd_check", passwd_check);
		   		response.sendRedirect("https://localhost:8443/CSC574_NetSec/new_account.jsp");
		   		return;
	   		}	  	  
	   
	   		String passwd_salt = password + salt;
	   		String add_passwd_hash = hash_sha512.computehash(passwd_salt);  
		   	if(stmt.execute("INSERT INTO login_ncsu(email_id, hash_passwd, salt, last_login, no_of_retries)" + "values('"+username+"', '"+passwd_hash+"', '"+salt+"', '"+new java.sql.Timestamp(new java.util.Date().getTime())+"', '3')")){
		   		session.setAttribute("message", "Email ID already exists");
		   		response.sendRedirect("https://localhost:8443/CSC574_NetSec/login.jsp");
		   		out.println("Account Not Created");
		   	}
		   	else
		   		out.println("Account Created");
   		}
   		else
   		{
			result = stmt.executeQuery("SELECT * FROM login_ncsu where email_id='"+username+"'");
			String temp_salt = "";
		String temp_passwd_salt = "";
		// Compute hash here
		while(result.next())
		{
			temp_salt = result.getString("salt");
			temp_passwd_salt = hash_sha512.computehash(password+temp_salt);
			if(temp_passwd_salt.equals(result.getString("hash_passwd")))
			{
				stmt.execute("UPDATE login_ncsu SET no_of_retries= 3 where email_id = '"+username+"'");
				session.setAttribute("email_id", username+"@ncsu.edu");
				response.sendRedirect("https://localhost:8443/CSC574_NetSec/email_interface.jsp");
				return;
			}
			else
			{
				if(result.getString("email_id").equals(username))
				{
						if(result.getInt("no_of_retries")==0)
						{							
							session.setAttribute("message", "Your Account has been locked. Contact System Admin to unlock it.");
							response.sendRedirect("https://localhost:8443/CSC574_NetSec/login.jsp");
							return;
						}
						else
						{
							int a = result.getInt("no_of_retries");
							a = a-1;
							//result.updateInt("no_of_retries", a-1);
							stmt.execute("UPDATE login_ncsu SET no_of_retries= "+a+" where email_id = '"+username+"'");
						}
						session.setAttribute("message", "Incorrect password1");
						response.sendRedirect("https://localhost:8443/CSC574_NetSec/login.jsp");
						return;
				}
				session.setAttribute("message", "Incorrect ID or password2");
				response.sendRedirect("https://localhost:8443/CSC574_NetSec/login.jsp");
				return;
			}
   		}
		session.setAttribute("message", "Incorrect ID or password3");
		response.sendRedirect("https://localhost:8443/CSC574_NetSec/login.jsp");
		return;	
   }
     
   
   %>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html>