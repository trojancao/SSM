package ecloud.com.base.redis;//package ecloud.com.base.redis;
//
//
//import java.util.List;
//import java.util.concurrent.ScheduledThreadPoolExecutor;
//import java.util.concurrent.TimeUnit;
//
//import net.zicp.xiaochangwei.web.dao.CityDao;
//import net.zicp.xiaochangwei.web.dao.FeedBackDao;
//import net.zicp.xiaochangwei.web.dao.HobbyDao;
//import net.zicp.xiaochangwei.web.dao.PhotoDao;
//import net.zicp.xiaochangwei.web.dao.RolePermissionDao;
//import net.zicp.xiaochangwei.web.dao.UserDao;
//import net.zicp.xiaochangwei.web.entity.City;
//import net.zicp.xiaochangwei.web.entity.Hobby;
//import net.zicp.xiaochangwei.web.entity.HobbyType;
//import net.zicp.xiaochangwei.web.entity.Permission;
//import net.zicp.xiaochangwei.web.entity.Photos;
//import net.zicp.xiaochangwei.web.entity.Role;
//import net.zicp.xiaochangwei.web.entity.UserInfo;
//import net.zicp.xiaochangwei.web.utils.Constant;
//import net.zicp.xiaochangwei.web.utils.NamedThreadFactory;
//
//import org.apache.commons.collections.CollectionUtils;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.DisposableBean;
//import org.springframework.beans.factory.InitializingBean;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.beans.factory.annotation.Value;
//import org.springframework.data.redis.core.RedisTemplate;
//import org.springframework.stereotype.Component;
//
//import com.alibaba.fastjson.JSON;
//
///**
// * 
// * @author xiaochangwei
// * redis缓存变动较少的数据并定时刷新
// */
//@Component
//public class BasicDataCacheLoader implements InitializingBean, DisposableBean {
//
//    private final Logger log = LoggerFactory.getLogger(this.getClass());
//
//    protected static final int CORE_SIZE = Runtime.getRuntime().availableProcessors() * 2;
//    
//    @Value("${cache.cacheExpire}")
//    private long cacheExpire;
//
//    private ScheduledThreadPoolExecutor executor = null;
//
//    @Autowired
//    private RedisTemplate<String, String> redisCache;
//    
//    @Autowired
//    private FeedBackDao feedBackDao;
//
//    @Autowired
//    private RolePermissionDao rolePermissionDao;
//
//    @Autowired 
//    private CityDao cityDao;
//    
//    @Autowired
//    private HobbyDao hobbyDao;
//    
//    @Autowired
//    private UserDao userDao;
//    
//    @Autowired
//    private PhotoDao photoDao;
//    
//    
//    @Override
//    public void destroy() throws Exception {
//        executor.shutdownNow();
//    }
//
//    @Override
//    public void afterPropertiesSet() throws Exception {
//        
//        executor = new ScheduledThreadPoolExecutor(CORE_SIZE, new NamedThreadFactory("static-info-loader"));
//        RefreshCache refreshCache = new RefreshCache();
//        refreshCache.run();
//        executor.scheduleWithFixedDelay(refreshCache, cacheExpire, cacheExpire, TimeUnit.SECONDS);
//        
//    }
//
//    private class RefreshCache implements Runnable {
//        @Override
//        public void run() {
//            log.info("---开始刷新角色权限缓存-----");
//            List<Role> roles = rolePermissionDao.getAllRole();
//            if (CollectionUtils.isNotEmpty(roles)) {
//                for (Role role : roles) {
//                    List<Permission> permissions = rolePermissionDao.getPermissionByRole(role.getRid());
//                    role.setPermissions(permissions);
//                    redisCache.opsForValue().set(Constant.ROLE + role.getRid(), JSON.toJSONString(role));
//                }
//            }
//            
//            log.info("---开始刷新城市缓存-----");
//            List<City> cityProvince = cityDao.getAllProvince();
//            redisCache.opsForValue().set(Constant.CITY_ROOT, JSON.toJSONString(cityProvince));
//            if (CollectionUtils.isNotEmpty(cityProvince)) {
//                for (City sheng : cityProvince) {
//                    List<City> shis = cityDao.getCityByParentId(sheng.getCid());
//                    sheng.setChildren(shis);
//                    redisCache.opsForValue().set(Constant.CITY + sheng.getCid(), JSON.toJSONString(sheng));
//                    if (CollectionUtils.isNotEmpty(shis)) {
//                        for (City shi : shis) {
//                            List<City> xians = cityDao.getCityByParentId(shi.getCid());
//                            shi.setChildren(xians);
//                            redisCache.opsForValue().set(Constant.CITY + shi.getCid(), JSON.toJSONString(shi));
//                            for (City xian : xians) {
//                                redisCache.opsForValue().set(Constant.CITY + xian.getCid(), JSON.toJSONString(xian));
//                            }
//                        }
//                    }
//                }
//            }
//            
//            log.info("---开始刷新兴趣爱好缓存-----");
//            List<HobbyType> allHobby = hobbyDao.getAllHobbys();
//            if(CollectionUtils.isNotEmpty(allHobby)){
//                for(HobbyType ht : allHobby){
//                    List<Hobby> hobbys = hobbyDao.getHobbyItems(ht.getHtId());
//                    if(CollectionUtils.isNotEmpty(hobbys)){
//                        ht.setHobbys(hobbys);
//                    }
//                    redisCache.opsForValue().set(Constant.HOBBY + ht.getHtId(), JSON.toJSONString(ht));
//                }
//            }
//            
//            log.info("---开始刷新用户信息缓存-----");
//            List<UserInfo> userinfos = userDao.getAllUserInfo();
//            if(CollectionUtils.isNotEmpty(userinfos)){
//                for(UserInfo userInfo : userinfos){
//                    List<Photos> photos = photoDao.getUserPhotos(userInfo.getUserId());
//                    if(CollectionUtils.isNotEmpty(photos)){
//                        userInfo.setPhotos(photos);
//                    }
//                    redisCache.opsForValue().set(Constant.USER_INFO + userInfo.getUserId(), JSON.toJSONString(userInfo));
//                }
//            }
//
//        }
//    }
//    /**
//     * 从redis中获取并解析为对象
//     * @param number
//     * @return
//     */
//    @Override
//    public List<UserInfo> getUserInfoFromCache(int number) {
//        Set<String> sets = redis.keys(Constant.USER_INFO + "*");
//        Iterator<String> it = sets.iterator();
//        List<UserInfo> result = new LinkedList<UserInfo>();
//        int i = 0;
//        while(it.hasNext() && i<number){
//            String item = it.next();
//            String value = redis.opsForValue().get(item);
//            result.add(JSON.parseObject(value,UserInfo.class));
//            i++;
//        }
//        return result;
//    }
//}
