package com.lrgame.goc.cn.page;

import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.ActionBar;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Fragment;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.os.PersistableBundle;
import android.provider.MediaStore;
import android.telephony.ims.ProvisioningManager;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.Toast;

import com.lrgame.goc.cn.R;
import com.lrgame.goc.cn.adapter.FruitAdapter;
import com.lrgame.goc.cn.application.DMApplication;
import com.lrgame.goc.cn.entity.FruitItem;
import com.lrgame.goc.cn.entity.PersonEntity;
import com.lrgame.goc.cn.fragment.RightFragment;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

// AppCompatActivity是一种向下兼容的Activity：最低兼容到2.1系统、属于Activity的子类
public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static final String TAG = "DMGameProxy";

    private String[] datas = {"Apple", "Banana", "Orange", "Watermelon", "Pear",
            "Grape", "Pineapple", "Strawberry", "Cherry", "Mango",
            "Apple", "Banana", "Orange", "Watermelon", "Pear",
            "Grape", "Pineapple", "Strawberry", "Cherry", "Mango"};

    private List<FruitItem> fruits = new ArrayList<>();

    private List<Activity> activityList = new ArrayList<>();

    private static final int TAKE_PHOTO = 0;
    private static final int CROP_PHOTO = 1;

    // 当Activity启动的时候调用
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // 将系统自带的标题栏隐藏
        requestWindowFeature(Window.FEATURE_NO_TITLE); // 作用于当前activity
//        ActionBar actionBar = getSupportActionBar();
//        if (actionBar != null) {
//            actionBar.hide();
//        }

        showBaseIdea();

        showActivity();

        showBaseUI();

        showFragment();

        showLayout();

        showCustomView();

        showListView();

        showFragment();

        showDynamicLoadLayout();

        showPic();

        // 当pageA跳转到pageB的时候，pageA可能会被回收，这时候返回pageA则不会调用onRestart()方法，而是调用onCreate()方法重新创建pageA，这个时候pageA中的临时数据需要在onSaveInstanceState()方法中保存
        if (savedInstanceState != null) {
            Log.v(TAG, savedInstanceState.getString("name"));
        }

        // 包管理者对象
        PackageManager pm = getPackageManager();
        try {
            PackageInfo info = pm.getPackageInfo(getPackageName(), 0);
            Log.v(TAG, info.versionName); //
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 异常情况也要处理
    }

    private void showBaseIdea() {
        // 1.Android Studio介绍
        // 1>.概念：Android Studio简称AS，是一款由Google推出的用于开发Android应用程序的IDE（集成开发环境：帮助开发人员创建、开发、测试、部署）
        // 2>.配置Android开发环境：登录官网下载Android Studio -> Create New Project（选择No Activity）-> 使用Java/Kotlin编写源代码、使用xml编写用户界面
        // 3>.发布：Google Play商店、其它应用程序商店
        // 4>.IDEA主题下载：https://plugins.jetbrains.com/search?tags=Theme
        // 5>.详细配置操作：https://www.cnblogs.com/qianguyihao/p/4022844.html

        // 2.jdk介绍

        // 3.Gradle介绍



































        // 1.Android系统
        // 1>.概述
        // a.定义：Android是基于Linux内核，由“谷歌Google”和"开放手机联盟OHA"开发的针对移动设备的操作系统
        // b.特点：应用框架和组件可以重复使用、允许Java语言开发和管理代码、丰富的开发环境：模拟器、调试工具、运行内存检测...、源代码完全开放
        // c.Dalvik虚拟机：“谷歌Google”设计的针对Android平台的虚拟机
        // 2>.架构
        // a.Linux内核层：为硬件提供驱动（显示驱动、音频驱动、照相机驱动）
        // b.系统运行库层（运行机制DVM-JVM）：通过C/C++库来为Android系统提供主要的特性支持
        // c.应用框架层：提供构建应用程序可能用到的各种api
        // d.应用层：所有安装在手机上的应用程序
        // 3>.jvm和dvm的区别
        // a.jvm - java虚拟机
        // b.dvm - android平台虚拟机Dalvik（把所有的.class文件变成一个.dex文件、因为版本原因才自己开发）
        // >>art模式 - android系统运行的一种模式
        // 4>.特色
        // a.四大组件：Activity、Service、Broadcast Receiver、Content Provider
        // b.丰富的系统组件
        // c.支持SQLite数据库
        // d.强大的多媒体
        // e.地理位置定位
        // 5>.版本
        // a.时间：2008年9月，谷歌正式发布了Android1.0
        // b.参考：http://developer.android.google.cn/about/dashboards

        // 2.搭建开发环境
        // a.下载安装JDK，配置java环境变量
        // b.下载安装Android Studio
        // c.下载安装Android SDK，配置Android环境变量
        // d.创建模拟器AVD

        // 3.项目结构
        // 1>.Android模式
        /*
        xxx
        */
        // 2>.Project模式
        /*
        DMGameProxy ------ 项目名称
            .gradle ------ AS自动生成的文件（包含gradle工具的各个版本）：无需关心，不能手动编辑
            .idea ------ AS自动生成的文件（包含了开发环境所需要的各种环境）：无需关心，不能手动编辑
            app ------ Application Module
                libs ------ 存放第三方jar包：放在这个目录下的jar包需要被添加到构建路径中
                src ------ 资源文件
                    androidTest ------ 编写测试用例
                    main ------ xxx
                        java ------ 源代码
                        res ------ 资源文件
                            drawable ------ 图片
                            drawable-v24 ------ 图片
                            layout ------ 布局
                            layout-large ------ 布局
                            mipmap-anydpi-v26 ------ 图标
                            mipmap-hdpi ------ 图标
                            mipmap-mdpi ------ 图标
                            mipmap-xhdpi ------ 图标
                            mipmap-xxhdpi ------ 图标
                            mipmap-xxxhdpi ------ 图标
                            values
                                colors ------ 颜色
                                strings ------ 字符串
                                styles ------ 舞蹈
                                themes ------ 主题
                            layout-night ------ 布局
                            xml
                        test ------ 编写Unit Test测试用例
                        AndroidManifest.xml ------ 图标
               .gitignore ------ git忽略文件
                build.gradle ------ app模块的gradle构建脚本：只对app模块有效
                proguard-rules ------ 指定项目代码的混淆规则：如果不希望代码被别人识别可以将代码进行混淆
            gradle ------ AS默认不启用gradle wrapper
            .gitignore ------ git忽略文件
            build.gradle ------ 全局gradle构建脚本：基本不需要修改
            gradle.properties ------ 配置的属性将会影响项目中所有的gradle编译脚本
            gradlew ------ 用来在命令行界面执行gradle命令：Linux系统和Mac系统
            gradlew.bat ------ 用来在命令行界面执行gradle命令：Windows系统
            local.properties ------ 用来指定本机中的Android SDK路径
            setting.gradle ------ 指定项目中所有引入的模块（初始化过程中被执行）
        */
        // >>怎么引用res/values/strings.xml中资源
        // 1.代码中使用
        System.out.println(R.string.app_name);
        System.out.println(R.layout.activity_main);
        System.out.println(R.drawable.ic_launcher_background);
        System.out.println(R.mipmap.ic_launcher);
        // 2.在xml文件中使用
        // @string/app_name
        // @layout/activity_main
        // @drawable/ic_launcher_background
        // @mipmap/ic_launcher

        // 4.log输出
        System.out.println("hello world");
        Log.v(TAG, "verbose"); // 用于打印那些最为琐碎的、意义最小的日志信息verbose
        Log.d(TAG, "debug"); // 打印调试信息debug
        Log.i(TAG, "info"); // 打印比较重要的数据info
        Log.w(TAG, "warn"); // 打印警告信息warn
        Log.e(TAG, "error"); // 打印错误信息error：红色

        // 5.adb指令
        // xxx
    }

    private void showActivity() {
        // 6.activity活动
        // 1>.创建activity
        // >>新建xxx.java代码文件
        // >>新建xxx.xml布局文件
        // >>在AndroidManifest.xml中注册
        Log.v(TAG, getClass().getName()); // 获取当前对象的类的名称（包含packageName）
        Log.v(TAG, getClass().getSimpleName()); // 获取当前对象的类的名称（不包含packageName）
        // 2>.toast
        Button button = findViewById(R.id.login_btn); // 获取布局文件定义的元素
        // 匿名内部类：也可以直接传入实现该接口的类的对象
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // Toast.LENGTH_LONG
                // Toast.LENGTH_SHORT
                Toast.makeText(MainActivity.this, "Login", Toast.LENGTH_SHORT).show();
            }
        });
        // 3>.menu
        // >>默认不会显示：右屏幕三个点点击一下弹出
        // >>选中res -> 新建menu -> 选中menu -> 选择Menu resource file
        // >>重写onOptionsItemSelected()方法
        // 4>.Intent意图：
        // a.作用：减少组件之间的耦合、使用Intent应用于android三个核心组件：Activity、Service、Broadcast Receiver
        // b.显示Intent
        /**
         * 此处需要新建页面（在Android中一个activity就是一个页面）
         * 1>.新建activity文件：New -> Activity -> Empty Views Activity
         * 2>.新建activity.xml布局文件：勾选自动创建
         * 3>.在AndroidManifest.xml文件中注册activity：勾选自动创建
         */
        // 第一种方式
        Intent intent = new Intent(this, HomeActivity.class);
        intent.putExtra("name", "xwj");
        intent.putExtra("age", 18);
        // 传递对象：对象必须序列化
        intent.putExtra("data", new PersonEntity());
//        String name = getIntent().getStringExtra("name"); // 传递的是String类型
//        int age = getIntent().getIntExtra("age", 18); // 传递的是int类型
//        PersonEntity p1 = (PersonEntity) getIntent().getSerializableExtra("data"); // 获取对象
        startActivity(intent);
        // 第二种方式
        Intent intent1 = new Intent();
        intent1.setClass(this, HomeActivity.class);
        Bundle bundle = new Bundle();
        bundle.putString("name", "xwj");
        intent1.putExtras(bundle);
//        Bundle bundle = getIntent().getExtras();
//        bundle.get("name");
        startActivity(intent1);
        // c.隐式Intent：没有任何Intent响应则会crash
        // 每个intent只能指定一个action
        intent = new Intent("com.lrgame.goc.cn.ACTION_HOME");
        // 每个intent可以指定多个category
        // >>默认category不用添加
        intent.addCategory("android.intent.category.DEFAULT");
        // >>自定义category必须指定
        intent.addCategory("com.lrgame.goc.cn.category.HOME");
        startActivity(intent);
        // c.打开网页
        intent = new Intent(Intent.ACTION_VIEW);
        intent.setData(Uri.parse("https://www.baidu.com"));
        startActivity(intent);
        // d.返回数据给上一个activity
//        startActivityForResult(intent, 1);
        registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), result -> {
            if (result.getResultCode() == 100) {
                Intent data = result.getData();
                if (data != null) {
                    Log.v(TAG, data.getStringExtra("name"));
                }
            }
        }).launch(new Intent(this, HomeActivity.class));
        // e.延迟跳转
//        Handler sHandler = new Handler(new Handler.Callback() {
//            @Override
//            public boolean handleMessage(@NonNull Message message) {
//                // 延迟执行的语句
//                switch (message.what) {
//                    case 1: {
//                        Log.v(TAG, message.obj.toString());
//                    }
//                    break;
//                }
//                return false;
//            }
//        });
        Handler sHandler = new Handler(message -> {
            // 延迟执行的语句
            Log.v(TAG, message.obj.toString());
            return false;
        });
        sHandler.sendEmptyMessageDelayed(0, 2000);
        Message msg = new Message();
        msg.what = 1;
        msg.obj = "xwj";
        sHandler.sendMessage(msg); // 此处执行就会进入handleMessage()方法
        // 5>.生命周期
        // a.概念：Android使用"任务task（一组存放在返回栈中的活动的集合）"管理活动
        // b.特点：系统总会显示处于栈顶的activity
        // c.activity的生命周期：运行状态、暂停状态、停止状态、销毁状态
        // 6>.启动模式
        // a.standard：默认启动模式（系统不会关注这个活动是否已经在返回栈中存在，每次启动都会创建该活动的一个新的实例）
        // b.singleTop：启动活动时如果发现返回栈的栈顶（必须位于栈顶，不然还会创建新对象）已经是该活动，则直接使用它，不会再创建新的活动实例
        // c.singleTask：每次启动该活动时系统首先会在返回栈中检查是否存在该活动的实例，如果发现已经存在则直接使用该实例，并把在这个活动之上的所有活动统统出栈，如果没有发现就会创建一个新的活动实例
        // d.singleInstance：xxx
    }

    private void showBaseUI() {
        // 8.基础UI开发：Android实现UI开发的方法（编写xml代码）
        // 1>.TextView
        TextView textView = findViewById(R.id.text_view);
        textView.setTextColor(Color.RED);
        textView.setBackgroundColor(Color.YELLOW); // java一般使用“class + 常量”替代“枚举”
        textView.setTextSize(25.0f);
        textView.setText("123");
        Log.v(TAG, textView.getText().toString());
        // 2>.Button
        Button button = findViewById(R.id.login_btn);
//        button.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                // 逻辑实现
//            }
//        });
        button.setOnClickListener(this);
        // 3>.EditText
        EditText editText = findViewById(R.id.edit_text);
        editText.setHint("请输入账号");
        Log.v(TAG, editText.getText().toString());
        if (TextUtils.isEmpty(editText.getText().toString())) {
            // 判断字符串是否为空
        }
//        editText.setOnKeyListener(new View.OnKeyListener() {
//            @Override
//            public boolean onKey(View view, int i, KeyEvent keyEvent) {
//                if (keyEvent.getAction() == KeyEvent.ACTION_DOWN &&
//                        keyEvent.getAction() == KeyEvent.KEYCODE_ENTER) {
//                    //执行发送消息操作
//                    return true;
//                }
//                return false;
//            }
//        });
        // 如果匿名函数只有一个方法可以直接使用Lambda
        // 如果方法只有一个参数可以省略()
        editText.setOnKeyListener((view, i, keyEvent) -> {
            if (keyEvent.getAction() == KeyEvent.ACTION_DOWN &&
                    keyEvent.getAction() == KeyEvent.KEYCODE_ENTER) {
                //执行发送消息操作
                return true;
            }
            return false;
        });
        // 4>.ImageView
        ImageView imageView = findViewById(R.id.image_view);
        imageView.setImageResource(R.drawable.ic_launcher_background); // 推荐使用
        imageView.setImageDrawable(getResources().getDrawable(R.drawable.ic_launcher_background));
        // 5>.ProgressBar
        // ProgressDialog废弃
        ProgressBar progressBar = findViewById(R.id.progress_bar);
        /**
         * View.VISIBLE控件可见
         * View.INVISIBLE控件不可见（仍然占据原来的位置）
         * View.GONE控件不可见（不再占据原来的位置）
         */
        progressBar.setVisibility(View.GONE);
        // 6>.AlertDialog
        AlertDialog.Builder dialog = new AlertDialog.Builder(MainActivity.this);
        dialog.setTitle("title");
        dialog.setMessage("This is Message");
        // 可否用Back键关闭对话框
        dialog.setCancelable(false);
        dialog.setPositiveButton("OK", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                // 右边
                dialogInterface.dismiss();
            }
        });
        dialog.setNegativeButton("Cancel", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialogInterface, int i) {
                // 左边
            }
        });
//        dialog.setView(View.inflate(DMApplication.getContext(), R.layout.title, null));
        dialog.show();
        // 7>.CheckBox：这个控件最好自定义
        // xxx
//        // 8>.RadioGroup
//        RadioGroup radioGroup = findViewById(R.id.radio_group);
//        RadioButton leftButton = findViewById(R.id.left_radio);
//        RadioButton rightButton = findViewById(R.id.right_radio);
//        radioGroup.setOnCheckedChangeListener(new RadioGroup.OnCheckedChangeListener() {
//            @Override
//            public void onCheckedChanged(RadioGroup radioGroup, int checkedId) {
//                if (leftButton.getId() == checkedId) {
//
//                } else if (rightButton.getId() == checkedId) {
//
//                }
//            }
//        });
        // 9>.App布局的尺寸单位
        // px - 分辨率
        // 常用分辨率
        // 320 * 480
        // 480 * 800
        // 1280 * 720
        // pt - 逻辑坐标：iOS使用、不同设备不会改变
        // https://blog.csdn.net/qq_39312146/article/details/129271533
        // dp - android使用的尺寸
        // sp - android使用字体大小
    }

    private void showLayout() {
        // 9.基本布局
        // 1>.LinearLayout线性布局
        // 2>.RelativeLayout相对布局
        // 3>.FrameLayout帧布局
        // 4>.ConstraintLayout约束布局
    }

    private void showCustomView() {
        // 10.自定义布局
        // 1.概念：View是最基本的UI组件，可以在屏幕上绘制矩形区域，并且监听各种事件（所有控件都是直接或间接继承View、所有布局都是直接或间接继承自ViewGroup）
        // 2.第一种方式：引入布局（用处有限）
        // 1>.选中res/layout -> 新建navigation_bar.xml -> 写布局代码
        // 2>.<include layout="@layout/navigation_bar"/> // 引入布局：解决了重复编写代码的问题

        // 1>.选中res/layout -> 新建navigation_bar.xml -> 写布局代码
        // 3>.新建class extends 布局 -> 添加自定义控件
        // 4>.实现监听
    }
    // https://blog.csdn.net/u012221046/article/details/52452592

    private void showListView() {
        // 11.ListView：无法实现横向滚动
        // 1>.简单ListView
        ListView listView = findViewById(R.id.list_view);
        /**
         * 数据只能通过Adapter适配器才可以传给ListView（Android中也有ScrollView）
         * @param Context context上下文
         * @param int resource子项布局文件的id：cell的布局
         * @param object 数据
         */
        ArrayAdapter<String> adapter = new ArrayAdapter<>(MainActivity.this, android.R.layout.simple_list_item_1, datas);
        // 数据无法直接传递给ListView，需要借助适配器adapter
        listView.setAdapter(adapter);
        // 2>.定制ListView
        // 准备阶段
        // a.我们需要在Activity中添加ListView控件
        // b.我们需要布局ListView控件子项的UI
        // c.创建数据model
        // 实施阶段
        // a.新建Adapter适配器（自定义）
        // b.对接数据
        for (int index = 0; index < 10; index++) {
            FruitItem item = new FruitItem("123", 0);
            fruits.add(item);
        }
        FruitAdapter fruitItemAdapter = new FruitAdapter(MainActivity.this, R.layout.listview_fruit_item, fruits);
        listView.setAdapter(fruitItemAdapter);
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> adapterView, View view, int i, long l) {
                FruitItem fruitItem = fruits.get(i);
                Log.v(TAG, fruitItem.getName() + fruitItem.getImageId());
            }
        });
    }

    private void showGridView() {
        // 12.GridView
    }

    private void showFragment() {
        // 13.碎片Fragment
        // 1>.概念：碎片Fragment是一种可以嵌入在Activity中的UI片段
        // 2>.作用：广泛用于平板电脑，让程序更加合理和充分的利用大屏幕
        // 3>.直接添加碎片
        // xxx
        // 4>.动态添加Fragment
        FragmentManager manager = getSupportFragmentManager();
        FragmentTransaction transaction = manager.beginTransaction();
        transaction.replace(R.id.other_fragment, new RightFragment());
        transaction.addToBackStack(null); // 4>.在碎片中模拟返回栈：点击Back按钮不会直接退出（返回上一个碎片）
        transaction.commit();
        // 5>.碎片和活动之间通信
        // >>在activity中获取fragment
        RightFragment rightFragment = (RightFragment)getSupportFragmentManager().findFragmentById(R.id.other_fragment);
//        // >>在fragment中怎么获取activity
//        MainActivity activity = (MainActivity) getActivity();
//        // >>fragment获取另一个fragment
//        activity.getSupportFragmentManager().findFragmentById(R.id.right_fragment);
        // 6>.碎片的生命周期
        // a.运行状态：当一个fragment是可见的，并且它所关联的activity正处于运行状态时，该fragment也处于运行状态
        // b.暂停状态：当一个activity进入暂停状态时(由于另一个未占满屏幕的activity被添加到了栈顶)，与它相关联的可见fragment就会进入到暂停状态
        // c.停止状态：当一个activity进入停止状态时，与它相关联的fragment就会进入到停止状态/通过调用FragmentTransaction的remove()、replace()方法将碎片从活动中移除，但如果在事务提交之前调用addToBackStack()方法，这时的碎片也会进入到停止状态（进入停止状态的fragment对用户来说是完全不可见的，有可能会被系统回收）
        // d.销毁状态：fragment总是依附于activity而存在的，当activity被销毁时，与它相关联的fragment就会进入到销毁状态/通过调用FragmentTransaction的remove()、replace()方法将碎片从活动中移除，但在事务提交之前并没有调用addToBackStack()方法，这时的碎片也会进入到销毁状态
    }

    private void showDynamicLoadLayout() {
        // 14.动态加载布局
        // 1>.使用限定符：模糊概念
        // 新建layout-large文件夹 -> 导入相同名称的布局文件：实现不一样
        // >>与屏幕大小有关
        // layout-small - 提供给小屏幕设备的资源
        // layout-normal - 提供给中等屏幕设备的资源
        // layout-large - 提供给大屏幕设备的资源
        // layout-xlarge - 提供给超大屏幕设备的资源
        // >>与分辨率有关
        // drawable-ldpi - 提供给低分辨率设备的资源(120dpi以下)
        // drawable-mdpi - 提供给中等分辨率设备的资源(120dpi~160dpi)
        // drawable-hdpi - 提供给高分辨率设备的资源(160dpi~240dpi)
        // drawable-xhdpi - 提供给超高分辨率设备的资源(240dpi~320dpi)
        // drawable-xxhdpi - 提供给超超高分辨率设备的资源(320dpi~480dpi)
        // >>与屏幕方向有关
        // layout-land - 提供给横屏设备的资源
        // layout-port - 提供给竖屏设备的资源
        // 2>.使用最小宽度限定符：精确概念（以dp为单位）
        // layout-sw600dp：屏幕宽度大于这个值的设备就加载这个布局
        // FIXME - 3>.res目录详解
        // xxx
        // selector
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

    @Override
    public void onClick(View view) {
        if (view.getId() == R.id.login_btn) {
            // 逻辑实现
        }
    }

    public void addActivity(Activity activity) {
        activityList.add(activity);
    }

    public void removeActivity(Activity activity) {
        activityList.remove(activity);
    }

    public void finished() {
        for (Activity activity: activityList) {
            if (!activity.isFinishing()) {
                // 销毁活动
                activity.finish();
            }
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main_menu, menu);
        return super.onCreateOptionsMenu(menu);
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.main_add) {
            Toast toast = Toast.makeText(MainActivity.this, "Login", Toast.LENGTH_SHORT);
            toast.setGravity(Gravity.CENTER, 0, 0);
            toast.show();
        } else if (item.getItemId() == R.id.main_remove) {
            // 4>.销毁一个活动
            finish(); // 销毁当前活动
        }
        return super.onOptionsItemSelected(item);
    }

//    /**
//     * @param requestCode 标识是哪一个按钮
//     * @param resultCode 标识是哪个activity
//     * @param data 携带数据
//     */
//    @Override
//    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
//        super.onActivityResult(requestCode, resultCode, data);
//        switch (requestCode) {
//            case 1: {
//                if (resultCode == 100) {
//                    // 获取返回数据
//                    Log.v(TAG, data.getExtras().getString("key")); // 此处getExtras()需要与传入数据的格式一致
//                }
//            }
//            break;
//        }
//    }

    @Override
    protected void onStart() {
        super.onStart();
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    @Override
    protected void onPause() {
        super.onPause();
    }

    @Override
    protected void onStop() {
        super.onStop();
    }

    @Override
    protected void onRestart() {
        super.onRestart();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
    }

    @Override
    public void onBackPressed() {
        super.onBackPressed();
        // 按下物理Back键执行该方法
        // https://blog.csdn.net/weixin_44570190/article/details/135995654
        // https://blog.csdn.net/chen_md/article/details/125201681?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-125201681-blog-135995654.235%5Ev43%5Epc_blog_bottom_relevance_base2&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-4-125201681-blog-135995654.235%5Ev43%5Epc_blog_bottom_relevance_base2&utm_relevant_index=8
    }

    @Override
    public void onSaveInstanceState(@NonNull Bundle outState, @NonNull PersistableBundle outPersistentState) {
        super.onSaveInstanceState(outState, outPersistentState);
        // 活动被回收之前调用（保存临时数据）
        String tempString = "谢吴军";
        outState.putString("name", tempString);
    }
}