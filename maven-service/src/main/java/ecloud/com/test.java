package ecloud.com;//package ecloud.com;
//
//import java.io.UnsupportedEncodingException;
//import java.security.NoSuchAlgorithmException;
//import java.util.HashMap;
//import java.util.Map;
//import java.util.Random;
//
//import com.agile.ecloud.sdk.bean.EcloudPublicKey;
//
//import ecloud.common.http.HttpInvoker;
//import ecloud.common.utils.DateUtil;
//
//
//public class test {
//
//	public static void main(String[] args) throws NoSuchAlgorithmException, UnsupportedEncodingException {
//
//		final String appKey = "yyzw7dsdu69r0e8jw9";
//		final String secret = "2b9c3b64e4ae038abdf735fb9baddcc7";
//		Map<String, Object> params = new HashMap<String, Object>();
//		params.put("timestamp", DateUtil.timeToString(DateUtil.getCurrentTime()));
//		params.put("appKey", appKey);
//		params.put("v", "1.0");
//
//		Random r = new Random();
//		Integer random = r.nextInt(899999) + 100000;
//		params.put("nonce", String.valueOf(random));
//		// params.put("nonce", new DecimalFormat("000000").format(
//		// (Math.random()*1000000)) );
//		//
//		//
//		Map<String, String> map = new HashMap<String, String>();
//		map.put("type", "1");
//		map.put("cardType", "7");
//		map.put("idCardNum", "123456789012");
//		map.put("name", "企业");
//		map.put("mobilePhone", "15051566611");
//
//		String info = com.alibaba.fastjson.JSON.toJSONString(map);
//
//		params.put("info", info);
//		
//		
//		 EcloudPublicKey.init(appKey, secret, "1.0", "https://testapi.ecloudsign.com/ecs/account/applyCert.jspa");
//		 HttpInvoker httpInvoker = HttpInvoker.getInstance();
//		try {
//			String response = httpInvoker.invoke("https://testapi.ecloudsign.com/ecs/account/applyCert.jspa", params,
//					true);
//		} catch (Exception e1) {
//			// TODO Auto-generated catch block
//			e1.printStackTrace();
//		}
//		// TODO Auto-generated method stub
//
//	}
//
//}
