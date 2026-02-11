package com.lrgame.goc.cn.page;

import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.localbroadcastmanager.content.LocalBroadcastManager;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;
import android.Manifest;
import android.annotation.SuppressLint;
import android.app.Notification;
import android.app.NotificationManager;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.ComponentName;
import android.content.ContentValues;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.ServiceConnection;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.database.Cursor;
import android.database.sqlite.SQLiteCursorDriver;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteQuery;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.media.MediaPlayer;
import android.net.Uri;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Environment;
import android.os.IBinder;
import android.provider.MediaStore;
import android.util.Log;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.Window;
import android.widget.Toast;
import android.widget.VideoView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.lrgame.goc.cn.R;
import com.lrgame.goc.cn.application.DMApplication;
import com.lrgame.goc.cn.entity.FruitItem;
import com.lrgame.goc.cn.service.MyService;
import com.lrgame.goc.cn.utils.MyDataBaseHelper;
import com.lrgame.goc.cn.utils.MyHandler;

import org.json.JSONArray;
import org.json.JSONObject;
import org.xml.sax.InputSource;
import org.xml.sax.XMLReader;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserFactory;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.StringReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.SAXParserFactory;

public class HomeActivity extends AppCompatActivity {
    private List<FruitItem> fruitList = new ArrayList<>();
    private IntentFilter intentFilter;
    private NetworkChangeReceiver networkChangeReceiver;

    //存储
    private FileOutputStream out = null;
    private BufferedWriter writer = null;
    //读取
    private FileInputStream in = null;
    private BufferedReader reader = null;

    private MediaPlayer player; // 音频
    private VideoView videoView; // 视频

    private static final int TAKE_PHOTO = 0;
    private static final int CROP_PHOTO = 1;

    // API17以后，js只能调用加@JavascriptInterface的java方法
    @SuppressLint({"Range", "JavascriptInterface"})
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.activity_home);
    }

    private void showBroadcast() {
        // 详解广播机制（！！！区别发送广播和接收广播！！！）
        // 1.广播机制概述
        // a>.每个App都可以对自己感兴趣的广播进行注册（只会接收到自己所关心的广播内容）
        // b>.广播可能来自系统，也可能来自其他App（跨进程通信方式）
        // 2.类型
        // a>.标准广播：一种完全异步执行的广播，在广播发出之后，所有的广播接收器（Broadcast Receiver）几乎都会在同一时刻接收到这条广播消息，因此它们之间没有任何先后顺序，这种广播的效率会比较高，但同时也意味着它是无法被截断的
        // b>.有序广播：一种同步执行的广播，在广播发出之后，同一时刻只会有一个Broadcast Receiver能够收到这条广播消息，当这个Broadcast receiver中的逻辑执行完毕后，广播才会继续传递。Broadcast receiver是有先后顺序的，优先级高的Broadcast receiver就可以先收到广播消息，前面的Broadcast receiver还可以截断正在传递的广播，这样后面的Broadcast receiver就无法收到广播消息
        // 3.接收系统广播
        // a>.常见的内置系统级别广播
        // b>.动态注册（程序启动的以后才可以监听/监听网络变化）
        // 添加相应action（指明需要注册的广播）
        intentFilter = new IntentFilter();
        intentFilter.addAction("android.net.conn.CONNECTIVITY_CHANGE");
        networkChangeReceiver = new HomeActivity.NetworkChangeReceiver();
        // 4.注册广播
        registerReceiver(networkChangeReceiver, intentFilter);
        // c.静态注册（程序未启动就可以监听/监听开机启动）
        /*
        // 1>.在AndroidManifest.xml中注册广播
        <receiver
            android:name=".BootCompleteReceiver"
            android:enabled="true"
            android:exported="true" >
            // 2>.添加相应action（指明需要注册的广播）
            <intent-filter>
                <action android:name="android.intent.action.BOOT_COMPLETED"/>
            </intent-filter>
        </receiver>
        */
        // 5.发送自定义广播
        // a>.发送标准广播
        /*
        1>.新建Broadcast Receiver（用于接收广播）
        public class BootCompleteReceiver extends BroadcastReceiver {

            @Override
            public void onReceive(Context context, Intent intent) {
                // 不允许开启线程：不要进行耗时操作
                // onReceive()运行较长时间不结束就会报错
                Toast.makeText(context, "Boot Complete", Toast.LENGTH_LONG).show();
            }
        }
        */
        /*
        2>.在AndroidManifest.xml中注册广播（action自定义）
        <receiver
        android:name=".BootCompleteReceiver"
        android:enabled="true"
        android:exported="true" >
            <intent-filter>
                <action android:name="android.intent.action.MY_BROADCAST"/>
            </intent-filter>
        </receiver>
        */
        // 3>.发送广播
        Intent intent = new Intent("android.intent.action.MY_BROADCAST");
        sendBroadcast(intent);
        // b>.发送有序广播
        /*
        1>.新建Broadcast Receiver（用于接收广播）
        public class BootCompleteReceiver extends BroadcastReceiver {

            @Override
            public void onReceive(Context context, Intent intent) {
                // 不允许开启线程：不要进行耗时操作
                // onReceive()运行较长时间不结束就会报错
                Toast.makeText(context, "Boot Complete", Toast.LENGTH_LONG).show();
            }
        }
        */
        /*
        2>.在AndroidManifest.xml中注册广播（action自定义）
        <receiver
        android:name=".BootCompleteReceiver"
        android:enabled="true"
        android:exported="true" >
            // 3>.设置广播接收器的先后顺序
            <intent-filter android:priority="100">
                <action android:name="android.intent.action.MY_BROADCAST"/>
            </intent-filter>
        </receiver>
        */
        /*
        4>.截断广播
        abortBroadcast();
        */
        sendOrderedBroadcast(intent, null);
        // 6.使用本地广播（跨进程之间通信会存在安全问题，该机制发出去的广播只能在App内部传递）
        LocalBroadcastManager localBroadcastManager = LocalBroadcastManager.getInstance(this); // 获取本地广播管理类
        intent = new Intent("com.lrgame.goc.cn.broadcast.LOCAL_BROADCAST");
        // a>.发送本地广播
        localBroadcastManager.sendBroadcast(intent);
        // b>.接收广播（无法通过静态注册接收广播：因为静态注册是为了让程序在未启动的情况下也能接收广播，而发送本地广播时，我们的程序肯定是已启动）
        // 2>.添加相应action（指明需要注册的广播）
        intentFilter.addAction("android.intent.action.LOCAL_BROADCAST");
        HomeActivity.LocalReceiver localReceiver = new HomeActivity.LocalReceiver();
        localBroadcastManager.registerReceiver(localReceiver, intentFilter);
        // 销毁广播：位于onDestroy()方法中
        localBroadcastManager.unregisterReceiver(localReceiver);
        // c>.本地广播的优点
        // 1>.可以明确地知道正在发送的广播不会离开我们的程序，不必担心机密数据泄漏
        // 2>.其他的程序无法将广播发送到我们程序的内部，因此不需要担心会有安全漏洞的隐患
        // 3>.发送本地广播比发送系统全局广播将会更加高效
    }
    // 1>.新建一个类（广播接收器）：继承BroadcastReceiver
    class NetworkChangeReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {
            /*
            2>.重写onReceive()方法（监听对象发生变化就会执行该方法）
            ConnectivityManager connectivityManager = (ConnectivityManager)getSystemService(Context.CONNECTIVITY_SERVICE);
            NetworkInfo networkInfo = connectivityManager.getActiveNetworkInfo();
            if (networkInfo != null && networkInfo.isAvailable()) {
                Toast.makeText(context, "network is available", Toast.LENGTH_SHORT).show();
            } else {
                Toast.makeText(context, "network is unavailable", Toast.LENGTH_SHORT).show();
            }
            */
        }
    }
    // 1>.新建一个类（本地广播接收器）：继承BroadcastReceiver
    class LocalReceiver extends BroadcastReceiver {
        @Override
        public void onReceive(Context context, Intent intent) {

        }
    }

    private void showSaveData() {
        // 数据持久化
        // 1.概述：将内存中瞬时数据保存在存储设备中
        // 2.方案
        // a>.文件存储（存储简单的文本数据、二进制数据）
        // 1>.特点：不对存储内容进行任何的格式化处理，适合存储简单的文本数据和二进制数据
        // 2>.存储位置：/data/data/<package name>/files/
        // 3>.保存数据到文件中（！！！必须先了解"Java流"！！！）
        FileOutputStream out = null;
        BufferedWriter writer = null;
        try {
            // data - 文件名（不可以包含路径，因为所有的文件都默认存储在/data/data/<package name>/files/）
            // Context.MODE_PRIVATE - 文件操作模式
            // MODE_PRIVATE - （默认）当指定同样文件名的时候所写入的内容将会覆盖源文件的内容
            // MODE_APPEND - 文件已经存在就往文件中追加内容，不存在就创建新文件
            out = openFileOutput("data", Context.MODE_PRIVATE);
            writer = new BufferedWriter(new OutputStreamWriter(out));
            writer.write("xwj");
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (writer != null) {
                    writer.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        // 4>.从文件中读取数据
        FileInputStream in = null;
        BufferedReader reader = null;
        StringBuffer content = new StringBuffer();
        try {
            in = openFileInput("data");
            reader = new BufferedReader(new InputStreamReader(in));
            String line = "";
            // 一行一行的读取数据
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        // b>.SharedPreferences存储
        // 1>.特点：使用键值对的方式来存储数据
        // 2>.存放位置（私有目录：只有你的应用有权限访问）：/data/data/<package_name>/shared_prefs/
        // 3>.获取SharedPreference对象：SharedPreferences文件使用xml格式对数据进行管理
//        // 第一种方式
//        // xwj - 指定SharedPreferences的文件名（如果指定的文件不存在则会创建）
//        // MODE_PRIVATE - 默认操作模式（表示只有当前的App才可以对该文件进行读写）
//        SharedPreferences sp = getSharedPreferences("xwj", MODE_PRIVATE);
//        // 第二种方式
//        // 自动将当前活动的类名作为SharedPreferences的文件名：主要保存Activity级别的数据
//        // MODE_PRIVATE - 默认操作模式（表示只有当前应用程序才可以对该文件进行读写）
//        sp = getPreferences(MODE_PRIVATE);
//        // 第三种方式
//        // 自动使用当前应用程序的包名作为前缀来命名SharedPreferences文件
//        sp = PreferenceManager.getDefaultSharedPreferences(HomeActivity.this);
        // 第四种方式：保存全局级别数据（推荐使用）
        SharedPreferences sp = DMApplication.getContext().getSharedPreferences("xwj", MODE_PRIVATE);
        // 4>.保存数据：将数据序列化写入文件
        SharedPreferences.Editor editor = sp.edit();
        editor.putBoolean("isSuccess", true);
        editor.apply();
        // 5>.获取数据：从文件读取并反序列化数据
        boolean isSuccess = sp.getBoolean("isSuccess", false);
        // c>.数据库
        // 1>.概述：SQLite数据库是一款轻量级的关系型数据库
        // 2>.存放位置：/data/data/<package name>/databases/
        // 3>.创建数据库（第一次会调用onCreate方法创建数据库、第二次不会调用onCreate方法）
        // 1、传入的"数字 > 1"就会调用onUpgrade方法
        MyDataBaseHelper myDataBaseHelper = new MyDataBaseHelper(HomeActivity.this, "BookStore.db", null, 1);
        // 2、可读数据库：当数据库不可写入的时候（比如磁盘空间已满、文件只读）会抛出异常
        // >>执行insert、update、delete操作
        SQLiteDatabase write_db = myDataBaseHelper.getWritableDatabase();
        // 3、可写数据库：当数据库不可写入的时候（比如磁盘空间已满）则返回的对象将以只读的方式去打开数据库
        // >>执行select操作
        SQLiteDatabase read_db = myDataBaseHelper.getReadableDatabase();
        ContentValues values = new ContentValues();
        values.put("name", "The Code");
        values.put("author", "Dan Brown");
        values.put("pages", 454);
        values.put("price", 16.96);
        // 4、添加数据
        write_db.insert("Book", null, values);
        write_db.execSQL("insert into Book (name, author, pages, price) values(?, ?, ?, ?)", new String[] { "The Da Vinci Code", "Dan Brown", "454", "16.96" });
        // 5、更新数据
        write_db.update("Book", values, "name = ?", new String[] {"The Code"});
        write_db.execSQL("update Book set price = ? where name = ?", new String[] { "10.99",
                "The Da Vinci Code" });
        // 6、删除数据
        write_db.delete("", "page > ?", new String[] {"500"});
        write_db.execSQL("delete from Book where pages > ?", new String[] {"500"});
        // 7、查询数据
        // Book - 表名
        Cursor cursor = read_db.query("Book", null, null, null, null, null, null);
        if (cursor.moveToFirst()) {
            do {
//                cursor.getString(cursor.getColumnIndex("name"));
            } while (cursor.moveToNext());
            cursor.close();
        }
        read_db.rawQuery("select * from Book", null);

        // 4>.操作数据库的开源库LitePal.jar
        // xxx

        // 5>.升级数据库：如果已经有创建成功的数据表，我们想再创建一张新的数据表则不会成功，因为不会调用onCreate方法
        // 解决办法：卸载App、升级数据库
    }
    private void initDatabase() {
//        MyDataBaseHelper db_Helper = new MyDataBaseHelper(this,"book_db.db",null,1);
//        SQLiteDatabase sql_db = db_Helper.getWritableDatabase();// 创建数据库
//        ContentValues values = new ContentValues();
//        values.put("name","xwj");
//        sql_db.insert("book_db",null, values);
//
//        SQLiteDatabase db = DMApplication.getContext().openOrCreateDatabase(
//                "book_db.db", MODE_PRIVATE, new SQLiteDatabase.CursorFactory() {
//                    @Override
//                    public Cursor newCursor(SQLiteDatabase sqLiteDatabase, SQLiteCursorDriver sqLiteCursorDriver, String s, SQLiteQuery sqLiteQuery) {
//                        return null;
//                    }
//                });
//        // 非查询语句
//        db.execSQL("");
//        db.close();
        // 查询语句：游标Cursors
    }
    private void createDatabase() {
        SQLiteDatabase db = DMApplication.getContext().openOrCreateDatabase(
                "book_db.db", MODE_PRIVATE, new SQLiteDatabase.CursorFactory() {
                    @Override
                    public Cursor newCursor(SQLiteDatabase sqLiteDatabase, SQLiteCursorDriver sqLiteCursorDriver, String s, SQLiteQuery sqLiteQuery) {
                        return null;
                    }
                });
    }
    public boolean deleteDatabase(String name) {
        if (DMApplication.getContext().deleteDatabase(name)) {
            return true;
        }
        return false;
    }
    private void userTransaction() {
//        SQLiteDatabase db = DMApplication.getContext().openOrCreateDatabase(
//                "book_db.db", MODE_PRIVATE, new SQLiteDatabase.CursorFactory() {
//                    @Override
//                    public Cursor newCursor(SQLiteDatabase sqLiteDatabase, SQLiteCursorDriver sqLiteCursorDriver, String s, SQLiteQuery sqLiteQuery) {
//                        return null;
//                    }
//                });
//        // 开启事务
//        db.beginTransaction();
//        try {
//            // 数据库操作
//            db.execSQL("");
//            // 提交当前事务：不提交会回滚事务
//            db.setTransactionSuccessful();
//        } finally {
//            db.endTransaction();
//        }
    }
    private void save(Context context,String msg) {
        try {
            out = openFileOutput("data", MODE_PRIVATE);
            writer = new BufferedWriter(new OutputStreamWriter(out));
            writer.write(msg);
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (writer != null) {
                    writer.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    private String get() {
        StringBuilder content = new StringBuilder();
        try {
            in = openFileInput("data");
            reader = new BufferedReader(new InputStreamReader(in));
            String line = "";
            while ((line = reader.readLine()) != null) {
                content.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (reader != null) {
                try {
                    reader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        return content.toString();
    }

    private void showContentProvider() {
        // 内容提供器：跨程序共享数据
        // 1.概念："内容提供器Content Provider"主要用于在不同的应用程序之间实现数据共享的功能，它提供了一套完整的机制，允许一个程序访问另一个程序中的数据，同时还能保证被访数据的安全性
        // 2.特点：使用"内容提供器Content Provider"是Android实现跨程序共享数据的标准方式
        // 3.系统现有的"内容提供器Content Provider"
        // a、查询query
        Cursor cursor = null;
        try {
            // uri = content://包名.provider/表名...指定查询某个应用程序下的某一张表
            // projection - 指定查询的列名
            // selection - 指定where的约束条件
            // selectionArgs - 为where中的占位符提供具体的值
            // sortOrder - 指定查询结果的排序方式
            cursor = getContentResolver().query(Uri.parse("content://com.lrgame.goc.cn.provider/table"), null, null, null, null);
            if (cursor != null) {
                while (cursor.moveToNext()) {
                    @SuppressLint("Range")
                    String column1 = cursor.getString(cursor.getColumnIndex("column1"));
                }
                cursor.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // b、添加insert
        ContentValues values1 = new ContentValues();
        values1.put("column1", "123");
        getContentResolver().insert(Uri.parse("content://com.lrgame.goc.cn.provider/table"), values1);
        // c、更新update（约束更新条件）
        values1.put("column1", "");
        getContentResolver().update(Uri.parse("content://com.lrgame.goc.cn.provider/table"), values1, "column1 = ?", new String[] {"123"});
        // d、删除delete
        getContentResolver().delete(Uri.parse("content://com.lrgame.goc.cn.provider/table"), "column1 = ?", new String[] {"123"});
    }

    private void showNotification() {
        // 通知
        NotificationManager manager1 = (NotificationManager)getSystemService(Context.NOTIFICATION_SERVICE);
        Notification notification = new Notification(R.drawable.ic_launcher_background,null, System.currentTimeMillis());
        Intent intent1 = new Intent(this, MainActivity.class);
        PendingIntent pendingIntent = PendingIntent.getActivity(this,0, intent1, PendingIntent.FLAG_IMMUTABLE);
        manager1.notify(0, notification);
        manager1.cancel(0); // 通知消失

        Uri soundUri = Uri.fromFile(new File("/system/media/audio/ringtones/\n" +
                "Basic_tone.ogg"));
        Notification.Builder builder = new Notification.Builder(DMApplication.getContext()); // 创建
        Intent intent3 = new Intent(DMApplication.getContext(), MainActivity.class); // 需要跳转
        PendingIntent pendingIntent1 = PendingIntent.getActivity(DMApplication.getContext(),
                0,intent3, PendingIntent.FLAG_CANCEL_CURRENT | PendingIntent.FLAG_IMMUTABLE);
        builder.setContentIntent(pendingIntent1);
        builder.setSmallIcon(R.drawable.ic_launcher_background); // 小图标
        builder.setLargeIcon(BitmapFactory.decodeResource(getResources(), R.drawable.ic_launcher_background)); // 大图标
        builder.setContentTitle("发现新版本"); // 通知的标题
        builder.setContentText("立即更新吧"); // 内容
        builder.setWhen(System.currentTimeMillis()); // 设置通知的时间：以毫秒为单位
        builder.setAutoCancel(true); // 维护通知的消失
        builder.setTicker("new msg");
        builder.setOngoing(true);
        builder.setNumber(20);
        // 设置通知的重要程度
        // PRIORITY_MIN - 最低（系统可能只会在特定的场景才显示这条通知，比如用户下拉状态栏的时候）
        // PRIORITY_LOW - 较低（系统可能会将这类通知缩小，或改变其显示的顺序，将其排在更重要的通知之后）
        // PRIORITY_DEFAULT - 默认（和不设置效果是一样的）
        // PRIORITY_HIGH - 较高（系统可能会将这类通知放大，或改变其显示的顺序， 将其排在比较靠前的位置）
        // PRIORITY_MAX - 最高（必须要让用户立刻看到，甚至需要用户做出响应操作）
        builder.setPriority(Notification.PRIORITY_MAX);
        Notification notification2 = builder.build();
        notification2.flags = Notification.FLAG_NO_CLEAR;
        notification2.sound = soundUri; // 发出通知的时候发出一段音频
        // 通知管理类
        NotificationManager manager2 = (NotificationManager)getSystemService(NOTIFICATION_SERVICE);
        // 第一个参数是id：要保证为每个通知所指定的id都不同
        manager2.notify(1, notification2); // 显示通知
        // 点击以后状态栏图标消失：传入该通知所指定的id
        manager2.cancel(1);
    }

    private void showMedia() {
        // 多媒体
        player = new MediaPlayer();
        try {
            File file = new File(Environment.getExternalStorageDirectory(),
                    "music.mp3");
            player.setDataSource(file.getPath()); // 指定音频路径
            player.prepare(); // 进入准备状态
        } catch (Exception e) {
            e.printStackTrace();
        }

//        // init
//        videoView = findViewById(R.id.video);
//        File file = new File(Environment.getExternalStorageDirectory(),
//                "music.3gp");
//        // 指定视频路径
//        videoView.setVideoPath(file.getPath());

        // 是否正在播放
        if (!player.isPlaying()) {
            player.start(); // 开始播放
        }

        if (!videoView.isPlaying()) {
            videoView.start();
        }

        if (player.isPlaying()) {
            player.pause();
        }

        if (videoView.isPlaying()) {
            // 暂时播放
            videoView.pause();
        }

        if (player.isPlaying()) {
            // 重置成刚刚创建的状态：音频重头开始播放
            player.stop();
            // 必须再次init
            try {
                File file1 = new File(Environment.getExternalStorageDirectory(),
                        "music.mp3");
                // 指定音频路径
                player.setDataSource(file1.getPath());
                // 进入准备状态
                player.prepare();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (videoView.isPlaying()) {
            // 重新播放
            videoView.resume();
        }
    }

    public void showPic() {
        File outputImage = new File(Environment.getExternalStorageDirectory(),
                "pic.jpg");
        try {
            if (outputImage.exists()) {
                outputImage.delete();
            }
            outputImage.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Uri imageUri = Uri.fromFile(outputImage);
        // 启动相机程序
        Intent intent = new Intent("android.media.action.IMAGE_CAPTURE");
        intent.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
        registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), result -> {
            if (result.getResultCode() == TAKE_PHOTO) {

            }
        }).launch(intent);

        File outputImage1 = new File(Environment.getExternalStorageDirectory(),
                "out.jpg");
        try {
            if (outputImage1.exists()) {
                outputImage1.delete();
            }
            outputImage1.createNewFile();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Uri imageUri1 = Uri.fromFile(outputImage1);

        Intent intent1 = new Intent("android.intent.action.GET_CONTENT");
        intent1.setType("image/*");
        intent1.putExtra("crop", true);
        intent1.putExtra("scale", true);
        intent1.putExtra(MediaStore.EXTRA_OUTPUT,imageUri1);
        registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), result -> {
            if (result.getResultCode() == CROP_PHOTO) {

            }
        }).launch(intent1);

        Intent intent2 = new Intent("com.android.camera.action.CROP");
        intent2.setDataAndType(imageUri, "image/*");
        intent2.putExtra("scale", true);
        intent2.putExtra(MediaStore.EXTRA_OUTPUT, imageUri);
        registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), result -> {
            if (result.getResultCode() == CROP_PHOTO) {

            }
        }).launch(intent2);

        try {
            Bitmap bitmap = BitmapFactory.decodeStream(
                    getContentResolver().openInputStream(imageUri)
            );
//            // ImageView
//            picImg.setImageBitmap(bitmap); // 将裁剪后的照片显示出来
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
    }

    private void showService() {
        // 服务
        // 1.概述
        // 1>.概念：Service服务是Android中实现程序后台运行的解决方案
        // 2>.作用：适合去执行那些不需要和用户交互且要求长期运行的任务
        // 3>.特点：服务的运行不依赖于任何用户界面（"程序被切换到后台/用户打开了另外一个应用程序"服务仍然能够保持正常运行）
        // 4>.注意：服务不是运行在一个独立的进程当中的，而是依赖于创建服务时所在的程序进程（当某个应用程序进程被杀掉时，所有依赖于该进程的服务也会停止运行）
        // 5>.执行：服务不会自动开启线程，所有的代码都是默认运行在主线程当中（我们需要在服务的内部手动创建子线程，并在这里执行具体的任务，否则就有可能出现主线程被阻塞住的情况）
        Intent intent = new Intent();
        intent.setClass(this, MyService.class); // 创建MyService继承Service
        startService(intent); // 启动服务
        // 2.Activity和Service进行通信
        ServiceConnection connection = new ServiceConnection() {
            @Override
            public void onServiceConnected(ComponentName name, IBinder service) {
                // 活动和服务成功绑定
                MyService.DownloadBinder downloadBinder = (MyService.DownloadBinder)service;
                downloadBinder.startDownload();
                downloadBinder.getProgress();
            }

            @Override
            public void onServiceDisconnected(ComponentName name) {
                // 活动和服务的连接断开
            }
        };
        // 绑定服务
        bindService(intent, connection, BIND_AUTO_CREATE);
        // 解绑服务
        unbindService(connection);
        // 3.服务的生命周期
        // onCreate() -> onStartCommand() -> onBind() -> onDestroy()
        // 4.前台服务
        // a、引入原因：后台服务的系统优先级比较低：当系统出现内存不足的时候就可能被回收掉正在后台运行的服务
        // 5.使用IntentService
        // a、作用：可以简单的创建一个异步的、会自动停止的服务
        // 6.服务的最佳实践 - 完整版的下载示例
    }

    public void showThread() {
        // 多线程
        // 第一种方式
        MyThread t1 = new MyThread();
        t1.start();

        // 第二种方式
        YourThread yourThread = new YourThread();
        Thread t2 = new Thread(yourThread);
        t2.start();

        new Thread(new Runnable() {
            @Override
            public void run() {
                // 处理具体的逻辑
            }
        });

        // 启动任务
        new DownloadTask().execute();
    }
    class MyThread extends Thread {
        @Override
        public void run() {
            super.run();
            // 处理具体的逻辑
        }
    }
    class YourThread implements Runnable {
        @Override
        public void run() {
            // 处理具体的逻辑
        }
    }
    class DownloadTask extends AsyncTask<Void, Integer, Boolean> {
        // Void 传入参数给后台
        // Integer 进度显示单位
        // Boolean 反馈执行结果
        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // 后台任务执行之前调用：比如显示进度条
        }

        @Override
        protected Boolean doInBackground(Void... params) {
            // 处理所有的耗时操作，返回处理结果：子线程
            publishProgress(0);
            return null;
        }

        @Override
        protected void onProgressUpdate(Integer... values) {
            super.onProgressUpdate(values);
            // 操作UI界面元素
        }

        @Override
        protected void onPostExecute(Boolean aBoolean) {
            super.onPostExecute(aBoolean);
            // 后台任务执行完毕调用
        }
    }

    private void showRequest() {
        // 网络技术
//        // 1.WebView的用法
//        WebView webView = findViewById(R.id.web_view);
//        // 设置属性：让webView支持js脚本
//        webView.getSettings().setJavaScriptEnabled(true);
//        // 当需要从一个网页跳转到另一个网页时，我们希望目标网页仍然在当前WebView中显示，而不是打开系统浏览器
//        webView.setWebViewClient(new WebViewClient());
//        webView.loadUrl("https://baidu.com");
        // 2.使用http议访问网络（HttpClient在Android 6.0的时候被完全移除）
        // 官方推荐使用HttpURLConnection
        new Thread(new Runnable() {
            @Override
            public void run() {
                HttpURLConnection connection = null;
                BufferedReader reader = null;
                try {
                    URL url = new URL("https://baidu.com");
                    connection = (HttpURLConnection) url.openConnection();
                    // 提交数据
//                    connection.setRequestMethod("POST");
//                    DataOutputStream out = new DataOutputStream(connection.getOutputStream());
//                    out.writeBytes("username=admin&password=123456");
                    // 请求方式
                    connection.setRequestMethod("GET");
                    // 连接超时
                    connection.setConnectTimeout(8000);
                    // 读取超时
                    connection.setReadTimeout(8000);
                    // 获取服务器返回的输入流
                    InputStream inputStream = connection.getInputStream();
                    // 关闭网络请求
                    connection.disconnect();
                    // 下面对获取到的输入流进行读取
                    reader = new BufferedReader(new InputStreamReader(inputStream));
                    StringBuilder response = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        response.append(line);
                    }
                    Log.v("HomeActivity", response.toString());
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (reader != null) {
                        try {
                            reader.close();
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    }
                    if (connection != null) {
                        connection.disconnect();
                    }
                }
            }
        }).start();
        // 3.日常Android开发使用Retrofit/OkHttp + Gson
        // 4.xml解析
        /*
        <apps>
            <app>
                <id>1<id>
                <name>Google Map<name>
                <version>1.0<version>
            <app>
            <app>
                <id>1<id>
                <name>Google Map<name>
                <version>1.0<version>
            <app>
            <app>
                <id>2<id>
                <name>Chrome<name>
                <version>2.1<version>
            <app>
            <app>
                <id>3<id>
                <name>Google Play<name>
                <version>2.3<version>
            <app>
        <apps>
        */
        // 1>.Pull解析
        try {
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser xmlPullParser = factory.newPullParser();
            xmlPullParser.setInput(new StringReader("xml数据"));
            int eventType = xmlPullParser.getEventType();
            String id = "";
            String name = "";
            String version = "";
            while (eventType != XmlPullParser.END_DOCUMENT) {
                String nodeName = xmlPullParser.getName();
                switch (eventType) {
                    // 开始解析某个节点
                    case XmlPullParser.START_TAG: {
                        if (nodeName.equals("id")) {
                            id = xmlPullParser.nextText();
                        } else if (nodeName.equals("name")) {
                            name = xmlPullParser.nextText();
                        } else if (nodeName.equals("version")) {
                            version = xmlPullParser.nextText();
                        }
                    }
                    break;
                    // 完成解析某个节点
                    case XmlPullParser.END_TAG: {
                        if (nodeName.equals("app")) {
                            Log.d("WebActivity", "id is " + id);
                            Log.d("WebActivity", "name is " + name);
                            Log.d("WebActivity", "version is " + version);
                        }
                    }
                    break;
                    default:break;
                }
                eventType = xmlPullParser.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 2>.SAX解析
        try {
            SAXParserFactory factory = SAXParserFactory.newInstance();
            XMLReader xmlReader = factory.newSAXParser().getXMLReader();
            MyHandler handler = new MyHandler();
            // 将ContentHandler的实例设置到XMLReader中
            xmlReader.setContentHandler(handler);
            // 开始执行解析
            xmlReader.parse(new InputSource(new StringReader("xml数据")));
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 5.解析JSON
        /*
        [
            {
            "id":"5",
            "version":"5.5",
            "name":"Clash of Clans"
            },
            {
            "id":"6",
            "version":"7.0",
            "name":"Boom Beach"
            },
            {
            "id":"7",
            "version":"3.5",
            "name":"Clash Royale"
            }
        ]
        */
        // 1>.JSONObject
        try {
            JSONArray jsonArray = new JSONArray("json数据"); // 如果json数据是[]
//            JSONObject jsonObject = new JSONObject("json数据"); // 如果json数据是{}
            for (int index = 0; index < jsonArray.length(); index++) {
                JSONObject jsonObject = jsonArray.getJSONObject(index);
                String id = jsonObject.getString("id");
                String name = jsonObject.getString("name");
                String version = jsonObject.getString("version");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 2>.GSON：登录github -> 搜索GSON -> 复制implementation 'com.google.code.gson:gson:2.10'
        Gson gson = new Gson();
        FruitItem fruitItem = gson.fromJson("json数据", FruitItem.class);
        List<FruitItem> fruitList = gson.fromJson("json数组", new TypeToken<List<FruitItem>>(){}.getType());
    }

    private void showAuthority() {
        // 权限机制
        // 1.概念：应用程序申明权限以后用户在安装该应用程序的时候就会在安装界面看到提醒（Android 6.0以前）
        // 2.导致的问题：一些应用程序滥用权限而用户只能选择安装或不安装（二选一的窘状）
        // 3.解决问题：Android 6.0以后引入"运行时权限功能（用户不需要在安装软件的时候一次性授权所有的权限，可以在软件的使用过程中再对某一项权限进行授权）"，这样我就算用户拒绝某一个权限还可以使用该应用程序的其它功能（而不是无法安装）
        // 4.权限分类
        // >>普通权限：不会直接威胁到用户的安全和隐私的权限/系统自动授权/查看网络连接、开机启动/只需要在AndroidManifest.xml文件中添加一下权限声明
        // >>危险权限：可能会触及用户隐私或者对设备安全性造成影响的权限/用户手动点击授权/获取设备联系人信息、定位设备的地理位置/每个危险权限都属于一个权限组，我们在进行运行时权限处理时使用的是权限名，用户一旦同意授权了，那么该权限所对应的权限组中所有的其他权限也会同时被授权
        // 5.在程序运行时申请权限
        // a、Android 6.0之前
        // 第一步：申请权限
        // <!--拨打电话-->
        // <uses-permission android:name="android.permission.CALL_PHONE"/>
        // 第二步：拨打电话
        try {
            // 打开拨号界面（不需要声明权限）
            //Intent intent = new Intent(Intent.ACTION_DIAL);
            // 直接拨打电话（必须声明权限）
            Intent intent = new Intent(Intent.ACTION_CALL);
            intent.setData(Uri.parse("tel:10086"));
            startActivity(intent);
        } catch (SecurityException e) {
            e.printStackTrace();
        }
        // b、Android 6.0之后
        // 核心：在程序运行过程中由用户授权我们去执行某些危险操作，程序不可以擅自做主去执行这些危险操作
        // 1>.判断是否已经授权
        if (ContextCompat.checkSelfPermission(HomeActivity.this,
                Manifest.permission.CALL_PHONE) != PackageManager.PERMISSION_GRANTED) {
            // 未授权：向用户申请授权
            // requestCode请求码：必须唯一
            // 执行完该方法以后系统会弹出权限申请对话框：用户点击同意或不同意都会回调onRequestPermissionsResult()方法
            ActivityCompat.requestPermissions(HomeActivity.this,
                    new String[] {Manifest.permission.CALL_PHONE}, 1);
        } else {
            // 已授权：直接后续操作
            // 如果已经同意：直接后续操作，还可以在Settings里面关闭权限
            try {
                // 打开拨号界面（不需要声明权限）
                //Intent intent = new Intent(Intent.ACTION_DIAL);
                // 直接拨打电话（必须声明权限）
                Intent intent = new Intent(Intent.ACTION_CALL);
                intent.setData(Uri.parse("tel:10086"));
                startActivity(intent);
            } catch (SecurityException e) {
                e.printStackTrace();
            }
        }
    }
    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        switch (requestCode) {
            case 1: {
                if (grantResults.length > 0 && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    try {
//                        // 打开拨号界面（不需要声明权限）
//                        Intent intent = new Intent(Intent.ACTION_DIAL);
//                        // 直接拨打电话（必须声明权限）
                        Intent intent = new Intent(Intent.ACTION_CALL);
                        intent.setData(Uri.parse("tel:10086"));
                        startActivity(intent);
                    } catch (SecurityException e) {
                        e.printStackTrace();
                    }
                } else {
                    // 如果没有同意：下次点击还会弹出权限申请对话框
                    Toast.makeText(this, "You denied the permission", Toast.LENGTH_SHORT).show();
                }
            }
            break;
            default:break;
        }
    }

    private void showRecyclerView() {
        // 动控件RecyclerView：必须添加support库
        initFruit();
        RecyclerView recyclerView = findViewById(R.id.recycler_view);
        // LinearLayoutManager
        LinearLayoutManager manager = new LinearLayoutManager(HomeActivity.this);
        // GridLayoutManager
        // StaggeredGridLayoutManager
        // 第一个参数：指定布局列数
        // 第二个参数：指定布局的排列方向
//        StaggeredGridLayoutManager *manager = new StaggeredGridLayoutManager(3, StaggeredGridLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(manager);
//        RecyclerViewFruitAdapter adapter = new RecyclerViewFruitAdapter(fruitList);
//        recyclerView.setAdapter(adapter);
    }
    private void initFruit() {
        for (int index = 0; index < 20; index++) {
            FruitItem fruit_item = new FruitItem("Apple", R.drawable.mine_icon);
            fruitList.add(fruit_item);
        }
    }

    private void showLocationManager() {
        // 基于位置的服务
    }

    private void showSensor() {
        // 传感器
        // 获取管理传感器实例
        SensorManager sensorManager = (SensorManager)getSystemService
                (Context.SENSOR_SERVICE);
        // 获取光照传感器
        Sensor sensor = sensorManager.getDefaultSensor(Sensor.TYPE_LIGHT);
        // 对传感器输出的信号进行监听
        SensorEventListener listener = new SensorEventListener() {
            @Override
            public void onSensorChanged(SensorEvent sensorEvent) {
                // 当传感器监测到的数值发生变化
            }

            @Override
            public void onAccuracyChanged(Sensor sensor, int i) {
                // 当传感器的精度发生变化
            }
        };
        /**
         * 注册传感器
         * SensorEventListener实例
         * Sensor实例
         * 传感器输出信息的更新速率
         */
        sensorManager.registerListener(listener,sensor,
                SensorManager.SENSOR_DELAY_GAME);
        // 销毁：位于onDestroy()方法中
        if (sensorManager != null) {
            sensorManager.unregisterListener(listener);
        }
    }

    private void showTest() {
        // 编写测试用例
    }

    private void publishApplication() {
        // 应用发布
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        // 5.取消注册（动态注册的广播必须取消注册）
        unregisterReceiver(networkChangeReceiver);
        if (player != null) {
            player.stop();
            player.release();
        }

        if (videoView != null) {
            videoView.suspend();
        }
    }

    @Override
    public void onBackPressed() {
        // 按下物理Back键执行该方法
        super.onBackPressed();
        Intent intent = new Intent();
        intent.putExtra("name", "wy");
        setResult(100, intent);
        finish();
        // https://blog.csdn.net/weixin_44570190/article/details/135995654
        // https://blog.csdn.net/chen_md/article/details/125201681?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-125201681-blog-135995654.235%5Ev43%5Epc_blog_bottom_relevance_base2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-125201681-blog-135995654.235%5Ev43%5Epc_blog_bottom_relevance_base2&utm_relevant_index=8
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        switch (keyCode) {
            case KeyEvent.KEYCODE_DPAD_CENTER: {
                System.out.println("KEYCODE_DPAD_CENTER");
            }
                break;
            case KeyEvent.KEYCODE_DPAD_UP: {
                System.out.println("KEYCODE_DPAD_UP");
            }
                break;
            default:
                break;
        }

        return super.onKeyDown(keyCode, event);
    }

    @Override
    public boolean onKeyUp(int keyCode, KeyEvent event) {

        switch(keyCode) {
            case KeyEvent.KEYCODE_DPAD_CENTER: {
                System.out.println("KEYCODE_DPAD_CENTER");
            }
                break;
            case KeyEvent.KEYCODE_DPAD_UP: {
                System.out.println("KEYCODE_DPAD_UP");
            }
                break;
            default:
                break;
        }
        return super.onKeyUp(keyCode, event);
    }

    @Override
    public boolean onKeyMultiple(int keyCode, int repeatCount, KeyEvent event) {
        return super.onKeyMultiple(keyCode, repeatCount, event);
    }

    @Override
    public boolean onTouchEvent(MotionEvent event) {
        int action = event.getAction();

        return super.onTouchEvent(event);
    }
}