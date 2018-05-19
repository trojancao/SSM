package ecloud.com.base.mq;

import static org.junit.Assert.*;

import javax.annotation.Resource;
import javax.jms.Destination;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.context.annotation.ImportResource;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class) // 使用junit4进行测试
@ContextConfiguration({ "classpath:config/spring/applicationContext-*.xml", "classpath:config/mybatis/*.xml" }) // 加载配置文件

public class ConsumerServiceTest {
@Resource
ConsumerService ConsumerService;

@Resource
Destination destinationQueue;
	@Test
	public void test() {
		System.err.println(ConsumerService.receive(destinationQueue));
	}

}
