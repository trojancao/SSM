package ecloud.com.base.exception;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.SimpleMappingExceptionResolver;

import com.alibaba.fastjson.JSON;

import ecloud.com.base.dto.JsonResp;

public class SpringMVCSimpleMappingExceptionResolver extends SimpleMappingExceptionResolver {
	public static final Logger log = LoggerFactory.getLogger(SpringMVCSimpleMappingExceptionResolver.class);

	@Override
	protected ModelAndView doResolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		ModelAndView mv = null;
		String accept = request.getHeader("accept");
		if (accept != null
				&& !(accept.indexOf("application/json") > -1 || (request.getHeader("X-Requested-With") != null
						&& request.getHeader("X-Requested-With").indexOf("XMLHttpRequest") > -1))) {
			mv = super.doResolveException(request, response, handler, ex);
		} else {
			super.setDefaultStatusCode(200);
			try {
				// json 请求返回
				PrintWriter writer = response.getWriter();
				JsonResp json;
				if (ex instanceof BusiException) {
					json = new JsonResp(0, ((BusiException) ex).getCode(), ex.getMessage(), null);
				} else {
					json = new JsonResp(1, null, ex.getMessage(), null);
				}
				writer.write(JSON.toJSONString(json));
				writer.flush();
				writer.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return mv;
	}
}
