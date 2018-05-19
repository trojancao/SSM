package ecloud.com.base.mq;

import javax.jms.Destination;

public interface AmqSenderService {

	void sendMsg(Destination destination, Object queue);
}
