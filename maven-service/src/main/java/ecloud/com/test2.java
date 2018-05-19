package ecloud.com;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import com.mysql.jdbc.Connection;

public class test2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Random r = new Random();
		Integer random = r.nextInt(899999) + 100000;
		String cardNum = "110105198710" + random.toString();
		String randomName = "";
		for (int i = 0; i < 10; i++) {
			randomName = randomName + (char) (Math.random() * 26 + 'A');
		}
		String mobilePhoneRandomNum = "1581";// "15818322868";
		for (int i = 0; i < 7; i++) {
			mobilePhoneRandomNum = mobilePhoneRandomNum + r.nextInt(9);
		}
	}

	private Connection getCon() throws ClassNotFoundException, SQLException {
		String username = "admin";
		String password = "admin";
		String driver = "com.mysql.jdbc.Driver";
		// 其中test为数据库名称
		String url = "jdbc:mysql://192.168.218.158:3306/test";
		Class.forName(driver);
		Connection conn = (Connection) DriverManager.getConnection(url, username, password);
		return conn;
	}

	private ResultSet getInfo() throws SQLException, ClassNotFoundException {
		Connection conn = getCon();
		PreparedStatement pst = conn.prepareStatement(" select * from ");
		ResultSet rs = pst.executeQuery();
		return rs;

	}

}
