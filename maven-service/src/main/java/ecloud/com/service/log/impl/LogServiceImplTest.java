package ecloud.com.service.log.impl;

import ecloud.com.base.model.PageBean;
import ecloud.com.model.Log;
import ecloud.com.model.LogVO;
import ecloud.com.service.log.LogService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

@RunWith(SpringJUnit4ClassRunner.class) // 使用junit4进行测试
@ContextConfiguration({ "classpath:spring/applicationContext-*.xml", "classpath:mybatis/*.xml" }) // 加载配置文件
public class LogServiceImplTest extends AbstractJUnit4SpringContextTests {
	protected Logger logger = LoggerFactory.getLogger(getClass());
	@Resource
	LogService logService;

	@Resource
	CacheManager cacheManager;
	@Resource
	CacheManager redisCacheManager;
	@Resource
	net.sf.ehcache.Cache myCache;

	@Test
	public void test() {
		
		logger.info("1##############"+myCache.getName());
		logger.info("1##############"+redisCacheManager.getCacheNames());
		redisCacheManager.getCache("test").put("1", "1111111111111");
		redisCacheManager.getCache("redistest").put("1", "222222");
		logger.info("test##############"+redisCacheManager.getCache("test").get("1").get());
		logger.info("redistest##############"+redisCacheManager.getCache("redistest").get("1").get());
		
		List<String> keys = myCache.getKeys();
		for (String key : keys) {
			logger.info("key:" + key);
		}

		Log log2= logService.selectByKey("1");
		Map<String, Object> params= new HashMap<>();
		try {
			List<LogVO> logs = logService.queryForList(params);
			Iterator<LogVO> it= logs.iterator();
			while (it.hasNext()) {
				LogVO log = it.next();
//				System.err.println(log);
			}
		} catch (Exception e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
		
		// Cache levelOneCache = (Cache) cacheManager.getCache("myCache");
		PageBean<LogVO> pageBean = null;
		Map<String, Object> params2=new HashMap<>();
		int pageSize=0;
		int pageNum=1;
		try {
			pageBean = logService.queryForPage(params2,pageSize,pageNum);
			List<LogVO> aaa = pageBean.getList();
//			System.err.println(aaa);
			redisCacheManager.getCache("test").put("pagemode", pageBean);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
//		logger.info("================###############list:" + JSON.toJSONString(pageBean));
		logger.info("2##############");
		keys = myCache.getKeys();
		for (String key : keys) {
			logger.info("key:" + key);
		}
		PageBean list2 = new PageBean();
		try {
			list2 = logService.queryForPage(params2,pageSize,pageNum);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
//		logger.info("================###############list2" + JSON.toJSONString(list2));
		try {
			Cache ehRedisCache = cacheManager.getCache("ehRedisCache");
			Cache content = cacheManager.getCache("content");
			Cache common = cacheManager.getCache("common");
//			Cache ehCache = cacheManager.getCache("ehCache");
			logger.info("cachenames:{}",cacheManager.getCacheNames().toString());
			logger.info("ehCache name:{}",myCache.getName());
			keys = myCache.getKeys();
			for (String key : keys) {
				logger.info("key:" + key);
			}
		} catch (Exception e) {
			throw e;
		}

		logger.info("3##############");
	}

}
