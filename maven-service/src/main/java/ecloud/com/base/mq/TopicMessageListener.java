package ecloud.com.base.mq;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.MessageListener;
import javax.jms.TextMessage;

/**
 * 异步方式消费消息
 * @author caoqiang
 *
 */
public class TopicMessageListener implements MessageListener {

    @Override
    public void onMessage(Message msg) {
        if (msg instanceof TextMessage) {
            try {
                TextMessage txtMsg = (TextMessage) msg;
                String message = txtMsg.getText();
                //实际项目中拿到String类型的message(通常是JSON字符串)之后，
                //会进行反序列化成对象，做进一步的处理
                System.out.println("TopicMessageListener receive txt msg===" + message + "destination==" +txtMsg);
            } catch (JMSException e) {
                throw new RuntimeException(e);
            }
        } else {
            throw new IllegalArgumentException("Message must be of type TextMessage");
        }
    }
}
