package com.lrgame.goc.cn.service;

import android.app.Notification;
import android.app.PendingIntent;
import android.app.Service;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.BitmapFactory;
import android.os.Binder;
import android.os.IBinder;
import android.util.Log;

import androidx.core.app.NotificationCompat;

import com.lrgame.goc.cn.R;
import com.lrgame.goc.cn.page.MainActivity;

public class MyService extends Service {

    Intent myServiceIntent;

    DownloadBinder mBinder = new DownloadBinder();

    public class DownloadBinder extends Binder {
        public void startDownload() {
            Log.d("MyService", "startDownload executed");
        }

        public int getProgress() {
            Log.d("MyService", "getProgress executed");
            return 0;
        }
    }

    public MyService() {
    }

    @Override
    public IBinder onBind(Intent intent) {
        // 绑定Service
        MyBinder myBinder = new MyBinder();
        return myBinder;
    }

    @Override
    public void onCreate() {
        // 创建服务：第一次创建服务的时候调用
        super.onCreate();

        IntentFilter filter = new IntentFilter("android.provider.Telephony.SMS_RECEIVED");
        filter.setPriority(0);

        // 前台服务
        Intent intent = new Intent(this, MainActivity.class);
        PendingIntent pi = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE);
        Notification notification = new NotificationCompat.Builder(this)
                .setContentTitle("This is content title")
                .setContentText("This is content text")
                .setWhen(System.currentTimeMillis())
                .setSmallIcon(R.drawable.mine_icon)
                .setLargeIcon(BitmapFactory.decodeResource(getResources(), R.drawable.mine_icon))
                .setContentIntent(pi)
                .build();
        startForeground(1, notification);
    }

    @Override
    public int onStartCommand(Intent intent, int flags, int startId) {
        // 启动服务：每次启动服务的时候都会调用
        new Thread(new Runnable() {
            @Override
            public void run() {
                // 处理具体的逻辑
                // 服务在执行完毕后自动停止
                stopSelf();
            }
        }).start();
        return super.onStartCommand(intent, flags, startId);
    }

    @Override
    public void onDestroy() {
        // 销毁服务
        super.onDestroy();
//        stopService(myServiceIntent); // 第一种方式：终止服务
        stopSelf(); // 第二种方式：终止服务（无论服务被启动多少次）
    }

    @Override
    public boolean onUnbind(Intent intent) {
        return super.onUnbind(intent);
    }

    public class MyBinder extends Binder {

    }
}