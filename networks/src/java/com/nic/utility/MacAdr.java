package com.nic.utility;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class MacAdr {
    Pattern macpt = null;
	public String getMac(String ip) {
	/*	// System.out.println("qqq");
	
	    // Find OS and set command according to OS
	    String OS = System.getProperty("os.name").toLowerCase();
	    //System.out.println("IP in MAC -- "+ip);
	    String[] cmd;
	    if (OS.contains("win")) {
	        // Windows
	        macpt = Pattern
	                .compile("[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+-[0-9a-f]+");
	        String[] a = { "arp", "-a", ip };
	        cmd = a;
	    } else {
	        // Mac OS X, Linux
	        macpt = Pattern
	                .compile("[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+:[0-9a-f]+");
	        String[] a = { "arp", ip };
	        cmd = a;
	    }

	    try {
	        // Run command
	        Process p = Runtime.getRuntime().exec(cmd);
	        p.waitFor();
	        System.out.println("1");
	        // read output with BufferedReader
	        BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
	        String line = reader.readLine();
	     //   System.out.println("2");
	        // Loop trough lines
	        while (line != null) {
	            Matcher m = macpt.matcher(line);
	          //  System.out.println("3");
	            // when Matcher finds a Line then return it as result
	            if (m.find()) {
	                System.out.println("Found");
	                System.out.println("MAC: " + m.group(0));
	                return m.group(0);
	            }

	            line = reader.readLine();
	        }

	    } catch (IOException  e1) {
	    }catch ( InterruptedException e1) {
	    }

	    // Return empty string if no MAC is found
	    return "";
	}*/
	
	
	InetAddress ips;
        String macAddress = "";
	try {

		ips = InetAddress.getLocalHost();
	//	System.out.println("Current IP address : " + ips.getHostAddress());

		NetworkInterface network = NetworkInterface.getByInetAddress(ips);

		byte[] mac = network.getHardwareAddress();

	//	System.out.print("Current MAC address : ");

		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < mac.length; i++) {
			sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));
		}
	//	System.out.println(sb.toString());
macAddress = sb.toString();
	} catch (UnknownHostException e) {

		e.printStackTrace();

	} catch (SocketException e){

		e.printStackTrace();

	}
return macAddress;
   }
        
	
}
