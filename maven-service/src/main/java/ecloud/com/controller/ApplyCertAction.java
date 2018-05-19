package ecloud.com.controller;

import ecloud.com.base.annotation.SystemLog;
import ecloud.com.base.controller.BaseController;
import ecloud.com.base.mq.AmqSenderService;
import ecloud.com.base.mq.ConsumerService;
import ecloud.com.base.service.BaseService;
import ecloud.com.model.Log;
import ecloud.com.model.LogVO;
import ecloud.com.model.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.jms.Destination;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("account")
public class ApplyCertAction extends BaseController<Log>{
	@Resource
	protected AmqSenderService amqSenderService;
	@Resource
	ConsumerService ConsumerService;
    @Resource
    private Destination destinationTopic;
    //目的地队列的明证，我们要向这个队列发送消息
    @Resource(name = "destinationQueue")
    private Destination destinationQueue;
	@RequestMapping("/index")
	@SystemLog(module="系统管理",methods="组管理-删除组",description="",operation="查询日志信息")//凡需要处理业务逻辑的.都需要记录操作日志
	public ModelAndView doIndex(Log entity) throws Exception {
		logger.info("1####################" + getInstanceClass().getSimpleName().toLowerCase());
		Map<String, Object> map = new HashMap<String, Object>();
//		map = BeanUtilsBean.getInstance().describe(entity);
//		BeanUtils.populate(entity, map);
//		entity=	(Log) BeanUtils.cloneBean(map);
		try {
			List<LogVO> logs = logService.queryForList(map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		amqSenderService.sendMsg(destinationQueue,"####mq测试#####");
		amqSenderService.sendMsg(destinationTopic,"++++发布主题++++");
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("user/index");
		modelAndView.addObject("entity", entity);
		logger.info("keys:"+myCache.getKeys());
		
//		System.err.println(ConsumerService.receive(destinationQueue));
		return  modelAndView;
	}
	@Override
	public BaseService<Log> getBaseService() {
		return logService;
	}
	@Override
	protected Class getInstanceClass() {
		return this.getClass();
	}	
}
