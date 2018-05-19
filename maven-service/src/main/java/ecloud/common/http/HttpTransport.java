package ecloud.common.http;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.security.KeyStore;

import javax.net.ssl.SSLContext;

import org.apache.http.HttpEntity;
import org.apache.http.HttpStatus;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ssl.SSLConnectionSocketFactory;
import org.apache.http.conn.ssl.SSLContexts;
import org.apache.http.entity.ByteArrayEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;

public class HttpTransport {

	private RequestConfig requestConfig;
	private int connectionRequestTimeout;
	private int connectTimeout;
	private int socketTimeout;

	public HttpTransport() {
		connectionRequestTimeout = 30000;
		connectTimeout = 30000;
		socketTimeout = 30000;
		requestConfig = RequestConfig.custom().setConnectionRequestTimeout(connectionRequestTimeout)
				.setConnectTimeout(connectTimeout).setSocketTimeout(socketTimeout).build();
	}

	public Object httpGet(String url, CloseableHttpClient httpClent) throws IOException {
		HttpGet get = new HttpGet(url);
		get.setConfig(requestConfig);
		get.setHeader("Accept", "text/xml,text/javascript,text/html");
		get.setHeader("Content-Type", "text/html;charset=utf-8");

		CloseableHttpResponse response = null;
		try {
			response = httpClent.execute(get);
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				throw new RuntimeException("通讯失败");
			}
			HttpEntity entity = response.getEntity();
			byte[] ret = EntityUtils.toByteArray(entity);
			EntityUtils.consume(entity);
			return ret;
		} catch (ClientProtocolException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			get.abort();
			if (response != null) {
				response.close();
			}
		}
		return null;
	}

	/**
	 * 
	 * @param uri
	 * @param contentType
	 * @param body json字符串转成byte型
	 * @param httpClent
	 * @return
	 * @throws Exception
	 */
	public Object httpPost(String uri, String contentType, byte[] body, CloseableHttpClient httpClent)
			throws Exception {
		// 使用post方式提交数据
		HttpPost post = new HttpPost(uri);
		post.setConfig(requestConfig);
		post.addHeader("Content-Type", contentType);
		if (body != null) {
			post.setEntity(new ByteArrayEntity(body));
		}
		CloseableHttpResponse response = null;
		try {
			// 执行post请求，并获取服务器端的响应HttpResponse
			response = httpClent.execute(post);
			int statusCode = response.getStatusLine().getStatusCode();
			if (statusCode != HttpStatus.SC_OK) {
				// throw new RuntimeException("通讯失败");
				throw new Exception("通讯失败");
			}
			HttpEntity entity = response.getEntity();
			byte[] ret = EntityUtils.toByteArray(entity);
			EntityUtils.consume(entity);
			return ret;
		} catch (Exception e) {
			throw new Exception("通讯失败", e);
		} finally {
			post.abort();
			if (response != null) {
				response.close();
			}
		}
	}

	@SuppressWarnings("deprecation")
	private SSLConnectionSocketFactory createSSLSocketFactory(String certLocalPath, String certPassword) {
		KeyStore keyStore = null;
		FileInputStream instream = null;
		try {
			keyStore = KeyStore.getInstance("PKCS12");
			instream = new FileInputStream(new File(certLocalPath));// 加载本地的证书进行https加密传输
			keyStore.load(instream, certPassword.toCharArray());// 设置证书密码
			// Trust own CA and all self-signed certs
			SSLContext sslcontext = SSLContexts.custom().loadKeyMaterial(keyStore, certPassword.toCharArray()).build();
			// Allow TLSv1 protocol only
			SSLConnectionSocketFactory sslsf = new SSLConnectionSocketFactory(sslcontext, new String[] { "TLSv1" },
					null, SSLConnectionSocketFactory.BROWSER_COMPATIBLE_HOSTNAME_VERIFIER);
			return sslsf;
		} catch (Exception e) {
			throw new RuntimeException("通讯地址未定义");
		} finally {
			if (instream != null) {
				try {
					instream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
}
