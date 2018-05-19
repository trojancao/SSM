package ecloud.com.base.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

import org.springframework.cache.annotation.Cacheable;

/**
 * 基于注解的缓存 存入cacheManager管理的ehRedisCache缓存中
 * @author caoqiang
 *
 */
@Target({ElementType.TYPE, ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Cacheable(value="ehRedisCache")
public @interface EhRedisCache {

}
