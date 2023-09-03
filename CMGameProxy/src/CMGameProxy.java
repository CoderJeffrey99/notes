// package语句位于源文件的首行

// import语句位于package语句和类定义之间
import java.io.*;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

// 一个源文件最多只能有一个public类：源文件名和public类名保持一致
// 一个源文件可以有多个非public类
// Java所有的类默认继承根类Object
public class CMGameProxy {
    /**
     * 6.main函数
     * public - 被JVM调用，权限需要足够大
     * static - 被JVM调用，不需要创建对象
     * void - 被JVM调用，不需要任何的返回值
     * main - 默认规定的（只有这样写才能被JVM识别）
     * String[] args - 接收键盘录入的数据
     */
    public static void main(String[] args) {
        CMGameProxy c1 = new CMGameProxy(); // 创建类
        c1.showPackageBase(); // 调用方法
        System.out.println(c1); // 输出的是d1的地址
        System.out.println(c1.toString()); // 与上面的方法等价：我们可以通过重写toString{}方法
    }

    private void showPackageBase() {
        /**
         * 1.计算机基础
         * 1>.快捷键
         * command+C/V/X/A/S/Z - 复制/粘贴/剪切/全选/保存/撤销一步
         * 2>.人机交互
         * 命令行方式：需要在控制台输入特定的指令（操作麻烦）
         * 图形化界面：简单直观
         * 3>.DOS命令
         * cd + 文件夹 - 进入指定文件夹
         * md + 文件名称 - 创建文件夹
         * rd + 文件名称 - 删除文件夹
         * touch + 文件 - 创建文件
         * exit - 退出dos命令行
         */

        /**
         * 2.Java简介
         * 1>.特征：简单性、面向对象、分布式处理、解释性、健壮性、跨平台、安全性、可移植性、高性能、多线程、动态性、开源、强类型语言
         * 2>.诞生：1995年Sun公司正式推出
         * 3>.分类
         * JavaSE标准版（为开发普通桌面和商务应用程序提供的解决方案）- 基础/Java标准平台
         * JavaME小型版（为开发电子消费产品和嵌入式设备提供的解决方案）- 安卓/嵌入式产品开发平台
         * JavaEE企业版（为开发企业环境下的应用程序提供的一套解决方案）- 后台/企业级应用开发平台
         * 4>.平台：Java虚拟机 + JavaAPI
         * 5>.跨平台：JVM不是跨平台
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
         */

        // 3.Java开发环境搭建
        // 1>.下载JDK（Java开发工具包）= JRE（Java运行环境）+ Java工具 + Java基础类库
        // 2>.JDK的配置：安装JDK -> 配置环境变量
        /**
         * 3>.JDK的目录
         * JDK
         *  bin......JDK工具程序
         *      javac.exe
         *      java.exe
         *      appletviewer.exe
         * demo......Java自带的演示程序
         * include......用于编译本地方法的c++头文件
         * jre......Java运行环境文件
         * lib......Java的类库文件
         * sample......Java自带的示例程序
         * src.zip......Java API类的源代码压缩文件
         */
        // 4>.java核心机制和JVM运行原理
        // xxx

        /**
         * 4.进制转换
         * 1>.概述
         * 计算机最小存储单位是"字节byte"
         * 1byte = 8bit（"1bit"相当于"一个二进制的数字0或1"）
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
        System.out.println(0x100); // 十六进制 - 0x

        /**
         * 5.原码/补码/反码：1表示负数，0表示正数（！！！有时间可以操作一遍！！！）
         * 1>.真值：一个数的十进制表示形式/机器数：一个数的二进制表示形式
         * 2>.原理：计算机内存是由大量开关组成的，分别用0和1来表示每一位开关（每一位成为1bit，每8位成为1字节/byte）
         * 1kb=1024byte   1Mb=1024kb   1Gb=1024Mb   1Tb=1024Gb/计算机分配内存的最小单位是字节/byte
         * 3>.原码：将一个数的真值的绝对值转为二进制，存储的八位内存空间，最高位存储符号位，1表示负数，0表示正数，其余7位用来存储真值的绝对值的二进制表示形式
         * 结论：计算机不以原码的方式进行数据存储，原码会出现计算错误
         * 4>.反码：正数的反码是原码，负数的反码是原码符号位不变，其余位数按位取反（0变1，1变0）反码的反码是原码
         * 结论：计算机不以反码的方式进行数据存储，反码解决不了0的问题
         * 5>.补码：正数的补码是原码，负数的补码是反码加1，补码的补码是原码
         * 结论：计算机是以补码的形式进行存储/计算机只会做"加法运算"
         * 正数三码合一
         * 真值      原码       反码       补码
         * 1        00000001  00000001   00000001
         * -1       10000001  11111110   11111111
         */

        // 7.第一个Java程序
        // java的执行原理：xxx
        System.out.println("Hello World");

        /**
         * 8.标识符
         * 1>.概念：给类、接口、方法、变量起名字时候使用的字符序列（不能与关键字同名）
         * 2>.要求：由字母、数字、_、$组合而成，并且不能以数字开头（不能把关键字和保留字作为标识符、严格区分大小写）
         * 3>.注意：Java语言使用Unicode国际标准字符集（标识符中可以有汉字、日文等，一般不建议这样操作）
         * 4>.命名风格
         * a.包（文件夹）：一般域名（www.heima.com）倒过来/com.heima.utils/全部小写
         * b.类/接口：每个单词首字母大写（驼峰命名）/CMGameProxy
         * c.方法/变量：从第二个单词开始首字母大写/playGame
         * d.常量：所有字母大写，以'_'隔开/MAX_VALUE
         */

        /**
         * 9.关键字
         * 1>.概念：被Java语言赋予特定含义的单词
         * 2>.特点：关键字全部小写、关键字不能做为标识符
         * 3>.保留关键字：goto/const（保留关键字也不能做为标识符）
         */

        // 10.注释：用于解释说明程序的文字
        // 1>.单行注释：可以嵌套
        /**
         * 2>.多行注释：不可以嵌套
         */
        // javadoc -d api -version -author -ArrayTool.java
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
        // 6>.注释可以帮助我们排查错误：初级排错方式/有一定效果
    }

    // 11.常量和变量
    private void showPackageNums() {
        // 1>.常量：程序运行过程中其值始终不能改变的量
        /**
         * final可以修饰成员变量、成员方法、类
         * 1>.修饰成员变量：表示该成员变量是常量：一般配合static修饰，保存在常量区
         * 2>.修饰成员方法：表示该成员方法是最终方法：无法被子类重写，但是可以被继承
         * 3>.修饰类：表示该类是最终类：不能被继承
         */
        final int MAX = 100;
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
        System.out.println(' ');  // 对：可以放空格
        // 布尔常量：true/false
        boolean a5 = true;
        System.out.println(a5 ? "YES" : "NO");
        // 空常量
        String a6 = null;
        System.out.println(a6);
        // 2>.变量：在程序执行过程中可以发生改变的量（必须先声明在使用）
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

    // 12.数据类型
    // 1>.概念：java语言是强类型语言，每个数据都有明确的数据类型，在内存中都分配了不同大小的内存空间
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
    public void showPackageDataType() {
        // 3>.整数型：默认为int
        byte a1 = 10; // 取值范围：-128 - 127
        short a2 = 20;
        int a3 = 15;
        long a4 = 8888888888888L; // 超过int范围/Integer number too large（必须末尾加一个"l/L"表示这是一个long类型）
        // 4>.浮点型：默认为double
//        float a5 = 12.3; // 报错：因为float是单精度，'12.3'默认是double，不能直接赋值
        float a6 = 12.3f; // ！！！必须末尾加一个"f/F"表示这是一个float类型！！！
//        double a6 = 3.14d; // 正确：末尾加一个"d/D"表示这是一个double类型
        double a7 = 3.14; // "d/D"可以省略不写
        // 5>.字符char：取值范围：0 ~ 65535
        char a8 = 'a'; // 没有负数
//        char a9 = '12'; // 不能放置两个字符
        char a10 = '我'; // 可以存在中文（因为java是unicode编码）/单个中文占2个字节
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
        // 强制转换的格式
        // 数据类型 变量名 = (数据类型)变量值;
        int a14 = 10;
        byte a15 = 4;
        byte a16 = (byte) (a14 + a15);
        // b、强制转换超出"数据类型"的取值范围会出错
        byte a17 = (byte) (126 + 4);
        System.out.println(a17); // 输出-126（多于8位的会直接砍掉）
        byte a18 = (byte)300;
        System.out.println(a18); // 输出44
        /**
         * 注意点
         * 1.在定义long/float类型变量的时候需要加上L/f
         * 2.整数默认类型是int/浮点数默认类型是double
         * 3.byte/short在定义的时候接收的实际上是一个int类型（如果不在它们的范围就会报错）
         * 4.关于自动类型提升 - byte/short/char -> int -> long -> float -> double
         */
    }
    /**
     * 面试题
     * 1>.在Java中boolean类型占几个字节？
     * 在Java中boolean类型理论上占1/8个字节，因为一个开关就可以决定true和false，但是在java中没有明确指定boolean类型的大小
     * 2>.以下程序是否有问题？如果有问题请指出问题？
     * byte a1 = 3;
     * byte a2 = 4;
     * // 1.byte与任何数据类型（char/int/short/byte）进行运算会提升为int，两个int类型相加结果也是int
     * // 2.a1和a2是两个变量，变量存储的值是变化的，在编译的时候无法判断具体的值，相加有可能会超出byte取值范围
     * byte a3 = a1 + a2; // 报错
     * // Java编译器有常量优化机制（编译的时候直接将常量相加的结果算出来赋值）
     * byte a4 = 3 + 4;
     */

    // 13.运算符：对常量和变量进行操作的符号、运算符的优先级可以通过‘()’改变
    private void showPackageOperator(CMGameProxy cmGameProxy) {
        // 1>.算术运算符+ - * / %
        // %的结果和被除数是同一类型（char类型本质也是整型）
        System.out.println(10 / 3); // 输出3：整数相除结果只能是整数
        // 计算结果的精度
        // 精度：byte - short - int - long - float - double
        // java按运算符两边的操作元的最高精度保留计算结果的精度
        System.out.println(10 / 3.0); // 输出3.33333：小数相除结果只能是小数（把其中一个数变成小数，另一个数会自动类型提升）
        // 结果只与左边的符号有关，与右边无关
        System.out.println(-2 / 5); // 输出-2：当左边的绝对值小于右边绝对值的时候结果为左边的值
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
        // 3>.关系运算符（boolean没有非零既真）
        boolean a19 = a13 == a12;
        boolean a20 = a13 != a12;
        boolean a21 = a13 > a12;
        boolean a22 = a13 < a12;
        boolean a23 = a13 >= a12;
        boolean a24 = a13 <= a12;
        // 4>.逻辑运算符
        // 短路与：只要a19为假则不再计算a20
        boolean a25 = a19 && a20;
        // 短路或：只要a19为真则不再计算a20
        boolean a26 = a19 || a20;
        // a19真结果为假，a19假结果为真
        boolean a27 = !a19;
        // 5>.位运算符：先把操作数化成二进制再操作
        // <<左移（左边最高位丢弃，右边补0）
        // >>右移（最高位是0，左边补0；最高位是1，左边补1）
        // >>>无符号右移（无论最高位是0或1，左边补0）
        // '有符号右移>>'和'无符号右移>>>'的区别
        // 1>.'有符号右移>>'：无论高位是0还是1，移动后都用0补位
        // 2>.'无符号右移>>>'：最高位是0移动后就用0补位，最高位是1移动后就用1补位
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
        // a1按位取反
        // 0变成1，1变成0
        int a28 = ~a13;
        // a1和a2按位做与运算
        // 如果相对应位都是1，则结果为1，否则为0
        int a29 = a13 & a12;
        // a1和a2按位做或运算
        // 如果相对应位都是0，则结果为0，否则为1
        int a30 = a13 | a12;
        // a1和a2按位做或运算
        // 如果相对应位值相同，则结果为0，否则为1
        int a31 = a13 ^ a12;
        // a1按位右移a2位
        int a32 = a13 >> a12;
        // a1按位左移a2位
        int a33 = a13 << a12;
        // a1按位右移a2位（左边的空位一律填0）
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
        // 6>.赋值运算符
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
        // 7>.三目运算符
        int a38 = (a34 > a33) ? 36 : 45;
        // 8>.对象运算符
        if (cmGameProxy instanceof CMGameProxy) {
            // 一个对象是否是某一个指定类（其子类）的实例
        }
    }

    // 14.选择语句
    private void showPackageCondition() {
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
        // d、if支持嵌套
        if (a2 > 20) {
            if (a2 > 10) {
                // 语句体1
            } else {
                // 语句体2
            }
        }
        // 2>.switch语句：判断固定值使用（枚举）/理论上比"if语句"效率高
        // a、可以是byte/short/char/int（自动类型提升为int类型的数据都可以/long不可以作为switch的表达式）
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

    // 15.循环语句
    private void showPackageLoop() {
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
//                break inner; // 跳出内部循环（与break;效果一样）
//                break outer; // 跳出外部循环
            }
            // 转义字符
            System.out.print("\n");
        }
        // 6>.死循环
//        // ！！！java对于永远无法执行到的语句会报错！！！
//        while (true) {
//        }
//
//        do {
//        } while (true);
//
//        for (;;) {
//        }
        /**
         * 面试题
         * 1>.下面的代码是否能够执行?
         * // 可以执行，因为"https:"是一个标号，"//www.baidu.com"是一个注释
         * https://www.baidu.com
         * System.out.println("hello java");
         */
    }

    // 16>.数组
    // 1>.为什么需要数组：可以存储相同数据类型的集合（这点与js不一样）
    // 2>.数组（引用数据类型）可以存储基本数据类型、也可以存储引用数据类型（这点与Objective-C不一样）
    private void showPackageArray() {
        // 3>.一维数组：相同类型变量的列表（可以存在基本数据类型，也可以存在类对象）
        // a>.声明数组：还没有分配内存
        int[] array0; // 推荐使用
        int array1[];
        // b>.Java中的数组是引用类型变量：必须使用new关键字来分配空间确定数组大小
        array0 = new int[10];
        array1 = new int[12];
        // c>.初始化数组：为数组开辟连续的内存空间，并为每个元素赋值
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
        // 2>.静态初始化：给出初始化值，由系统指定长度
        // 第一种方法：可以先声明再赋值
        // ！！！第二个[]不允许有数字！！！
        int[] array_02 = new int[]{1, 2, 3, 4, 5};
        // 第二种方法：必须声明并赋值
        int[] array_03 = {1, 2, 3, 4, 5};
        // d>.异常
//        // 1>.java.lang.ArrayIndexOutOfBoundsException数组索引越界异常（访问了数组中不存在的索引）
//        System.out.println(array_03[10]);
//        // 2>.java.lang.NullPointerException空指针异常（数组已经不再指向堆内存，还继续使用数组名访问元素）
//        // oc没有空指针异常
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

        // 4>.多维数组
        // a>.概述
        // [3] - 二维数组中有3个一维数组
        // [2] - 一维数组中有2个元素
        int[][] array_06 = new int[3][2]; // 推荐使用
        int[] array_07[] = new int[3][2];
        int array_08[][] = new int[3][2];
        System.out.println(array_06); // 二维数组
        System.out.println(array_06[0]); // 二维数组中的第一个一维数组
        System.out.println(array_06[0][0]); // 二维数组中的第一个一维数组的第一个元素
        // b>.初始化：这是一个二维数组
        int[][] array_09 = {
                {1, 2, 3},
                {4, 5},
                {6, 7, 8}
        };
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
        private static int binarySearch(int[] a, int fromIndex, int toIndex, int key) {
            int low = fromIndex;
            int high = toIndex - 1;
            while (low <= high) {
                int mid = (low + high) >>> 1;
                int midVal = a[mid];
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

    // 17.包装类
    // 1>.为什么引入基本数据类型包装类：把基本数据类型对象化，为基本数据类型的操作提供必要的方法
    // 2>.包装类的特点：所有的包装类都是final类型，无法派生子类
    // 3>.基本数据类型与包装类的对应关系
    // byte        Byte
    // short       Short
    // int         Integer
    // long        Long
    // float       Float
    // double      Double
    // char        Character：没有parseXxx()
    // boolean     Boolean
    private void showPackageGroup() {
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
        // 自动装箱：把基本类型转换为包装类类型
        Integer integer6 = 100;
        // 自动拆箱：把包装类类型转换为基本类型
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

//        // f>.Charactor：jdk1.9以后不推荐使用
//        Character ch0 = new Character('a');
        Character ch0 = Character.valueOf('a');
        /**
         * 面试题
         * 1>.int类型和Integer类型有什么区别？它们之间如何相互转换？
         * xxx
         */
    }

    // 18.Object
    public void showPackageObject() {
        // 1>.概念：Java类层次结构的根类，所有类都直接或间接继承该类
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
        // 用一个对象：hashCode()肯定相同
        obj1.hashCode();
        // 返回对象的运行时类
        obj1.getClass();
        // 获取对象的真实类的全名称（类名）
        obj1.getClass().getName();
        /**
         * // 没有意义，一般要重写
         * public String toString() {
         *  return getClass().getName() + "@" + Integer.toHexString(hashCode());
         * }
         */
        obj1.toString();
    }
    /**
     * 面试题：
     * 1>."==和equals()"有什么区别？
     * 1."=="是比较运算符（既可以比较基本数据类型，也可以比较引用数据类型）
     * 2."==和equals()"没有重写之前是一样的（比较地址值）
     */

    // 19>.String：Java中把String当作对象处理（不可变字符串）
    private void showPackageString() {
        // 字符串是常量，一旦被赋值就不能被改变
        // s0存储在常量区
        String s0 = "hello world";
        // 当把"abc"赋值给s0，原来的"hello world"就变成了垃圾
        s0 = "abc";
        s0.toString();
        // s1和s2存储在堆区
        String s1 = new String();
        String s2 = new String("hello world");
        // 字符串提取
        char c1 = s1.charAt(3); // 返回字符串中指定位置的字符
        String s3 = s1.substring(1, 4); // 返回字符串中指定位置"1 - (4 - 1)"中的子串/字符串中的字符位置序号从0开始
        s3 = s1.substring(2); // 从指定位置开始截取字符串，默认到末尾
        int c2 = s1.indexOf('w'); // 返回字符w第一次出现的位置，找不到返回-1
        int c3 = s1.indexOf("wu"); // 返回字符串wu第一次出现的位置，找不到返回-1
        int c4 = s1.lastIndexOf('a'); // 从后往前查找：指定'字符、字符串'第一次出现的索引
        // 字符串比较大小
        int c5 = s1.compareTo(s2); // 比较字符串大小，返回结果">0、=0、<0"
        boolean c6 = s1.equals(s2); // ！！！判断字符串内容是否相同（区分大小写）！！！
        boolean c7 = s1 == s2; // 用于判断两个字符串引用是否指向同一个字符串对象（判断字符串地址是否相同）
        boolean c8 = s1.equalsIgnoreCase(s2); // 判断字符串内容是否相同（不区分大小写）
        // 其它类型转换为字符串
        String s4 = String.valueOf(123.4); // 基础数据类型 -> 字符串
        String s5 = s1.toLowerCase(); // 大写 -> 小写
        String s6 = s1.toUpperCase(); // 小写 -> 大写
        // 字符串替换
        String s7 = s1.replaceAll("wu", "ju"); // 把"wu"替换成"ju"（全部替换）
        // 其它方法
        String s8 = s1.concat(s2); // 字符串拼接（返回一个新字符串）
        String s9 = s1 + s2;
        String s10 = s1.trim(); // 移除字符串首尾空格（返回一个新字符串）
        int c9 = s1.length(); // 返回当前字符串的长度
        // 常用判断方法
        System.out.println(s1.contains(s2)); // 判断s1中是否包含s2
        System.out.println(s1.startsWith("abc")); // 判断s1是否以"abc"开头
        System.out.println(s1.endsWith("abc")); // 判断s1是否以"abc"结尾
        float pi = 3.14F;
        int max = 12;
        // 格式化字符串
        System.out.println(String.format("浮点型变量的值为：%f" +
                "整型变量的值为：%d" +
                "字符串变量的值为：%s", pi, max, s1));
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
        }
        for (int i = 0; i < s1.toCharArray().length; i++) {

        }
    }

    // 20>.StringBuffer：用于创建可变字符串类、字符串缓冲区类、线程安全的可变字符序列
    private void showPackageStringBuffer() {
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
        StringBuffer sb10 = new StringBuffer("heima"); // 通过构造方法
        StringBuffer sb11 = new StringBuffer();
        sb11.append("heima"); // 通过append()方法
        // b.StringBuffer -> String
        StringBuffer sb12 = new StringBuffer("heima");
        String s29 = new String(sb12); // 通过构造方法
        String s30 = sb12.toString(); // 通过toString()方法
        String s31 = sb12.substring(0, 3); // 通过substring(start, end)方法
        /**
         * 面试题
         * 1>.StringBuffer和StringBuilder的区别
         * a.StringBuffer出现于jdk1.0，线程安全，效率低
         * b.StringBuilder出现于jdk1.5，线程不安全，效率高
         * c.String是不可变字符串序列，StringBuffer是可变字符序列
         * 2>.String和StringBuffer作为参数传递
         * a.基本数据类型的值传递：不改变其值
         * String s1 = "heima";
         * // String类虽然是引用数据类型，但是作为参数传递时和基本数据类型一样
         * change(s1);
         * System.out.println(s1); // heima
         * b.引用数据类型的值传递：改变其值
         * StringBuffer sb1 = new StringBuffer("heima");
         * change(sb1);
         * System.out.println(sb1); // heimaitcase
         */
    }

    // 21>.其他类
    private void showPackageOtherClass() {
        // a>.Date类
        // 获取一个日期的字符串
        Date date = new Date();
        // 获取时间戳：自"1970-01-01 00:00:00 GMT"起以毫秒为单位的时间
        date.getTime();
        if (date.before(date)) {
            // 是否比指定日期早
        }
        if (date.after(date)) {
            // 是否比指定日期晚
        }
        if (date.equals(date)) {
            // 比较两个日期的相等性
        }

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
        Date d3 = new Date();
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
        // 天花板函数（向上取整）/>=该参数并且为整数
        System.out.println(Math.ceil(13.3)); // 14.0
        System.out.println(Math.ceil(13.99)); // 14.0
        System.out.println(Math.ceil(-13.3)); // -13.0
        // 地板函数（向下取整）/<=该参数并且为整数
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
        BigInteger[] array_10 = bigInteger_01.divideAndRemainder(bigInteger_02); // 取除数和余数

        // f>.BigDecimal：精确的表示小数
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
        Random r1 = new Random();
        System.out.println(r1.nextInt(100)); // 生成int类型随机数：[0 100)

        // h>.System
        // 一个源文件中可以有多个外部类（实际开发中一个文件只写一个类），只能有一个外部类使用public
        System.gc(); // 运行垃圾回收器：调用finalize()方法
        System.exit(0); // 退出JVM：非0状态属于异常终止
        System.currentTimeMillis(); // 时间戳：当前时间与1970年1月1日之间的毫秒数
    }

    // 22>.正则表达式
    // 1>.概念：一个用来描述或者匹配一系列符合某个语法规则的字符串的单个字符串
    // 2>.规则：参考百度
    private void showPackageRegex() {
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
        // xxx
    }

    // 23>.Scanner
    private void showPackageScanner() {
        Scanner scanner = new Scanner(System.in); // 键盘录入
        // 输入是否为整数（可能会抛出异常）
        if (scanner.hasNextInt()) {
            // 键盘录入一个整数，存储在i中
            int i = scanner.nextInt();
        } else {
            System.out.println("输入类型错误");
        }
        String s = scanner.nextLine(); // 键盘录入什么都可以
        scanner.close(); // 关闭扫描器
        /**
         * 面试题
         * 1>.sc.nextInt()和sc.nextLine()同时存在不行？？？
         * a>.创建两个Scanner对象...浪费空间
         * b>.全部使用sc.nextLine()...后续将整数字符串转换成整数
         */
    }

    // 24>.异常处理
    // 1>.什么是异常：程序在运行过程中发生的错误、一定发生在运行时
    // 2>.Throwable类是所有Exception异常和Error错误的父类
    // 3>.作用：提供一种面向对象的异常处理机制来处理程序运行时产生的各种不正常情况，加强程序的健壮性
    // 4>.程序错误的种类：语法错误（编译错误）、运行时错误
    // 5>.常见的运行时异常类：空指针异常NullPointerException | 索引越界异常IndexOutOfBoundException | 类型转换异常ClassCastException | 算术运算异常ArithmeticException
    // 6>.处理异常：异常分为"运行时异常：程序可以不做处理"和"非运行时异常：程序必须捕获或声明"
    /**
     * 异常的处理机制
     * 1.在出现异常的方法中主动调用"try...catch..."处理异常
     * 2.如果该方法中没有做出任何异常处理，把异常抛给调用该方法的上一层方法：上一层方法主动调用"try...catch..."处理异常
     * 3.如果异常抛给程序顶层的main方法还没有被处理，程序停止运行：main方法发出错误信息
     */
    private void showPackageException() {
        try {
            // 一旦代码运行出现异常则停止执行后续代码，开始寻找catch语句中异常类型相匹配的异常处理，处理完毕程序继续执行后续代码
            // 可能发生异常的代码（可能产生N个异常，并伴随N个catch语句捕获异常）
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
            e.printStackTrace();
        } finally {
            // 必须执行的代码：最多只能有一个（一般进行资源的释放：关闭文件、关闭数据库）
            // 无论是否发生异常都需要执行的代码（提供统一出口）
        }
        // 非检查型异常和检查型异常的区别
        // 非检查型异常处理
        // 1>.概述：系统定义的运行异常，由系统自动检测并做出默认处理，用户不需要做任何操作
        // 2>.特点：非检查型异常也可以由用户主动调用"try...catch..."处理异常
        // 检查型异常
        // 1>.概述：用户必须进行处理的异常：捕获异常（主动调用"try...catch..."处理异常）、声明抛出异常（抛给调用方法处理）
    }
    class MyException extends Exception {
        void msgError() {
            System.out.println("这是自定义异常");
        }
    }
    // 抛出异常：不主动调用"try...catch..."处理异常
    // 异常声明：一个方法在执行的时候可能会发生异常但是我们不处理，而是交给调用它的方法处理
    private void showException() throws ArithmeticException, MyException {
        int x = 10 / 0;
        // 抛出异常
        // throws和throw的区别？？？
        // 1>.throw关键字用于在代码中抛出异常
        // 2>.throws关键字用于在方法声明中指定可能会抛出的异常类型
        throw new MyException();
    }

    // 25>.面向对象
    // 枚举的定义：从0开始
    enum SexType {
        male, female, unknown
    }
    /*
    public abstract/final class YourClass extends MyClass implements x1, x2 {
        // 代码
    }
    */
    class PackageObject {
        // 1>.类：描述了一组有相同特征（属性）和相同行为（方法）的对象

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
         * 特点：1、Java只支持单继承，不支持多继承（C++支持多继承）；2、Java支持多层继承
         * 注意：1、子类只能继承父类所有非私有的成员（成员方法和成员变量）；2、子类不能继承父类的构造方法（可以通过super去访问父类构造方法）；3、不要为了部分功能而刻意使用继承
         * c>.多态
         * 概念：在一个程序中同名的不同方法可以共存，子类对象可以响应同名的方法，具体的实现方法不同，完成的功能也不同
         * 好处：1、提高了代码的维护性；2、提高了代码的扩展性
         * 弊端：不能使用子类特有的属性和行为
         */

        // 3>.成员变量
        /**
         * public公共的：能被本类访问、能为子类访问、能被外部访问
         * protected受保护的：默认权限、可以被本类访问、也能为子类访问、不能被外部访问
         * private私有的：只能被本类访问、不能被子类访问、不能被外部访问
         */
        /**
         * // 在Java中所有的变量在使用之前必须声明
         * 局部变量：定义在方法、语句块中的变量/作用域：当前方法、语句块/位于栈内存，随着方法的调用而存在，随着方法的调用完毕而消失/必须在访问前声明（不可以使用访问修饰符修饰、必须init以后才可以使用）
         * 成员变量：定义在类中、方法外的变量/作用域：当前类/位于堆内存，随着对象的创建而存在，随着对象的销毁而消失/可以使用访问修饰符修饰（有默认值：0、false、null）
         * 静态变量：定义在类中、方法外的变量/作用域：当前类/生命周期：类加载时被创建，直到程序结束才会被销毁/使用static修饰，程序运行期间只有一份内存，可以使用访问修饰符修饰
         */
        String name;
        int score;
        private SexType sex; // 设置成员变量为private
//        // static关键字：主要用来修饰类的内部成员（成员变量、成员方法、内部类、语句块）
//        // a>.静态变量：static修饰成员变量
//        // 随着类的加载而加载，先于对象存在
//        // 被类的所有对象共享（被static修饰的成员位于方法区）
//        // 可以通过类名调用（也可以通过对象名调用）
//        // 系统加载类的时候进行一次空间分配和初始化（与对象无关）
//        private static String height;
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

        // 4>.构造函数
        // 作用：给类的成员变量赋初值
        // 构造方法名和类名一致
        // 构造方法没有返回值（连void都没有）、可以有多个构造方法
        // 构造方法不能由用户直接调用：创建一个对象的时候系统会自动调用该类的构造方法
        public PackageObject() {
            // 缺省构造方法：没有参数、方法体为空、使用各种数据类型的默认值来自动init对象的成员变量
            // a>.系统为没有定义构造方法的类自动添加的一种特殊的构造方法
            // b>.一旦类中已经定义构造方法则系统不会再添加"缺省构造方法"（这时候调用无参构造方法会报错）
            /**
             * // super关键字
             * 实现对父类成员变量和成员方法的访问；是谁在调用父类的方法？？？
             * // this关键字
             * 1>.指向当前对象本身，用于类的非静态方法和构造方法中，不能用于静态方法
             * 2>.代表当前对象的引用（谁调用代表谁）
             * 3>.既可以调用本类，也可以调用父类
             */
            // 访问父类的空参构造方法：因为子类会继承父类中的数据（可能还会使用父类数据），所以子类初始化之前必须完成父类的初始化
            // 必须放在第一条语句
            super(); // 调用父类的构造方法：如果不写系统默认加上
        }

        // 构造方法的重载：在同一个类中，方法名相同，参数列表不同，与返回值无关
        // 如果我们没有给出构造方法，系统会自动提供一个无参构造方法
        // 如果我们给出了构造方法，系统不会再提供默认的无参构造方法（如果需要使用有参构造方法必须自定义 - ！！！建议永远自定义无参构造方法！！！）
        public PackageObject(String name, SexType sex) {

        }

        // 5>.成员方法
        /*
        public
        abstract（抽象方法：没有方法体）
        static（类方法：只能处理类变量）
        final（无法被继承）
        修饰符 返回值类型 方法名(参数类型 参数名) {
            // 方法体
            return 返回值;
        }
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

        // 6>.代码块
        // a.概念：在java中，使用{}括起来的代码被称为代码块
        // b.分类：局部代码块、构造代码块、静态代码块、同步代码块
        // 局部代码块：出现在方法中，限定变量的生命周期，及时释放提高内存利用率
        {

        }
        // 构造代码块（初始化块）：出现在类中方法外，多个构造方法中重复代码存在在一起，每次调用构造方法直接执行
        {
            System.out.println("构造代码块");
        }
//        // 静态代码块：出现在类中方法外，static修饰，用于给类进行初始化，类加载的时候执行（优先于方法执行、只执行一次）
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
        @Override
        protected void finalize() throws Throwable {
            super.finalize();
        }
        // 5>.内存空间划分
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
        // 3>.创建一个对象的步骤：
        // a>.xxx.class加载进入内存（进入方法区、方法也在此处（对象指向方法））
        // b>.main压栈（声明"xxx类型对象"）
        // c>.堆内存创建对象（对象属性默认初始化值、有一块区域包含super属性）
        // d>.构造方法压栈（初始化对象属性）
        // e>.构造方法弹栈
        // f>.将对象的地址值赋值给"xxx类型对象"

    }
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

    // 26>.内部类
    // 1>.概念：在一个类或一个方法中定义的类，也称为嵌套类（声明这个内部类的类称为外部类）
    // 2>.作用
    // a.实现了类的重用功能：直接使用类，不需要使用对象
    // b.实现了多继承：一个类会继承该类内部类继承的类
    // c.封装性：可以把某些数据隐藏在内部类中
    // 3>.特点：内部类是外部类的一个类成员（内部类兼具成员方法和类的特性）、内部类的类名不能和外部类一样
    // 4>.外部类要访问内部类的成员必须创建对象（外部类名.内部类名 对象名 = new 外部类名.new 内部类名();）
    class PackageObjectInner {
        // 5>.成员内部类
        public int num = 10;
        private class Inner {
            // 内部类可以访问外部类的成员（包括private）
            public int num = 20;
            public void method() {
                int num = 30;
                System.out.println(num); // 30
                System.out.println(this.num); // 20
                // 内部类之所以可以获取到外部类的成员，是因为内部类可以获取到外部类的引用（外部类.this）
                System.out.println(PackageObjectInner.this.num); // 10
            }
        }
        // 成员内部类被私有外部不能调用，内部可以调用
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
        // 8>.匿名内部类（局部内部类的一种/内部类的简化写法）
        // 1>.前提：存在一个类或者接口（具体类、抽象类）
        // 2>.本质："继承该类/实现该接口的子类"匿名对象
        // 3>.应用：匿名内部类可以当做参数传递（将匿名内部类看作一个对象）
        public void showLog() {
            // ！！！匿名内部类调用多次方法的时候不使用，太麻烦！！！
        }
    }
    /**
     * // 创建内部类对象
     * 1>.普通内部类：外部类名.内部类名 对象名 = new 外部类名.new 内部类名()
     * InterDemo.Inner io = new InterDemo().new Inner();
     * 2>.静态内部类：外部类名.内部类名 对象名 = 外部类名.内部类对象
     * InterDemo.Innering io = new InterDemo.Innering();
     * 3>.局部内部类 - 只能在方法内部访问
     * MethodInner mi = new MethodInner();
     */

    // 27>.抽象类
    // 1.抽象类和抽象方法必须使用abstract修饰
    // 2.抽象类中不一定有抽象方法：可以有抽象方法，也可以有非抽象方法，有抽象方法的类一定是抽象类或者接口
    // 3.抽象类不能实例化：必须使用子类实例化（只能作为其他类的父类）
    // 4.抽象类的子类：要不必须是抽象类、要不必须实现抽象类中的所有抽象方法
    abstract class PackageObjectNess {
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
     */

    // 28>.接口：静态常量和抽象方法的集合、对外提供规则
    // 1.特点：仅仅描述了能够实现什么样的功能，具体实现则由实现该接口的类决定、一个类可以实现多个接口、一个接口可以被多个类实现
    // 2.功能：接口是java提供的一个用于实现多继承功能的机制
    // abstract默认省略：编译器自动添加
    interface PackageObjectCallback {
        // 1、常量定义
        // "public final static"编译器自动添加
        int MAX = 10;

        // 2、构造方法
        // 接口没有构造方法

        // 3、成员方法
        // 只能全部是抽象方法
        // "public abstract"编译器自动添加
        void getGame();
    }
    // 可以多继承：子接口默认继承父接口中所有的常量和抽象方法
    interface PackageObjectListener extends PackageObjectCallback {
        void showGame();
    }
    // 接口允许多继承
    interface PackageObjectLessCallback extends PackageObjectListener, PackageObjectCallback {

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
    class PackageObjectLess extends PackageObject implements PackageObjectCallback, PackageObjectListener {
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
        // b>.返回值必须与父类中原方法的值类型相同或原类型的子类
        // c>.访问权限可以扩大不能缩小，否则原来可以访问该方法的类可能就无法访问了
        // d>.不能重写被final修饰的方法
        // e>.静态方法不能被重写，但是可以在子类中定义相同的静态方法将父类的方法隐藏
        // f>.应用：子类需要父类的功能，也需要子类特有的功能，可以重写父类的方法
        // g>.注意事项：a.父类的私有方法不能被重写；b.子类重写父类方法访问权限不能更低（最好一致）；c.父类静态方法，子类也必须通过静态方法重写（不算重写）
        // h>.子类调用方法的顺序：先找子类本身 -> 再找父类
        @Override
        public String getDetails() {
            // super关键字：指向当前对象的父类（此处想要访问父类的方法必须使用super）
            // a>.用于在子类的构造方法中调用父类的构造方法
            // b>.用于在子类中显式的引用被隐藏的继承自父类的同名变量
            // c>.子类重写成员方法时，用super引用父类的相应方法实现对原有功能的扩充
            super.getDetails(); // 调用父类的成员方法
            super.score = 10; // 调用父类的数据成员
            return this.name + "：" + this.age;
        }

        // 多态
        // 前提：a.有继承关系、b.有方法重写、c.父类引用指向子类对象
        // 成员变量：编译看左边（父类），运行看左边（父类）
        // 成员方法：编译看左边（父类），运行看右边（子类）
        // 静态方法（与类相关，算不上重写）：编译看左边（父类），运行看左边（父类）
        public void showDetails() {
            PackageObjectLess p = (PackageObjectLess) new PackageObject(); // 父类引用指向子类对象（向上转型）
            System.out.println(p.name); // John
            p.getDetails();
            if (p instanceof PackageObject) {
                PackageObject sm = (PackageObject) p; // 向下转型
                sm.getDetails();
            }
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
             *  构造方法：有
             *  成员方法：只可以是抽象方法
             */
        }

        public synchronized void showGetDetails() {
            // 同一时间只能被一个线程访问
        }
    }

    // 29>.包：为了更好地组织类，Java提供了包机制，用于区别类名的命名空间
    // 1.概念：一组相关类和接口的集合（就是文件夹）
    // 2.特征：同一个包中的类不能同名，不同包中的类可以同名，这样就有效解决了命名冲突问题
    // 3.包声明：package 包名1.包名2.包名3
    // 4.包引用：import 包名1.包名2.包名3
    // 5.注意事项
    // package语句必须是可执行程序的第一行
    // package语句在Java文件中只能有一个
    // 如果没有package语句，默认表示无包名
    /**
     *  按照功能划分
     *  com.heima.add
     *      AddStudent
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

    // 30>.数据结构
    public void showPackageDataStructure() {
        // a>.Enumeration接口/Vector动态数组
        Vector<String> dayNames = new Vector<>();
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
        // b>.Stack栈：Vector的一个子类
        Stack<String> stack = new Stack<>();
        // 把对象压入堆栈顶部
        stack.push("Sunday");
        // 移除堆栈顶部对象
        String s = stack.pop();
    }

    // 31>.集合框架
    public void showPackageSet() {
        // a>.ArrayList：可以动态修改的数组
        ArrayList<String> siteNames = new ArrayList<>();
        // 添加元素
        siteNames.add("Google");
        siteNames.add("Taobao");
        siteNames.add("Runoob");
        siteNames.add("Weibo");
        // 访问元素
        if (siteNames.size() > 1) {
            System.out.println(siteNames.get(1));
        }
        // 修改元素
        siteNames.set(1, "Tencent");
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
        // 迭代器
        // 获取迭代器
        Iterator<String> iterator = siteNames.iterator();
        while (iterator.hasNext()) {
            System.out.println(iterator.next());
        }

        // b>.LinkedList：链表
        // 相比ArrayList：LinkedList的“添加、删除”操作效率更高；“查找、修改”操作效率更低
        LinkedList<String> siteNames1 = new LinkedList<>();
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

        // c>.HashSet：不允许有重复元素的集合
        // 1>.特点：无序、允许有null值、线程不安全
        HashSet<String> siteNames2 = new HashSet<>();
        // 添加元素
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

        // d>.HashMap：散列表，存储的内容是key-value映射
        // 1>.特点：无序、key-value的类型可以是String，也可以是Integer
        HashMap<String, String> map = new HashMap<>();
        HashMap<Integer, String> map1 = new HashMap<>();
        // 添加键值对
        map1.put(1, "Google");
        map1.put(2, "Taobao");
        map1.put(3, "Runoob");
        map1.put(4, "Weibo");
        map1.put(5, "Tencent");
        // 获取元素
        map1.get(3);
        // 删除元素
        map1.remove(1);
        // 清空
        map1.clear();
        // 遍历HashMap
        for (Integer index:
                map1.keySet()) {
            System.out.println(map1.get(index));
        }
        for (String value:
                map1.values()) {
            System.out.println(value);
        }
    }

    // 32>.多线程
    // 耗时的操作：大量占用cpu的任务
    // 第一种方式
    class MyThread extends Thread {
        @Override
        public void run() {
            super.run();
        }
    }
    // 第二种方式
    class YourThread implements Runnable {
        @Override
        public void run() {

        }
    }
    public void showThread() {
        // 创建一个子线程对象
        MyThread myThread = new MyThread();
        myThread.start();

        YourThread yourThread = new YourThread();
        Thread t1 = new Thread(yourThread);
        t1.start();
    }
    // 用户线程：在前台运行的线程
    // 守护线程：在后台运行的线程（周期性的执行某种任务、等待处理某些发生的事件）
    // 同步线程：多线程共享资源
    // “生产者/消费者”问题
    // 死锁

    // 33>.文件类
    public void showPackageFiles() {
        // 1>.创建文件对象
        File file = new File("path路径");
        File file1 = new File("path路径", "文件名/目录名");
        File file2 = new File(file1, "文件名/目录名");
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
        }
        if (file.isDirectory()) {
            // File对象表示的文件或目录是否是目录
        }
        if (file.isFile()) {
            // File对象表示的文件或目录是否是文件
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
        // 4>.目录操作
        file.mkdir(); // 创建File对象所表示的指定目录
        file.mkdirs(); // 创建File对象所表示的目录
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
            // 删除File对象表示的文件或目录（如果表示的是目录则该目录必须为空才可以删除）
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

    // 34>.输入输出流
    public void showPackageStream() {
        // 1>.流的概念
        // a、流：是指一组有顺序、有起点、有终点的数据集合（有方向/先进先出原则）
        // b、输入流：从连接到数据源的流中读取数据（只能读数据，不能写数据）
        // c、输出流：从连接到目的地的流向其写数据（只能写数据，不能读数据）
        // 2>.流的分类
        // a、按照流处理的数据类型不同：
        // 字节流：以字节为单位读写数据
        // 字符流：以字符为单位读写数据
        // 字节流限于处理8位字节
        // InputStream字节输入流/OutputStream字节输出流：
        // 1>.是所有字节输入流和字节输出流的顶层父类，都是抽象类，不能实例化
        // 字符流可以处理Unicode字符集中所有的字符（读取文本类型数据）
        // Reader字符输入流和Writer字符输出流
        // 1>.是所有字节输入流和字节输出流的顶层父类，都是抽象类，不能实例化
        // 3>.文件流
        // a、文件字节流
        File file = new File("path路径");
        try {
            // 文件输入字节流
            // 需要处理两个异常：FileNotFoundException/IOException
            FileInputStream fis = new FileInputStream("文件名"); // 使用给定的文件名创建对象
            FileInputStream fis1 = new FileInputStream(file); // 使用File对象创建对象
            fis.read(); // FileInputStream是顺序读取文件：只要流不关闭，每次调用read方法就顺序的读取数据，直到文件末尾或流被关闭
            fis.close(); // 关闭输入流
            // 文件输出字节流
            // 需要处理一个异常：IOException
            FileOutputStream fos = new FileOutputStream("文件名"); // 使用给定的文件名创建对象
            FileOutputStream fos1 = new FileOutputStream(file); // 使用File对象创建对象
            fos.write(1); // FileOutputStream是顺序向文件写数据：只要流不关闭，每次调用write方法就顺序的向文件写内容，直到流被关闭
            fos.close(); // 关闭输出流
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // b、文件字符流（读写的数据单元不同）
        try {
            // 文件输入字符流
            FileReader fileReader = new FileReader("文件名"); // 使用给定的文件名创建对象
            FileReader FileReader1 = new FileReader(file); // 使用File对象创建对象
            fileReader.read();
            fileReader.close();
            // 文件输出字符流
            FileWriter fileWriter = new FileWriter("文件名"); // 使用给定的文件名创建对象
            FileWriter fileWriter1 = new FileWriter(file); // 使用File对象创建对象
            fileWriter.write(1);
            fileWriter.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 4>.缓冲流
        // a、概念：增加了内部缓冲区的流
        // b、特征：提高I/O的执行效率
        // 1>.当缓冲流执行输出操作时，并不马上将数据写到所连接的输出流中，而是写入缓冲区，当缓冲区写满或关闭流的时候再一次性将缓冲区中数据写入输出流中，这样可以减少实际写请求的次数，提高将数据写入文件的效率
        // 2>.当缓冲流执行输入操作时，并不从输入流读取数据，而是从缓冲区中读取数据，当缓冲区中数据读完后，才从输入流中读取成批数据存入缓冲区，这样可以提高读数据的效率
        // c、字节缓冲流
        try {
            // 字节缓冲输入流
            FileInputStream fis = new FileInputStream("文件名");
            BufferedInputStream bis = new BufferedInputStream(fis);
            BufferedInputStream bis1 = new BufferedInputStream(fis, 20);
            bis.read();
            bis.close();
            // 字节缓冲输出流
            FileOutputStream fos = new FileOutputStream("文件名");
            BufferedOutputStream bos = new BufferedOutputStream(fos);
            BufferedOutputStream bos1 = new BufferedOutputStream(fos, 20);
            bos.write(1);
            bos.flush(); // 刷新输出流：将缓冲区中的数据强制写入输出流
            bos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // d、字符缓冲流
        try {
            // 文件输入字符流
            FileReader fileReader = new FileReader("文件名");
            BufferedReader bufferedReader = new BufferedReader(fileReader);
            BufferedReader bufferedReader1 = new BufferedReader(fileReader, 20);
            bufferedReader.read();
            bufferedReader.readLine(); // 读取一个文本行，不包含任何行终止符（遇到\n、\r、\t等认为本行结束，到达流末尾则返回null）
            bufferedReader.close();
            // 文件输出字符流
            FileWriter fileWriter = new FileWriter("文件名");
            BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
            BufferedWriter bufferedWriter1 = new BufferedWriter(fileWriter, 20);
            bufferedWriter.write(1);
            bufferedWriter.flush();
            bufferedWriter.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 5>.随机存储文件类
        // a、引入原因：输入输出流都是顺序访问流（流中的数据必须按照顺序进行读写），而随机存取文件类可以实现对文件的随机读写操作
        try {
            // 如果文件不存在则创建该文件
            // r - 以只读方式打开文件
            // rw - 以读写方式打开文件
            RandomAccessFile raf = new RandomAccessFile("文件名", "rw");
            long startOff = raf.getFilePointer(); // 获取文件的初始文件位置
            raf.writeDouble(2.4);
            raf.seek(startOff); // 设置文件的指针为文件的开始位置
            raf.close(); // 关闭流
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 6>.标准流
        // 标准输入流/标准输出流/标准错误流
        // 7>.字节流和字符流之间的转换
        try {
            // 字节输入流 -> 字符输入流
            InputStreamReader isr = new InputStreamReader(System.in);
            BufferedReader bufferedReader = new BufferedReader(isr);
            // 字节输出流 -> 字符输出流
            OutputStreamWriter osw = new OutputStreamWriter(System.out);
            BufferedWriter bufferedWriter = new BufferedWriter(osw);
            isr.close();
            bufferedReader.close();
            osw.close();
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        // 8>.管道流：xxx
    }

    // 35>.泛型
    public void showPackageCollections() {
        // E - Element元素
        // K - Key键
        // N - Number数
        // T - Type类型
        // V - Value值
        // 如果没有泛型：任何对象被添加到集合中都会转换成Object类型，然后取出来则需要再次强制转换成原有类型
    }

    // 36>.Annotation注解

    // 37>.Java Reflection反射机制
}