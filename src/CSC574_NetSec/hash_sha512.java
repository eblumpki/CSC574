package CSC574_NetSec;
import java.security.MessageDigest;


public class hash_sha512 {
	public static String computehash (String pass)
	{
	       String hash="",hx="";
	       try
	       {
	       MessageDigest md = MessageDigest.getInstance("SHA-512");
	       //String pass = "hello"
	       

	    md.reset();
	    md.update(pass.getBytes());
	    byte[] digest = md.digest();
	    for (Integer i=0;i < digest.length;i++)
	            {
	               hx =  Integer.toHexString(0xFF & digest[i]);
	               //0x03 is equal to 0x3, but we need 0x03 for our md5sum
	               if(hx.length() == 1){hx = "0" + hx;}
	               hash = hash + hx;
	               }
	       } catch(Exception ex) 
	       {
	               return null;
	       }
	       //out.print(hash);
	       return hash;
	    
	}

}
