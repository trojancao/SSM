package ecloud.com.base.shiro.dao;


import ecloud.com.base.dao.IBusiBaseDao;
import ecloud.com.base.shiro.entity.Resource;

import java.util.List;

/**
 * <p>Resource: Zhang Kaitao
 * <p>Date: 14-1-28
 * <p>Version: 1.0
 */
public interface ResourceDao extends IBusiBaseDao<Resource> {

    public Resource createResource(Resource resource);
    public Resource updateResource(Resource resource);
    public void deleteResource(Long resourceId);

    Resource findOne(Long resourceId);
    List<Resource> findAll();

}
