package ecloud.com.service.log.impl;

import java.util.UUID;

import org.springframework.stereotype.Service;

import ecloud.com.base.dao.IBusiBaseDao;
import ecloud.com.base.service.AbstractService;
import ecloud.com.mapper.base.SqlMapper;
import ecloud.com.model.Log;
import ecloud.com.service.log.LogService;

@Service
public class LogServiceImpl extends AbstractService<Log> implements LogService {


	@Override
	protected IBusiBaseDao<Log> getBaseDao() {
		return iLogDao;
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	protected Class getInstanceClass() {
		return this.getClass();
	}

	@Override
	protected SqlMapper<Log> getSqlMapper() {
		return logMapper;
	}
	
//	@MyCacheable
//	@SystemLog(module="service日志查询",description="LogServiceImpl查询日志",methods="queryForList",operation="查询")
//	@Override
//	public List<LogVO> queryForList(Map<String, Object> params) throws Exception {
//		logger.info("3#################################LogServiceImpl.queryForList");
//		return getBaseDao().queryForList(params);
//	}
//	@MyCacheable
//	@Override
//	@SystemLog(module="日志查询",description="LogServiceImpl分页查询日志",methods="queryForPage",operation="查询")
//	public PageBean queryForPage(PageBean pageBean) throws Exception {
//		logger.info("3#################################LogServiceImpl.queryForPage");
//		return getBaseDao().queryForPage(pageBean);
//	}
	
	
//allEntries为true表示清除value中的全部缓存,默认为false  
//    @CacheEvict(value="myCache", allEntries=true)
//    @CacheEvict(value="myCache", key="#logid")
//	@CachePut 注释，这个注释可以确保方法被执行，同时方法的返回值也被记录到缓存中，实现缓存与数据库的同步更新。
//	@CachePut(value="accountCache",key="#account.getName()")// 更新accountCache 缓存  
//	@Cacheable(value = "myCache", key = "#logid") // 注解式缓存
//	@Caching(   //组合缓存
//	        cacheable = {  
//	                @Cacheable(value = "myCache", key = "#p0"),  
//	                @Cacheable(value = "myCache", key = "#p0"),  
//	                @Cacheable(value = "myCache", key = "#p0")  
//	        }  
//	)  

	public String getLoginUserId() {
		return UUID.randomUUID().toString();
	}


}
