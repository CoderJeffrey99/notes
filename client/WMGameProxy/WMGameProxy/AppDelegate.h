//
//  AppDelegate.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

/*
 1.UIWindow：https://www.jianshu.com/p/1b201061a0a5
 1>.UIWindow是一种特殊的UIView
 2>.每个App至少一个UIWindow：一般只创建一个、没有UIWindow就看不见任何UI界面
 3>.启动原理：iOS程序启动完毕以后创建的第一个视图控件就是UIWindow -> 接着创建控制器的view加到UIWindow
 4>.keyWindow：用来管理键盘以及非触摸类的消息，只能有一个（多scene可以有多个）
 5>.UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
 */
@property (strong, nonatomic) UIWindow *window;

/*
 2.设置启动图的方式（LaunchScreen原理）
 https://www.jianshu.com/p/a0f53f66ccbe
 1>.使用LaunchScreen.storyboard（优先级高）
 2>.使用LaunchImage（已废弃）
 */
// iOS13新特性 - https://mp.weixin.qq.com/s/ynkun7E1niuXfnnNBRap8Q
// iOS中这些牛逼的实用技巧 - https://www.jianshu.com/p/9374a006c87e

/*
 3.info.plist简介
 1>.作用：设置应用程序的配置信息（本身是一个dict）
 2>.Bundle name - 应用程序名称
 3>.Bundle identifier - 应用程序唯一标识（包名）
 4>.Bundle version string (short) - 上架版本号：必须从v1.0开始，下一个版本号必须大于上一个版本号
 5>.Bundle version - 打包版本号
 */
@end

