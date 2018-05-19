package ecloud.com.base.cache;

import net.sf.ehcache.Element;
import org.apache.commons.lang3.SerializationUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.Cache;
import org.springframework.cache.support.SimpleValueWrapper;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;

import java.io.*;
import java.util.concurrent.Callable;

/**
 * 两级缓存，一级:ehcache,二级为redisCache
 * 
 * @author yulin
 *
 */
public class EhRedisCache implements Cache {

	private static String delimeter = "_";
	private static final Logger LOG = LoggerFactory.getLogger(EhRedisCache.class);

	private String name;

	private net.sf.ehcache.Cache ehCache;

	private RedisTemplate<String, Object> redisTemplate;

	private long liveTime = 2 * 60L; // 默认1h=1*60*60

	public String getName() {
		return this.name;
	}

	public Object getNativeCache() {
		return this;
	}


	public ValueWrapper get(Object key) {
		Element value = ehCache.get(key);
		LOG.debug("get Cache L1 (ehcache) :{}={},{}", key, value, ehCache.getName());
		if (value != null) {
			return (value != null ? new SimpleValueWrapper(value.getObjectValue()) : null);
		}
		// TODO 这样会不会更好？访问10次EhCache 强制访问一次redis 使得数据不失效
		final String keyStr = name.concat(delimeter).concat(key.toString());
		Object objectValue = redisTemplate.execute(new RedisCallback<Object>() {
			public Object doInRedis(RedisConnection connection) throws DataAccessException {
				byte[] key = keyStr.getBytes();
				byte[] value = connection.get(key);
				if (value == null) {
					return null;
				}
				// 每次获得，重置缓存过期时间
				if (liveTime > 0) {
					connection.expire(key, liveTime);
				}
				return SerializationUtils.deserialize(value);
				// return toObject(value);
			}
		}, true);
		if (objectValue != null) {
			ehCache.put(new Element(key, objectValue));// 取出来之后缓存到本地
		}

		LOG.debug("get Cache L2 (redis) :{}={}", key, objectValue);
		return (objectValue != null ? new SimpleValueWrapper(objectValue) : null);

	}


	public void put(Object key, Object value) {
		LOG.debug("put Cache L1 (redis) :{}={}", key, value);
		ehCache.put(new Element(key, value));
		final String keyStr = name.concat(delimeter).concat(key.toString());
		final Object valueStr = value;
		redisTemplate.execute(new RedisCallback<Long>() {
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				connection.set(keyStr.getBytes(), SerializationUtils.serialize((Serializable) valueStr));
				if (liveTime > 0) {
					connection.expire(keyStr.getBytes(), liveTime);
				}
				return 1L;
			}
		}, true);

	}

	public void evict(Object key) {
		ehCache.remove(key);
		final String keyStr = name.concat(delimeter).concat(key.toString());
		redisTemplate.execute(new RedisCallback<Long>() {
			public Long doInRedis(RedisConnection connection) throws DataAccessException {
				return connection.del(keyStr.getBytes());
			}
		}, true);
	}

	public void clear() {
		ehCache.removeAll();
		redisTemplate.execute(new RedisCallback<String>() {
			public String doInRedis(RedisConnection connection) throws DataAccessException {
				connection.flushDb();
				return "clear done.";
			}
		}, true);
	}

	public net.sf.ehcache.Cache getEhCache() {
		return ehCache;
	}

	public void setEhCache(net.sf.ehcache.Cache ehCache) {
		this.ehCache = ehCache;
	}

	public RedisTemplate<String, Object> getRedisTemplate() {
		return redisTemplate;
	}

	public void setRedisTemplate(RedisTemplate<String, Object> redisTemplate) {
		this.redisTemplate = redisTemplate;
	}

	public long getLiveTime() {
		return liveTime;
	}

	public void setLiveTime(long liveTime) {
		this.liveTime = liveTime;
	}

	public void setName(String name) {
		this.name = name;
	}


    public <T> T get(Object key, Class<T> type) {
        return null;
    }

    public <T> T get(Object key, Callable<T> valueLoader) {
        return null;
    }

    public ValueWrapper putIfAbsent(Object key, Object value) {
        return null;
    }

    /**
	 * 描述 : Object转byte[]. <br>
	 * 
	 * @param obj
	 * @return
	 */
	private byte[] toByteArray(Object obj) {
		byte[] bytes = null;
		ByteArrayOutputStream bos = new ByteArrayOutputStream();
		try {
			ObjectOutputStream oos = new ObjectOutputStream(bos);
			oos.writeObject(obj);
			oos.flush();
			bytes = bos.toByteArray();
			oos.close();
			bos.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		}
		return bytes;
	}

	/**
	 * 描述 : byte[]转Object . <br>
	 * 
	 * @param bytes
	 * @return
	 */
	private Object toObject(byte[] bytes) {
		Object obj = null;
		try {
			ByteArrayInputStream bis = new ByteArrayInputStream(bytes);
			ObjectInputStream ois = new ObjectInputStream(bis);
			obj = ois.readObject();
			ois.close();
			bis.close();
		} catch (IOException ex) {
			ex.printStackTrace();
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		}
		return obj;
	}
}