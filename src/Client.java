import java.io.*;
import java.net.*;
//import java.security.Security.*;
//import com.sun.net.ssl.*;
//import com.sun.*; 
import javax.net.ssl.HttpsURLConnection;

public class Client {
	/*
	 *
	 * A free Java sample program 
	 * to POST to a HTTPS secure SSL website
	 *
	 * @author William Alexander
	 * free for use as long as this comment is included 
	 * in the program as it is
	 * 
	 * More Free Java programs available for download 
	 * at http://www.java-samples.com
	 *
	 */
	HttpsURLConnection connection;
	public void connect(String query){
		String cuki=new String();
		try {
			System.setProperty("java.protocol.handler.pkgs", "javax.net.ssl.HttpsURLConnection");
			java.security.Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider()); 
			URL url = new URL("https://localhost:8443"); 
			connection = (HttpsURLConnection) url.openConnection();
			connection.setDoInput(true); 
			connection.setDoOutput(true);
			String cookieHeader = connection.getHeaderField("set-cookie"); 
			if(cookieHeader != null) { 
				int index = cookieHeader.indexOf(";"); 
				if(index >= 0) 
					cuki = cookieHeader.substring(0, index); 
				connection.setRequestProperty("Cookie", cuki); 
			}
	 
			//connection.setRequestMethod("POST"); 
			//HttpURLConnection.setFollowRedirects(true);  
	//connection.setRequestProperty("Accept-Language","it"); 
	//connection.setRequestProperty("Accept", "application/cfm, image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, image/png, //*/*"); 
	//connection.setRequestProperty("Accept-Encoding","gzip"); 
			int queryLength = query.length(); 
			connection.setFixedLengthStreamingMode(queryLength);
			connection.setRequestProperty("Content-length",String.valueOf (queryLength)); 
			connection.setRequestProperty("Content-Type","application/x-www- form-urlencoded"); 
			connection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 5.0; Windows 98; DigExt)"); 

	// open up the output stream of the connection 
			DataOutputStream output = new DataOutputStream( connection.getOutputStream() ); 

	// write out the data 
			output.writeBytes( query ); 
	//output.close();

			System.out.println("Resp Code:"+connection.getResponseCode()); 
			System.out.println("Resp Message:"+ connection.getResponseMessage()); 

	// get ready to read the response from the cgi script 
			DataInputStream input = new DataInputStream( connection.getInputStream() ); 

	// read in each character until end-of-stream is detected 
			for( int c = input.read(); c != -1; c = input.read() ) 
				System.out.print( (char)c ); 
			input.close(); 
		} 
		catch(Exception e) 
		{ 
			connection.disconnect();
			System.out.println( e ); 
			e.printStackTrace(); 
		} 
		finally{
			connection.disconnect();
		}
			
	}
}
