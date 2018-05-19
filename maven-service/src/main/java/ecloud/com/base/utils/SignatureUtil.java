package ecloud.com.base.utils;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class SignatureUtil {
	public static String getSignature(Map<String, String> paramMap) {
		List<String> paramList = new ArrayList<String>();
		for (Map.Entry entry : paramMap.entrySet()) {
			paramList.add(entry.getKey().toString());
		}

		Collections.sort(paramList);
		StringBuffer sb = new StringBuffer(SystemConfig.getValue("secret"));
		if (paramList.size() > 0) {
			for (String paramName : paramList) {
				if (!("signature".equals(paramMap.get(paramName)))) {
					String value = (String) paramMap.get(paramName);
					if ((value != null) && (!("".equals(value)))) {
						sb.append(value);
					}
				}
			}
		}
		sb.append(SystemConfig.getValue("secret"));

		String verifySign = MD5Util.encode(sb.toString());
		return verifySign;
	}


	public static String getSignatureForObject(Map<String, Object> paramMap) {
		List<String> paramList = new ArrayList<String>();
		for (Map.Entry entry : paramMap.entrySet()) {
			paramList.add(entry.getKey().toString());
		}

		Collections.sort(paramList);
		StringBuffer sb = new StringBuffer(SystemConfig.getValue("secret"));
		if (paramList.size() > 0) {
			for (String paramName : paramList) {
				if (!("signature".equals(paramMap.get(paramName)))) {
					String value = paramMap.get(paramName).toString();
					if ((value != null) && (!("".equals(value)))) {
						sb.append(value);
					}
				}
			}
		}
		sb.append(SystemConfig.getValue("secret"));

		String verifySign = MD5Util.encode(sb.toString());
		return verifySign;
	}

	public static String getSignString(Map<String, String> paramMap) {
		StringBuffer sb = new StringBuffer();
		for (Map.Entry entry : paramMap.entrySet()) {
			sb.append(entry.getValue());
		}

		String verifySign = SystemConfig.getValue("secret") + sb.toString() + SystemConfig.getValue("secret");

		verifySign = MD5Util.MD5(verifySign);
		return verifySign;
	}
}
