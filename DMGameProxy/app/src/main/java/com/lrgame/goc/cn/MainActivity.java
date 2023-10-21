package com.lrgame.goc.cn;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.os.PersistableBundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {
    private final static String TAG = "DMGameProxy";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    private void showBaseIdea() {
        // 1.Android系统
        // 1>.概述
        // a.定义：Android是基于Linux内核，由“谷歌Google”和"开放手机联盟OHA"开发的针对移动设备的OS
        // b.特点：应用框架和组件可以重复使用、允许Java语言开发和管理代码、丰富的开发环境：模拟器、调试工具、运行内存检测...、源代码完全开放
        // c.Dalvik虚拟机：“谷歌Google”设计的针对Android平台的虚拟机
        // 2>.架构
        // a.Linux内核层：为硬件提供驱动：显示驱动、音频驱动、照相机驱动
        // b.系统运行库层：通过C/C++库来为Android系统提供主要的特性支持
        // c.应用框架层：提供构建应用程序可能用到的各种api
        // d.应用层：所有安装在手机上的应用程序
        // 3>.特色
        // a.四大组件：Activity、Service、Broadcast Receiver、Content Provider
        // b.丰富的系统组件
        // c.支持SQLite数据库
        // d.强大的多媒体
        // e.地理位置定位
        // 4>.版本
        // a.时间：2008年9月，谷歌正式发布了Android1.0
        // b.参考：http://developer.android.google.cn/about/dashboards

        // 2.搭建开发环境
        // 1>.Eclipse（废弃）
        // a.下载安装JDK，配置java环境变量
        // b.下载安装Eclipse，安装ADT插件
        // c.下载安装Android SDK，配置Android环境变量
        // d.配置ADV安卓虚拟机
        // 2>.Android Studio
        // a.下载安装JDK，配置java环境变量
        // b.下载安装Android Studio
        // c.下载安装Android SDK，配置Android环境变量
        // d.创建模拟器AVD

        // 3.项目结构
        // 1>.Android模式
        /**
         * 2>.结构模式
         * .gradle ------ AS自动生成的文件：无需关心，不能手动编辑
         * .idea ------ AS自动生成的文件：无需关心，不能手动编辑
         * app ------ module
         *  libs ------ 存放第三方jar包：放在这个目录下的jar包都会被自动添加到构建路径中
         *  src/androidTest ------ 编写测试用例
         *  *src/main/java ------ 源代码
         *  *src/main/res ------ 资源文件
         *   drawable ------ 图片
         *   mipmap ------ 图标
         *    mipmap.xxhdpi ------ 只有一份图标：放这里
         *   layout ------ 布局
         *   values ------ 字符串
         *    colors.xml ------ 颜色
         *    strings.xml ------ 字符串
         *    themes.xml ------ 主题
         *  *AndroidManifest.xml ------ 项目配置文件
         *  test ------ 编写Unit Test测试用例
         *  .gitignore ------ git忽略文件
         *  build.gradle ------ app模块的gradle构建脚本
         *  proguard-rules ------ 指定项目代码的混淆规则：如果不希望代码被别人识别可以将代码进行混淆
         * build ------ 编译时自动生成的文件：无需关心
         * gradle ------ AS默认不启用gradle wrapper
         * .gitignore  ------ git忽略文件
         * build.gradle ------ 全局gradle构建脚本：基本不需要修改
         * gradle.properties ------ 配置的属性将会影响项目中所有的gradle编译脚本
         * gradlew ------ 用来在命令行界面执行gradle命令：Linux系统和Mac系统
         * gradlew.bat ------ 用来在命令行界面执行gradle命令：Windows系统
         * xxx.iml - 用于标记这是一个IDEA项目
         * local.properties ------ 用来指定本机中的Android SDK路径
         * setting.gradle ------ 指定项目中所有引入的模块
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

        // 4.日志工具
        Log.v("", ""); // 用于打印那些最为琐碎的、意义最小的日志信息verbose
        Log.d("", ""); // 打印调试信息debug
        Log.i("", ""); // 打印比较重要的数据info
        Log.w("", ""); // 打印警告信息warn
        Log.e("", ""); // 打印错误信息error
    }

    private void showActivity() {
        // 5.activity活动
        // 1>.创建activity
        // a.新建xxx.java代码文件
        // b.新建xxx.xml布局文件
        // c.在AndroidManifest.xml中注册
        // 2>.toast
        Button button = findViewById(R.id.login_btn); // 获取布局文件定义的元素
        // 匿名内部类：也可以直接传入实现该接口的类的对象
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                // Toast.LENGTH_LONG
                // LENGTH_SHORT
                Toast.makeText(MainActivity.this, "Login", Toast.LENGTH_SHORT).show();
            }
        });
        // 3>.menu
        // >>默认不会显示：右屏幕三个点点击一下弹出
        // 5>.Intent
        // a.显示
        Intent intent = new Intent(MainActivity.this, HomeActivity.class);
        // 传递数据
        intent.putExtra("name", "xwj");
        intent.putExtra("age", 18);
        startActivity(intent);
        // b.隐式
        // >>没有任何Intent响应则会crash
        intent = new Intent("com.lrgame.goc.cn.ACTION_HOME");
        // >>默认的category不用添加
        intent.addCategory("com.lrgame.goc.cn.category.HOME");
        startActivity(intent);
        // 返回数据给上一个activity
        startActivityForResult(intent, 1);
        // 6>.生命周期
        // p66
        // 7>.启动模式
        // a.standard：默认启动模式（系统不会关注这个活动是否已经在返回栈中存在，每次启动都会创建该活动的一个新的实例）
        // b.singleTop：启动活动时如果发现返回栈的栈顶（必须位于栈顶，不然还会创建新对象）已经是该活动，则直接使用它，不会再创建新的活动实例
        // c.singleTask：每次启动该活动时系统首先会在返回栈中检查是否存在该活动的实例，如果发现已经存在则直接使用该实例，并把在这个活动之上的所有活动统统出栈，如果没有发现就会创建一个新的活动实例
        // d.singleInstance：xxx
        // 8>.最佳实践
    }

    private void showUserInterface() {

    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.main_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(@NonNull MenuItem item) {
        if (item.getItemId() == R.id.main_add) {
            Toast.makeText(MainActivity.this, "Login", Toast.LENGTH_SHORT).show();
        } else if (item.getItemId() == R.id.main_remove) {
            // 4>.销毁一个活动
            finish(); // 销毁当前活动
        }
        return true;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        switch (requestCode) {
            case 1: {
                if (resultCode == 100) {
                    // 获取返回数据
                }
            }
            break;
        }
    }

    // 8.activity的生命周期
    // 1>.概念：Android使用"任务task（一组存放在返回栈中的活动的集合）"管理活动
    // 2>.特点：系统总会显示处于栈顶的activity
    // 3>.activity的生命周期：运行状态、暂停状态、停止状态、销毁状态
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
    private void showLog() {
        // 7.Intent
        // 1>.显示Intent
        /**
         * 此处需要新建页面（在Android中一个activity就是一个页面）
         * 1>.新建activity文件：New -> Activity -> Empty Views Activity
         * 2>.新建activity.xml布局文件：勾选自动创建
         * 3>.在AndroidManifest.xml文件中注册activity：勾选自动创建
         */
        Intent intent = new Intent(this, HomeActivity.class);
        intent.putExtra("key1", "我是传递的数据");
        startActivity(intent);
        // 2>.隐式Intent
        Intent intent1 = new Intent("");
        intent1.addCategory("");
        intent1.addCategory("");
        startActivity(intent1);
        // 3>.打开网页
        Intent intent2 = new Intent(Intent.ACTION_VIEW);
        intent2.setData(Uri.parse("https://www.baidu.com"));
        startActivity(intent2);
    }

    private void showUI() {
        // 10.UI控件：res -> layout -> xxx.xml
        // 1>.TextView = UILabel
        TextView textView = findViewById(R.id.text_view);
        System.out.println(textView.getText().toString());
        // 2>.Button == UIButton
        Button loginBtn = findViewById(R.id.login_btn);
//        // 第一种方式：匿名函数
//        loginBtn.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                // 点击事件
//            }
//        });
        // 第二种方式：callback
        loginBtn.setOnClickListener(this);
        // 3>.EditText == UITextfield
        EditText editText = findViewById(R.id.edit_text);
        System.out.println(editText.getText().toString());
    }

    @Override
    public void onClick(View view) {
        switch (view.getId()) {
            case R.id.login_btn: {

            }
            break;
        }
    }
}
















/**
 * Android中分成：
 * LRGame表示项目：项目中有自己的build.grade
 * LRGame项目中有多个plugin插件：plugin插件分成两个部分
 * com.android.application - 表示应用程序默认：可以独立运行
 * >>自己的build.grade
 * com.android.library - 表示库模块：无法独立运行（需要依附在application模块上运行）
 * >>自己的build.grade
 */

/**
 * gradle脚本基于Groovy...配置相应的gradle脚本就能够达到自动化构建的目的
 * xxx.gradle文件是一种用于构建工具Gradle的配置文件
 */

//        主流三方库：
//        网络：
//        1、OKHttp
//        2、Retrofit
//        图片：
//        3、Glide
//        数据库：
//        4、GreenDao
//        响应式编程：
//        5、RxJava
//        内存泄露：
//        6、LeakCanary
//        依赖注入：
//        7、ButterKnife
//        8、Dagger2
//        事件总线：
//        9、EventBus

//        Android Gradle Plugin Version = 8.1.1
//        Gradle Version = 8.0
//        JDK = 17.0.8