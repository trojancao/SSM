package ecloud.common.utils;

import java.util.Date;

public class IdGenerator {

	public static String idGenerator() {
		
		return  DateTimeUtils.formatDateTimeCompact(new Date()) + (int)(Math.random()*10000);
	}
}
