//
//  WMNetworkViewController.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/18.
//  Copyright © 2020 zali. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 1.为什么要学习网络编程：https://www.jianshu.com/p/9017e6649228
// 1>.原因：几乎所有的App都需要用到网络
// 2>.移动网络应用 = 良好的UI + 良好的用户体验 + 实时数据更新

// 2.网络基础概念
// 1>.Client客户端：移动应用/iOS、Android应用
// 2>.Server服务端：为客户端提供服务、数据和资源
// 3>.Request请求：客户端向服务端索取数据的一种行为
// 4>.Response响应：服务端对客户端请求的反应

/*
 // 3.服务器
 1>.远程服务器（外网服务器、正式服务器）
 使用阶段：应用上线后使用的服务器
 适用人群：全体用户
 速度：取决于服务器性能和用户的网速
 2>.本地服务器（内网服务器、测试服务器）
 使用阶段：应用开发、测试阶段使用的服务器
 适用人群：公司内部开发人员和测试人员
 速度：由于是局域网（网速很快，有助于提高开发测试效率）
 */

// 4.客户端和服务器交互
// 1>.如何找到服务器：客户端通过URL找到想要连接的服务器
// 2>.统一资源定位符URL：俗称“网址”、在互联网上每个资源都是唯一的URL、协议://主机ip地址+端口号+资源
//使用利于记忆的符号来代替IP地址
//https://www.520it.com.img.logo.png
//https://202.108.22.5/img/bdlogo.gif
// 3>.URL中常见的协议
// a、http协议：超文本传输协议、规定客户端和服务端之间的数据传输格式、交互方法GET|POST|PUT|DELETE
// b、file协议：本地文件传输协议、访问本地计算机上的资源
// c、ftp协议：文件传输协议、访问共享主机的文件资源
// 4>.http协议的特点（为什么选择http协议）
// a、简单快捷、灵活（http协议允许传输各种各样的数据）
// 5>.发送http请求的方法
// a、GET查/POST改/OPTIONS/HEAD/PUT增/DELETE删/TRACE/CONNECT/PATCH

// 5.http通信过程
/*
 1.http协议详解
 1>.概念：http是一个属于应用层的面向对象的协议，由于其简捷、快速的方式适用于超媒体信息系统
 2>.特点：http是一个基于请求与响应模式的、无状态的应用层协议（基于tcp的连接方式）
 a.支持C/S模式
 b.无连接：服务器处理完客户的请求，并收到客户的应答后，即断开连接
 c.无状态：对于事务处理没有记忆能力
 */
// 2.请求
// a、请求头（对客户端的环境描述、客户端请求信息）
// Host：服务器主机地址
// User-Agent：客户端类型
// Accept：客户端可以接收的数据类型
// Accept-Language：客户端语言环境
// Accept-Encoding：客户端支持的数据压缩格式
// b、请求体（客户端发给服务器的具体数据、get请求没有请求体）
// 2>.响应
// a、响应头（对服务器的描述、对返回数据的描述）
// Server：服务器类型
// Content-Type：返回数据的类型
// Content-Length：返回数据的长度
// Date：响应的时间
// b、响应体（服务器返回给客户端的具体数据）
// 3.常用响应码状态
// a、200 - 请求成功
// b、400 - 服务端无法解析Bad Request/客户端请求的语法错误
// c、404 - 服务器无法通过客户端的请求找到资源NotFound
// d、500 - 无法完成请求Internal Server Error/服务器内部错误

/*
 // 6.https通信
 // 1>.概念：以安全为目标的http通道（https = http + ssl安全套接字层）
 2>.https和http的区别
 a、https协议需要到CA申请证书（一般免费证书很少，需要缴费）
 b、http是超文本传输协议，信息是明文传递；https则是具有安全性的ssl加密传输协议
 c、https和http使用的是完全不同的连接方式，用的端口也不一样
 d、http协议的连接是无状态的，https协议是由SSL+HTTP协议构建的可进行加密传输、身份认证的网络协议，比http协议安全
 */
// https使用哪一种加密方式？详细描述一下https加密的两个阶段（非对称加密和对称加密）

/*
 7.断点续传
 // 原理
 https://www.cnblogs.com/wangzehuaw/p/5610851.html
 https://www.cnblogs.com/findumars/p/5745345.html
 // 实现
 https://www.jianshu.com/p/0e6deea7de87
 https://www.jianshu.com/p/01390c7a4957
 https://blog.csdn.net/stree7cleaner/article/details/51440774
 https://blog.csdn.net/lcg910978041/article/details/51487485
 */
// http协议如何支持断点续传功能？
@interface WMNetworkViewController : UIViewController

@end

NS_ASSUME_NONNULL_END

