/**
 * 
 */
package ecloud.com.base.utils;

/**
 * @author caoqiang
 *
 */
public class BytesUtil {
	/*
	 * 字符转换为字节
	 */
	private static byte charToByte(char c) {
		return (byte) "0123456789ABCDEF".indexOf(c);
	}

	/**
	 * 16进制字符串转字节数组
	 */
	public static byte[] hexString2Bytes(String hex) {

		if ((hex == null) || (hex.equals(""))) {
			return null;
		} else if (hex.length() % 2 != 0) {
			return null;
		} else {
			hex = hex.toUpperCase();
			int len = hex.length() / 2;
			byte[] b = new byte[len];
			char[] hc = hex.toCharArray();
			for (int i = 0; i < len; i++) {
				int p = 2 * i;
				b[i] = (byte) (charToByte(hc[p]) << 4 | charToByte(hc[p + 1]));
			}
			return b;
		}

	}

	/**
	 * 字符串转16进制字符串
	 */
	public static String string2HexString(String s) throws Exception {
		String r = bytes2HexString(string2Bytes(s));
		return r;
	}

	/**
	 * 16进制字符串转字符串
	 */
	public static String hex2String(String hex) throws Exception {
		String r = bytes2String(hexString2Bytes(hex));
		return r;
	}

	/**
	 * 字符串转字节数组
	 */
	public static byte[] string2Bytes(String s) {
		byte[] r = s.getBytes();
		return r;
	}

	/**
	 * 字节数组转字符串
	 */
	public static String bytes2String(byte[] b) throws Exception {
		String r = new String(b, "UTF-8");
		return r;
	}

	/**
	 * 字节数组转16进制字符串
	 */
	public static String bytes2HexString(byte[] b) {
		String r = "";

		for (int i = 0; i < b.length; i++) {
			String hex = Integer.toHexString(b[i] & 0xFF);
			if (hex.length() == 1) {
				hex = '0' + hex;
			}
			r += hex.toUpperCase();
		}

		return r;
	}

	/**
	 * 字节转16进制字符串
	 */
	public static String byte2HexString(byte b) {

		String hex = Integer.toHexString(b & 0xFF);
		if (hex.length() == 1) {
			hex = '0' + hex;
		}

		return hex.toUpperCase();
	}
	
	/**
	 * 字节转字符串
	 * @throws Exception 
	 */
	public static String byte2String(byte b) throws Exception {
		return hex2String(byte2HexString(b));
	}
	
	/**
	 * 字节转10进制
	 */
	public static int byte2Int(byte b) {
		int r = (int) b;
		return r;
	}

	/**
	 * 10进制转字节
	 */
	public static byte int2Byte(int i) {
		byte r = (byte) i;
		return r;
	}
}
