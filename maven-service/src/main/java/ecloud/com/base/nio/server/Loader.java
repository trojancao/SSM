package ecloud.com.base.nio.server;

import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class Loader {

	public static void main(String[] args) {
		Deamon deamon = new Deamon(9999);
//		new Thread(deamon).start();

		ThreadPoolExecutor threadPoolExecutor = new ThreadPoolExecutor(2, 10, 0, TimeUnit.MILLISECONDS, new LinkedBlockingQueue<Runnable>(50));
		threadPoolExecutor.submit(deamon);
	}

}