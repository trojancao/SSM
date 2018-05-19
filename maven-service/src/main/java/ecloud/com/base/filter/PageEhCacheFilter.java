package ecloud.com.base.filter;

import net.sf.ehcache.CacheException;
import net.sf.ehcache.constructs.blocking.LockTimeoutException;
import net.sf.ehcache.constructs.web.AlreadyCommittedException;
import net.sf.ehcache.constructs.web.AlreadyGzippedException;
import net.sf.ehcache.constructs.web.filter.FilterNonReentrantException;
import net.sf.ehcache.constructs.web.filter.SimplePageCachingFilter;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;

import javax.servlet.FilterChain;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Enumeration;

public class PageEhCacheFilter extends SimplePageCachingFilter {

	private final static Logger log = org.slf4j.LoggerFactory.getLogger(PageEhCacheFilter.class);

	private final static String FILTER_URL_PATTERNS = "patterns";
	private static String[] cacheURLs;

	private void init() throws CacheException {
		String patterns = filterConfig.getInitParameter(FILTER_URL_PATTERNS);
		cacheURLs = StringUtils.split(patterns, ",");
	}

	@Override
	protected void doFilter(final HttpServletRequest request, final HttpServletResponse response, final FilterChain chain)
			throws AlreadyGzippedException, AlreadyCommittedException, FilterNonReentrantException, LockTimeoutException, Exception {
		if (cacheURLs == null) {
			init();
		}

		String url = request.getRequestURI();
		
		System.err.println("sessionId:"+request.getRequestedSessionId());
		System.err.println("uri:"+request.getRequestURI());
		System.err.println("url:"+request.getRequestURL());
		System.err.println("host:"+request.getRemoteHost());
		System.err.println("addr:" + request.getRemoteAddr());
		System.err.println("port:"+request.getRemotePort());
		System.err.println("user:"+request.getRemoteUser());
		System.err.println("servletPath:"+request.getServletPath());
		System.err.println("method:"+request.getMethod());
//		String url = request.getRequestURI();
		boolean flag = false;
		if (cacheURLs != null && cacheURLs.length > 0) {
			for (String cacheURL : cacheURLs) {
				if (url.contains(cacheURL.trim())) {
					flag = true;
					break;
				}
			}
		}
		log.info("###############flag:"+flag);
		// 如果包含我们要缓存的url 就缓存该页面，否则执行正常的页面转向
		if (flag) {
			String query = request.getQueryString();
			if (query != null) {
				query = "?" + query;
			}
			log.info("当前请求被缓存：" + url + query);
			super.doFilter(request, response, chain);
		} else {
			chain.doFilter(request, response);
		}
	}

	@SuppressWarnings("unchecked")
	private boolean headerContains(final HttpServletRequest request, final String header, final String value) {
		logRequestHeaders(request);
		final Enumeration accepted = request.getHeaders(header);
		while (accepted.hasMoreElements()) {
			final String headerValue = (String) accepted.nextElement();
			if (headerValue.indexOf(value) != -1) {
				return true;
			}
		}
		return false;
	}

	/**
	 * @see net.sf.ehcache.constructs.web.filter.Filter#acceptsGzipEncoding(HttpServletRequest)
	 *      <b>function:</b> 兼容ie6/7 gzip压缩
	 * @author hoojo
	 * @createDate 2012-7-4 上午11:07:11
	 */
	@Override
	protected boolean acceptsGzipEncoding(HttpServletRequest request) {
		boolean ie6 = headerContains(request, "User-Agent", "MSIE 6.0");
		boolean ie7 = headerContains(request, "User-Agent", "MSIE 7.0");
		return acceptsEncoding(request, "gzip") || ie6 || ie7;
	}
}