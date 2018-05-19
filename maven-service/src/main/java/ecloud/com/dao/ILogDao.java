package ecloud.com.dao;


import ecloud.com.base.dao.IBusiBaseDao;
import ecloud.com.model.Log;

import java.util.List;
import java.util.Map;

public interface ILogDao extends IBusiBaseDao<Log> {
//	public interface ILogDao extends SqlMapper<Log> {

    List<Log> queryLogList(Map<String, Object> map) throws Exception;
}
