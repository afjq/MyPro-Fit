package com.lzy.util;

import java.security.SecureRandom;

import org.apache.tomcat.util.codec.binary.Base64;

public class ShiroMd5Util {

	/**
	 * 生成密码
	 * 
	 * @return
	 */
//	public static String md5(String str, String salt) {
//		return new Md5Hash(str, salt).toString();
//	}

	/**
	 * 生成盐
	 * 
	 * @return
	 */
	public static String createSalt() {
		byte[] bytes = new byte[5];
		try {
			SecureRandom random = new SecureRandom();
			random.nextBytes(bytes);
			String salt = Base64.encodeBase64String(bytes);
			return salt;
		} catch (Exception e) {
			return null;
		}
	}
//
//	public static void main(String[] args) {
//
//		String salt = ShiroMd5Util.createSalt();
//		System.out.println("salt:" + salt);
//
//		String password = "123456";
//		System.out.println(ShiroMd5Util.md5(password, salt));
//	}

}