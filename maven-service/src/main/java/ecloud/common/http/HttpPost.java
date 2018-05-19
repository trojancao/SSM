package ecloud.common.http;

import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class HttpPost {
	private static HttpTransport httpTransport;
	private static CloseableHttpClient httpClient;

	protected static Logger logger = (Logger) LoggerFactory.getLogger(HttpPost.class);

	/**
	 * 发送接口并验签
	 * 
	 * 2017年5月4日
	 * 
	 * @param sign
	 * @return
	 * @throws Exception
	 *             String
	 */
	public static String post(String sign) throws Exception {

		byte[] responseByte = httpTransport(sign,"");

		String response = new String(responseByte, "UTF-8");
		logger.info("{http-response}:" + response);
		/**
		 * 验签
		 */
//		if (!XmlVerify.verify(response)) {
//			throw new RuntimeException("验签失败");
//		}
		return response;

	}

	/**
	 * 发送接口
	 * 
	 * 2017年5月4日
	 * 
	 * @param sign
	 * @return
	 * @throws Exception
	 *             String
	 */
	public static byte[] httpTransport(String sign,String url) throws Exception {
		httpTransport = new HttpTransport();
		httpClient = HttpClients.custom().build();
		byte[] responseByte = null;

		responseByte = (byte[]) httpTransport.httpPost(url, "utf-8",
				sign.getBytes("UTF-8"), httpClient);

		return responseByte;

	}

}
