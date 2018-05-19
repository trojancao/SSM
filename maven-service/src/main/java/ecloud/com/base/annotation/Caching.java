package ecloud.com.base.annotation;

import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.CachePut;
import org.springframework.cache.annotation.Cacheable;

public @interface Caching {
	Cacheable[] cacheable() default {}; // 声明多个@Cacheable

	CachePut[] put() default {}; // 声明多个@CachePut

	CacheEvict[] evict() default {}; // 声明多个@CacheEvict
}
