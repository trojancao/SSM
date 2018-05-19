package ecloud.com.base.cache;

import java.io.Serializable;
import java.util.concurrent.Callable;

import org.apache.commons.lang3.SerializationUtils;
import org.springframework.cache.Cache;
import org.springframework.cache.support.SimpleValueWrapper;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;

public class RedisCache implements Cache {

	private RedisTemplate<String, Object> redisTemplate;
	private String name;
	/**
	 * 超时时间
	 */
	private long liveTime;
	private static String delimeter="_";

	public RedisTemplate<String, Object> getRedisTemplate() {
		return redisTemplate;
	}

	public void setRedisTemplate(RedisTemplate<String, Object> redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

	public void setLiveTime(long liveTime) {
		this.liveTime = liveTime;
	}

	public void clear() {
		System.out.println("-------緩存清理------");
		redisTemplate.execute(new RedisCallback<String>() {
			@Override
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				connection.flushDb();
				return "ok";
			}
		});
	}

	public void evict(Object key) {
		System.out.println("-------緩存刪除------");
		final String keyf = name.concat(delimeter).concat(key.toString()) ;
		redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.del(keyf.getBytes());
			}
		});
	}

	public ValueWrapper get(Object key) {
		System.out.println("------缓存获取-------" + key.toString());
		final String keyf = name.concat(delimeter).concat(key.toString()) ;
		Object object = null;
		object = redisTemplate.execute(new RedisCallback<Object>() {
			@Override
			public Object doInRedis(RedisConnection connection) throws DataAccessException {
				byte[] key = keyf.getBytes();
				byte[] value = connection.get(key);
				if (value == null) {
					System.out.println("------缓存不存在-------");
					return null;
				}
				return SerializationUtils.deserialize(value);
			}
		});
		ValueWrapper obj = (object != null ? new SimpleValueWrapper(object) : null);
		System.out.println("------获取到内容-------" + obj);
		return obj;
	}

	public void put(Object key, Object value) {
		System.out.println("-------加入缓存------");
		System.out.println("key----:" + key);
		System.out.println("key----:" + value);
		final String keyString = name.concat(delimeter).concat(key.toString()) ;
		final Object valuef = value;
		// final long liveTime = 86400;
		redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				byte[] keyb = keyString.getBytes();
				byte[] valueb = SerializationUtils.serialize((Serializable) valuef);
				connection.set(keyb, valueb);
				if (liveTime > 0) {
					connection.expire(keyb, liveTime);
				}
				return 1L;
			}
		});

	}

	/**
	 * 获取序列
	 * 
	 * @param key
	 *            键值
	 * @param step
	 *            步数
	 */
	public void incr( String key, final long step) {
		System.out.println("-------取序列------");
		final String keyf = name.concat(delimeter).concat(key.toString()) ;
		redisTemplate.execute(new RedisCallback<Long>() {
			@Override
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.incrBy(keyf.getBytes(), step);
			}
		});
	}

	public void publish(String channel) {
		redisTemplate.convertAndSend(channel, "message");
		
	}
	public String getName() {
		return this.name;
	}

	public Object getNativeCache() {
		return this.redisTemplate;
	}

	public void setName(String name) {
		this.name = name;
	}


	@Override
	public <T> T get(Object key, Class<T> type) {
		return null;
	}

	@Override
	public <T> T get(Object key, Callable<T> valueLoader) {
		return null;
	}

	@Override
	public ValueWrapper putIfAbsent(Object key, Object value) {
		return null;
	}
}