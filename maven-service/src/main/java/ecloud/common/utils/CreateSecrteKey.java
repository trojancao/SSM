package ecloud.common.utils;

import java.io.IOException;
import java.security.InvalidKeyException;
/**
 * 引进的包都是Java自带的jar包 秘钥相关包 base64 编解码 这里只用到了编码
 */
import java.security.Key;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.NoSuchAlgorithmException;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.Signature;
import java.security.SignatureException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.InvalidKeySpecException;
import java.util.HashMap;
import java.util.Map;
import org.apache.commons.codec.binary.Base64;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

public class CreateSecrteKey {

	public class Keys {

	}

	public static final String KEY_ALGORITHM = "RSA";
	// public static final String SIGNATURE_ALGORITHM = "MD5withRSA";
	private static final String PUBLIC_KEY = "RSAPublicKey";
	private static final String PRIVATE_KEY = "RSAPrivateKey";

	// 获得公钥
	public static String getPublicKey(Map<String, Object> keyMap) throws Exception {
		// 获得map中的公钥对象 转为key对象
		Key key = (Key) keyMap.get(PUBLIC_KEY);
		// byte[] publicKey = key.getEncoded();
		// 编码返回字符串
		return encryptBASE64(key.getEncoded());
	}

	// 获得私钥
	public static String getPrivateKey(Map<String, Object> keyMap) throws Exception {
		// 获得map中的私钥对象 转为key对象
		Key key = (Key) keyMap.get(PRIVATE_KEY);
		// byte[] privateKey = key.getEncoded();
		// 编码返回字符串
		return encryptBASE64(key.getEncoded());
	}

	// 解码返回byte
	public static byte[] decryptBASE64(String key) throws Exception {
		return (new BASE64Decoder()).decodeBuffer(key);
	}

	// 编码返回字符串
	public static String encryptBASE64(byte[] key) throws Exception {
		return (new BASE64Encoder()).encodeBuffer(key);
	}

	// map对象中存放公私钥
	public static Map<String, Object> initKey() throws Exception {
		// 获得对象 KeyPairGenerator 参数 RSA 1024个字节
		KeyPairGenerator keyPairGen = KeyPairGenerator.getInstance(KEY_ALGORITHM);
		keyPairGen.initialize(1024);
		// 通过对象 KeyPairGenerator 获取对象KeyPair
		KeyPair keyPair = keyPairGen.generateKeyPair();

		// 通过对象 KeyPair 获取RSA公私钥对象RSAPublicKey RSAPrivateKey
		RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();
		RSAPrivateKey privateKey = (RSAPrivateKey) keyPair.getPrivate();
		// 公私钥对象存入map中
		Map<String, Object> keyMap = new HashMap<String, Object>(2);
		keyMap.put(PUBLIC_KEY, publicKey);
		keyMap.put(PRIVATE_KEY, privateKey);
		return keyMap;
	}

	public static void main(String[] args) {
		Map<String, Object> keyMap;
		try {
			keyMap = initKey();
			String publicKey = getPublicKey(keyMap);
			System.out.println(publicKey);
			String privateKey = getPrivateKey(keyMap);
			System.out.println(privateKey);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 方法描述：签名
	 * 
	 * @param: String
	 *             content, PrivateKey key, String charsetSet
	 * @return: String
	 * @version: 1.0
	 * @time: 2011-12-7 上午9:12:48
	 */
	public static String signPrivateKey(String content, PrivateKey key, String charsetSet) throws NoSuchAlgorithmException, IOException,
			InvalidKeySpecException, InvalidKeyException, SignatureException {
		PrivateKey prikey = key;

		Signature signature = Signature.getInstance("SHA1WithRSA");

		signature.initSign(prikey);

		signature.update(content.getBytes(charsetSet));

		byte[] signBytes = signature.sign();

		String sign = new String(Base64.encodeBase64(signBytes));
		return sign;
	}

	/**
	 * 方法描述：验签
	 * 
	 * @param: String
	 *             content, String sign,PublicKey key,String charsetSet
	 * @return: boolean
	 * @version: 1.0
	 * @time: 2011-12-7 上午9:28:04
	 */
	public static boolean verifyPublicKey(String content, String sign, PublicKey key, String charsetSet) throws NoSuchAlgorithmException, IOException,
			InvalidKeySpecException, InvalidKeyException, SignatureException {
		PublicKey pubkey = key;

		byte[] signed = Base64.decodeBase64(sign.getBytes());

		Signature signature = Signature.getInstance("SHA1WithRSA");

		signature.initVerify(pubkey);

		signature.update(content.getBytes(charsetSet));

		return signature.verify(signed);
	}

	/**
	 * 方法描述：签名
	 * 
	 * @param: String
	 *             content, PrivateKey key
	 * @return: String
	 * @version: 1.0
	 * @time: 2011-12-7 上午9:22:21
	 */
	public static String signPrivateKey(String content, PrivateKey key) throws NoSuchAlgorithmException, IOException, InvalidKeySpecException,
			InvalidKeyException, SignatureException {
//		PrivateKey prikey = key;
//
//		Signature signature = Signature.getInstance("SHA1WithRSA");
//		signature.initSign(prikey);
//		signature.update(content.getBytes("UTF-8"));
//		byte[] signBytes = signature.sign();
//		String sign = new String(Base64.encodeBase64(signBytes));
		return signPrivateKey( content, key, "UTF-8");
//		return sign;
	}

	/**
	 * 方法描述：验签
	 * 
	 * @param: String
	 *             content, String sign,PublicKey key
	 * @return: boolean
	 * @version: 1.0
	 * @time: 2011-12-7 上午9:25:05
	 */
	public static boolean verifyPublicKey(String content, String sign, PublicKey key) throws NoSuchAlgorithmException, IOException,
			InvalidKeySpecException, InvalidKeyException, SignatureException {
		PublicKey pubkey = key;

		byte[] signed = Base64.decodeBase64(sign.getBytes());

		Signature signature = Signature.getInstance("SHA1WithRSA");

		signature.initVerify(pubkey);

		signature.update(content.getBytes("UTF-8"));

		return signature.verify(signed);
	}
}