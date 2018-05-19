package ecloud.com.dao.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import ecloud.com.base.dao.impl.BusiBaseDaoImpl;
import ecloud.com.dao.ILogDao;
import ecloud.com.mapper.base.LogMapper;
import ecloud.com.model.Log;
import ecloud.com.model.LogVO;
@Repository
public class LogDaoImpl extends BusiBaseDaoImpl<Log>  implements ILogDao {

	//对应xml（工具生成）中namespace 可换成其他的，如ILogDao
	protected Class<LogMapper> getEClass() {
		return LogMapper.class;
	}


	// 多表链接查询
	public List<Log> queryLogList(Map<String, Object> map) throws Exception {
		return this.getSqlSession().selectList(this.getClass().getName()+".queryLogList", map);
//		return queryForList("ecloud.com.mapper.LogMapper.queryForList", map);
	}
	
//	@Override
//	public  List<Log> queryForList(Map<String, Object> map) throws Exception {
//		return queryForList(getStatement("queryForList"), map);
//	}
	
}
