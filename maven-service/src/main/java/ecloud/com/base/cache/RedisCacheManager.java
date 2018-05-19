package ecloud.com.base.cache;

import java.util.Arrays;
import java.util.Collection;
import java.util.List;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.data.redis.core.RedisTemplate;

/**
 * CacheManager implementation for Redis.
 * 
 * @author cao qiang
 */
public class RedisCacheManager implements CacheManager, InitializingBean {

	private final ConcurrentMap<String, Cache> caches = new ConcurrentHashMap<String, Cache>();
	private String names;
	private List<String> cacheNames;

	public void setNames(String names) {
		this.names = names;
	}
	private RedisTemplate redisTemplate;
	private long liveTime;
	public void setLiveTime(long liveTime) {
		this.liveTime = liveTime;
	}
	public void setRedisTemplate(RedisTemplate redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

	public Cache getCache(String name) {
		Cache c = caches.get(name);
		if (c == null) {
			synchronized (caches) {
				c = caches.get(name);
				if (c == null) {
					c = createCache(name);
					caches.put(name, c);
				}
			}
		}

		return c;
	}

	protected Cache createCache(String name) {
		RedisCache cache = new RedisCache();
		cache.setName(name);
		cache.setRedisTemplate(redisTemplate);
		cache.setLiveTime(liveTime);
		return cache;

	}

	public void afterPropertiesSet() throws Exception {
		if (StringUtils.isNotEmpty(names)) {
			cacheNames = Arrays.asList(names.split(","));
		}

	}

	public Collection<String> getCacheNames() {
		return cacheNames;
	}
}