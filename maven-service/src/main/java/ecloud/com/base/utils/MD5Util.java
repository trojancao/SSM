package ecloud.com.base.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.commons.codec.binary.Hex;

public class MD5Util {
	private static final char[] HEX_DIGIT = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e',
			'f' };

	/**
	 * MD5加密
	 * @param src
	 * @return
	 */
	public static String MD5(String src) {
		if (src == null) {
			return null;
		}
		MessageDigest md = null;
		try {
			md = MessageDigest.getInstance("MD5");
		} catch (NoSuchAlgorithmException e) {
			throw new RuntimeException(e.getMessage());
		}

		StringBuffer sb = new StringBuffer();
		byte[] b = md.digest(src.getBytes());
		int i = 0;
		for (int m = b.length; i < m; ++i) {
			sb.append(HEX_DIGIT[(b[i] >>> 4 & 0xF)]);
			sb.append(HEX_DIGIT[(b[i] & 0xF)]);
		}
		return sb.toString();
	}

	/**
	 * MD5加密 password
	 * @param password
	 * @return
	 */
	public static String encode(String password) {
		byte[] digest;
		try {
			MessageDigest md5 = MessageDigest.getInstance("MD5");
			digest = md5.digest(password.getBytes("UTF-8"));
		} catch (UnsupportedEncodingException e) {
			throw new IllegalStateException("UTF-8 not supported!");
		} catch (NoSuchAlgorithmException e) {
			throw new IllegalStateException("MD5 not supported!");
		}
		return new String(Hex.encodeHex(digest));
	}
}
