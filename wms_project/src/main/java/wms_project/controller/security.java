package wms_project.controller;

import java.security.MessageDigest;

public interface security {

default StringBuilder secode(String passwd) throws Exception{
		
		MessageDigest md5 = MessageDigest.getInstance("MD5");
		md5.update(passwd.getBytes());	
		byte[] repw = md5.digest();
		
		StringBuilder sb = new StringBuilder();
		for(byte w : repw) {
		
			
			String word = String.format("%x", w);
			sb.append(word);
		}
		return sb;
	}
}
