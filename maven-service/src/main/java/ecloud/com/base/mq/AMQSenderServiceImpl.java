package ecloud.com.base.mq;

import javax.annotation.Resource;
import javax.jms.Destination;
import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.jms.core.MessageCreator;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

@Service
public class AMQSenderServiceImpl implements AmqSenderService{
	 private static final Logger logger = LoggerFactory.getLogger(AMQSenderServiceImpl.class);

	    @Resource(name = "jmsTemplate")
	    private JmsTemplate jmsTemplate;

	    //向特定的队列发送消息
	    @Override
	    public void sendMsg(Destination destination,Object queue) {
	        final String msg = JSON.toJSONString(queue);
	        try {
	            logger.info("发送的消息msg:{}-{}", destination, msg);
	            jmsTemplate.convertAndSend(destination, msg);
	            // xml配置了messageConverter 可直接使用convertAndSend 方法
//	            jmsTemplate.send(destination, new MessageCreator() {
//	                @Override
//	                public Message createMessage(Session session) throws JMSException {
//	                    return session.createTextMessage(msg);
//	                }
//	            });

	        } catch (Exception ex) {
	            logger.error("向队列{}发送消息失败，消息为：{}", destination, msg);
	        }

	    }

}
