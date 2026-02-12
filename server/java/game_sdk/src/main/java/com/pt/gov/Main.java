// package语句位于源文件的首行
package com.pt.gov;

// import语句位于package语句和类定义之间
// 同一个包下的xxx.java文件不需要import
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Collection;
import java.util.Collections;
import java.util.Random;
import java.util.Scanner;
import java.util.Set;
import java.util.Stack;
import java.util.TreeSet;
import java.util.Vector;

// 一个源文件最多只能有一个public类：也可以没有
// 一个源文件可以有多个非public类：一个class的定义对应一个xxx.class文件
// public类的className必须与源文件名一致
// Java所有的类默认继承根类Object
public class Main { // 类名尽量不要相同
    /**
     * 4.main函数：程序的入口（凡是需要加载的类全部加载到JVM中才会执行main方法）
     * public - 被JVM调用，权限需要足够大
     * static - 被JVM调用，不需要创建对象，类名访问
     * void - 被JVM调用，不需要任何的返回值
     * main - 默认规定的（只有这样写才能被JVM识别）
     * String[] args - 接收键盘录入的数据：args参数名可以修改
     */
    public static void main(String[] args) {
        // 创建类
        Main m1 = new Main();
        // 输出的是d1的地址
        System.out.println(m1); 
        // 可以将“java对象”转换成“字符串形式”
        // 与上面的方法等价：我们可以通过重写toString{}方法
        System.out.println(m1.toString());
        m1.showPackageBase();
        m1.showProjectNums();
        m1.showPackageDataType();
        m1.showPackageOperator(m1);
        m1.showPackageCondition();
        m1.showPackageLoop();
        m1.showPackageArray();
        m1.showPackageGroup();
        m1.showPackageString();
        m1.showPackageStringBuffer();
        m1.showPackageOtherClass();
        m1.showPackageRegex();
        m1.showPackageScanner();
    }

    private void showPackageBase() {
        /**
         * 1.计算机基础
         * 1>.常用快捷键
         * command+C/V/X/A/S/Z - 复制/粘贴/剪切/全选/保存/撤销一步
         * 2>.人机交互
         * 命令行方式：需要在控制台输入特定的指令（操作麻烦）
         * 图形化界面：简单直观
         * 3>.DOS命令
         * cd + 文件夹 - 进入指定文件夹
         * cd .. - 回退到上一级目录
         * dir - 查看当前目录下的文件（夹）
         * mkdir + 文件夹名 - 创建文件夹
         * rmdir + 文件夹名 - 删除文件夹（只能删除空文件夹、不走废纸篓）
         * echo.> + 文件 - 创建文件
         * cls - 清屏
         * exit - 退出dos命令行
         * 4>.相对路径和绝对路径
         * >>相对路径：从“文件自身”出发
         * $/ - 进入下一个文件夹
         * $../ - 返回上一个文件夹
         * >>绝对路径：从”我的电脑“出发（基本不使用）
         * 5>.计算机的组成：硬件（cpu、内存、硬盘、主板）、软件（系统软件、应用软件）
         * 6>.计算机语言发展史：机器语言 -> 汇编语言 -> 高级语言
         */

        /**
         * 2.Java简介：底层是C++
         * 1>.特征：简单性、面向对象、分布式处理、解释性、健壮性、跨平台、安全性、可移植性、高性能、多线程、动态性、开源、强类型语言
         * 2>.诞生：1995年Sun公司正式推出、James Gosling
         * 3>.分类
         * JavaSE标准版（为开发普通桌面和商务应用程序提供的解决方案）- 基础/Java标准平台
         * JavaME小型版（为开发电子消费产品和嵌入式设备提供的解决方案）- 安卓/嵌入式产品开发平台
         * JavaEE企业版（为开发企业环境下的应用程序提供的解决方案）- 后台/企业级应用开发平台
         * 4>.平台：Java虚拟机（C++编写） + JavaAPI
         * 5>.跨平台：JVM不是跨平台、JVM没有独立安装包
         * 什么是跨平台：通过java语言编写的应用程序在不同的系统平台上都可以运行
         * 原理：在运行java应用程序的OS上安装一个JVM，由JVM负责java应用程序在该系统中的运行
         * 6>.JRE和JDK
         * JRE/java运行环境：JVM + 类库/运行java程序
         * JDK/java开发工具包：JRE + java开发工具包/开发java程序
         * 7>.JDK的安装和卸载
         * 卸载：直接找到安装目录卸载
         * 安装：进入www.oracle.com下载
         * 8>.java开发工具
         * Notepad：记事本
         * Notepad++：简单编译工具
         * eclipse：IBM公司花费4000万美元利用java开发的IDE
         * MyEclipse：付费IDE
         * IntelliJ IDEA：付费IDE
         */

        // 3.Java开发环境搭建
        // 1>.下载JDK（Java开发工具包）= JRE（Java运行环境）+ Java工具 + Java基础类库
        // 2>.JDK的配置：安装JDK -> 配置环境变量：希望在任何位置都可以访问bin目录（桌面计算机 -> 点击右键 -> 属性 -> 高级系统设置 -> 环境变量）
        /**
         * 3>.JDK的目录
         * JDK
         *  bin......JDK工具程序
         *      javac.exe......负责编译
         *      java.exe......负责运行
         *      appletviewer.exe
         * demo......Java自带的演示程序
         * include......用于编译本地方法的c++头文件
         * jre......Java运行环境文件
         * lib......Java的类库文件
         * sample......Java自带的示例程序
         * src.zip......Java API类的源代码压缩文件
         */
        // 4>.java核心机制和JVM运行原理
        // java核心机制：面向对象、跨平台性、垃圾自动回收、异常处理
        // JVM运行原理：JVM是java应用程序的执行环境，负责加载和运行Java字节码
        // >>类加载器 - 负责从文件系统或网络加载.class文件，并将其转换成Java的内部表示形式（检查是否已经加载过该类 -没有加载过-> 将class的字节码文件加载到内存 -> JVM的字节码校验器进行校验/ -已经加载过-> 直接复用）
        // >>解释器 - 负责执行加载到JVM中的字节码（当程序运行时，解释器会将字节码转换成特定平台的机器码并执行，解释器通常采用"一个指令，执行一次"的方式执行字节码）
        // >>JIT编译器 - 将字节码转换为本地机器代码并缓存（提高执行效率）、在运行时将经常执行的热点代码编译成本地机器代码，以减少解释器的开销（提高执行速度）
        // 5>.java的加载和执行：一个xxx.java可以编译生成多个xxx.class文件
        // 编译阶段：java源代码xxx.java必须经过编译变成字节码文件xxx.class才可以被JVM识别
        // 运行阶段：源代码不参与程序的执行过程（编译成字节码文件xxx.class以后可以直接删除java源代码xxx.java）

        /**
         * 5.进制转换
         * 1>.概述
         * 计算机最小存储单位是"字节byte"
         * 1byte = 8bit（"1bit"相当于"一个二进制的数字0或1"）/-128 ～ 127
         * 1K = 1024byte | 1M = 1024K | 1G = 1024M | 1T = 1024G
         * 2>.为什么要引入二进制？？？
         * 因为计算机是以二进制形式进行数据存储：二进制存储简单方便
         * 3>.技巧
         * 大进制->小进制：除k取余法/底部是高位、上部是低位
         * 小进制->大进制：从低位起*k的n（n从0开始）次幂相加
         * 二进制<-->八进制/十六进制：有特殊技巧（3位1取/4位1取：高位不足可以补0）
         * 十进制：用0-9来表示所以的自然数
         */
        // 默认是十进制
        System.out.println(100);
        // 二进制：用0-1来表示所有的自然数
        // 前面加上0b
        System.out.println(0b100);
        // 八进制：用0-7来表示所有的自然数
        // 前面加上0
        System.out.println(0100);
        // 十六进制：用0-F来表示所有的自然数
        // 前面加上0x
        System.out.println(0x100);

        /**
         * 6.原码、补码、反码：1表示负数，0表示正数（！！！有时间可以操作一遍！！！）
         * 1>.真值：一个数的十进制表示形式/机器数：一个数的二进制表示形式
         * 2>.原理：计算机内存是由大量开关组成的，分别用0和1来表示每一位开关（每一位成为1bit，每8位成为1字节/byte）
         * 1kb=1024byte   1Mb=1024kb   1Gb=1024Mb   1Tb=1024Gb/计算机分配内存的最小单位是字节/byte
         * 3>.原码：将一个数的真值的绝对值转为二进制，存储的八位内存空间，最高位存储符号位，1表示负数，0表示正数，其余7位用来存储真值的绝对值的二进制表示形式
         * 结论：计算机不以原码的方式进行数据存储，原码会出现计算错误
         * 4>.反码：正数的反码是原码，负数的反码是原码符号位不变，其余位数按位取反（0变1，1变0）反码的反码是原码
         * 结论：计算机不以反码的方式进行数据存储，反码解决不了0的问题
         * 5>.补码：正数的补码是原码，负数的补码是反码加1，补码的补码是原码
         * 结论：计算机是以补码的形式进行存储、计算机只会做"加法运算"
         * 正数三码合一
         * 真值   原码       反码       补码
         * 1     00000001  00000001   00000001
         * -1    10000001  11111110   11111111
         */
        // 150是int类型：00000000 00000000 00000000 10010110
        // 强制转换为byte类型：10010110
        // 计算机以补码的形式存储：11101010...-106

        // 7.第一个Java程序
        // 快速生成sout
        System.out.println("Hello World");
        
        /**
         * 8.关键字
         * 1>.概念：被Java语言赋予特定含义的单词（区别于JDK的内置类String、Scanner、System...）
         * 2>.特点：关键字全部小写、关键字不能做为标识符
         * 3>.保留关键字：goto/const（保留关键字也不能做为标识符）
         */

        /**
         * 9.标识符
         * 1>.概念：给类、接口、方法、变量起名字时候使用的字符序列（不能与关键字同名）
         * 2>.要求：由字母、数字、_、$组合而成，并且不能以数字开头（不能把关键字和保留字作为标识符、严格区分大小写）
         * 3>.注意：Java语言使用Unicode国际标准字符集（标识符中可以有汉字、日文等，一般不建议这样操作）
         * 4>.命名风格
         * a.包（文件夹）：一般域名（www.heima.com）倒过来/com.heima.utils/全部小写
         * b.类/接口：每个单词首字母大写（驼峰命名）/CMGameProxy
         * c.方法/变量：从第二个单词开始首字母大写/playGame
         * d.常量：所有字母大写，以'_'隔开/MAX_VALUE
         * e.文件：文件命名可以使用数字开头的名称，比如：123.java
         */

        // 10.注释：用于解释说明程序的文字
        // 1>.单行注释：可以嵌套
        /*
        2>.多行注释：不可以嵌套
        */
        // CMGameProxy必须是public
        // javadoc -d 要生成的文件夹的名字 -version -author -CMGameProxy.java
        /**
         * 3>.文档注释：文本会自动包含在用javadoc命令生成的html文档中、不可以嵌套、Java文档生成器
         * @author 谢吴军
         * @version 1.0.0
         * @param name String 名称
         * @deprecated 过期文本
         * @throws ParseException
         * @exception ParseException
         * @see javadoc.tool
         * @since JDK1.3
         * @return 对函数返回值的注释
         */
        // 4>.注释是一个程序猿必须要具备的编程习惯
        // 5>.初学者可以先写注释再写代码
        // 6>.注释可以帮助我们排查错误：初级排错方式（有一定效果）
    }

    private void showProjectNums() {
        // 11.常量和变量
        // 1>.常量：程序运行过程中其值始终不能改变的量
        /**
         * final可以修饰成员变量、成员方法、类
         * 1>.修饰成员变量：表示该成员变量是常量（一般配合static修饰，保存在常量区）、系统不会默认赋值（需要程序员手动赋值（只能赋值一次）：可以声明变量同时赋值（推荐使用）、也可以在构造方法中赋值（使用较少）...其它地方不行）
         * 2>.修饰成员方法：表示该成员方法是最终方法（无法被子类重写，但是可以被继承）
         * 3>.修饰类：表示该类是最终类：不能被继承
         */
        final int MAX = 100; // final修饰的变量只能赋值一次：final修饰的引用一旦指向某个对象，无法再指向其它对象（不能改变地址值：对象属性可以修改）
        // 字符串常量：用""括起来
        String a1 = "abc";
        System.out.println(a1);
        // 整数常量：所有整数
        int a2 = 123;
        System.out.println(a2);
        // 小数常量：所有小数
        double a3 = 12.3;
        System.out.println(a3);
        // 字符常量：用''括起来，只能放单个数字、单个字符
        char a4 = 'A';
        System.out.println(a4); // 对
//        System.out.println('10'); // 错：''必须放单个字符，10不表示单个字符
//        System.out.println(''); // 错：任何字符都不放也不行，因为无法代表任何字符
        System.out.println('中'); // 属于char
        System.out.println("中"); // 属于String
        System.out.println(' ');  // 对：可以放空格
        // 转义字符：\t、\"、\'...
        System.out.println("我爱\"你\"...垃圾\n");
        // 布尔常量：true/false
        boolean a5 = true;
        System.out.println(a5 ? "YES" : "NO");
        // 空常量
        String a6 = null;
//        System.out.println(a6);
        // 2>.变量：在程序执行过程中可以发生改变的量（必须声明 -> 初始化 -> 使用）
        int a7 = 10;
        String a8 = "hello world";
        // 成员变量系统默认初始化
        // 同一个区域不能使用相同的变量名
        boolean a9;
        {
            // 局部变量在使用之前必须初始化
            int a10 = 10;
        }
        // 3.一条语言可以声明无数个变量：使用变量之前赋值即可
        int a11, a12, a13;
        a11 = 10;
        a12 = 20;
        a13 = 30;
        System.out.println(a11);
        System.out.println(a12);
        System.out.println(a13);
    }

    public void showPackageDataType() {
        // 12.数据类型
        // 1>.概念：java语言是强类型语言，每个数据都有明确的数据类型（决定每个数据在内存中分配的空间大小）
        /**
         * 2>.基本数据类型
         *  整型
         *      byte字节 - 8位、1个字节
         *      short短整型 - 16位、2个字节
         *      int整型 - 32位、4个字节
         *      long长整型 - 64位、8个字节
         *  字符型
         *      char - 16位、2个字节
         *  浮点型
         *      float单精度、4个字节
         *      double双精度、8个字节
         *  布尔类型：没有非0既真（true不等于1、false不等于0、没有明确指定大小）
         * 引用类型
         *  类
         *  接口
         *  数组
         *  枚举
         */
        // 3>.整数型：默认为int
        byte a1 = 10; // 取值范围：-128 - 127
        short a2 = 20;
        int a3 = 15;
        long a4 = 8888888888888L; // 超过int范围：Integer number too large（必须末尾加一个"l/L"表示这是一个long类型）、不加L会被当做int看待
        // 4>.浮点型：默认为double
//        float a5 = 12.3; // 报错：因为float是单精度，'12.3'默认是double，不能直接赋值
        float a6 = 12.3f; // ！！！必须末尾加一个"f/F"表示这是一个float类型！！！
//        double a6 = 3.14d; // 正确：末尾加一个"d/D"表示这是一个double类型
        double a7 = 3.14; // "d/D"可以省略不写
        // 5>.字符char：取值范围：0 ~ 65535
        char a8 = 'a'; // 没有负数
//        char a9 = '12'; // 不能放置两个字符
        char a10 = '我'; // 可以存在中文（因为java是unicode编码）、单个中文占2个字节
        // 字符和字符串参与运算
        System.out.println('a' + 1); // 98 - 因为有ASCII码表, 'a'字符对应97
        System.out.println('a' + 1 + "hello"); // 98hello - 任何数据类型用"+"与字符串相连接都会产生新的字符串
        System.out.println("5 + 5 = " + 5 + 5); // 5 + 5 = 55;
        System.out.println("5 + 5 = " + (5 + 5)); // 5 + 5 = 10;
        // 6>.布尔型：没有'非0即真'，不能与其它类型运算（因为java中布尔类型没有明确指定大小）
        boolean a11 = true; // 没有明确指定大小
        // 7>.数据类型转换
        // a.隐式类型转换：自动类型提升（系统会自动将"小类型"->"大类型"，不会损失精度）/"大类型"->"小类型"可能会损失精度 - 报错
        // byte/short/char -> int -> long -> float -> double
        // int类型占4个字节：在内存中如果位数不够需要在前面补0
        // 123 - 00000000/00000000/00000000/01111011
        // 如果转成byte类型占1个字节：在内存中会将前面的0去掉
        int a12 = 10;
        byte a13 = 4;
        a3 = a12 + a13;
        // b.强制类型转换：可能会导致损失精度
        // 格式：数据类型 变量名 = (数据类型)变量值;
        int a14 = 10;
        byte a15 = 4;
        byte a16 = (byte) (a14 + a15);
        // 强制转换超出"数据类型"的取值范围会出错
        byte a17 = (byte) (126 + 4);
        System.out.println(a17); // 输出-126（多于8位的会直接砍掉）
        byte a18 = (byte)300;
        System.out.println(a18); // 输出44
        /**
         * 注意点
         * 1.在定义long/float类型变量的时候需要加上L/f
         * 2.整数默认类型是int/浮点数默认类型是double
         * 3.byte/short在定义的时候接收的实际上是一个int类型（如果不在它们的范围就会报错）
         * 4.关于自动类型提升：byte/short/char -> int -> long -> float -> double
         */
        // m1没有init
        int m1, n1 = 10;
        /**
         * 面试题
         * 1>.在Java中boolean类型占几个字节？
         * 在Java中boolean类型理论上占1/8个字节，因为一个开关就可以决定true和false，但是在java中没有明确指定boolean类型的大小
         * 2>.以下程序是否有问题？如果有问题请指出问题？
         * byte a1 = 3;
         * byte a2 = 4;
         * >>1.byte与任何数据类型（char/int/short/byte）进行运算会提升为int，两个int类型相加结果也是int
         * >>2.a1和a2是两个变量，变量存储的值是变化的，在编译的时候无法判断具体的值，相加有可能会超出byte取值范围
         * byte a3 = a1 + a2; // 报错
         * >>Java编译器有常量优化机制（编译的时候直接将常量相加的结果算出来赋值）
         * byte a4 = 3 + 4;
         */
    }

    private void showPackageOperator(Main m1) {
        // 13.运算符：对常量和变量进行操作的符号、运算符的优先级可以通过‘()’改变
        // 1>.算术运算符+ - * / %
        // %的结果和被除数是同一类型（char类型本质也是整型）
        System.out.println(10 / 3); // 输出3：整数相除结果只能是整数
        // 计算结果的精度
        // 精度：byte/short/char - int - long - float - double
        // java按运算符两边的操作元的最高精度保留计算结果的精度
        System.out.println(10 / 3.0); // 输出3.33333：小数相除结果只能是小数（把其中一个数变成小数，另一个数会自动类型提升）
        // 结果只与左边的符号有关，与右边无关
        System.out.println(-2 / 5); // 输出-2：当左边的绝对值小于右边绝对值的时候结果为左边的值
        System.out.println(-12 % 5); // 输出-2
        float a14 = (float) 1 / 2; // 0.5
//        // “除数为0/对0求余”属于非法操作：抛出ArithematicException
//        System.out.println(10 / 0);
//        System.out.println(10 % 0);
        // 2>.自增自减（自身永远都需要+1或-1）
        int a12 = 10;
        int a13 = 10;
        int a15 = a13++;
        int a16 = ++a13;
        int a17 = a13--;
        int a18 = --a13;
        /**
         * 面试题
         * 1>.下列哪句话会报错？
         * byte b = 10;
         * b++; // '++'是一个运算符所以肯定会有一个结果，底层会转化为'b = (byte)(b + 1);'
         * b = b + 1; // 报错 - byte和int进行运算会自动类型提升为int，int再赋值给byte会报错
         *
         * 2>.下列程序是否有问题？
         * short s = 1; s = s + 1; // 报错 - short和int进行运算会自动类型提升为int，int再赋值给short会报错
         * short s = 1; s += 1; // short s = (short)(s + 1);
         */
        // 3>.关系运算符（boolean没有非0即真）
        boolean a19 = a13 == a12;
        boolean a20 = a13 != a12;
        boolean a21 = a13 > a12;
        boolean a22 = a13 < a12;
        boolean a23 = a13 >= a12;
        boolean a24 = a13 <= a12;
        // 4>.逻辑运算符：操作数必须是布尔类型
        // 逻辑与
        boolean a25 = a19 & a20;
        // 短路与：只要a19为假则不再计算a20（会发生短路现象）
        a25 = a19 && a20;
        /**
         * “逻辑与&”和“短路与&&”的区别
         * “逻辑与&” - 无论左边是true还是false，右边都要参与运算
         * “短路与&&” - 左边如果是false，右边不参与运算，左边如果是true，右边参与运算
         */
        // 逻辑或
        boolean a26 = a19 | a20;
        // 短路或：只要a19为真则不再计算a20（会发生短路现象）
        a26 = a19 || a20;
        // a19真结果为假，a19假结果为真
        boolean a27 = !a19;
//        // 逻辑异或
//        a27 = a19 ^ a20; // 两边结果相同，结果为假；两边结果不同，结果为真
        // 5>.位运算符：先把操作数化成二进制再操作
        // <<左移（左边最高位丢弃，右边补0）
        // >>右移（最高位是0，左边补0；最高位是1，左边补1）
        // >>>无符号右移（无论最高位是0或1，左边补0）
        // '有符号右移>>'和'无符号右移>>>'的区别
        // 1>.'有符号右移>>'：最高位是0移动后就用0补位，最高位是1移动后就用1补位
        // 2>.'无符号右移>>>'：无论高位是0还是1，移动后都用0补位
        System.out.println(12 << 1); // 24（向左移动几位就是乘以2的几次幂）
        System.out.println(12 << 2); // 48
        System.out.println(12 >> 1); // 6（向右移动几位就是除以2的几次幂）
        System.out.println(12 >> 2); // 3
        /**
         * 面试题
         * 1>.请使用最有效率的方式写出'2 * 8'的结果
         * 分析：最有效的方法就是'操作二进制（位运算）'
         * 2 * 8 = 2 << 3 = 16;
         */
        // a13按位取反
        // 0变成1，1变成0
        int a28 = ~a13;
        // a13和a12按位做与运算
        // 如果相对应位都是1，则结果为1，否则为0
        int a29 = a13 & a12;
        // a13和a12按位做或运算
        // 如果相对应位都是0，则结果为0，否则为1
        int a30 = a13 | a12;
        // a13和a12按位做或运算
        // 如果相对应位值相同，则结果为0，否则为1
        int a31 = a13 ^ a12;
        // a13按位右移a12位
        int a32 = a13 >> a12;
        // a13按位左移a12位
        int a33 = a13 << a12;
        // a13按位右移a12位（左边的空位一律填0）
        int a34 = a13 >>> a12;
        /**
         * 面试题
         * 1>.实现两个整数的交换
         * int x = 10;
         * int y = 5;
         * // 1.引入第三方变量（实际开发推荐使用）
         * int temp = x;
         * x = y;
         * y = temp;
         * // 2.不引入第三方变量（有弊端：有可能超出int的取值范围）
         * x = x + y;
         * y = x - y;
         * x = x - y;
         * // 3.不引入第三方变量
         * x = x ^ y;
         * y = x ^ y;
         * x = x ^ y;
         * // 4>.封装成方法
         * xxx
         */
        // 6>.赋值运算符：先执行右边再执行左边
        // a33 = a33 + a34
        a33 += a34;
        // a33 = a33 - a34
        a33 -= a34;
        // a33 = a33 * a34
        a33 *= a34;
        // a33 = a33 / a34
        a33 /= a34;
        // a33 = a33 % a34
        a33 %= a34;
        // a33 = a33 & a34
        a33 &= a34;
        // a33 = a33 | a34
        a33 |= a34;
        // a33 = a33 ^ a34
        a33 ^= a34;
        // a33 = a33 << a34
        a33 <<= a34;
        // a33 = a33 >> a34
        a33 >>= a34;
        // a33 = a33 >>> a34
        a33 >>>= a34;
        // 7>.三元运算符：支持嵌套
        int a38 = (a34 > a33) ? 36 : 45;
        // 8>.对象运算符
        if (m1 instanceof Main) {
            // 一个对象是否是某一个指定类（其子类）的实例
            // >>运行阶段动态判断引用指向的对象的类型
        }
    }

    private void showPackageCondition() {
        // 14.选择语句（程序语句一般写在前面的先执行，写在后面的后执行）
        // 1>.if语句
        // a、判断条件必须是boolean
        // b、如果是一条语言'{}'可以省略，如果是多条语句'{}'不能省略（建议永远不要省略）
        int a2 = 12;
        if (a2 > 18) System.out.println("可以浏览该网站");
//        // 报错：因为'int m1 = 1;'默认不是一条语句
//        if (a2 > 18) int m1 = 1;
        // c、一般来讲，有"{"就没有分号
        // 第一种方式
        if (a2 > 10) {
            // 语句体1
        }
        // 第二种方式
        if (a2 < 10) {
            // 语句体1
        } else {
            // 语句体2
        }
        // 第三种方式
        if (a2 > 10) {
            // 语句体1
        } else if (a2 < 10) {
            // 语句体2
        } else {
            // 语句体3
        }
        // d、if语句支持嵌套
        if (a2 > 20) {
            if (a2 > 10) {
                // 语句体1
            } else {
                // 语句体2
            }
        }
        // 2>.switch语句：判断固定值使用（枚举）/理论上比"if语句"效率高
        // a、可以是byte/short/char/int（自动类型提升为int类型的数据都可以、long不可以作为switch的表达式）
        // b、"表达式"可以接收：基本数据类型（byte，short，char，int）
        // c、>=jdk1.5可以接收枚举
        // d、>=jdk1.7可以接收字符串String
        // e、每个case不能相同
        int a12 = 12;
        switch (a12) {
            // case后面只能是常量（必须不一样），不能是变量
            case 1: {
                System.out.println("123");
            }
            break;
            case 2: {
                System.out.println("456");
            }
            break;
            // case穿透
            case 3:
            case 4:
            case 5: {
                System.out.println("123456");
            }
            break;
            // default可以省略（不建议），可以放在任何位置（放在最后可以省略break）
            // 不管放在任何位置都只会最后执行
            default: {
                System.out.println("789");
            }
            break;
        }
        // String
        String gender = "男士";
        switch (gender) {
            case "男士": {
                System.out.println("男士");
            }
            break;
            case "女生": {
                System.out.println("女生");
            }
            break;
            default: {
                System.out.println("太监");
            }
            break;
        }
    }

    private void showPackageLoop() {
        // 15.循环语句
        boolean a19 = true;
        // 1>.while语句：条件为true开始循环，条件为false终止循环
        while (a19) {
        }
        // 2>.do...while语句：条件为true开始循环，条件为false终止循环
        do {
        } while (a19);
        // 3>.for语句
        for (int index = 0; index < 100; index++) {
//            // 结束当前循环，开始下轮循环（只可以使用于"循环语句"）
//            continue;
//            // 终止循环：开始执行循环以后的语句（只可以使用于"循环语句"和"switch语言"）
//            break;
//            // 结束方法（返回值）：终止循环，不再执行循环以后的语句
//            return;
        }
        // 4>.增强for循环
        int[] nums = {1, 2, 3, 4, 5, 6};
        for (int index :
                nums) {
            System.out.println(index);
        }
        // 5>.循环嵌套
        // 外循环控制行数
        // 标号：合法标识符即可、可以跳出指定的循环
        outer:
        for (int i = 0; i < 4; i++) {
            // 内循环控制列数
            // 标号：合法标识符即可、可以跳出指定的循环
            inner:
            for (int j = 0; j < 5; j++) {
//                System.out.println("*"); // 输出自动换行
                System.out.print("*"); // 输出不自动换行
            //    break inner; // 跳出内部循环（与break效果一样：总是终止离它最近的那个循环语句）
            //    break outer; // 跳出外部循环
            }
            // 转义字符
            System.out.print("\n");
        }
        // 6>.死循环
        // ！！！java对于永远无法执行到的语句会报错！！！
        while (true) {
            // 对于有明确循环结束条件，但是并不清楚具体需要循环多少次的时候可以使用：死循环 + break、递归
            break;
        }
        do {
            break;
        } while (true);

        for (;;) {
            break;
        }
        /**
         * 面试题
         * 1>.下面的代码是否能够执行?
         * // 可以执行，因为"https:"是一个标号，"//www.baidu.com"是一个注释
         * https://www.baidu.com
         * System.out.println("hello java");
         */
    }

    private void showPackageArray() {
        // 16.数组
        // 1>.为什么需要数组：可以存储相同数据类型的集合（这点与js不一样）
        // 2>.数组（引用数据类型...父类是Object...存储在堆内存）可以存储基本数据类型、也可以存储引用数据类型（这点与Objective-C不一样）
        // 3>.一维数组：相同类型变量的列表（可以存在基本数据类型，也可以存在类对象）
        // a>.声明数组：还没有分配内存
        int[] array0; // 推荐使用
        int array1[];
        // b>.Java中的数组是引用类型变量：必须使用new关键字来分配空间确定数组大小
        array0 = new int[10];
        array1 = new int[12];
        // c>.初始化数组：为数组开辟连续的内存空间，并为每个元素赋值（数组必须先初始化才能使用）
        // 1>.动态初始化：指定长度，由系统给出初始化值
        // 整数类型（byte/short/int/long）默认为0
        // 浮点类型（float/double）默认为0.0
        // 布尔类型（boolean）默认为false
        // 字符类型（char）默认为'\u0000'
        // 引用类型默认为null
        for (int i = 0; i < 10; i++) {
            array0[i] = i;
        }
        for (int i = 0; i < 12; i++) {
            array1[i] = i;
        }
        // 2>.静态初始化：给出每个数组元素的初始化值，由系统指定长度
        // 第一种方法：可以先声明再赋值
        // ！！！第二个[]不允许有数字！！！
        int[] array_02 = new int[]{ 1, 2, 3, 4, 5 };
        // 第二种方法：必须声明并赋值
        int[] array_03 = { 1, 2, 3, 4, 5 };
        // d>.异常
//        // 1>.java.lang.ArrayIndexOutOfBoundsException数组索引越界异常（访问了数组中不存在的索引）
//        System.out.println(array_03[10]);
//        // 2>.java.lang.NullPointerException空指针异常（数组已经不再指向堆内存，还继续使用数组名访问元素）
//        // OC没有空指针异常、空指针访问实例相关的都会出现空指针异常
//        array_03 = null;
//        System.out.println(array_03[0]);
        // e>.遍历
        // 数组的最大索引：array_04.length - 1
        int[] array_04 = {1, 2, 3, 4, 5};
        for (int i = 0; i < array_04.length; i++) {
            System.out.println(array_04[i]);
        }
        for (int element : array_04) {
            System.out.println(element);
        }
        // 多个引用指向同一块内存
        array_04 = array_03;
        // 当没有'任何引用'指向'堆内存的对象'的时候该对象变成垃圾，'jvm的垃圾回收机制'会在不定时对其进行回收
        int[] array_05 = new int[5];
        // f>.可以合并（重点）
        int array2[] = {1, 2, 3, 4};
        int[] array3 = new int[5]; // 推荐写法
        // 数组的扩容：在java开发中，数组长度一旦确定就不可以改变，当数组count满了以后需要扩容：先新建一个大容量的数组，然后将小容量数组中的数据一个一个拷贝到大数组中（效率很低）

        // 4>.多维数组
        // a>.概述
        // [3] - 二维数组中有3个一维数组
        // [2] - 一维数组中有2个元素
        int[][] array_06 = new int[3][2]; // 推荐使用
        int[] array_07[] = new int[3][2];
        int array_08[][] = new int[3][2];
        System.out.println(array_06); // 二维数组
        System.out.println(array_06[0]); // 二维数组中的第一个一维数组
        System.out.println(array_06[0][1]); // 二维数组中的第一个一维数组的第二个元素
        // b>.静态初始化：这是一个二维数组
        int[][] array_09 = {
                {0, 1, 2, 3},
                {4, 5},
                {6, 7, 8}
        };
        System.out.println(array_09.length); // 3
        System.out.println(array_09[0].length); // 4
        // c>.遍历
        for (int i = 0; i < array_09.length; i++) {
            for (int j = 0; j < array_09[i].length; j++) {
                System.out.println(array_09[i][j]);
            }
        }
        // 5>.Arrays类：操作数组的工具类
        int[] array = {22, 33, 55, 11, 44};
        // 判断两个数组是否相等
        Arrays.equals(array, array);
        // 数组转字符串
        Arrays.toString(array); // [22, 33, 55, 11, 44]
        // 排序
        Arrays.sort(array); // [11, 22, 33, 44, 55]
        // 二分查找
        int[] sortArray = {11, 22, 33, 44, 55};
        Arrays.binarySearch(sortArray, 22); // 1
        Arrays.binarySearch(sortArray, 55); // 4
        Arrays.binarySearch(sortArray, 66); // (-插入点 - 1) = -6
        /*
        private static int binarySearch(int[] array, int fromIndex, int toIndex, int key) {
            int low = fromIndex;
            int high = toIndex - 1;
            while (low <= high) {
                int mid = (low + high) >>> 1;
                int midVal = array[mid];
                if (midVal < key) {
                    low = mid + 1;
                } else if (midVal > key) {
                    high = mid - 1;
                } else {
                    return mid; // key found
                }
            }
            return -(low + 1);  // key not found.
        }
        */
    }

    private void showPackageGroup() {
        // 17.包装类
        // 1>.为什么引入基本数据类型包装类：把基本数据类型对象化，为基本数据类型的操作提供必要的方法（基本数据类型不能创建对象并调用方法）
        // 2>.包装类的特点：所有的包装类都是final类型，无法派生子类
        // 3>.基本数据类型与包装类的对应关系
        // 基本数据类型  包装类                           父类
        // byte        Byte                            Number
        // short       Short                           Number
        // int         Integer                         Number
        // long        Long                            Number
        // float       Float                           Number
        // double      Double                          Number
        // char        Character                       Object：没有parseXxx()方法...String由多个字符组成，转换成char的时候只能接收一个字符（String->Char有toCharArray()方法）
        // boolean     Boolean                         Object
        // a>.Integer
//        // int -> Integer
//        Integer integer0 = new Integer(1234); // jdk1.9以后不推荐使用
        Integer integer0 = Integer.valueOf(1234);
//        // String -> Integer
//        Integer integer1 = new Integer("1234");
        Integer integer1 = Integer.valueOf("1234");
        // Integer integer2 = new Integer("abc"); // 数字格式异常java.lang.NumberFormatException
        // int可以表示的最大值和最小值
        System.out.println(Integer.MAX_VALUE); // int可以表示的最大值/2^31 - 1
        System.out.println(Integer.MIN_VALUE); // int可以表示的最小值/-2^31
        // 自动装箱：基本数据类型 -> 包装类
        Integer integer2 = 10;
        // 自动拆箱：包装类 -> 基本数据类型
        int x1 = integer2;

        // String -> int
        // 第一种方式
//        // String -> Integer
//        Integer integer3 = new Integer("200");
        Integer integer3 = Integer.valueOf("200");
        int a39 = integer3.intValue(); // Integer -> int
        // b.第二种方式（推荐使用）
        int a40 = Integer.parseInt("1234");
        // int -> String
        // 第一种方式（推荐使用）
        int a41 = 100;
        String s1 = a41 + "";
        System.out.println(s1);
        // 第二种方式（推荐使用）
        String s2 = String.valueOf(a41);
        System.out.println(s2);
        // 第三种方式
        Integer integer_03 = Integer.valueOf(a41);
        String s35 = integer_03.toString();
        System.out.println(s35);
        // 第四种方式
        String s3 = Integer.toString(123);
        // 装箱：把基本类型转换为包装类类型
        Integer integer4 = Integer.valueOf(1234);
        Integer integer5 = Integer.valueOf("1234");
        // 拆箱：把包装类类型转换为基本类型
        int a42 = integer4.intValue();
        // 自动装箱：把基本类型转换为包装类类型（不需要通过构造方法）
        Integer integer6 = 100;
        // 自动拆箱：把包装类类型转换为基本类型（不需要通过构造方法）
        int a43 = integer5 + 200;
//            // 注意事项：java.lang.NullPointerException空指针异常（null不能去调用方法...这点区别于oc）
//            Integer integer7 = null;
//            int a44 = integer7 + 100;
        // b>.Double
//        // 构造方法：jdk1.9以后不推荐使用
//        Double d0 = new Double(123.45);
//        Double d1 = new Double("123.45");
        // 数字字符串 -> 基本类型数字
        double d2 = Double.parseDouble("123.45");
        // 基本类型数字 -> 数字字符串
        String s4 = Double.toString(1234.54);
        // 数字字符串/基本类型数字 -> 数字包装类
        Double d3 = Double.valueOf(1234.45);
        Double d4 = Double.valueOf("1234.45");
        // 数字包装类 -> 基本类型数字
        double d5 = d4.doubleValue();

        // c>.Float

        // d>.Boolean

        // e>.Long

//        // f>.Character：jdk1.9以后不推荐使用
//        Character ch0 = new Character('a');
        Character ch0 = Character.valueOf('a');
        /**
         * 面试题
         * 1>.int类型和Integer类型有什么区别？它们之间如何相互转换？
         * xxx
         * 2>.下面代码输出什么？
         * // Integer直接赋值范围在-128～127之间的时候不会创建多个对象
         * Integer i1 = new Integer(127);
         * Integer i2 = new Integer(128);
         * i1 == i2; // false
         * Integer i1 = 127;
         * Integer i2 = 127;
         * i1 == i2; // true
         * Integer i1 = 128;
         * Integer i2 = 128;
         * i1 == i2; // false
         */
    }

    public void showPackageObject() {
        // 18.Object
        // 1>.概念：Java类层次结构的根类，所有类都直接或间接继承该类
        // JDK源码中的native表示调用C++方法
        Object obj1 = new Object();
        Object obj2 = new Object();
        if (obj1.equals(obj2)) {
            /**
             * public boolean equals(Object obj) {
             *  // 比较对象的地址值，没有什么意义，需要重写
             *  // 在开发中，我们一般比较对象的属性值（我们一般认为相同属性是同一个对象）
             *  return (this == obj);
             * }
             */
            // 两个对象是否是同一个对象
        }
        // 返回的不是对象的实际地址值（可以理解为逻辑地址值）
        // 不同对象：hashCode()一般不相同
        // 相同对象：hashCode()肯定相同
        int hashCode = obj1.hashCode();
        // 返回对象的运行时类
        Class c1 = obj1.getClass();
        // 获取对象的真实类的类名：包含包名
        String name = c1.getName();
        // 获取对象的真实类的类名：不包含包名
        String simpleName = c1.getSimpleName();
        /**
         * // 没有意义，一般要重写：返回内存地址经过"哈希算法"得出的十六进制结果
         * public String toString() {
         *  return getClass().getName() + "@" + Integer.toHexString(hashCode());
         * }
         */
        // 重写一般都是返回一个字符串把所有属性的value显示出来
        obj1.toString();
        /**
         * 面试题：
         * 1>."==和equals()"有什么区别？
         * 1."=="是比较运算符（既可以比较基本数据类型：比较value，也可以比较引用数据类型：比较地址值）
         * 2."==和equals()"没有重写之前是一样的（比较地址值）
         * 2>.Java开发中无论new什么对象：都会执行Object类的无参构造方法...而且是最先执行
         */
    }

    private void showPackageString() {
        // 19.String：Java中把String当作对象处理（不可变字符串）
        // 字符串是常量，一旦被赋值就不能被改变
        // s0存储在常量区...常量区不会有重复的数据
        String s0 = "hello world"; // 推荐使用
        // 当把"abc"赋值给s0，原来的"hello world"就变成了垃圾
        s0 = "abc";
        s0.toString();
        // s1和s2存储在堆区
        byte[] bytes = {95, 94, 93};
        String s1 = new String(bytes);
        char[] chars = {'a', 'b', 'c'};
        s1 = new String(chars);
        String s2 = new String("hello world");
        // 字符串提取
        char c1 = s1.charAt(3); // 返回字符串中指定位置的字符
        String s3 = s1.substring(1, 4); // 返回字符串中指定位置"1 - (4 - 1)"中的子串：[1, 4)、字符串中的字符位置序号从0开始
        s3 = s1.substring(2); // 从指定位置开始截取字符串，默认到末尾
        int c2 = s1.indexOf('w'); // 返回字符w第一次出现的位置，找不到返回-1
        int c3 = s1.indexOf("wu"); // 返回字符串wu第一次出现的位置，找不到返回-1
        int c4 = s1.lastIndexOf('a'); // 从后往前查找：指定'字符、字符串'第一次出现的索引
        s1.indexOf('w', 2); // 返回字符w第一次出现的位置（从指定位置开始：包含指定位置、返回的是最原始的位置（不是从指定位置开始的相对位置）），找不到返回-1
        // 字符串比较大小
        int c5 = s1.compareTo(s2); // 比较字符串大小，返回结果">0、=0、<0"
        // 基本数据类型比较大小使用==
        // 引用数据类型比较大小使用equals()
//        // 防止空指针异常
//        s1.equals("admin"); // 不推荐
//        "admin".equals(s1); // 推荐
        boolean c6 = s1.equals(s2); // ！！！判断字符串内容是否相同（区分大小写：已经重写）！！！
        boolean c7 = s1 == s2; // 用于判断两个字符串引用是否指向同一个字符串对象（判断字符串地址是否相同）
        boolean c8 = s1.equalsIgnoreCase(s2); // 判断字符串内容是否相同（不区分大小写）
        /**
         * 面试题
         * String s1 = "abc";
         * String s2 = "abc";
         * System.out.println(s1 == s2); // true...相同的常量指向同一块内存区域
         * System.out.println(s1.equals(s2)); // true
         * String s3 = new String("abc");创建几个对象...先看常量区有没有该常量，没有就创建一个，然后在堆内存开辟一个内存空间，将常量区副本copy到堆区（创建两个对象）
         * System.out.println(s1 == s3); // false...s1指向常量区地址值、s3指向堆区地址值
         * System.out.println(s1.equals(s3)); // true
         * String s4 = "a" + "b" + "c";
         * System.out.println(s1 == s4); // true...java有常量优化机制：编译的时候s4 = "abc"
         * System.out.println(s1.equals(s4)); // true
         * String s5 = "ab";
         * String s6 = s5 + "c"; // StringBuffer sb = new StringBuffer(s5); String s6 = sb.append("c").toString();
         * System.out.println(s1 == s6); // false
         * System.out.println(s1.equals(s6)); // true
         */
        // 其它类型转换为字符串
        String s4 = String.valueOf(123.4); // 基础数据类型 -> 字符串
        String s5 = s1.toLowerCase(); // 大写 -> 小写
        String s6 = s1.toUpperCase(); // 小写 -> 大写
        // 字符串替换
        s1.replace('w', 'j'); // 没有被替换的字符直接打印原字符串
        s1.replace("wu", "ju"); // 只替换一次结束
        String s7 = s1.replaceAll("wu", "ju"); // 把"wu"替换成"ju"（全部替换）
        // 其它方法
        String s8 = s1.concat(s2); // 字符串拼接（返回一个新字符串）
        String s9 = s1 + s2; // +操作符两边只要有一个是字符串就是连接符：返回一个字符串
        String s10 = s1.trim(); // 移除字符串首尾空格（返回一个新字符串）
        int c9 = s1.length(); // 返回当前字符串的长度
        System.out.println(s1.toString());
        // 常用判断方法
        System.out.println(s1.contains(s2)); // 判断s1中是否包含s2
        System.out.println(s1.startsWith("abc")); // 判断s1是否以"abc"开头
        System.out.println(s1.endsWith("abc")); // 判断s1是否以"abc"结尾
        float number = 3.14F;
        int max = 12;
        // 格式化字符串
        String.format("浮点型变量的值为：%f 整型变量的值为：%d 字符串变量的值为：%s", number, max, s0);
        /**
         * 面试题
         * 1>.""和null的区别？？？
         * a>.""是字符串常量，同时也是一个String类对象（可以调用String类对象）
         * b>.null是空常量，不能调用任何方法（会出现java.lang.NullPointerException空指针异常）/null可以给任意引用数据类型赋值
         */
        System.out.println(s1.isEmpty()); // 判断s1是否为空
//        String s11 = null;
//        System.out.println(s11.isEmpty()); // java.lang.NullPointerException空指针异常
        // 字符串遍历
        for (int i = 0; i < s1.length(); i++) {
            char c10 = s1.charAt(i);
            System.out.println(c10);
            // 把字符串中的http替换成https
            String newString = "http://www.baidu.com".replace("http", "https");
            
            String[] strings = newString.split("."); // String -> Array
        }
        // 字符串 -> char数组
        for (int i = 0; i < s1.toCharArray().length; i++) {
            // 字符串 -> 字节数组
            byte[] bytes1 = s1.getBytes();
        }
    }

    // 推荐使用StringBuilder
    private void showPackageStringBuffer() {
        // 20.StringBuffer：用于创建可变字符串类、字符串缓冲区类、线程安全的可变字符序列（效率低）、底层是byte[]
        // 注意：因为String是不可变的，频繁的修改String会导致内存暴增...建议使用StringBuffer
        // StringBuffer是字符缓冲区，当new的时候是在堆内存中创建一个对象（底层是一个长度为16的字符数组）
        StringBuffer sb3 = new StringBuffer();
        System.out.println(sb3.length()); // 0 - 容器中的字符个数（实际值）/StringBuffer所包含的有效字符个数
        System.out.println(sb3.capacity()); // 16 - 容器的初始容量（理论值）/StringBuffer当前容量
        StringBuffer sb4 = new StringBuffer(10);
        System.out.println(sb4.length()); // 0 - 容器中的字符个数（实际值）
        System.out.println(sb4.capacity()); // 10 - 容器的初始容量（理论值）
        StringBuffer sb5 = new StringBuffer("heima");
        System.out.println(sb5.length()); // 5 - 容器中的字符个数（实际值）
        System.out.println(sb5.capacity()); // 5 + 16 = 21 - 容器的初始容量（理论值）
        // 增删改查
        // a>.添加：可变的字符序列，都是操作同一个对象（不会重新创建对象，会不断向原缓冲区添加字符）
        StringBuffer sb6 = new StringBuffer();
        StringBuffer sb7 = sb6.append(true);
        StringBuffer sb8 = sb6.append("heima");
        StringBuffer sb9 = sb6.append(sb5);
        System.out.println(sb6.toString()); // trueheimaheima
        System.out.println(sb7.toString()); // trueheimaheima
        System.out.println(sb8.toString()); // trueheimaheima
        System.out.println(sb9.toString()); // trueheimaheima
        // b>.插入
        // 在指定位置添加元素，如果没有指定位置的索引会报"索引越界异常"
        sb6.insert(3, "hao"); // truhaoeheimaheima
        // c>.删除
        sb6.deleteCharAt(4); // 通过index删除元素（如果没有指定位置的索引会报"java.lang.ArrayIndexOutOfBoundsException字符串越界异常"）
        sb6.delete(0, 2); // 包含头，不包含尾/[0, 2)
        sb6.delete(0, sb6.length()); // 清空缓冲区
        // sb_03 = new StringBuffer(); // 不能使用该方法清空缓冲区
        // d>.替换
        sb6.replace(0, 3, "baima");
        // e>.反转
        sb6.reverse();
        // f>.截取 - 不再返回StringBuffer
        String s3 = sb6.substring(2);
        s3 = sb6.substring(2, 5); // 包含头，不包含尾、[2, 5)
        System.out.println(s3);
        System.out.println(sb6); // 此处sb_03没有改变
        // StringBuffer和String之间的相互转换
        // a.String -> StringBuffer
        // 1.通过构造方法
        StringBuffer sb10 = new StringBuffer("heima");
        // 2.通过append()方法
        StringBuffer sb11 = new StringBuffer();
        sb11.append("heima");
        // b.StringBuffer -> String
        StringBuffer sb12 = new StringBuffer("heima");
        String s29 = new String(sb12); // 通过构造方法
        String s30 = sb12.toString(); // 通过toString()方法
        String s31 = sb12.substring(0, 3); // 通过substring(start, end)方法
        /**
         * 面试题
         * 1>.StringBuffer和StringBuilder的区别
         * 1.StringBuffer出现于jdk1.0，线程安全，效率低
         * 2.StringBuilder出现于jdk1.5，线程不安全，效率高
         * 3.String是不可变字符串序列，StringBuffer/StringBuilder都是可变字符序列
         * 2>.String和StringBuffer作为参数传递
         * a.基本数据类型的值传递：不改变其值
         * String s1 = "heima";
         * // String类虽然是引用数据类型，但是作为参数传递时和基本数据类型一样
         * change1(s1);
         * System.out.println(s1); // heima
         * public static void change1(String s) {
         *     s = s + "itcase";
         * }
         * b.引用数据类型的值传递：改变其值
         * StringBuffer sb1 = new StringBuffer("heima");
         * change2(sb1);
         * System.out.println(sb1); // heimaitcase
         * public static void change2(StringBuffer s) {
         *     s = s.append("itcase");
         * }
         */
    }

    private void showPackageOtherClass() {
        // 21.其他类
        // a>.Date类
        // 获取一个日期的字符串
        Date date = new Date(0);
        // 获取时间戳：自"1970-01-01 00:00:00 GMT"起以毫秒为单位的时间
        date.setTime(1000); // 如果添加这一句代码则date.getTime()返回1000：默认等于System.currentTimeMillis()
        date.getTime(); // 获取当前时间对象的毫秒值：默认等于System.currentTimeMillis()
        System.currentTimeMillis(); // 获取时间戳
        if (date.before(date)) {
            // 是否比指定日期早
        }
        if (date.after(date)) {
            // 是否比指定日期晚
        }
        if (date.equals(date)) {
            // 比较两个日期的相等性
        }
        Date date1 = new Date(0); // 指定毫秒值
        System.out.println(date1); // 打印出来的是08:00...系统时间依旧是0点，只是pc时区设置的是东八区
        // 昨天这个时候
        Date yesterdayDate = new Date(System.currentTimeMillis() - 24 * 60 * 60 * 1000);

        // b>.SimpleDateFormat类：DateFormat类的子类
//        G - 年代标识（表示公元前还是公元后）
//        y - 年
//        M - 月份
//        W/w - 第几周
//        D/d - 第几天
//        H/h - 24小时/12小时
//        m - 分钟
//        s - 秒
//        z - 时区
//        // 抽象类不能被实例化
//        DateFormat dateFormat = new DateFormat();
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        // 等同于DateFormat df1 = new SimpleDateFormat();
        DateFormat df1 = DateFormat.getDateInstance(); // 父类引用指向子类对象
        // 日期对象Date -> 时间字符串
        // h - 12小时制
        // H - 24小时制
        Date d3 = new Date(0);
        SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
        sdf1.format(d3);
        // 时间字符串 -> 日期对象Date
        String s38 = "2000-08-08 12:00:00";
        SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        try {
            // 将字符串转成成Date
            Date d4 = sdf2.parse(s38);
        } catch (ParseException e) {
            e.printStackTrace();
        }

        // c>.Calendar类
        // 抽象类不能被实例化：GregorianCalendar类
        // java中一般不使用enum...使用常量"public static final int"替代
        Calendar calendar_01 = Calendar.getInstance(); // 父类引用指向子类对象
        calendar_01.get(Calendar.YEAR); // 获取年
        calendar_01.get(Calendar.MONTH); // 获取月（从0开始）
        calendar_01.get(Calendar.DAY_OF_MONTH); // 一月中的第几天
        // 此处可以通过自定义方法修改成我们常用的样子（周一是第一天，周日是最后一天）
        calendar_01.get(Calendar.DAY_OF_WEEK); // 一周中的第几天（周日是第一天，周六是最后一天）
        // 加一年
        calendar_01.add(Calendar.YEAR, 1);
        // 设置为2000年
        calendar_01.set(Calendar.YEAR, 2000);
        calendar_01.set(2000, 8, 8); // 2000-09-08

        // d>.Math：包含的所有方法都是静态方法
        System.out.println(Math.E); // 自然对数的底数
        System.out.println(Math.PI); // 圆周率
        double c5 = Math.rint(10.6); // 返回最接近参数并且为整数
        System.out.println(Math.abs(-10)); // 取绝对值
        // 天花板函数（向上取整）/>=该参数并且为最近的整数
        System.out.println(Math.ceil(13.3)); // 14.0
        System.out.println(Math.ceil(13.99)); // 14.0
        System.out.println(Math.ceil(-13.3)); // -13.0
        // 地板函数（向下取整）/<=该参数并且为最近的整数
        System.out.println(Math.floor(13.3)); // 13.0
        System.out.println(Math.floor(13.99)); // 13.0
        System.out.println(Math.floor(-13.3)); // -14.0
        // 获取最大值
        System.out.println(Math.max(10, 20)); // 20
        // 获取最小值
        System.out.println(Math.min(10, 20)); // 10
        // 2的3次方
        System.out.println(Math.pow(2, 3)); // 2.0 ^ 3.0
        // 生成[0.0 1.0)之间的小数（随机数）
        System.out.println(Math.random());
        // 四舍五入
        System.out.println(Math.round(13.4)); // 13
        // 开平方
        System.out.println(Math.sqrt(4)); // 根号4

        // e>.BigInteger：可以表示很大很大的整数（精确的表示整数）
//        // int弊端：有范围
//        int num1 = 1234567890987654321;
//        // long弊端：有范围
//        long num2 = 123456789098765432101234567890L;
        BigInteger bigInteger_01 = new BigInteger("123456789098765432101234567890");
        BigInteger bigInteger_02 = new BigInteger("2");
        bigInteger_01.add(bigInteger_02); // +
        bigInteger_01.subtract(bigInteger_02); // -
        bigInteger_01.multiply(bigInteger_02); // *
        bigInteger_01.divide(bigInteger_02); // /
        BigInteger[] array_10 = bigInteger_01.divideAndRemainder(bigInteger_02); // 商和余数

        // f>.BigDecimal：精确的表示小数...财务系统中使用
//        // 开发中不推荐使用（不够精确）
//        BigDecimal bigDecimal_01 = new BigDecimal(2.0);
//        BigDecimal bigDecimal_02 = new BigDecimal(1.1);
//        System.out.println(bigDecimal_01.subtract(bigDecimal_02));
        // 通过构造中传入字符串的方式（推荐使用）
        BigDecimal bigDecimal_03 = new BigDecimal("2.0");
        BigDecimal bigDecimal_04 = new BigDecimal("1.1");
        bigDecimal_03.add(bigDecimal_04); // +
        bigDecimal_03.subtract(bigDecimal_04); // -
        bigDecimal_03.multiply(bigDecimal_04); // *
        bigDecimal_03.divide(bigDecimal_04); // /
        // 推荐使用（底层与方法2一致）
        BigDecimal bigDecimal_05 = BigDecimal.valueOf(2.0);
        BigDecimal bigDecimal_06 = BigDecimal.valueOf(1.1);

        // g>.Random
        // 生成伪随机数：计算机通过算法seed生成的数字
        Random r1 = new Random(); // 指定seed = 当前时间的毫秒值
        Random r2 = new Random(100); // 指定seed = 100：seed保持不变生成的随机数不变
        r1.nextInt(); // 生成的随机数取自此随机数生成器序列的均匀分布的int值
        System.out.println(r1.nextInt(100)); // 生成int类型随机数：[0 100)
        r1.nextLong(); // 生成的随机数取自此随机数生成器序列的均匀分布的long值
        r1.nextBoolean(); // 生成的随机数取自此随机数生成器序列的均匀分布的boolean值
        r1.nextFloat(); // [0.0, 1.0)之间均匀分布的float值
        r1.nextDouble(); // [0.0, 1.0)之间均匀分布的double值

        // h>.System
        // 一个源文件中可以有多个外部类（实际开发中一个文件只写一个类），只能有一个外部类使用public
        System.gc(); // 运行垃圾回收器：调用finalize()方法
        System.exit(0); // 退出JVM：非0状态属于异常终止
        System.currentTimeMillis(); // 时间戳：当前时间与1970年1月1日之间的毫秒数
        System.getProperties(); // 获取当前OS的属性
    }

    private void showPackageRegex() {
        // 22.正则表达式
        // 1>.概念：一个用来描述或者匹配一系列符合某个语法规则的字符串的单个字符串
        // 2>.规则：参考百度
        // a>.a，b，c其中单个字符
        String regex = "[abc]"; // []代表单个字符
        System.out.println("a".matches(regex));
        // b>.任何单个字符除掉a，b，c
        regex = "[^abc]";
        System.out.println("a".matches(regex)); // false
        System.out.println("ef".matches(regex)); // false
        // c>.a到z或者A到Z（两头字母包括在内）
        regex = "[a-zA-Z]";
        // d>.分割、替换、分组、获取
    }

    private void showPackageScanner() {
        // 23.Scanner键盘接收数据
        Scanner scanner = new Scanner(System.in); // 键盘录入
        // 输入是否为整数（可能会抛出异常）
        if (scanner.hasNextInt()) {
            // 程序停止：等待用户输入
            // 键盘录入一个整数，存储在i中
            int i = scanner.nextInt(); // 接收一个整数
        } else {
            System.out.println("输入类型错误");
        }
        // 接收一个字符串：遇到'空格、回车'就会结束（实际操作中如果多输入一个空格就会导致数据错误）
        String s1 = scanner.next();
        // 接收一个字符串：遇到回车才会结束
        String s2 = scanner.nextLine();
        // 关闭扫描器
        scanner.close();
        /**
         * 面试题
         * 1>.sc.nextInt()和sc.nextLine()同时存在不行？？？
         * a>.创建两个Scanner对象...浪费空间
         * b>.全部使用sc.nextLine()...后续将整数字符串转换成整数
         */
    }

    private void showPackageException() {
        // 24.异常处理
        // 1>.什么是异常：程序在运行过程中发生的错误、一定发生在运行时
        // 2>.Throwable类（三个常用方法）是所有Exception异常和Error错误的父类
        // 3>.作用：提供一种面向对象的异常处理机制来处理程序运行时产生的各种不正常情况，加强程序的健壮性
        // 4>.程序错误的种类：语法错误（编译错误）、运行时错误
        // 5>.常见的运行时异常类：空指针异常NullPointerException | 索引越界异常IndexOutOfBoundException | 类型转换异常ClassCastException | 算术运算异常ArithmeticException
        // 6>.处理异常：异常分为"运行时异常：程序可以不做处理、也可以像非运行时异常一样处理"和"非运行时异常（编译时异常）：程序必须处理，否则就会发生错误，无法通过编译"
        /**
         * 异常的处理机制
         * 1.在出现异常的方法中主动调用"try...catch..."处理异常
         * 2.如果该方法中没有做出任何异常处理，把异常抛给调用该方法的上一层方法：上一层方法主动调用"try...catch..."处理异常
         * 3.如果异常抛给程序顶层main方法还没有被处理，就会抛给JVM，JVM就会终止程序运行：main方法发出错误信息
         */
        try {
            // 一旦代码运行出现异常则停止执行后续代码，开始寻找catch语句中异常类型相匹配的异常处理，处理完毕程序继续执行后续代码
            // 可能发生异常的代码（可能产生N个异常，并伴随N个catch语句捕获异常）
            showException();
            System.out.println("这里的代码可能不会执行");
        } catch (NullPointerException e) {
            // 捕获异常并进行处理（先处理范围小的异常）
        } catch (Exception e) {
            // 处理代码块：可以有多个（特殊的异常必须放在最前面：IOException必须放在Exception前面）
            // AWTException图形用户界面异常
            // IOException输入输出异常
            // SQLException数据库异常
            // RuntimeException运行时异常
            // FontFormatException字体异常类
            // ArithmeticException算术运算异常
            // 打印出“从方法调用处到抛出异常处”的方法调用序列
            e.printStackTrace(); // 打印异常的堆栈
            e.getMessage(); // 获取异常的详细消息字符串
            e.toString(); // 获取异常的简单描述
        } finally {
            // 必须执行的代码：最多只能有一个（一般进行资源的释放：关闭文件、关闭数据库）
            // 无论是否发生异常都需要执行的代码（提供统一出口）
        }
//        // try不能单独使用
//        // >>"try...catch..."可以使用
//        // >>"try...finally..."也可以使用
//        try {
//            // 先输出
//            System.out.println("123");
//            // 最后结束
//            return;
//        } finally {
//            // 无论是否发生异常都需要执行的代码（提供统一出口）
//            // 再输出
//            System.out.println("456");
//        }
//        try {
//            // 先输出
//            System.out.println("123");
//            System.exit(0);
//        } finally {
//            // 不再执行
//            System.out.println("456");
//        }
        // 非检查型异常和检查型异常的区别
        // 非检查型异常处理
        // 1>.概述：系统定义的运行异常，由系统自动检测并做出默认处理，用户不需要做任何操作
        // 2>.特点：非检查型异常也可以由用户主动调用"try...catch..."处理异常
        // 检查型异常
        // 1>.概述：用户必须进行处理的异常：捕获异常（主动调用"try...catch..."处理异常）、声明抛出异常（抛给调用方法处理）
    }
    // 自定义异常
    // 1>.编写一个类继承Exception或者RuntimeException...Exception和RuntimeException的区别？
    class MyException extends Exception {
        // 2>.编写两个构造方法
        public MyException() {

        }

        public MyException(String s) {
            super(s);
        }
    }
    // 抛出异常：不主动调用"try...catch..."处理异常
    // 异常声明：一个方法在执行的时候可能会发生异常但是我们不处理，而是交给调用它的方法处理
    private void showException() throws ArithmeticException, MyException {
        int x = 10 / 0;
        // 抛出异常
        // throws和throw的区别？？？
        // 1>.throw关键字用于在代码中抛出异常
        // 2>.throws关键字用于在方法声明中指定可能会抛出的异常类型：谁调用这个方法exception就抛给谁
        throw new MyException("这是自定义异常"); // 必须抛出异常才会中断程序：光new不会
    }
    // 注意：写出方法供其他人调用的时候（对于sdk编写特别有用）：如果别人传入无效的数据我们可以直接抛出异常...不要动不动就return

    class PackageObject {
        // 25.面向对象
        // 枚举的定义：从0开始
        enum SexType {
            male, female, unknown
        }
        /*
        public abstract/final class YourClass extends MyClass implements x1, x2 {
            // 代码
        }
        */
        // 1>.概念
        // >>面向过程和面向对象的区别：xxx
        // >>OOA - 面向对象分析
        // >>OOD - 面向对象设计
        // >>OOP - 面向对象编程
        // >>类：描述了一组有相同特征（属性）和相同行为（方法）的对象（实例）
        // >>实例化：创建对象也叫实例化

        /**
         * 2>.三大特征
         * a>.封装
         * 概念：将对象的数据和基于数据的操作封装成一个独立的模块（使用者不必知道对象的内部细节，只需要通过对象提供的接口访问对象即可）
         * 好处：1、提高代码复用性；2、提高安全性
         * 原则：1、将不需要对外的内容隐藏起来；2、隐藏属性，仅提供公共对外访问方式
         * b>.继承
         * 概念：在现有类（基类、父类）的基础上创建新类（子类、派生类）：添加新的属性和功能、代码重用
         * 好处：1、提高了代码的复用性；2、提高了代码的维护性；3、让类与类之间产生关系（多态的前提）
         * 弊端：提高了代码的耦合性
         * 原则：高内聚（自己完成某件事的能力）、低耦合（类与类的关系）
         * 特点：1、Java只支持单继承，不支持多继承（C++支持多继承）；2、Java支持多重继承
         * 注意：1、子类只能继承父类所有非私有的成员（成员方法和成员变量）；2、子类不能继承父类的构造方法（可以通过super去访问父类构造方法）；3、不要为了部分功能而刻意使用继承
         * c>.多态
         * 概念：在一个程序中同名的不同方法可以共存，子类对象可以响应同名的方法，具体的实现方法不同，完成的功能也不同
         * 好处：1、提高了代码的维护性；2、提高了代码的扩展性
         * 弊端：不能使用子类特有的属性和行为
         */

        // 3>.成员变量
        /**
         * public公共的：能被本类访问、能为子类访问、能被外部访问
         * protected受保护的：可以被本类访问、也能为子类访问、不能被外部访问
         * private私有的：只能被本类访问、不能被子类访问、不能被外部访问
         * 访问控制修饰符        本类        同一个包下        子类        任意位置        修饰属性        修饰方法        修饰类        修饰接口
         * public              ✔          ✔               ✔          ✔             ✔             ✔             ✔             ✔
         * protected           ✔          ✔               ✔          ✘             ✔             ✔             ✘             ✘
         * private             ✔          ✘               ✘          ✘             ✔             ✔              ✘             ✘
         * 默认                 ✔          ✔              ✘           ✘             ✔             ✔             ✔             ✔
         */
        /**
         * // 在Java中所有的变量在使用之前必须声明
         * 局部变量：定义在方法、语句块中的变量/作用域：当前方法、语句块/位于栈内存，随着方法的调用而存在，随着方法的调用完毕而消失/必须在访问前声明（不可以使用访问修饰符修饰、必须init以后才可以使用）
         * 成员变量：定义在类中、方法外的变量/作用域：当前类/位于堆内存，随着对象的创建而存在，随着对象的销毁而消失/可以使用访问修饰符修饰（调用构造方法的时候赋默认值：0、false、null）
         * 静态变量：定义在类中、方法外的变量/作用域：当前类/生命周期：类加载时被创建，直到程序结束才会被销毁/使用static修饰，程序运行期间只有一份内存，可以使用访问修饰符修饰
         */
        String name;
        int score;
        private SexType sex; // 设置成员变量为private

//        // static关键字：主要用来修饰类的内部成员（成员变量、成员方法、内部类、语句块）
//        // a>.静态变量：static一般修饰共性成员变量
//        // 随着类的加载而加载，先于对象存在
//        // 被类的所有对象共享（被static修饰的成员位于方法区）
//        // 通过类名调用：也可以通过对象名调用，但是不会发生空指针异常（c1.country底层运行还是Chinese.country）
//        // 系统加载类的时候进行一次空间分配和初始化（与对象无关）
//        private static String height; // 此处占用位置
//        // b>.静态方法：static修饰成员方法（与对象无关）
//        static void show() {
//            // 只能访问静态成员，无法访问非静态成员
//            // 只能继承，无法重写
//            // 不能使用this和super关键字（这点与oc不一样）
//        }
//        // c>.静态语句块：在类中不属于任何方法体且使用static修饰的语句块
//        // 什么时候调用：仅仅在类加载的时候运行一次
//        static {
//
//        }
//        // 我们一般会把常量定义为静态变量
//        public static final String APP_NAME = "MyApp";
//        /**
//         * 注意事项
//         * 1>.静态方法中没有this关键字（静态方法随着类的加载而加载，this随着对象的创建而存在）
//         * 2>.静态方法只能访问静态成员方法和静态成员变量（静态只能访问静态）
//         * 3.'静态变量/类变量'和'成员变量/实例变量'的区别
//         * 4>.静态变量属于类（类变量），成员变量属于对象（对象变量）
//         * 5>.静态变量存储于方法区中的静态区，成员变量存储于堆内存
//         * 6>.静态变量随着类的加载而加载（随着类的销毁而销毁），成员变量随着对象的创建而创建（随着对象的销毁而销毁）
//         * 7>.静态变量可以通过类名调用（也可以通过对象调用），成员变量只能通过对象名调用
//         */

        private final static String lastName = "谢"; // 成员变量使用final修饰一般配合static一起使用，称为常量：存放在常量区，类加载的时候初始化

        /*
        >IDEA怎么自动生成setter/getter方法
        >>选中属性 -> 点击右键选择Generate... -> Setter/Getter
         */
        public void setName(String name) {
            // this可以调用"成员方法"和"成员变量"，代表"当前对象（调用者）的引用"
            this.name = name;
        }
        public String getName() {
            return name;
        }

        // 对外提供公共的访问方式
        public void setSex(SexType sex) {
            this.sex = sex;
        }

        public SexType getSex() {
            return sex;
        }

        // 4>.构造方法
        // 作用：给类的成员变量赋初值...默认值初始化
        // 构造方法名和类名一致
        // 构造方法没有返回值（连void都没有）、可以有多个构造方法
        // 构造方法不能由用户直接调用：创建一个对象的时候系统会自动调用该类的构造方法
        // 构造方法不能被继承：所以也不能被override...私有方法亦然
        public PackageObject() {
            // 缺省构造方法：没有参数、方法体为空、使用各种数据类型的默认值来自动init对象的成员变量
            // a>.系统为没有定义构造方法的类自动添加的一种特殊的构造方法（每个类都有构造方法）
            // b>.一旦类中已经定义构造方法则系统不会再添加"缺省构造方法"（这时候调用无参构造方法会报错）
            /**
             * // this关键字
             * 1>.指向当前对象本身，用于类的非静态方法和构造方法中，不能用于静态方法中
             * 2>.代表当前对象的引用（谁调用代表谁）
             * 3>.既可以调用本类，也可以调用父类
             * 4>.this();只能出现在构造方法的第一行：调用本类中的其它构造方法
             * 5>.this();和super();不能共存：因为它们都要位于构造方法的第一行
             */
            // 访问父类的空参构造方法：因为子类会继承父类中的数据（可能还会使用父类数据），所以子类初始化之前必须完成父类的初始化
            // 必须放在第一条语句
            super(); // 调用父类的无参构造方法：如果不写系统默认加上（当构造方法第一行没有this()也没有super()的时候会默认加上super();表示调用父类的无参构造方法）
//            super(xx, yy); // 用户初始化父类中的private属性
        }

        // 构造方法的重载：在同一个类中，方法名相同，参数列表不同，与返回值无关
        // 如果我们没有给出构造方法，系统会自动提供一个无参构造方法
        // 如果我们给出了构造方法，系统不会再提供默认的无参构造方法（如果需要使用有参构造方法必须自定义 - ！！！建议永远自定义无参构造方法：为了创建对象使用！！！）
        public PackageObject(String name, SexType sex) {
            this.name = name;
            this.sex = sex;
//            // 给类的成员变量赋初值...默认值初始化：就算不写代码也是这样
//            this.score = 0;
        }

        // 5>.成员方法
        /*
        public
        abstract（抽象方法：没有方法体）
        static（类方法：只能处理类变量）
        final（无法被继承）
        修饰符 返回值类型 方法名(参数类型 参数名1, 参数类型 参数名2) {
            // 方法体
            return 返回值; // 返回值类型是void可以省略return（jvm会自动加上）
        }
        方法必须调用才能执行：调用的时候参数数量和类型必须与定义的时候一致
        */
        // 值传递：基本数据类型
        // 引用传递：对象类型
        public String getDetails() {
            SexType[] array = SexType.values(); // 返回枚举类中所有的值
            for (SexType type:
                    array) {
                // 每个枚举常量的索引
                System.out.println(type.ordinal());
                // 返回指定字符串值的枚举常量：不存在会报错IllegalArgumentException
                System.out.println(SexType.valueOf("male"));
            }
            return this.name + "：" + this.sex;
        }
        // 可变参数
        // 可以传递0到多个参数、必须是最后一个参数、只能有一个可变参数、可以直接传入数组
        public void getKeyValues(String msg, int... num) {

        }
        // 方法重载：在同一个类中、方法名相同、参数列表不同（参数个数不同、参数类型不同、参数顺序不同）、与返回值无关
        public String getDetails(String name) {
            return "";
        }
        // 方法递归：方法自己调用自己（必须有明确的结束条件、递归太深容易发生栈内存溢出错误：推荐使用循环替代递归）

        // 6>.代码块
        // a.概念：在java中，使用{}括起来的代码被称为代码块
        // b.分类：局部代码块、构造代码块、静态代码块、同步代码块
        // 局部代码块：出现在方法中，限定变量的生命周期，及时释放提高内存利用率
        {

        }
        // 构造代码块（初始化块）：出现在类中方法外，多个构造方法中重复代码存在在一起，每次调用构造方法都会执行（在构造方法之前执行）
        {
            System.out.println("构造代码块");
        }
//        // 静态代码块：出现在类中方法外，static修饰，用于给类进行初始化，类加载的时候执行（可能优先于main方法执行、只执行一次）
//        // 作用：不常用（用于加载驱动）、提供一种可能性（记录类加载的log）
//        static {
//            System.out.println("静态代码块");
//        }

        // 7>.内存管理机制：垃圾回收
        // a>.概念：系统会监控每个对象的运行状态，在确定某个对象不在被使用后自动释放其内存空间
        /**
         * b>.怎么判断一个对象不被使用？
         * 1>.对于非线程对象，当所有活动线程都不可能访问到该对象时，该对象成为"垃圾"
         * 2>.对于线程对象，除了要满足第一条标准外，还要求此线程本身已经死亡或者处于新建状态
         */
//        // 3>.显示垃圾回收：垃圾回收的周期比较长
//        System.gc();
        // 4>.对象的回收
        // a>.概述：Java提供了垃圾回收器（能够自动释放不再使用的内存）
        // b>.原理：xxx
//        @Override
//        protected void finalize() throws Throwable {
//            super.finalize();
//            // 对象被垃圾回收器回收的时候调用
//        }

        // 8>.内存空间划分
        // 栈：存储"局部变量（定义在方法声明和方法中的变量）"
        // 堆：存储"new出来的数组和对象"（每new一次就会在堆中新增一个新的对象/不会覆盖以前的对象）
        // 方法区（代码区/静态区）：存储源代码
        // 本地方法区：与系统有关
        // 寄存器：给cpu使用
        // 6>.内存图解
//        // a、图解一个数组
//        // main方法压栈（"局部变量array"在方法中）
//        public static void main(String[] args) {
//            // 遇到new在堆中开辟连续的内存空间（0x0011）
//            // 将"内存空间地址0x0011"赋值给"局部变量array"
//            int[] array = new int[5];
//            // 修改堆中相关数值 - 栈中的"局部变量array"指向堆
//            array[0] = 10;
//            array[1] = 20;
//        }
//        // b、图解两个数组
//        // main方法压栈（"局部变量array"在方法中）
//        public static void main(String[] args) {
//            // 遇到new在堆中开辟连续的内存空间（0x0011）
//            // 将"内存空间地址0x0011"赋值给"局部变量array"
//            int[] array = new int[5];
//            // 修改堆中相关数值 - 栈中的"局部变量array"指向堆
//            array[0] = 10;
//            array[1] = 20;
//
//            System.out.println(array);
//            System.out.println(array[0]);
//            System.out.println(array[1]);
//            System.out.println("-----------------------------------");
//            // 遇到new在堆中开辟连续的内存空间（0x0012）
//            // 将"内存空间地址0x0012"赋值给"局部变量newArray"
//            int[] newArray = new int[5];
//            // 修改堆中相关数值 - 栈中的"局部变量newArray"指向堆
//            newArray[0] = 10;
//            newArray[1] = 20;
//
//            System.out.println(newArray);
//            System.out.println(newArray[0]);
//            System.out.println(newArray[1]);
//        }
//        // c、图解二维数组
//        // main方法压栈（"局部变量array"在方法中）
//        public static void main(String[] args) {
//            // 遇到new在堆中开辟连续的内存空间（0x0011）- 存放3个一维数组地址（默认为null）
//            // 遇到new在堆中开辟连续的内存空间（0x0012）- 存放一维数组元素的地址
//            // 0x0011指向0x0012
//            int[][] array = new int[3][2];
//
//            // 栈中的"局部变量newArray"指向堆
//            System.out.println(array); // 打印二维数组
//            System.out.println(array[0]); // 打印二维数组中第一个一维数组
//            System.out.println(array[0][0]); // 打印二维数组中第一个一维数组的第一个元素
//        }
        // 7>.创建一个对象的步骤：
        // a>.xxx.class加载进入内存（进入方法区、方法也在此处（对象指向方法））
        // b>.main压栈（声明"xxx类型对象"）
        // c>.堆内存创建对象（对象属性默认初始化值、有一块区域包含super属性）
        // d>.构造方法、成员方法压栈（初始化对象属性）
        // e>.构造方法、成员方法弹栈
        // f>.将对象的地址值赋值给"xxx类型对象"
        /**
         * class ArrayTool {
         *     // 注意：如果一个类中所有的方法都是静态方法，我们需要私有构造函数，防止外部创建对象
         *     private ArrayTool() {
         *     }
         *
         *     public static int MaxElement(int[] args) {
         *         int maxElement = -1;
         *         if (args.length > 0) {
         *             maxElement = args[0];
         *         }
         *         for (int i = 0; i < args.length; i++) {
         *             if (maxElement < args[i]) {
         *                 maxElement = args[i];
         *             }
         *         }
         *         return maxElement;
         *     }
         * }
         */
    }
    
    class PackageObjectInner {
        // 26.内部类
        // 1>.概念：在一个类或一个方法中定义的类，也称为嵌套类（声明这个内部类的类称为外部类）
        // 2>.作用
        // a.类的重用功能：直接使用类，不需要使用对象
        // b.多继承：一个类会继承该类内部类继承的类
        // c.封装性：可以把某些数据隐藏在内部类中
        // 3>.特点：内部类是外部类的一个类成员（内部类兼具成员方法和类的特性）、内部类的类名不能和外部类一样
        // 4>.外部类要访问内部类的成员必须创建对象（外部类名.内部类名 对象名 = new 外部类名.new 内部类名();）
        // 5>.成员内部类：随着创建对象而加载
        public int num = 10;
        private class Inner {
            // 内部类可以访问外部类的成员（包括private）
            public int num = 20;
            //            public static String name = "xwj"; // 随着类的加载而加载：先于成员内部类加载（非静态的成员内部类不可以定义静态成员）
            private void method() {
                int num = 30;
                System.out.println(num); // 30
                System.out.println(this.num); // 20
                // 内部类之所以可以获取到外部类的成员，是因为内部类可以获取到外部类的引用（外部类.this）
                System.out.println(PackageObjectInner.this.num); // 10
            }
        }
        // 成员内部类：私有方法外部不能调用，内部可以调用
        // 外部想要调用需要定义方法对外
        public void getMethod() {
            Inner i = new Inner();
            i.method();
        }
        //        // 6>.静态内部类
//        static class Innering {
//            // 可以定义对象方法
//            public void method() {
//
//            }
//            // 可以定义静态方法
//            public static void log() {
//
//            }
//        }
        // 7>.局部内部类
        public void show() {
            final int num = 10;
            class Inner {
                public void print() {
                    // 局部内部类访问局部变量必须用final修饰（jdk1.8以后不加final也可以）
                    // 1>.因为如果不使用final修饰，num会随着方法的弹栈而销毁，这时候"局部内部类对象"还没有销毁
                    // 2>.使用final修饰的局部变量在类加载的时候会进入常量池，即使方法弹栈常量也不会消失
                    System.out.println(num);
                }
            }
            // 局部内部类只能在其所在的方法中访问
            Inner i = new Inner();
            i.print();
        }
        // 8>.匿名内部类（局部内部类的一种、内部类的简化写法）
        // 1>.前提：存在一个类或者接口（具体类、抽象类）
        // 2>.本质："继承该类/实现该接口的子类"匿名对象
        // 3>.应用：匿名内部类可以当做参数传递（将匿名内部类看作一个对象）
        public void showLog() {
            // ！！！匿名内部类调用多次方法的时候不使用，太麻烦...最好重写一个方法的时候调用！！！
            // 1.把接口interface做为参数传入方法：我们不能直接new interface...没有这个语法
            // >>把class类实现接口interface：直接new class传入方法中
            // >>使用匿名内部类：new interface名称() { // 接口中的方法 }...表示实现“interface名称”接口的类的子类对象
        }
        /**
         * // 创建内部类对象
         * 1>.普通内部类：外部类名.内部类名 对象名 = new 外部类名.new 内部类名()
         * InterDemo.Inner io = new InterDemo().new Inner();
         * 2>.静态内部类：外部类名.内部类名 对象名 = new 外部类名.内部类对象
         * InterDemo.Innering io = new InterDemo.Innering();
         * 3>.局部内部类 - 只能在方法内部访问
         * MethodInner mi = new MethodInner();
         */
    }
    
    abstract class PackageObjectNess {
        // 27.抽象类：可以配合多态一起使用（降低程序的耦合度，提高程序的扩展力）
        // 1.抽象类和抽象方法必须使用abstract修饰
        // 2.抽象类中不一定有抽象方法：可以有抽象方法，也可以有非抽象方法，有抽象方法的类一定是抽象类或者接口
        // 3.抽象类不能实例化：必须使用子类实例化（只能作为其他类的父类）
        // 4.抽象类的子类：要不必须是抽象类、要不必须实现抽象类中的所有抽象方法
        // 抽象类的成员变量：既可以是常量，也可以是变量
        // abstract不能修饰成员变量
        int num = 10;
        final static int SUM = 100;

        // 构造方法：供子类调用
        public PackageObjectNess() {
            // 可以在子类中使用super调用
        }

        // 抽象方法：表示该类和子类不同而实现不同的方法（每一个非抽象子类都必须实现所有抽象方法）
        // 1>.特点：只有方法声明没有方法实现、不要定义为private，否则无法在子类被继承、构造方法和类方法不能声明为抽象方法
        abstract void getDetails();

        // 非抽象方法：表示该类和子类共有的方法（大家实现都一样，个别不同可以使用重写）
        void getMsg() {
            System.out.println("msg");
        }
        /**
         * 面试题
         * 1>.一个类如果没有抽象方法，可以定义为抽象类吗？如果可以，有什么意义？
         * 一个类没有抽象方法可以定义为抽象类，目的是不让其他类创建本类对象，交给子类完成
         * 2>.abstract不能与哪些关键字共存？
         * a>.abstract和static不能共存（abstract修饰的方法没有方法体，static修饰的方法可以用类名调用，而"类名.抽象方法"没有意义）
         * b>.abstract和final不能共存（abstract修饰的方法必须被子类重写，final修饰的方法不能被子类重写）
         * c>.abstract和private不能共存（abstract修饰的方法必须被子类继承，private修饰的方法不能被子类继承）
         * 3>.什么是抽象类？有什么作用？能实例化吗？
         * // 什么是抽象类？
         * 抽象类是使用abstract修饰的类：只能用来作父类，本身并没有生成实例的能力
         * // 有什么作用？
         * a>.用于类型隐藏：xxx
         * b>.用于拓展对象的行为功能：xxx
         * // Java语言中凡是没有方法体的方法都是抽象方法？
         * 不对：public native int hashCode();没有方法体，但是不是抽象方法（有一个native表示调用JVM本地程序）
         */
    }

    // 28.接口：静态常量和抽象方法的集合、对外提供规则
    // 1.特点：仅仅描述了能够实现什么样的功能，具体实现则由实现该接口的类决定、一个类可以实现多个接口、一个接口可以被多个类实现
    // 2.功能：接口是java提供的一个用于实现多继承功能的机制
    // abstract默认省略：编译器自动添加
    interface PackageObjectCallback1 {
        // 1、常量定义
        // "public static final"编译器自动添加
        int MAX = 10;

        // 2、构造方法
        // 接口没有构造方法

        // 3、成员方法
        // 只能全部是抽象方法
        // "public abstract"编译器自动添加
        void getGame();
    }
    interface PackageObjectCallback2 {
        int Min = 10;

        void getMin();
    }
    // 可以多继承：子接口默认继承父接口中所有的常量和抽象方法
    interface PackageObjectListener extends PackageObjectCallback1 {
        void showGame();
    }
    // 接口允许多继承
    interface PackageObjectLessCallback extends PackageObjectListener, PackageObjectCallback2 {

    }
    /**
     * 面试题
     * 1>.抽象与接口的区别？
     * a>.接口使用interface声明，抽象类使用abstract class声明
     * b>.接口中不能声明变量，编译器会自动补充public/static/final属性关键字，抽象类中编译器不会有任何动作
     * c>.接口中的方法编译器会自动补充public/abstract属性关键字，抽象类中编译器不会有任何动作
     * d>.接口中所有的方法都是抽象方法，抽象类中可以有抽象方法，也可以有非抽象方法，但是只要有一个方法是抽象方法则该类必须定义为抽象类
     * e>.接口可以继承多个不同的父接口，但是不能实现接口，抽象类只能继承一个父类，但是可以实现多个接口
     * 2>.接口无法用new来实例化对象，但是接口的引用可以指向直接或间接实现它的所有类的对象
     * PackageObjectLessCallback callback;
     * PackageObjectLess p = new PackageObjectLess();
     * callback = p;
     * callback.showGame();
     */

    // Java不支持多继承，但支持多重继承
    // 接口的实现
    // 一个类可以实现多个接口，以","隔开，必须实现该接口所有抽象方法
    // 如果实现接口的是抽象类则不需要实现该接口的方法，但是该抽象类的任何非抽象的子类都必须实现父类的所有抽象方法
    /**
     * 如果一个类实现的多个接口中有相同的方法时：
     * 1>.如果方法的声明完全一样，在类中实现一个方法即可
     * 2>.如果方法的参数列表不同，在类中分别实现多个方法
     * 3>.如果方法的返回值不同，编译报错
     */
    // 如果需要在接口中添加方法不能直接添加，这样的话会导致以前实现该接口的类都会报错，我们需要创建一个子接口添加方法
    class PackageObjectLess extends PackageObject implements PackageObjectCallback2, PackageObjectListener {
        // 父类中private修饰的私有变量和方法子类无法继承
        // 子类不能直接访问父类中的私有数据成员和成员方法：只能通过非私有的成员方法间接访问
        // 子类中如果声明了与父类相同的数据成员：父类的相应成员变量会隐藏
        // 子类可以重写父类中同名的方法：父类相应成员方法会被隐藏（super可以访问父类的方法）
        // 子类可以对父类进行扩展：定义自己的成员变量和方法
        private int age;
        // 就近原则：父类的同名成员变量就会被隐藏
        // 注意：子类只有在执行子类的方法的时候父类同名变量才会隐藏，子类执行父类的成员方法还是使用父类的变量
        private String name;

        // 父类的构造方法子类无法继承
        public PackageObjectLess() {
            /**
             * 子类无法继承父类的构造方法
             * 1>.如果父类的构造方法有参数：子类必须显式的通过super关键字来调用父类构造方法
             * 2>.如果父类的构造方法无参数：系统会自动调用父类的无参构造方法
             */
            super("东方不败", SexType.unknown);
            this.age = 1000;
        }

        // 成员方法重写：此处不同于成员变量的重写，父类的成员方法将不复存在
        // a>.子类方法名和参数列表必须与父类相同（方法名相同，参数列表不同不是重写而是重载）
        // b>.返回值必须与父类中原方法的原值类型相同或原引用类型的子类
        // c>.访问权限可以扩大不能缩小，否则原来可以访问该方法的类可能就无法访问了
        // d>.不能重写被final修饰的方法
//        // e>.静态方法不能被重写（不存在方法覆盖：可以在子类中定义相同的静态方法将父类的方法隐藏）
//        Animal a1 = new Cat();
//        a1.doSome(); // 如果doSome()是static方法则依旧会调用Animal类的实现
        // f>.应用：子类需要父类的功能，也需要子类特有的功能，可以重写父类的方法
        // g>.注意事项：a.父类的私有方法不能被重写（子类不知道父类有该方法：子类可以定义一个同名方法）；b.子类重写父类方法访问权限不能更低（最好一致）；c.父类静态方法，子类也必须通过静态方法重写（不算重写）
        // h>.子类调用方法的顺序：先找子类本身 -> 再找父类
        @Override
        public String getDetails() {
            // super关键字：想要访问父类的方法必须使用super
            // a>.用于在子类的构造方法中调用父类的构造方法：只能出现在构造方法中的第一行
            // b>.用于在子类中显式的引用被隐藏的继承自父类的同名变量
            // c>.子类重写成员方法时，用super引用父类的相应方法实现对原有功能的扩充
            // d>.super不能使用在static方法中
            // “this.”表示访问当前类的成员方法和成员变量
            super.getDetails(); // 调用父类的成员方法：不能省略super.
            super.score = 10; // 调用父类的数据成员：不能省略super.
            return this.name + "：" + this.age;
            /**
             * super.属性; // 访问父类属性
             * super.方法名(); // 访问父类方法
             * super(); // 访问父类构造方法
             */
        }
//        // 接口interface和多态一起使用
//        PackageObjectCallback packageObjectCallback = new PackageObjectLess(); // 接口不能new：但是接口实现的类可以new
//        packageObjectCallback.getGame();
//        // 接口之间没有继承关系的时候进行强制类型转换：编译不报错、运行报错
//        PackageObjectListener packageObjectListener = (PackageObjectListener)packageObjectCallback;

        // 多态
        // 前提：a.有继承关系、b.有方法重写（私有方法不能被重写、静态方法不谈被重写）、c.父类引用指向子类对象
        // 成员变量：编译看左边（父类），运行看左边（父类）
        // 成员方法：编译看左边（父类），运行看右边（子类）
        // 静态方法（与类相关：算不上重写、不存在覆盖的说法）：编译看左边（父类），运行看左边（父类）
        public void showDetails() {
            PackageObject p = new PackageObjectLess(); // 父类引用指向子类对象（向上转型）
            System.out.println(p.name); // John
            p.getDetails();
            // 调用子类特有方法：需要向下转型，因为不知道外部可以传入什么子类型，所以必须要判断（iOS亦然）
            if (p instanceof PackageObject) {
                // java.lang.ClassCastException类型转换异常
                // Animal a1 = new Dog();
                // Cat cat = (Cat)a1; // 编译不报错、运行报错
                // cat.catchMouse();
                PackageObject sm = (PackageObject) p; // 向下转型：必须使用instanceof进行判断，可以避免java.lang.ClassCastException类型转换异常
                sm.getDetails();
            }
        }

        @Override
        public void getMin() {
            
        }

        // public定义可以省略，实现则无法省略
        @Override
        public void getGame() {
            /**
             * 类与类、类与接口、接口与接口的关系
             * 类与类的关系
             *  继承关系，只能单继承，不能多继承
             * 类与接口的关系
             *  实现关系，可以单实现，也可以多实现
             *  可以在继承一个类的同时实现多个接口
             * 接口与接口的关系
             *  继承关系，可以单继承，也可以多继承
             */
        }

        @Override
        public void showGame() {
            /**
             * 抽象类和接口的关系
             * 抽象类
             *  成员变量：可以是变量，也可以是常量
             *  构造方法：有
             *  成员方法：可以是抽象方法，也可以非抽象方法
             * 接口
             *  成员变量：只可以是常量
             *  构造方法：无
             *  成员方法：只可以是抽象方法
             */
        }

        public synchronized void showGetDetails() {
            // 同步修饰符synchronized：同一时间只能被一个线程访问
        }
    }

    // 29.包：为了更好地组织类，Java提供了包机制，用于区别类名的命名空间
    // 1.概念：一组相关类和接口的集合（就是文件夹）
    // 2.特征：同一个包中的类不能同名，不同包中的类可以同名，这样就有效解决了命名冲突问题
    // 3.包声明：package 包名1.包名2.包名3...真正的类名：包名1.包名2.包名3.CMGameProxy
    // 4.包引用：import 包名1.包名2.包名3.*/import 包名1.包名2.包名3.CMGameProxy
    // 5.注意事项
    // package语句必须是可执行程序的第一行
    // package语句在Java文件中只能有一个
    // 如果没有package语句，默认表示无包名
    // 有package包名的类实际类名：package.类名
    // 6.创建package
    // 选中文件 -> New -> Package
    /**
     *  按照功能划分
     *  com.heima.add
     *      AddStudent // 实际类名com.heima.add.AddStudent：我们使用import com.heima.add;导入包才可以直接使用AddStudent
     *      AddTeacher
     *  com.heima.delete
     *      DeleteStudent
     *      DeleteTeacher
     *  com.heima.update
     *      UpdateStudent
     *      UpdateTeacher
     *  com.heima.find
     *      FindStudent
     *      FindTeacher
     */
    /**
     *  按照模块划分：推荐方法
     *  com.heima.teacher
     *      AddTeacher
     *      DeleteTeacher
     *      UpdateTeacher
     *      FindTeacher
     *  com.heima.Student
     *      AddStudent
     *      DeleteStudent
     *      UpdateStudent
     *      FindStudent
     */
    // 先创建project -> 再创建module -> 最后创建package

    public void showPackageCollections() {
        // 30.泛型
        // >>不使用泛型的缺点：任何对象被添加到集合中都会转换成Object类型，然后取出来则需要再次强制转换成原有类型
        // >>使用泛型的优点：指定集合存储的数据类型（从集合取出来的元素也不再是Object、调用子类特有的方法还是要强制转换：需要先判断）
        // >>泛型<T>紧跟在类名的后面
        List<String> list1 = new ArrayList<String>(); // JDK1.8以前
        List<String> list2 = new ArrayList<>(); // JDK1.8以后
        // 自定义泛型
        LRGameOver<String> gameOver = new LRGameOver<>();
        gameOver.show("xwj");
        // E - Element元素
        // K - Key键
        // N - Number数
        // T - Type类型
        // V - Value值
    }
    // 泛型
    class LRGameOver<T> { // T表示一个标识符：可以随便定义、一般选择T/E
        public void show(T args) {
        }
    }
    // 无界类型通配符
    // 1.可以接受任何类型的泛型参数
    // 2.不能add写入：除null
    // 3.可以读取list.get(0)、读取为Object类型
    public static void showElement(List<?> list) {

    }
    // 类型通配符上限
    // 1.可以接受Number和Number子类的泛型参数
    // 2.不能add写入：除null
    // 3.可以读取list.get(0)、读取为Number类型
    public static void showElement(List<? extends Number> list) {
    }
    // 类型通配符下限
    // 1.可以接受Integer和Integer父类的泛型参数
    // 2.能add写入Integer以及子类
    // 3.可以读取list.get(0)、读取为Object类型
    public static void showElement(List<? super Integer> list) {
    }

    public void showCollectionMap() {
        // 31.集合框架：不能直接存储基本数据类型
        // >>在java中每个不同的集合底层都对应不同的数据结构：往不同集合存储数据 == 将数据放在不同的数据结构中
        /**
         * Iterable----------可迭代的interface
         *  Collection----------集合interface：只能存储Object子类型、Iterator迭代器interface
         *      List----------数组interface：有序可重复
         *          *ArrayList----------class：底层是数组：适合检索、不适合增删、非线程安全
         *          *LinkedList----------class：底层是双向链表：适合增删、不适合检索
         *          Vector----------class：底层是数组、线程安全（使用synchronized修饰：效率低，控制线程安全目前有更好办法）
         *      Set----------集合interface：无序不可重复
         *          *HashSet----------class：底层是哈希表（创建HashMap）
         *          SortedSet----------interface
         *              *TreeSet----------class：底层是二叉树（创建TreeMap）
         *  Map----------集合interface：以key/value键值对的形式存储元素、key无序不可重复
         *      *HashMap----------class：底层是哈希表、非线程安全
         *      Hashtable----------class：底层是哈希表、线程安全（使用synchronized修饰：效率低，控制线程安全目前有更好办法）
         *          *Properties----------class：存储的key/value必须是String
         *      SortedMap----------interface
         *          *TreeMap----------class：底层是二叉树（key可以自动按照大小顺序排序）
         */
        // 1>.Collection
        Collection c1 = new ArrayList();
        c1.add(1200); // 集合不能存放基本数据类型：这里可以存是因为“自动装箱”
        c1.size(); // 获取集合元素个数
        c1.clear(); // 清空集合
        if (c1.contains("xwj")) {
            // 集合是否包含某个元素：学会重写equals()...contains()和remove("")方法都是通过equals()进行比较的
        }
        c1.add("xwj");
        c1.remove("xwj"); // 删除集合中的某个元素
        if (c1.isEmpty()) {
            // 集合是否为空
        }
        Object[] objs = c1.toArray(); // 集合转换成数组
        // 遍历集合
        Iterator iterator = c1.iterator(); // 刚创建Iterator没有指向第一个元素：集合结构只要发生改变就必须重新创建Iterator
        while (iterator.hasNext()) { // 如果还有元素迭代器返回true
//             c1.remove(iterator.next()); // 报错：集合结构只要发生改变就必须重新创建Iterator
            iterator.remove(); // 不会报错：删除Iterator当前指向的元素
            System.out.println(iterator.next()); // 让迭代器前进一步：返回迭代器指向的元素
        }

        // 2>.List
        // >>有序可重复：下标从0开始
        List list = new ArrayList();
        list.add("淘宝");
        list.add(1, "字节");
        Iterator iterator1 = list.iterator();
        // 并发修改异常：不要边遍历边修改集合
        while (iterator1.hasNext()) {
            System.out.println(iterator1.next());
        }
        for (int i = 0; i < list.size(); i++) {
            String s1 = list.get(i).toString();
        }
        if (list.size() > 0) {
            String s2 = list.get(0).toString();
        }
        list.indexOf("淘宝"); // 第一次出现索引：没有返回-1
        list.lastIndexOf("小玩具"); // 最后一次出现索引：没有返回-1
        list.remove(0); // 删除指定位置的元素
        list.set(0, "xwj"); // 修改指定位置的元素
        /**
         * 增删改查的常见单词
         * 增 - add/save/new
         * 删 - delete/remove/drop
         * 改 - update/set/modify
         * 查 - find/get/query/select
         */

        // 3>.ArrayList：可以动态修改的数组
//         ArrayList<String> siteNames = new ArrayList<>(20); // 指定集合容量是20
        // >>底层先创建一个length = 0的数组，当添加第一个元素的时候，初始化集合容量是10
        // >>1.5倍扩容（10 -> 15...）
        ArrayList<String> siteNames = new ArrayList<>(); // 初始化集合容量是10：泛型紧紧跟在类名的后面
        Collections.synchronizedList(siteNames); // 转换成线程安全
//         // 通过HashSet创建List
//         Collection c2 = new HashSet();
//         c1.add("xwj");
//         List siteNames = new ArrayList(c1);
        // 添加元素
        siteNames.add("Google");
        siteNames.add("Taobao");
        siteNames.add("Runoob");
        siteNames.add("Weibo");
        // 访问元素
        if (siteNames.size() > 1) {
            System.out.println(siteNames.get(1));
            // 修改元素
            siteNames.set(1, "Tencent");
        }
        // 删除元素
        siteNames.remove(1);
        siteNames.remove("Google");
        if (siteNames.contains("Baidu")) {
            // 判断元素是否在ArrayList
        }
        if (siteNames.isEmpty()) {
            // 判断ArrayList是否为空
        }
        int index1 = siteNames.indexOf("Weibo");
        // 遍历ArrayList
        for (int index = 0; index < siteNames.size(); index++) {

        }
//        // 迭代器
//        // 获取迭代器
//        Iterator<String> iterator = siteNames.iterator();
//        while (iterator.hasNext()) {
//            System.out.println(iterator.next());
//        }

        // 4>.LinkedList链表
        // >>相比ArrayList：LinkedList的“添加、删除”操作效率更高；“查找、修改”操作效率更低
        LinkedList<String> siteNames1 = new LinkedList<>(); // 没有初始化容量
        // 添加元素
        siteNames1.add("Google");
        siteNames1.add("Taobao");
        siteNames1.add("Runoob");
        siteNames1.add("Weibo");
        // 在头部添加元素
        siteNames1.addFirst("Tencent");
        // 在尾部添加元素
        siteNames1.addLast("Baidu");
        // 移除头部元素
        siteNames1.removeFirst();
        // 移除头部元素
        siteNames1.removeLast();
        // 获取头部元素
        siteNames1.getFirst();
        // 获取尾部元素
        siteNames1.getLast();
        siteNames1.add(1, "ByteDance");
        // 遍历LinkedList
        for (int index = 0; index < siteNames1.size(); index++) {
            System.out.println(siteNames1.get(index));
        }

        // 5>.Vector动态数组：线程安全、效率低
        // >>因为目前我们有更好的方案可以保证线程安全，所以Vector使用较少
        Vector<String> dayNames = new Vector<>(); // 初始化集合容量是10：两倍扩容（10 -> 20 -> 40...）
        // 方法全部带synchronized
        dayNames.add("Sunday");
        dayNames.add("Monday");
        dayNames.add("Tuesday");
        dayNames.add("Wednesday");
        dayNames.add("Thursday");
        dayNames.add("Friday");
        dayNames.add("Saturday");
        while (dayNames.elements().hasMoreElements()) {
            System.out.println(dayNames.elements().nextElement());
        }
        // >>Stack栈：Vector的一个子类
        Stack<String> stack = new Stack<>();
        // 把对象压入堆栈顶部
        stack.push("Sunday");
        // 移除堆栈顶部对象
        String s = stack.pop();

        // 6>.HashSet：不允许有重复元素的集合（怎么保证元素唯一性？？？）
        // >>特点：无序、允许有null值、线程不安全
        // >>底层：哈希表（创建HashMap）
        Set<String> siteNames2 = new HashSet<>();
        // 添加元素：添加到HashSet集合中的元素实际上是放在HashMap集合的key
        siteNames2.add("Google");
        siteNames2.add("Taobao");
        // 重复的元素不会被添加
        siteNames2.add("Taobao");
        siteNames2.add("Runoob");
        siteNames2.add("Weibo");
        // 删除元素
        if (siteNames2.remove("Weibo")) {
            // 删除成功返回true
            siteNames2.clear(); // 删除所有元素
        }
        // 遍历HashSet
        for (String siteName:
                siteNames2) {
        }

        // 7>.TreeSet
        // >>特点：无序、不可重复...可排序集合：可以按照元素的大小顺序自动排序（无法对自定义类型排序）
        // >>底层：二叉树（创建TreeMap）
        Set treeSet = new TreeSet();
        treeSet.add("淘宝"); // 添加到TreeSet集合中的元素实际上是放在TreeMap集合的key

        // 8>.Map
        // >>Map和Collection之间没有继承关系
        // >>Map集合以key/value的形式存储数据：无序
        // >>HashMap的key可以null、Hashtable的key不能null
        Map<Integer, String> map = new HashMap<>();
        // 添加key/value
        map.put(Integer.valueOf(1), "Google"); // key/value都必须是引用类型：这里使用自动装箱
        map.put(Integer.valueOf(2), "Taobao");
        String value = map.get(Integer.valueOf(2)); // 通过key获取value
        System.out.println(map.size()); // 获取key/value的数量
        map.remove(Integer.valueOf(1)); // 删除
        if (map.containsKey(Integer.valueOf(1)) && map.containsValue("xwj")) {
            // 是否包含key和value
            Collection<String> c2 = map.values(); // 获取所有的values
            Set<Integer> set = map.keySet(); // 获取所有的keys
        }
        map.clear(); // 清空集合
        // 等于map.size() == 0
        map.isEmpty();
        // 遍历map
//        // 第一种方法
//        Set<Integer> mapSet = map.keySet();
//        Iterator iterator = mapSet.iterator();
//        while (iterator.hasNext()) {
//            System.out.println(iterator.next());
//        }
//        // 第二种方法
//        for (Integer key:
//                mapSet) {
//            System.out.println(map.get(key));
//        }
//        // 第三种方法
//        Set<Map.Entry<Integer, String>> set = map.entrySet();
//        Iterator<Map.Entry<Integer, String>> iterator2 = set.iterator();
//        while (iterator2.hasNext()) {
//            Map.Entry<Integer, String> node = iterator2.next();
//            System.out.println(node.getKey());
//            System.out.println(node.getValue());
//        }
//        // 第四种方法
//        for (Map.Entry<Integer, String> node:
//                set) {
//            System.out.println(node.getKey());
//            System.out.println(node.getValue());
//        }

        // 9>.Properties
        Properties properties = new Properties();
        properties.setProperty("key", "xwj");
        String name = properties.getProperty("key");

        // 10>.Collections集合工具类
        List<String> list1 = new ArrayList<>();
        // 转换成线程安全
        Collections.synchronizedList(list1);
        list1.add("xwj");
        list1.add("wy");
        Collections.sort(list1); // 把指定的列表按升序排列
        Collections.reverse(list1); // 反转指定列表中元素顺序
        Collections.shuffle(list1); // 使用默认的随机源随机排列指定列表

        // 自然排序Comparable
        // 比较器排序Comparator
    }

    public void showPackageFiles() {
        // 32.File文件类
        // >>File文件类不是流...不能完成文件读写
        // >>File文件类对象：可能是目录、可能是文件
        // 1>.创建文件对象...仅仅是一个路径名，可以存在也可以不存在，需要通过具体的操作把这个路径的内容转换成具体存在的
        File file = new File("给定path路径");
        File file1 = new File("父path路径", "子文件名/子目录名");
        File file2 = new File(new File("父path路径"), "子文件名/目录名");
        // 2>.获取文件或目录信息
        System.out.println(file.getName()); // 返回File对象表示的文件或目录的名称
        System.out.println(file.getParent()); // 返回File对象表示的文件或目录的父目录，如果没有返回null
        System.out.println(file.getPath()); // 返回File对象表示的文件或目录的路径名
        System.out.println(file.getAbsolutePath()); // 返回File对象表示的文件或目录的绝对路径名
        System.out.println(file.length()); // 返回File对象表示的文件或目录的大小（以字节为单位）
        System.out.println(file.lastModified()); // 获取文件或目录最近一次修改时间
        // 3>.文件或目录测试与检查操作
        if (file.exists()) {
            // File对象表示的文件或目录是否存在
            try {
                // a>.以文件形式新建
                // 如果文件不存在，返回true，开始创建
                // 如果文件存在，返回false，不创建
                file.createNewFile();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        file.setReadable(false); // 设置不可读：Windows下面所有文件默认均可读
        if (file.isDirectory()) {
            // File对象表示的文件或目录（文件夹）是否是目录（文件夹）
        }
        if (file.isFile()) {
            // File对象表示的文件或目录（文件夹）是否是文件目录（文件夹）
        }
        if (file.canRead()) {
            // File对象表示的文件或目录是否可读
        }
        if (file.canWrite()) {
            // File对象表示的文件或目录是否可写
        }
        if (file.isAbsolute()) {
            // File对象是否采用的是绝对路径
        }
        if (file.isHidden()) {
            // File对象是否表示隐藏文件或目录
        }
        // 4>.目录操作：就算path路径是一个文件，但是我调用该方法依旧会给我创建一个目录（以调用的方法为准，与path路径无关）
        // b>.以目录形式新建
        // 如果目录不存在，返回true，开始创建
        // 如果目录存在，返回false，不创建
        file.mkdir();
        // c>.以多重目录形式新建
        // 如果目录不存在，返回true，开始创建
        // 如果目录存在，返回false，不创建
        file.mkdirs();
        String[] list = file.list(); // 返回当前目录下所有文件和子目录的名称
        File[] listFile = file.listFiles(); // 返回当前目录下所有文件和子目录对应的File对象
        FilterFile filterFile = new FilterFile("java"); // 指定要显示文件的类型
        String[] list1 = file.list(filterFile); // 返回当前目录下指定类型文件和子目录的名称
        File[] listFile1 = file.listFiles(filterFile); // 返回当前目录下指定类型文件和子目录对应的File对象
        // 5>.文件创建、修改和删除
        try {
            if (file.createNewFile()) {
                // 若File对象表示的文件不存在，则创建一个空文件夹
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        if (file.delete()) {
            // 删除File对象表示的文件或目录（如果表示的是目录（文件夹）则该目录（文件夹）必须为空才可以删除）
        }
        file.renameTo(file2); // 将文件重命名为newFile对应的文件名
    }
    // FilenameFilter是一个用于文件过滤的接口
    class FilterFile implements FilenameFilter {
        private String fname; // 声明文件类型

        public FilterFile(String name) {
            fname = name;
        }

        @Override
        public boolean accept(File dir, String name) {
            // 用于测试指定文件是否应该包含在某一个文件列表中
            // dir - 被查找的文件所在的目录
            // name - 文件名称
            boolean result = name.endsWith("." + fname);
            return result;
        }
    }

    public void showPackageStream() {
        // 33.IO流（输入输出流）
        // 1>.流的概念：是指一组有顺序、有起点、有终点的数据传输
        // 2>.流的特点：有方向、先进先出原则
        /**
         * 3>.流的分类
         * >>按照流的方向：以内存为参考物
         * 输入流：从连接到数据源的流中读取数据到内存（只能读数据，不能写数据）
         * 输出流：从连接到目的地的流向硬盘写数据（只能写数据，不能读数据）
         * >>按照流处理的数据类型不同
         * 字节流：以字节为单位（一次读取一个字节byte）读写数据...什么类型的文件都可以读取（包括：文本文件、图片、声音、视频）
         * 字符流：以字符为单位（一次读取一个字符）读写数据...只能读取纯文本（不能读取：图片、声音、视频、word文件）
         */
        // 4>.抽象类
        // >>所有的流实现close();方法：因为流是一个内存到硬盘之间的通道，用完以后一定要关闭，不然会占用大量资源
        // >>所有的输出流实现flush();方法：输出流在最终输出以后调用flush();表示通道中剩余未输出的数据强行输出完（清空管道：不然会丢失数据）
        // a.InputStream字节输入流：抽象类
        // b.OutputStream字节输出流：抽象类
        // c.Reader字符输入流：抽象类
        // d.Writer字符输出流：抽象类

        // 5>.具体类
        // a.文件流
        // 1.FileInputStream文件字节输入流（掌握）
        // 作用：任何类型的文件都可以采用这个流来读
        // 方式：字节的方式、硬盘 -> 内存...输入操作
        FileInputStream fis = null;
//        FileInputStream fis1 = null;
//        File file = new File("path路径");
        try {
            fis = new FileInputStream("文件名"); // 使用给定的文件名创建对象
//            fis1 = new FileInputStream(file); // 使用File对象创建对象

//            // 这里会抛出异常
//            fis.read();
//
//            // 不推荐try...catch中嵌套try...catch
//            try {
//                fis.read();
//            } catch (IOException e) {
//                e.printStackTrace();
//            }
//
//            int readData = 0; // 返回读取到的“字节”本身：只要流不关闭，每次调用read方法就顺序的读取数据，直到文件末尾或流被关闭（返回-1）
//            // 使用循环
//            // >>硬盘和内存之间的交互太频繁
//            while (readData = fis.read() != -1) {
//                System.out.println(readData);
//            }

            // 最终版
            int readCount = 0; // 返回读取到的“字节”数量：不是“字节”本身，直到文件末尾或流被关闭（返回-1）
            // 使用循环
            byte[] bytes = new byte[1024 * 1024]; // 1M = 1024KB = 1024 * 1024byte
            // 返回读取到的字节数量
            while ((readCount = fis.read(bytes)) != -1) {
                System.out.println(readCount);
                // 读取多少转换多少
                // >>读取出来的字节怎么处理：逻辑写在这里
            }

            // 其它方法
            System.out.println(fis.read()); // 读取字节输入流：逐条读取
            System.out.println(fis.available()); // 返回流当中剩余的没有读到的字节数量：可以用于创建byte数组，这样读文件就不需要loop...不适合大文件（byte数组不能太大）
            System.out.println(fis.skip(2)); // 跳过2个字节不读
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 确保流一定关闭
            if (fis != null) { // 避免空指针异常
                try {
                    fis.close(); // 关闭输入流
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 2.FileOutputStream文件字节输出流（掌握）
        // 方式：字节的方式、内存 -> 硬盘...输出操作
        // 作用：任何类型的文件都可以采用这个流来写
        FileOutputStream fos = null;
        try {
//            fos = new FileOutputStream("文件名"); // 使用给定的文件名创建对象：文件不存在会自动创建...先清空原文件再写入：谨慎使用
            fos = new FileOutputStream("文件名", true); // 以追加的方式在文件末尾写入：不会清空原文件内容（默认会清空）
            // 开始写
            String s1 = "我是中国人";
            byte[] bytes = s1.getBytes();
            fos.write(bytes); // 将byte数组全部写入
            fos.write(bytes, 0, 2); // 将byte数组部分写入
            // 刷新
            fos.flush();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 确保流一定关闭
            if (fos != null) { // 避免空指针异常
                try {
                    fos.close(); // 关闭输入流
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
//            // 如果一边读文件FileInputStream、一边写文件FileOutputStream
//            // 必须分开try...catch：不然可能会导致无法全部关闭
//            if (fos != null) {
//                try {
//                    fos.close(); // 关闭输入流
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//            if (fis != null) {
//                try {
//                    fis.close(); // 关闭输入流
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
        }
        /**
         * 拷贝文件
         * >>从C盘->D盘无法直接拷贝，必须通过C盘->内存->D盘
         * >>拷贝的过程：一边读文件FileInputStream、一边写文件FileOutputStream
         */

        // 3.FileReader文件字符输出流
        // 方式：字符的方式、硬盘 -> 内存...输入操作
        // 作用：只能读取普通文本（读取文本内容的时候比较方便快捷、word文档不属于普通文件）
        FileReader reader = null;
        try {
            reader = new FileReader("文件名"); // 使用给定的文件名创建对象
            // 开始读
            char[] chars = new char[5];
            int readCount = 0;
            // 文件结束标记为-1
            while ((readCount = reader.read(chars)) != -1) {
                System.out.println(String.valueOf(chars, 0, readCount));
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 确保流一定关闭
            if (reader != null) { // 避免空指针异常
                try {
                    reader.close(); // 关闭输入流
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 4.FileWriter文件字符输入流
        // 方式：字符的方式、内存 -> 硬盘...输出操作
        // 作用：只能写入普通文本（写入文本内容的时候比较方便快捷）
        FileWriter writer = null;
        try {
//            writer = new FileWriter("文件名"); // 使用给定的文件名创建对象：文件不存在会自动创建...先清空原文件再写入：谨慎使用
            writer = new FileWriter("文件名", true); // 以追加的方式在文件末尾写入：不会清空原文件内容（默认会清空）
            // 开始写
            String s1 = "我是中国人";
            char[] chars = {'谢', '吴', '军'};
            writer.write(chars); // 将char数组全部写入
            writer.write(chars, 0, 2); // 将char数组部分写入
            // 可以直接写入字符串
            writer.write(s1);
            // 刷新
            writer.flush();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            // 确保流一定关闭
            if (writer != null) { // 避免空指针异常
                try {
                    writer.close(); // 关闭输入流
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // b.转换流：将字节流转换成字符流
        // InputStreamReader
        // OutputStreamWriter

        // c.缓冲流：自带内部缓冲区的流
        // >>提高I/O的执行效率、不需要自定义byte[]和char[]
        // >>当缓冲流执行输出操作时，并不马上将数据写到所连接的输出流中，而是写入缓冲区，当缓冲区写满或关闭流的时候再一次性将缓冲区中数据写入输出流中，这样可以减少实际写请求的次数，提高将数据写入文件的效率
        // >>当缓冲流执行输入操作时，并不从输入流读取数据，而是从缓冲区中读取数据，当缓冲区中数据读完后，才从输入流中读取成批数据存入缓冲区，这样可以提高读数据的效率
        // 1.BufferedReader
        // reader - 节点流
        // bufferedReader - 包装流、处理流
        BufferedReader bufferedReader = null;
        try {
//            inputStreamReader = new InputStreamReader(fis);
//            bufferedReader = new BufferedReader(inputStreamReader);
            bufferedReader = new BufferedReader(reader);
            String s2 = null;
            // 直接读取一行：不包含换行符
            while ((s2 = bufferedReader.readLine()) != null) {
                System.out.println(s2);
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bufferedReader != null) {
                try {
                    // 节点流不需要再单独关闭
                    bufferedReader.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }

        // 2.BufferedWriter：带有缓冲的字符输出流
        BufferedWriter bufferedWriter = null;
        try {
            bufferedWriter = new BufferedWriter(writer);
            bufferedWriter = new BufferedWriter(new OutputStreamWriter(new FileOutputStream("文件名", true)));
            // 直接写入字符串
            bufferedWriter.write("hello world");
            // 刷新
            bufferedWriter.flush();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (bufferedWriter != null) {
                try {
                    bufferedWriter.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        // BufferedInputStream
        // BufferedOutputStream

        // d.数据流：可以将数据连同数据的类型一起写入文件
        // DataInputStream
        // DataOutputStream

        // e.标准输出流
        // PrintWriter
//        // 1>.PrintStream标准字节输出流（掌握）
//        // >>标准的字节输出流，默认输出到控制台
//        PrintStream ps = System.out;
//        ps.println("hello world"); // 不需要手动关闭
//        // 改变标准字节输出流的输出方向：不再指向控制台，指向log文件
//        System.setOut(new PrintStream(new FileOutputStream("log", true))); // 追加日志
//        System.out.println("hello world");

        // f.对象专属流
        // ObjectInputStream（掌握）
        // ObjectOutputStream（掌握）
    }

    // 34.多线程
    // 1>.进程和线程
    // 进程
    // a>.在系统中正在运行的一个应用程序
    // b>.有状态（一个未运行的应用程序不是进程）
    // c>.相互独立（每个进程都拥有自己的内存空间和系统资源）
    // d>.一个应用程序可以对应多个进程
    // e>.一个进程可以有多个线程（至少有一个线程/同一个进程内的线程共享进程的资源）
    // f>.进程是CPU资源分配的基本单位（CPU给进程分配资源、进程类似于车间）
    // 线程
    // a>.进程中所有的任务都是在线程中执行的
    // b>.进程需要执行任务起码需要一个线程
    // c>.线程是CPU调度（执行任务）的最小单位（线程类似于工人）
    // 2>.多线程机制的目的：提高程序的执行效率
    // 3>.多线程的原理
    // >>单核CPU：同一时间点实际上只处理一件事情，多个线程之间频繁切换
    // >>多核CPU：同一个时间点可以真正实现并发执行
    // 4>.实现代码
    // 第一种方式
    class MyThread extends Thread {
        @Override
        public void run() {
            super.run();
            // 封装被线程执行的代码：运行在子线程中
        }
    }
    // 第二种方式
    // 避免Java单继承的局限性
    // 适合多个相同程序的代码去处理同一个资源的情况（把线程和程序的代码、数据有效分离，较好的体现了面向对象的设计思想）
    class YourThread implements Runnable {
        boolean isRun = true;
        @Override
        public void run() {
            if (isRun) {
                // 子线程运行
            } else {
                // 保存相关数据
            }
        }
    }
    public void showThread() {
        // 创建一个子线程对象
        MyThread myThread = new MyThread();
        myThread.run(); // 不会启动线程（相当于普通调用）：不会分配新的分支栈
        // 启动线程：启动一个子线程，在JVM中开辟一个新的栈空间（任务完成以后代码就结束）
        myThread.setName("ttt"); // 设置线程的名字（也可以使用带参构造方法赋值）
        System.out.println(myThread.getName()); // 获取线程的名字
        System.out.println(Thread.currentThread()); // 获取当前线程对象
        System.out.println(Thread.currentThread().getName()); // 获取当前线程的名字
        myThread.start(); // 启动线程：然后由JVM调用该线程的run()方法
        // 中断线程休眠：让休眠的线程异常
        myThread.interrupt();
        // 线程优先级
        /*
        线程调度模型：
        1.分时调度模型：所有线程轮流使用cpu，平均分配每个线程占用cpu的时间片
        2.抢占式调度模型：优先级高的线程优先使用cpu，如果线程的优先级相同，就会随机选择一个（优先级高的线程获取cpu时间片相对多一些）
         */
        // >>线程优先级高一些只是抢到cpu时间片的概率更高一些
        System.out.println("最高优先级：" + Thread.MAX_PRIORITY); // 10
        System.out.println("默认优先级：" + Thread.NORM_PRIORITY); // 5
        System.out.println("最低优先级：" + Thread.MIN_PRIORITY); // 1
        System.out.println("当前线程优先级：" + Thread.currentThread().getPriority());
        myThread.setPriority(10); // 设置myThread线程优先级（1～10）

        YourThread yourThread = new YourThread();
        Thread t1 = new Thread(yourThread);
        t1.start();
        // 终止线程
        yourThread.isRun = false;
        // 合并线程
        try {
            t1.join(); // 线程yourThread合并到当前线程：当前线程阻塞，线程yourThread执行直到结束（等待yourThread执行直到结束死亡）
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        // 设置守护线程
        t1.setDaemon(true);
        // 创建线程对象
        Thread hisThread = new Thread(new Runnable() {
            @Override
            public void run() {
                // 子线程运行
                try {
                    // 毫秒
                    // 让当前线程进入阻塞状态：放弃占有cpu时间片，让给其它线程使用
                    Thread.sleep(1000 * 2); // 休眠2s
                    Thread.yield(); // 当前线程暂停，回到就绪状态...让给其它线程
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        hisThread.start();
    }
    // 5>.生命周期
    // >>新建状态 ---调用start方法---> 就绪状态（有执行资格：没有执行权） ---JVM调度：抢到cpu执行权---> 运行状态（有执行资格：有执行权） ---run方法运行结束/stop() ---> 死亡状态
    // 其他线程抢走cpu的执行权：线程则会从“运行状态”再次回到“就绪状态”
    // >>新建状态 ---调用start方法---> 就绪状态 ---JVM调度---> 运行状态（有执行资格：有执行权） ---sleep()/遇到阻塞事件---> 阻塞状态（没有执行资格：没有执行权）
    // sleep()方法结束/阻塞事件结束：线程则会从“阻塞状态”再次回到“就绪状态”
    // 6>.线程同步机制：解决线程安全问题
    // 什么时候数据在多线程并发的环境下会存在安全问题？--- 多线程并发、共享数据、多条语句操作共享数据
    // >>异步编程：多线程并发
    // >>同步编程：在线程t1执行的时候，必须等待线程t2线程执行（线程排队执行）
    public void showSynchronized() {
        // 1.synchronized
        // 想要哪些线程同步()内部的数据就必须是哪些线程共享的数据
        synchronized (this) { // 这里的this指代的对象必须不变：这样写不行（new Object()）
            // 线程同步代码块
            // “局部变量 + 常量”不会存在线程安全问题：因为局部变量数据不共享（一个线程一个栈）
            System.out.println("123");
        }
    }
    // 同步方法
    // synchronized出现在实例方法中锁对象：this
    // 不够灵活、无故扩大线程同步范围（降低执行效率）
    public synchronized void showSynThread() {
        // 对象锁：在实例方法中使用synchronized、每个对象对应一把锁
    }
    // synchronized出现在类方法中锁对象：类名.class
    public static synchronized void showStaticSynThread() {
        // 类锁：在静态方法中使用synchronized、多个对象对应一把锁
        
        // 这样写的好处：既然实现代码出现什么问题，我们依旧可以释放锁
        try {
            private Lock lock = new ReentrantLock();
            lock.lock();
            // 实现代码
        } finally {
            lock.unlock();
        }
    }
    // 线程安全的类：StringBuffer Vector Hashtable
    // 7>.死锁
    // xxx
    // 原理 线程创建（几种方式） 线程启动 线程调度 线程控制 线程优先级 线程生命周期 多线程的安全问题（解决办法） 线程同步 互斥锁 死锁 线程通信 生产者与消费者案例（等待唤醒机制）

    public void showReflection() {
        // 35.反射机制
        // 类加载器
        // 当程序要使用某一个类的时候 如果该类还没有被加载到内存中，则系统会通过类的加载，类的链接，类的初始化这三个步骤来对类进行初始化，如果不出现意外情况，JVM将会连续完成这三个步骤，我们把这三个步骤统称为类加载（类初始化）
        // 类的加载：将class文件读入内存，并为之创建一个java.lang.Class对象、任何类被使用时，系统都会为之建立一个java.lang.Class对象
        /*
        类的链接：
        1.验证阶段：用于检验被加载的类是否有正确的内部结构，并和其他类协调一致
        2.准备阶段：负责为类的类变量分配内存，并设置默认初始化值
        3.解析阶段：将类的二进制数据中的符号引用替换成直接引用
         */
        // 类的初始化：对类变量进行初始化
        /*
        类的初始化
        a>.步骤：JVM总是最先初始化java.lang.Object
        1.假如类还没有被加载和链接，则程序先加载并链接该类
        2.假如该类的直接父类还未被初始化，则先初始化其直接父类（系统对直接父类的初始化也遵循步骤1-3）
        3.假如类中有初始化语句，则系统依次执行这些初始化语句
        b>.时机
        创建类的实例
        调用类的类方法
        访问类、接口的类变量（或者为该类变量赋值）
        使用反射方式来强制创建某个类、接口对应的java.lang.Class对象
        初始化某个类的子类
        直接使用java.exe命令来运行某个主类
         */
        /*
        类加载器
        a>.作用：负责将xx.class文件加载到内存中，并为之生成对应的java.lang.Class对象
        JVM的类加载机制
        全盘负责：就是当一个类加载器负责加载某个Class时，该Class所依赖的和引用的其他Class也将由该类加载器负责载入，除非显示使用另外一个类加载器来载入
        父类委托：就是当一个类加载器负责加载某个Class时，先让父类加载器试图加载该Class，只有在父类加载器无法加载该类时才尝试从自己的类路径中加载该类
        缓存机制：保证所有加载过的Class都会被缓存，当程序需要使用某个Class对象时，类加载器先从缓存区中搜索该Class，只有当缓存区中不存在该Class对象时，系统才会读取该类对应的二进制数据，并将其转换成Class对象，存储到缓存区
         */
        // ClassLoader：负责加载类的对象
        ClassLoader c = ClassLoader.getSystemClassLoader(); // 返回用于委派的系统类加载器
        c.getParent(); // 返回父类加载器进行委派（Bootstrap class loader虚拟机的内置类加载器，通常表示为null）

        // 反射机制
        // 概念：指在运行时去获取一个类的变量和方法信息
        // 1>.作用：可以操作字节码文件
        // 2>.获取类的字节码
        // 第一种方法
        // >>方法的参数是一个字符串
        // >>字符串需要一个完整类名
        // >>完整类名必须带有包名
        try {
            Class c1 = Class.forName("java.lang.String");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        // 第二种方式
        String s1 = "123";
        Class c2 = s1.getClass();
        // 第三种方法
        // >>任何一种类型（包括基本数据类型）都有.class属性
        Class c3 = String.class;
        Class c4 = int.class;
        // 3>.可以使用Class创建对象：调用对象的无参构造方法
        try {
            Object obj = c3.newInstance();
        } catch (Exception e) {
            e.printStackTrace();
        }
        // 获取构造方法
        Constructor<?>[] con1 = c1.getConstructors(); // 返回公共的构造方法：不能返回私有的构造方法（返回一个包含Constructor对象的数组）
        Constructor<?> con2 = c1.getConstructor(String.class, int.class);
        Constructor<?>[] con3 = c1.getDeclaredConstructors(); // 返回由该Class对象表示的类声明的所有构造方法的Constructor对象的数组
        Constructor<?> con4 = c1.getDeclaredConstructor(String.class, int.class);
        Object obj2 = con1.newInstance(); // 创建对象
        con4.setAccessible(true); // 值为true：取消访问检查
        Object obj4 con4.newInstance(); // 如果是私有的构造方法则无法直接访问，需要先调用setAccessible(true)方法
        // 获取成员变量
        Field[] f1 = c1.getFields(); // 返回一个包含Field对象的数组（私有方法不返回）
        Field f2 = c1.getField("address"); // 返回一个Field对象
        Field[] f3 = c1.getDeclaredFields(); // 返回一个包含Field对象的数组（全部方法返回）
        Field f4 = c1.getDeclaredField(); // 返回一个Field对象
        f4.setAccessible(true); // 值为true：取消访问检查
        f1.set(obj, "西安"); // 给成员变量赋值
        // 获取成员方法
        [] m1 = 
        Method[] m1 = c1.getMethods(); // 返回一个包含方法对象的数组（私有方法不返回）
        Method m2 = c1.getMethod("method1"); // 返回一个方法对象
        Method[] m3 = c1.getDeclaredMethods(); // 返回一个包含方法对象的数组（全部方法返回）
        Method m4 = c1.getDeclaredMethod(); // 返回一个方法对象
        m4.setAccessible(true); // 值为true：取消访问检查
        m2.invoke(obj, "xiewujun", 18); // 调用obj的方法
        // 4>.当前线程获取到类加载器对象默认从类的rootPath下加载资源
        // >>获取文件（文件必须在src文件下）的绝对路径：无论什么OS
        String path = Thread.currentThread().getContextClassLoader().getResource("images/线程生命周期.png").getPath();
    }
    // 原理 jvm和类 类的加载、连接和初始化 类加载器ClassLoader 类加载机制 自定义类加载器 获取class实例（4种方式） Proxy和InvocationHandler创建动态代理 动态代理和AOP

    // 36.Annotation注解
    // 1>.概念：Annotation注解是一种引用数据类型，编译以后生成xxx.class文件
    // 2>.格式：MyAnnotation表示注解类型名
    public @interface MyAnnotation {
        // 自定义注解
    }
    // 使用注解
    // >>注解可以出现在类上、方法上、属性上...任何位置上
    @MyAnnotation
    public void showAnnotation() {
    }
}