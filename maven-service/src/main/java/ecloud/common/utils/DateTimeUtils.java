package ecloud.common.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateTimeUtils {

	/**
	 * 默认日期格式, <code>yyyy-MM-dd</code>
	 */
	public static final String PATTERN_DEFAULT = "yyyy-MM-dd";

	/**
	 * 路径格式, <code>yyyy\MM\dd\</code>
	 */
	public static final String PATTERN_DAYPATH = "yyyy\\MM\\dd\\";

	/**
	 * 日期时间格式, <code>yyyy-MM-dd HH:mm:ss</code>, 24小时制
	 */
	public static final String PATTERN_DATETIME = "yyyy-MM-dd HH:mm:ss";

	/**
	 * 无间隔符的日期时间格式, <code>yyyyMMddHHmmss</code>, 24小时制
	 */
	public static final String PATTERN_DATETIME_COMPACT = "yyyyMMddHHmmss";

	/**
	 * 无间隔符日期格式, <code>yyyyMMdd</code>
	 */
	public static final String PATTERN_DATE_COMPACT = "yyyyMMdd";

	/**
	 * 无间隔符日期格式, <code>yyMMdd</code>
	 */
	public static final String PATTERN_DATESHORT = "yyMMdd";

	/**
	 * 年月, <code>yyyyMM</code>
	 */
	public static final String PATTERN_YEARMONTH = "yyyyMM";
	
	/**
	 * 年月, <code>yyyyMM</code>
	 */
	public static final String PATTERN_MONTHDAY = "MMddHHmmss";

	
	public static String formatDateTimeCompact(Date date) {
		if (date == null)
			return null;
		return new SimpleDateFormat(PATTERN_DATETIME_COMPACT).format(date);
	}
	
	public static String formatDateCompact(Date date) {
		if (date == null)
			return null;
		return new SimpleDateFormat(PATTERN_DATE_COMPACT).format(date);
	}
	
	/**
	 * <b> 根据默认格式(<code>yyyy-MM-dd</code>),格式化日期 </b>
	 * 
	 * @param date
	 *            日期
	 * @return java.util.Date
	 */
	public static String formatDate(Date date) {
		if (date == null)
			return null;
		return new SimpleDateFormat(PATTERN_DEFAULT).format(date);
	}

	/**
	 * <b> 根据指定格式,格式化日期 </b>
	 * 
	 * @param date
	 *            日期
	 * @param pattern
	 *            指定格式,参照类中常量定义
	 * @return java.util.Date
	 */
	public static String formatDate(Date date, String pattern) {
		return new SimpleDateFormat(pattern).format(date);
	}

	/**
	 * <b> 根据指定格式转换字符串为日期 </b> <br>
	 * 
	 * 如果字符串格式不正确,则返回null
	 * 
	 * 
	 * @param dateString
	 *            日期字符串
	 * @param pattern
	 *            指定格式,参照类中常量定义
	 * @return java.util.Date
	 */
	public static Date parseDate(String dateString, String pattern) {
		try {
			return new SimpleDateFormat(pattern).parse(dateString);
		} catch (ParseException pe) {
			return null;
		}
	}

	/**
	 * <b> 将默认格式(<code>yyyy-MM-dd</code>)的日期字符串转换成<code>java.util.Date</code>类型
	 * </b>
	 * 
	 * @param dateString
	 *            日期字符串
	 * @return java.util.Date
	 */
	public static Date parseDate(String dateString) {
		return parseDate(dateString, PATTERN_DEFAULT);
	}

	/**
	 * 计算日期
	 * 
	 * @param date
	 *            需要计算的日期
	 * @param timeUnit
	 *            时间单位 (Calendar.HOUR, Calendar.DATE, Calendar.MONTH,
	 *            Calendar.YEAR)
	 * @param amount
	 *            增减数,可以为负数
	 * @author LiuYuan
	 * @return
	 */
	public static Date accountDate(Date date, int timeUnit, int amount) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		c.add(timeUnit, amount);
		return c.getTime();
	}

	/**
	 * 获取日期所在年份的总天数
	 * 
	 * @param date
	 * @return
	 * @author LiuYuan
	 */
	public static int getDaysOfCurrentYear(Date date) {
		Calendar c = GregorianCalendar.getInstance();
		c.setTime(date);
		return c.isLenient() ? 366 : 365;
	}

	/**
	 * 获取日期所在月份的总天数
	 * 
	 * @param date
	 * @return
	 * @throws Exception
	 * @author LiuYuan
	 */
	public static int getDaysOfCurrentMonth(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.getActualMaximum(Calendar.DAY_OF_MONTH);
	}

	/**
	 * 获取当前时间于本年是星期数
	 * 
	 * @param date
	 * @return
	 */
	public static int getWeekOfCurrentDate(Date date) {
		Calendar c = Calendar.getInstance();
		c.setTime(date);
		return c.get(Calendar.WEEK_OF_YEAR) - 1;
	}

	/**
	 * 计算两个日期相差的单位数,取整值
	 * 
	 * @param date1
	 *            日期1
	 * @param date2
	 *            日期2
	 * @param unit
	 *            时间单位
	 * @return
	 * @throws Exception
	 * @author LiuYuan
	 */
	public static int getDiscrepantUnits(Date date1, Date date2, int timeUnit) {
		if (isSameDate(date1, date2))
			return 0;
		Calendar c1 = Calendar.getInstance();
		Calendar c2 = Calendar.getInstance();
		c1.setTime(date1.before(date2) ? date1 : date2);
		c2.setTime(date1.before(date2) ? date2 : date1);
		int count = -1;
		while (c1.before(c2)) {
			c1.add(timeUnit, 1);
			count++;
		}

		return date1.before(date2) ? count : -count;
	}

	/**
	 * 返回两个日期相差的天数
	 * 
	 * @param dateStart
	 * @param dateEnd
	 * @return
	 */
	public static int getDiscrepantDays(Date dateStart, Date dateEnd) {
		return (int) ((dateEnd.getTime() - dateStart.getTime()) / 1000 / 60 / 60 / 24);
	}

	/**
	 * 计算两个日期之间相差多少月 精确到月
	 * 
	 * @param dateStart
	 * @param dateEnd
	 * @return
	 * @throws Exception
	 * @author LiuYuan
	 */
	public static int getDiscrepantMonthI(Date dateStart, Date dateEnd) {
		Calendar calendarEnd = Calendar.getInstance();
		Calendar calendarStart = Calendar.getInstance();
		calendarEnd.setTime(dateEnd);
		calendarStart.setTime(dateStart);
		return ((calendarEnd.get(Calendar.YEAR) - calendarStart
				.get(Calendar.YEAR)) * 12)
				+ (calendarEnd.get(Calendar.MONTH) - calendarStart
						.get(Calendar.MONTH));
	}

	/**
	 * 计算两时间相差周数,以周六为每周结束时间
	 * 
	 * @param dateStart
	 * @param dateEnd
	 * @return
	 */
	public static int getDiscrepantWeeks(Date dateStart, Date dateEnd) {
		Calendar calendarEnd = Calendar.getInstance();
		Calendar calendarStart = Calendar.getInstance();
		calendarEnd.setTime(dateEnd);
		calendarStart.setTime(dateStart);
		return calendarEnd.get(Calendar.WEEK_OF_YEAR)
				- calendarStart.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 * 判断两个日期的大小关系
	 * 
	 * @param d1
	 * @param d2
	 * @return -1 d1在d2之前, 0 d1与d2相等, 1 d1在d2之后
	 * @throws Exception
	 */
	public static int compareDay(Date d1, Date d2) {
		return isSameDay(d1, d2) ? 0 : (d1.before(d2) ? -1 : 1);
	}

	/**
	 * 比较两个日期是否相同
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 * @throws Exception
	 */
	public static boolean isSameDate(Date date1, Date date2) {
		return !(date1.before(date2) || date2.before(date1));
	}

	/**
	 * 比较两个日期是否相同, 只是比较年月日
	 * 
	 * @param date1
	 * @param date2
	 * @return
	 * @throws Exception
	 */
	public static boolean isSameDay(Date date1, Date date2) {
		return formatDate(date1).equals(formatDate(date2));
	}

	/**
	 * 根据日时间得到当今天开始时间
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartOfDay(Date date) {
		return parseDate(formatDate(date, PATTERN_DEFAULT) + " 00:00:00",
				PATTERN_DATETIME);
	}

	/**
	 * 根据日时间得到当今天结束时间
	 * 
	 * @param date
	 * @return
	 */
	public static Date getEndOfDay(Date date) {
		return parseDate(formatDate(date, PATTERN_DEFAULT) + " 23:59:59",
				PATTERN_DATETIME);
	}

	/**
	 * 获取年底的日期
	 * 
	 * @return
	 */
	public static Date getEndOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return parseDate(calendar.get(Calendar.YEAR) + "-12-31");
	}

	/**
	 * 获取年初日期
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartOfYear(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		return parseDate(calendar.get(Calendar.YEAR) + "-01-01");
	}

	/**
	 * 获取下月底日期
	 * 
	 * @param date
	 * @return
	 * @throws Exception
	 */
	public static Date getEndOfNextMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		calendar.add(Calendar.MONTH, 1);
		calendar.set(Calendar.DAY_OF_MONTH,
				getDaysOfCurrentMonth(parseDate(calendar.get(Calendar.YEAR)
						+ "-" + (calendar.get(Calendar.MONTH) + 1) + "-1")));
		return calendar.getTime();
	}

	/**
	 * 根据日时间取本周开始日期
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartOfWeek(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
		calendar.add(Calendar.DATE, -dayOfWeek);
		return getStartOfDay(calendar.getTime());
	}

	/**
	 * 根据日时间取本周结束日期
	 * 
	 * @param date
	 * @return
	 */
	public static Date getEndOfWeek(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK) - 1;
		calendar.add(Calendar.DATE, 6 - dayOfWeek);
		return getEndOfDay(calendar.getTime());
	}

	/**
	 * 根据日时间取本月开始日期
	 * 
	 * @param date
	 * @return
	 */
	public static Date getStartOfMonth(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int year = calendar.get(Calendar.YEAR);
		int month = calendar.get(Calendar.MONTH) + 1;
		int day = 1;
		return getStartOfDay(parseDate(String.valueOf(year) + "-"
				+ String.valueOf(month) + "-" + String.valueOf(day)));
	}

	/**
	 * 根据日时间取本月结束日期
	 * 
	 * @param date
	 * @return
	 */
	public static Date getEndOfMonth(Date date) {
		date = getStartOfMonth(date);
		date = accountDate(date, Calendar.MONTH, 1);
		date = accountDate(date, Calendar.DATE, -1);
		return getEndOfDay(date);
	}

}
