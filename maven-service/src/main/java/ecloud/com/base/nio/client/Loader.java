package ecloud.com.base.nio.client;


import java.util.Scanner;

import ecloud.com.base.utils.Util;

public class Loader {

    public static void main(String[] args) {
        String name = "";
        Deamon deamon = new Deamon("127.0.0.1", 9999);
        new Thread(deamon).start();

        // 在主线程中 从键盘读取数据输入到服务器端
        Scanner scan = new Scanner(System.in);
        while (scan.hasNextLine()) {
            String line = scan.nextLine();
            if ("".equals(line))
                continue; // 不允许发空消息
            if ("".equals(name)) {
                name = line;
                line = name + Util.USER_CONTENT_SPILIT;
            } else {
                line = name + Util.USER_CONTENT_SPILIT + line;
            }
            deamon.chancelToWrite(Util.charset.encode(line));// sc既能写也能读，这边是写
        }
    }
}