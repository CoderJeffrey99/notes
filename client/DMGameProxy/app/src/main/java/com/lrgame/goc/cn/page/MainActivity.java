package com.lrgame.goc.cn.page;

import androidx.activity.result.ActivityResult;
import androidx.activity.result.ActivityResultCallback;
import androidx.activity.result.ActivityResultLauncher;
import androidx.activity.result.contract.ActivityResultContracts;
import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.content.ContextCompat;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentTransaction;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.graphics.Color;
import android.net.Uri;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.PersistableBundle;
import android.text.TextUtils;
import android.util.Log;
import android.view.Gravity;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.Window;
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
import com.lrgame.goc.cn.entity.FruitItem;
import com.lrgame.goc.cn.entity.PersonEntity;
import com.lrgame.goc.cn.fragment.RightFragment;

import java.util.ArrayList;
import java.util.List;

// AppCompatActivity是一种向下兼容的Activity：最低兼容到2.1系统、属于Activity的子类
public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private static final String TAG = "DMGameProxy";

    private ActivityResultLauncher firstLauncher;

    private String[] datas = {"Apple", "Banana", "Orange", "Watermelon", "Pear",
            "Grape", "Pineapple", "Strawberry", "Cherry", "Mango",
            "Apple", "Banana", "Orange", "Watermelon", "Pear",
            "Grape", "Pineapple", "Strawberry", "Cherry", "Mango"};

    private List<FruitItem> fruits = new ArrayList<>();

    private List<Activity> activityList = new ArrayList<>();

    // 当Activity启动的时候调用
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        showBaseIdea();

        showActivity();


        






















        // 将系统自带的标题栏隐藏
        // 作用于当前activity
        requestWindowFeature(Window.FEATURE_NO_TITLE);
//        ActionBar actionBar = getSupportActionBar();
//        if (actionBar != null) {
//            actionBar.hide();
//        }
        setContentView(R.layout.activity_main);

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
    }

    private void showBaseIdea() {
        // 概述
        // a>.定义：Android是基于Linux内核，由“谷歌Google”和"开放手机联盟OHA"开发的针对移动设备的操作系统
        // b>.发布时间：2008年9月，谷歌正式发布了Android1.0
        // c>.阻力：苹果乔布斯认为Android抄袭iOS、基于Linux内核开发的Android被Linux团队从Linux内核主线中除名、甲骨文起诉Android侵犯java知识产权
        // d>.优势：google开源Android源代码（任何单位和个人都可以免费的获取Android源代码，并自由使用和定制）
        // e>.特点：应用框架和组件可以重复使用、允许Java语言开发和管理代码、丰富的开发环境：模拟器、调试工具、运行内存检测

        // 系统架构
        // a>.Linux内核层：为硬件提供驱动（显示驱动、音频驱动、照相机驱动）
        // b>.系统运行库层（运行机制DVM-JVM）：通过C/C++库来为Android系统提供主要的特性支持
        // c>.应用框架层：提供构建应用程序可能用到的各种api
        // d>.应用层：所有安装在手机上的应用程序

        // 搭建开发环境
        // a>.下载安装jdk -> 配置java环境变量
        // b>.下载安装Android Studio -> 下载Android SDK -> 创建模拟器AVD

        // 项目结构
        /**
         * a>.Project模式
         * b>.Android模式
         */

        // 资源引用
        // a>.代码中使用
        System.out.println(R.string.app_name);
        System.out.println(R.layout.activity_main);
        System.out.println(R.drawable.ic_launcher_background);
        System.out.println(R.mipmap.ic_launcher);
        // b.在xml文件中使用
        // @string/app_name
        // @layout/activity_main
        // @drawable/ic_launcher_background
        // @mipmap/ic_launcher

        // Log输出
        System.out.println("hello world");
        Log.v(TAG, "verbose"); // 用于打印那些最为琐碎的、意义最小的日志信息verbose
        Log.d(TAG, "debug"); // 打印调试信息debug
        Log.i(TAG, "info"); // 打印比较重要的数据info
        Log.w(TAG, "warn"); // 打印警告信息warn
        Log.e(TAG, "error"); // 打印错误信息error：红色
    }

    private void showActivity() {
        // activity活动
        // 1.创建
        // a>.新建xxx.java代码文件
        // b>.新建xxx.xml布局文件
        // c>.在AndroidManifest.xml中注册
        // 2.toast
        // Toast.LENGTH_LONG - 2s（推荐使用）
        // Toast.LENGTH_SHORT - 3.5s
        Toast.makeText(MainActivity.this, "", Toast.LENGTH_SHORT).show();
        // 3.menu菜单
        // a>.默认不会显示：右屏幕三个点点击一下弹出
        // b>.选中res -> 新建menu -> 选中menu -> 选择Menu resource file
        // c>.重写onOptionsItemSelected()方法
        // 4.Intent意图
        // a>.作用：减少组件之间的耦合、使用Intent应用于android三个核心组件：Activity、Service、Broadcast Receiver
        // b>.显式Intent
        /**
         * 此处需要新建页面（在Android中一个activity就是一个页面）
         * 1>.新建activity文件：New -> Activity -> Empty Views Activity
         * 2>.新建activity.xml布局文件：勾选自动创建
         * 3>.在AndroidManifest.xml文件中注册activity：勾选自动创建
         */
        // 第一种方式
        Intent intent = new Intent(MainActivity.this, HomeActivity.class);
        intent.putExtra("name", "xwj");
//        String name = getIntent().getStringExtra("name"); // 传递的是String类型
        intent.putExtra("age", 18);
//        int age = getIntent().getIntExtra("age", 18); // 传递的是int类型
        // 传递对象：对象必须序列化
        intent.putExtra("data", new PersonEntity());
//        PersonEntity p1 = (PersonEntity) getIntent().getSerializableExtra("data"); // 获取对象
        startActivity(intent);
        // 第二种方式
        Intent intent1 = new Intent();
        intent1.setClass(MainActivity.this, HomeActivity.class);
        Bundle bundle = new Bundle();
        bundle.putString("name", "xwj");
        intent1.putExtras(bundle);
//        Bundle bundle = getIntent().getExtras();
//        bundle.get("name");
        startActivity(intent1);
        // c.隐式Intent：没有任何Intent响应则会crash（必须在Manifest文件中声明）
        // 一个intent只能指定一个action
        Intent intent2 = new Intent("com.lrgame.goc.cn.ACTION_HOME");
        // 一个intent可以指定多个category
        // >>默认category不用添加（调用startActivity()方法的时候会自动将这个category添加到Intent中）
        intent2.addCategory("android.intent.category.DEFAULT");
        // >>自定义category必须指定
        intent2.addCategory("com.lrgame.goc.cn.category.HOME");
        startActivity(intent2);
        // c.打开网页
        Intent intent3 = new Intent(Intent.ACTION_VIEW);
        intent3.setData(Uri.parse("https://www.baidu.com"));
        startActivity(intent3);
        // d.返回数据给上一个activity
//        startActivityForResult(intent, 1);
        firstLauncher = registerForActivityResult(new ActivityResultContracts.StartActivityForResult(), new ActivityResultCallback<ActivityResult>() {
            @Override
            public void onActivityResult(ActivityResult result) {
                switch (result.getResultCode()) {
                    case RESULT_OK:{
                        Intent data = result.getData();
                        if (data != null) {
                            Log.v(TAG, data.getStringExtra("name"));
                        }
                        /*
                        HomeActivity.java页面需要有两个按钮和onBackPressed()方法
                        // 创建返回的 Intent
                        Intent resultIntent = new Intent();
                        resultIntent.putExtra("name", inputData);
                        setResult(RESULT_OK, resultIntent);
                        setResult(RESULT_CANCELED);
                        // 关闭当前Activity（onBackPressed()方法中不需要写这一句）
                        finish();
                        */
                    }
                    break;
                    case RESULT_CANCELED:{

                    }
                    break;
                }
            }
        });
        firstLauncher.launch(intent1);
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
        Handler sHandler1= new Handler(message -> {
            // 延迟执行的语句
            Log.v(TAG, message.obj.toString());
            return false;
        });
        sHandler1.sendEmptyMessageDelayed(0, 2000);
        Message msg = new Message();
        msg.what = 1;
        msg.obj = "xwj";
        // 此处执行就会进入handleMessage()方法
        sHandler1.sendMessage(msg);
        // 5.生命周期
        // a>.概念：Android使用"任务task（一组存放在返回栈中的活动的集合）"管理活动
        // b>.特点：系统总会显示处于栈顶的activity
        // c>.activity的生命周期：运行状态、暂停状态、停止状态、销毁状态
        // 6.启动模式
        // a>.standard：默认启动模式（系统不会关注这个活动是否已经在返回栈中存在，每次启动都会创建该活动的一个新的实例）
        // b>.singleTop：启动活动时如果发现返回栈的栈顶（必须位于栈顶，不然还会创建新对象）已经是该活动，则直接使用它，不会再创建新的活动实例
        // c>.singleTask：每次启动该活动时系统首先会在返回栈中检查是否存在该活动的实例，如果发现已经存在则直接使用该实例，并把在这个活动之上的所有活动统统出栈，如果没有发现就会创建一个新的活动实例
        // d>.singleInstance：xxx
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
            // 销毁当前活动
            finish();
        }
        return super.onOptionsItemSelected(item);
    }

    private void showBaseUI() {
        // TextView
        TextView textView = findViewById(R.id.text_view);
        textView.setTextColor(ContextCompat.getColor(MainActivity.this, R.color.colorAccent));
        textView.setBackgroundColor(Color.YELLOW); // java一般使用“class + 常量”替代“枚举”
        textView.setTextSize(25.0f);
        textView.setText("123");
        Log.v(TAG, textView.getText().toString());

        // Button
        Button button = findViewById(R.id.login_btn);
//        button.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                // 逻辑实现
//            }
//        });
        button.setOnClickListener(this);

        // EditText
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
//                    // 执行发送消息操作
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
                // 执行发送消息操作
                return true;
            }
            return false;
        });

        // ImageView
        ImageView imageView = findViewById(R.id.image_view);
        imageView.setImageResource(R.drawable.ic_launcher_background); // 推荐使用
        imageView.setImageDrawable(ContextCompat.getDrawable(MainActivity.this, R.drawable.ic_launcher_background));

        // ProgressBar
        // ProgressDialog废弃
        ProgressBar progressBar = findViewById(R.id.progress_bar);
        /**
         * View.VISIBLE控件可见
         * View.INVISIBLE控件不可见（仍然占据原来的位置）
         * View.GONE控件不可见（不再占据原来的位置）
         */
        progressBar.setVisibility(View.GONE);

        // AlertDialog
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

        // CheckBox：这个控件最好自定义

//        // RadioGroup
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

        // 尺寸单位
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
        // 基本布局
        // LinearLayout线性布局
        // RelativeLayout相对布局
        // FrameLayout帧布局
        // TableLayout表格布局（不推荐）
        // AbsoluteLayout绝对布局（不推荐）
        // ConstraintLayout约束布局
    }

    private void showCustomView() {
        // 自定义布局
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
        // ListView：无法实现横向滚动
        // 1.简单ListView
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
        // 2.定制ListView
        // 准备阶段
        // a>.我们需要在Activity中添加ListView控件
        // b>.我们需要布局ListView控件子项的UI
        // c>.创建数据model
        // 实施阶段
        // a>.新建Adapter适配器（自定义）
        // b>.对接数据
        for (int index = 0; index < 10; index++) {
            FruitItem item = new FruitItem("123", 0);
            fruits.add(item);
        }
        FruitAdapter fruitItemAdapter = new FruitAdapter(MainActivity.this, R.layout.listview_fruit_item, fruits);
        listView.setAdapter(fruitItemAdapter);
        listView.setOnItemClickListener((adapterView, view, i, l) -> {
            FruitItem fruitItem = fruits.get(i);
            Log.v(TAG, fruitItem.getName() + fruitItem.getImageId());
        });
    }

    private void showSize() {
        // px - 像素（屏幕上可以显示的最小元素单元）
        // pt表示字体
        // 分辨率
        // dp/sp - 在不同密度的屏幕中显示比例将保持一致
        // 160dpi的屏幕 1dp = 1px
        // 320dpi的屏幕 1dp = 2px
        // 密度 - 是屏幕每英寸所包含的像素数、dpi
        float x = getResources().getDisplayMetrics().xdpi;
        float y = getResources().getDisplayMetrics().ydpi;
    }

    private void showGridView() {
        // GridView
    }

    private void showFragment() {
        // 碎片Fragment
        // a>.概念：碎片Fragment是一种可以嵌入在Activity中的UI片段
        // b>.作用：广泛用于平板电脑，让程序更加合理和充分的利用大屏幕
        // c>.直接添加碎片
        // xxx
        // d>.动态添加Fragment
        FragmentManager manager = getSupportFragmentManager();
        FragmentTransaction transaction = manager.beginTransaction();
        transaction.replace(R.id.other_fragment, new RightFragment());
        transaction.addToBackStack(null); // 4>.在碎片中模拟返回栈：点击Back按钮不会直接退出（返回上一个碎片）
        transaction.commit();
        // e>.碎片和活动之间通信
        // >>在activity中获取fragment
        RightFragment rightFragment = (RightFragment)getSupportFragmentManager().findFragmentById(R.id.other_fragment);
//        // >>在fragment中怎么获取activity
//        MainActivity activity = (MainActivity) getActivity();
//        // >>fragment获取另一个fragment
//        activity.getSupportFragmentManager().findFragmentById(R.id.right_fragment);
        // f>.碎片的生命周期
        // 运行状态：当一个fragment是可见的，并且它所关联的activity正处于运行状态时，该fragment也处于运行状态
        // 暂停状态：当一个activity进入暂停状态时(由于另一个未占满屏幕的activity被添加到了栈顶)，与它相关联的可见fragment就会进入到暂停状态
        // 停止状态：当一个activity进入停止状态时，与它相关联的fragment就会进入到停止状态/通过调用FragmentTransaction的remove()、replace()方法将碎片从活动中移除，但如果在事务提交之前调用addToBackStack()方法，这时的碎片也会进入到停止状态（进入停止状态的fragment对用户来说是完全不可见的，有可能会被系统回收）
        // 销毁状态：fragment总是依附于activity而存在的，当activity被销毁时，与它相关联的fragment就会进入到销毁状态/通过调用FragmentTransaction的remove()、replace()方法将碎片从活动中移除，但在事务提交之前并没有调用addToBackStack()方法，这时的碎片也会进入到销毁状态
    }

    private void showDynamicLoadLayout() {
        // 动态加载布局
        // a>.使用限定符：模糊概念
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
        // b>.使用最小宽度限定符：精确概念（以dp为单位）
        // layout-sw600dp：屏幕宽度大于这个值的设备就加载这个布局
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
    public void onSaveInstanceState(@NonNull Bundle outState, @NonNull PersistableBundle outPersistentState) {
        super.onSaveInstanceState(outState, outPersistentState);
        // 活动被回收之前调用（保存临时数据）
        String tempString = "谢吴军";
        outState.putString("name", tempString);
    }
}