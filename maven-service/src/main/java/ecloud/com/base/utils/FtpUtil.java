package ecloud.com.base.utils;
///**
// * 
// */
//package ecloud.common.utils;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.IOException;
//
//import sun.net.TelnetInputStream;
//import sun.net.ftp.FtpClient;
//
//
///**
// * @author caoqiang
// *
// */
//public class FtpUtil {
//	/**
//	 * FTP客户端
//	 */
//	private FtpClient ftpClient ;
//
//	/**
//	 * 服务器连接
//	 * 
//	 * @param ip
//	 *            服务器ip
//	 * @param port
//	 *            服务器端口
//	 * @param user
//	 *            用户名
//	 * @param password
//	 *            密码
//	 * @param path
//	 *            服务器路径
//	 * @author 王运涛
//	 * @date 2014-11-06
//	 */
//	public boolean connectServer(String ip, String port, String user, String password, String path) {
//		try {
//			ftpClient = new FtpClient(ip);
//			ftpClient.login(user, password);
//			// 设置成2进制传输
//			ftpClient.binary();
//			if (path.length() != 0) {
//				// 把远程系统上的目录切换到参数path指定目录
//				ftpClient.cd(path);
//			}
//			ftpClient.binary();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//			throw new RuntimeException(e);
//		}
//		return true;
//	}
//
//	/**
//	 * 关闭连接
//	 * 
//	 * @author 王运涛
//	 * @date 2014-11-06
//	 */
//	public void closeContect() {
//		try {
//			ftpClient.closeServer();
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
//	}
//
//	/**
//	 * 下载文件
//	 * 
//	 * @param remoteFile
//	 *            远程文件路径（服务器端）
//	 * @param localfile
//	 *            本地文件
//	 * @author 王运涛
//	 * @date 2014-11-06
//	 */
//	public void download(String remoteFile, String localFile) {
//		TelnetInputStream is = null;
//		FileOutputStream os = null;
//		try {
//			// 获取远程机器上的文件filename, 借助TelnetInputStream把文件传送到本地
//			is = ftpClient.get(remoteFile);
//			File file_in = new File(localFile);
//			os = new FileOutputStream(file_in);
//			byte[] bytes = new byte[1024];
//			int c;
//			while ((c = is.read(bytes)) != -1) {
//				os.write(bytes, 0, c);
//			}
//			System.out.println("download success");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			System.out.println("download fail");
//			e.printStackTrace();
//		} finally {
//			try {
//				if (is != null) {
//					is.close();
//				}
//			} catch (IOException e) {
//				// TODO Auto-generated catch block
//				e.printStackTrace();
//			} finally {
//				try {
//					if (is != null) {
//						os.close();
//					}
//				} catch (IOException e) {
//					// TODO Auto-generated catch block
//					e.printStackTrace();
//				}
//			}
//		}
//		
//		
//	}
//
//	public static void main(String[] args) {
//		FtpUtil fu = new FtpUtil();
//		fu.connectServer("192.168.169.36", "21", "cardftp", "card", "/home/cardftp/upfil/20170510");
//		fu.download("UPTRLOG_DZN_HX_20170510", "/Users/caoqiang/Desktop/temp.txt");
//		fu.closeContect();
//	}
//}
