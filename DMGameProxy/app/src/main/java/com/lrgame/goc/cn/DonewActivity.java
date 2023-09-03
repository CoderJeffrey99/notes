package com.lrgame.goc.cn;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.widget.Toast;

// 在此处先进行一波安卓的学习
public class DonewActivity extends AppCompatActivity {
    private final String TAG = "DMGameProxy";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_donew);

        /**
         * 1、Android概述
         * // 什么是Android
         * 1>.一个针对移动设备的操作系统和软件平台
         * 2>.基于Linux内核
         * 3>.由Google和开放手机联盟OHA开发的
         * 4>.允许使用java语言来开发和管理代码
         * 5>.Android开放源代码遵从ASL2.0版本的协议
         * 6>.Android于2007-11-05开放手机联盟成立时发布
         *
         * // Android的特点
         * 1>."应用框架/组件"可以重复使用
         * 2>.集成基于开源WebKit引擎的浏览器
         * 3>.SQLite做为结构化数据存储
         * 4>.Android支持多媒体、蓝牙、Wi-Fi、照相机、指南针、加速仪等传感器硬件
         * 5>.丰富的开发环境：包括模拟机、调试工具、内存运行检测
         *
         * // Android架构
         * 1>.Linux内核层：Android基于Linux内核（内核提供系统核心服务：进程、内存、电源管理、网络连接/Linux内核位于硬件和软件之间的抽象层）
         * 2>.系统运行库层：通过一些C/C++库来为Android系统提供了主要的特性支持（SQLite库提供了数据库的支持，OpenGL|ES库提供了3D绘图的支持，Webkit库提供了浏览器内核的支持）
         * 3>.应用框架层：提供构建应用程序时可能用到的各种API
         * 4>.应用层：各种App
         *
         * // Android应用开发特色
         * 1>.四大组件：Activity、Service、Broadcast Receiver、Content Provider
         * 2>.丰富的系统组件
         * 3>.支持SQLite数据库
         * 4>.强大的多媒体
         * 5>.地理位置定位
         */

        // 2、输出方法
        System.out.println("这是java输出方法");
        Log.v(TAG, "最为琐碎的、意义最小的日志信息");
        Log.d(TAG, "调试信息");
        Log.i(TAG, "比较重要的数据");
        Log.w(TAG, "警告信息");
        Log.e(TAG, "错误信息");

        // 3、Toast
        // LENGTH_SHORT和LENGTH_LONG有什么区别
        Toast.makeText(this, "我是toast", Toast.LENGTH_LONG);

        // 4、Intent
        // 1>.显示Intent
        /**
         * 此处需要新建页面（在Android中一个activity就是一个页面）
         * 1>.新建activity文件：New -> Activity -> Empty Views Activity
         * 2>.新建activity.xml布局文件：自动勾选
         * 3>.在AndroidManifest.xml文件中注册activity：自动勾选
         */
        Intent intent = new Intent(this, MainActivity.class);
        intent.putExtra("key1", "我是传递的数据");
        startActivity(intent);

        /**
         * 1.AS怎么导入module：https://blog.csdn.net/ygd1994/article/details/51348323
         * 2.AS删除module：https://blog.csdn.net/record_my_world/article/details/80292518
         * 3.相关错误：https://blog.csdn.net/blank__box/article/details/80321473
         */

    }
}