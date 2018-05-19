package ecloud.common.utils;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

/**
 * =========================================================================== |
 * [_replace_by_our_company_name] [_replaced_by_our_company_website] |
 * Copyright(c) 2009. All rights Reserved. | Unauthorized access, use,
 * dissemination, distribution, reproduction of this | file, or a portion of, in
 * any form is prohibited and unlawful. If you receive | this file and you are
 * not an authorized company employee, or you believe you | have received this
 * file in error, please notify the sender (or originator) | and promptly delete
 * this file. | | File: DateUtil | Created by: shijie.huang | Create Data:
 * 2012-12-26 | Version Number: 1.0 | Version Description:
 * =============================================================================
 **/
public class DateUtil {

	private DateUtil() {
	}

	public final static String PATTEN_YYYYMMDDHHMMSS = "yyyyMMddHHmmss";

	// 获得当前日期与本周一相差的天数
	private static int getMondayPlus() {
		Calendar cd = Calendar.getInstance();
		// 获得今天是一周的第几天，星期日是第一天，星期二是第二天......
		int dayOfWeek = cd.get(Calendar.DAY_OF_WEEK);
		if (dayOfWeek == 1) {
			return -6;
		} else {
			return 2 - dayOfWeek;
		}
	}

	/**
	 * 获得某周周一凌晨的时间
	 * 
	 * @param num
	 *            当num为负时表示前几周的周一时间 当num为0时表示当前周的周一时间 当num为正时表示下几周的周一时间
	 * @return
	 */
	public static String getSuchMonday(int weeks) {
		int mondayPlus = DateUtil.getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 7 * weeks);
		Date monday = currentDate.getTime();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		StringBuffer str = new StringBuffer(df.format(monday));
		str.append(" 00:00:00");
		return str.toString();
	}

	/**
	 * 获得某周周日晚上12点的时间
	 * 
	 * @param num
	 *            当num为负时表示前几周的周日时间 当num为0时表示当前周的周日时间 当num为正时表示下几周的周日时间
	 * @return
	 */
	public static String getSuchSunday(int weeks) {
		int mondayPlus = DateUtil.getMondayPlus();
		GregorianCalendar currentDate = new GregorianCalendar();
		currentDate.add(GregorianCalendar.DATE, mondayPlus + 7 * weeks + 6);
		Date monday = currentDate.getTime();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		StringBuffer str = new StringBuffer(df.format(monday));
		str.append(" 23:59:59");
		return str.toString();
	}

	/**
	 * 某天凌晨时间
	 * 
	 * @return
	 */
	public static String getDayStartString(Date time) {
		Date day = time;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd 00:00:00");
		StringBuffer str = new StringBuffer(df.format(day));
		return str.toString();
	}

	/**
	 * 将时间设置为当天凌晨时间
	 * 
	 * @return
	 */
	public static Date getDayStart(Date time) {
		String timeStr = getDayStartString(time);
		time = stringToTime(timeStr);
		return time;
	}

	/**
	 * 某天晚上12点
	 * 
	 * @return
	 */
	public static String getDayEndString(Date time) {
		Date day = time;
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd 23:59:59");
		StringBuffer str = new StringBuffer(df.format(day));
		return str.toString();
	}

	/**
	 * 将时间设置为当天晚上11点59分59秒
	 * 
	 * @return
	 */
	public static Date getDayEnd(Date time) {
		String timeStr = getDayEndString(time);
		time = stringToTime(timeStr);
		return time;
	}

	/**
	 * 字符串转为时间
	 * 
	 * @param str
	 * @return
	 */
	public static Date stringToTime(String str) {
		Date time = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			time = df.parse(str.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return time;
	}

	/**
	 * 字符串转为时间(只是日期部分)
	 * 
	 * @param str
	 * @return
	 */
	public static Date stringToTimeOnlyDate(String str) {
		Date time = new Date();
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			time = df.parse(str.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return time;
	}

	/**
	 * 字符串转为时间(只是时间部分)
	 * 
	 * @param str
	 * @return
	 */
	public static Date stringToTimeOnlyTime(String str) {
		Date time = new Date();
		DateFormat df = new SimpleDateFormat("HH:mm:ss");
		try {
			time = df.parse(str.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return time;
	}

	/**
	 * 字符串转为时间(只是时间部分)(没有秒数，只有时分)
	 * 
	 * @param str
	 * @return
	 */
	public static Date stringToTimeOnlyTimeNoneSecond(String str) {
		Date time = new Date();
		DateFormat df = new SimpleDateFormat("HH:mm");
		try {
			time = df.parse(str.toString());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return time;
	}

	/**
	 * 时间转为字符串
	 * 
	 * @param time
	 * @return
	 */
	public static String timeToString(Date time) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return df.format(time);
	}

	/**
	 * 时间转为字符串
	 * 
	 * @param time
	 * @return
	 */
	public static String timeToString(Date time, String format) {
		DateFormat df = new SimpleDateFormat(format);
		return df.format(time);
	}

	/**
	 * 时间转为字符串(只是日期部分)
	 * 
	 * @param time
	 * @return
	 */
	public static String timeToStringOnlyDate(Date time) {
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		return df.format(time);
	}

	/**
	 * 时间转为字符串
	 * 
	 * @param time
	 * @return
	 */
	public static String timeToString2(Date time) {
		DateFormat df = new SimpleDateFormat("MM/dd");
		return df.format(time);
	}

	/**
	 * 
	 * 获取当前日期时间
	 * 
	 * @return
	 */
	public static Date getCurrentTime() {
		return getCurrentCalendar().getTime();
	}

	/**
	 * 获取当前日期(only date)
	 * 
	 * @return
	 */
	public static Date getCurrentDate() {
		Calendar result = getCurrentCalendar();
		result.set(Calendar.HOUR, 0);
		result.set(Calendar.MINUTE, 0);
		result.set(Calendar.SECOND, 0);
		return result.getTime();
	}

	/**
	 * 只获取日期部分(only date)
	 * 
	 * @return
	 */
	public static Date timeToTimeOnlyDate(Date time) {
		String str = timeToStringOnlyDate(time);
		time = stringToTimeOnlyDate(str);
		return time;
	}

	/**
	 * 
	 * 获取系统当前时间
	 * 
	 * @return
	 */
	private static Calendar getCurrentCalendar() {
		return Calendar.getInstance();
	}

	/**
	 * 获取某年下有多少周
	 * 
	 * @param year
	 * @return
	 */
	public static int getWeeksByYear(int year) {
		// jdk1.7才可以使用
		/*
		 * Calendar c = Calendar.getInstance();
		 * 
		 * if(year == 0){ year = c.get(Calendar.YEAR) ; }
		 * 
		 * c.set(Calendar.YEAR, year);
		 * 
		 * return c.getWeeksInWeekYear() ;
		 */

		// 1.6 自己实现 。 实现思路主要是设置入参年份加一年减7天 ，然后再算这一天是今年的的几周

		Calendar c = Calendar.getInstance();

		if (year == 0) {
			year = c.get(Calendar.YEAR);
		}

		c.set(Calendar.YEAR, year + 1);

		c.set(Calendar.MONTH, 1);

		c.set(Calendar.DAY_OF_YEAR, 1);

		c.add(Calendar.DAY_OF_YEAR, -7);

		return c.get(Calendar.WEEK_OF_YEAR);

	}

	/**
	 * 输入当前月份 输出当月所处的季度
	 * 
	 * @param month
	 * @return
	 */
	public static int getQuarter(int month) {

		return month / 4 + 1;

	}

	public static void main(String[] args) throws ParseException {

	}
}
