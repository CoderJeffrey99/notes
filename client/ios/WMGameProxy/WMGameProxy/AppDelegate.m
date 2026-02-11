//
//  AppDelegate.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

#import "AppDelegate.h"
#import "WMComponentController.h"
#import "WMGameProxy.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

// SceneDelegate
// https://blog.csdn.net/weixin_38735568/article/details/101266408
#pragma mark - App默认代理
// 程序开始启动1 - 5
// 程序进入后台2 - 3
// 程序进入前台4 - 5
// 程序杀死2 - 3 - 6
// 这些方法都可以通过[UIApplication sharedApplication]手动调用
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 1.应用程序启动完毕
    // 1>.需要主动的请求授权才可以发送本地通知
    // 该方法一般放在AppDelegate.h中（表示程序一启动就主动请求授权）
    if (@available(iOS 8.0, *)) {
        // iOS8.0以后可以设置推送通知带操作的行为
        // 创建一组操作行为
        UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
        // 设置组标识
        category.identifier = @"select";
        // 设置组的操作行为
        UIMutableUserNotificationAction *actionA = [[UIMutableUserNotificationAction alloc]init];
        actionA.identifier = @"A";
        actionA.title = @"同意";
        UIMutableUserNotificationAction *actionB = [[UIMutableUserNotificationAction alloc]init];
        actionB.identifier = @"B";
        actionB.title = @"撤回";
        NSArray *array = @[actionA, actionB];
        /*
         UIUserNotificationActionContextDefault代表最多可以显示4个
         UIUserNotificationActionContextMinimal代表最多可以显示2个
         */
        [category setActions:array forContext:UIUserNotificationActionContextDefault];
        NSSet *categories = [NSSet setWithObject:category];
        UIUserNotificationSettings *set = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:categories];
        [[UIApplication sharedApplication] registerUserNotificationSettings:set];
    }
    // 2>.说明用户点击了本地通知启动的App
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        // 在这里需要做一些操作
        
    }
    // 3>.程序启动时首先调用该方法
    // [[UIScreen mainScreen] bounds]只能使用该方法获取设备尺寸
    // 键盘、状态栏其实都是window
    // 问题：iOS9.0以后，如果添加多个窗口，控制器会自动把状态栏隐藏
    // 解决办法：把状态栏交给应用程序管理（info.plist里面操作）
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = UIColor.whiteColor;
    // UIWindow有3个级别：UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal（默认）
    // 会遮挡状态栏
    self.window.windowLevel = UIWindowLevelStatusBar;
    
    // 原理：底层调用“[navigationController pushViewController:[[WMComponentController alloc]init] animated:true];”
    // 验证：不允许Pushing the same view controller instance more than once is not supported
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:[[WMComponentController alloc]init]];
    // 当前UIWindow的根视图控制器rootViewController
    self.window.rootViewController = navigationController;
    
//    // 通过UIStoryboard加载程序
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"main" bundle:nil];
//    // 加载箭头指向的UIStoryboard
//    self.window.rootViewController = [sb instantiateInitialViewController];
//    // 加载指定UIStoryboard
//    self.window.rootViewController = [sb instantiateViewControllerWithIdentifier:@"main"];
//    // ？？？通过Segue实现页面的跳转？？？
    
//    // 通过xib加载程序（必须将xib和controller进行绑定）
//    // 1>.如果指定特定名称的xib则会加载指定的xib
//    XibViewController *vc = [[XibViewController alloc] initWithNibName:@"xib名称" bundle:nil];
//    // 2>.如果没有指定特定名称的xib：首先会去加载当前控制器相同名称的xib，如果没有则去加载当前控制器名称相近的xib(名称去掉controller)
//    XibViewController *vc = [[XibViewController alloc] initWithNibName:nil bundle:nil];
//    // 3>.底层自动调用“initWithNibName”
//    // 由于没有指定xib名称：首先会去加载当前控制器相同名称的xib，如果没有则去加载当前控制器名称相近的xib(名称去掉controller)
//    // 先去加载XibViewController.xib，再去加载XibView.xib
//    XibViewController *vc = [[XibViewController alloc]init];
    
    // 如果此处添加btn则此时controller.view还没有添加
    // 开始创建的view不是透明的（不然无法处理事件）、但是view的颜色可以设置透明（可以处理事件）
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.window addSubview:btn];
    
    // 显示UIWindow
    // 1.让当前self.window设置成当前App主窗口：这样在别的控制器就可以通过“[UIApplication sharedApplication].keyWindow”取到
    // 2.让窗口显示（self.window.hidden = NO;）
    // 3.让"rootViewController的view"添加到当前App主窗口（[self.window addsubView:rootViewController.view]）
    [self.window makeKeyAndVisible];
    
//    // WMGameProxy借用地盘
//    /**
//     [WMGameProxy alloc] - 堆内存开辟存储空间并返回对象地址/类方法
//     [wm init] - 初始化对象属性并返回对象地址/对象方法
//     wm - 指针变量wm接收返回对象地址
//     */
//    /*
//     1.创建对象返回的地址就是类的第零个属性的地址
//     2.类的第零个属性就是isa属性
//     */
//    WMGameProxy *wm = [[WMGameProxy alloc]init];
//    [wm performSelector:@selector(test)]; // oc没有真正的私有（使用该方法可以访问私有方法）
//    /*
//     不推荐使用new
//     1.为WMGameProxy类创建出来的对象分配存储空间 + alloc()方法/1.开辟存储空间；2.将所有属性设置为0
//     2.初始化WMGameProxy类创建出来的对象的属性 + init()方法/1.初始化成员变量（默认情况下什么都没做）；2.返回初始化后的实例对象地址
//     3.返回WMGameProxy类创建出来的对象对应的地址
//     */
//    WMGameProxy *wm = [WMGameProxy new];
//    wm.sdk = @"sdk"; // 不推荐直接赋值
//    /// "调用方法"在OC中叫做"发送消息"
//    // ？？？OC中调用方法的原理？？？
//    [wm setSdk:@"sdk"];
//    NSString *sdk = wm.sdk; // 点语法就是调用“setter/getter方法”
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // 2.App即将进入非活动状态：从前台切换到后台，比如“来电话了”
    // 该期间App不接收消息和事件（不可交互）
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 3.App已经进入后台（比如按home键）
    // 此处可以设置后台继续运行（保存应用程序的数据）
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 4.App即将进入前台（恢复应用程序的数据）
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 5.App进入活动状态：从后台切换到前台
    // 能否与用户进行交互
    // 需要在这里清除图标右上角的数字
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // 6.App将要退出调用（如果应用程序处于挂起状态的时候无法调用该方法）
    // 保存数据、清理缓存
}


- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    // 7.App接收到内存警告
    // 清理缓存：释放不需要的内存
    // 内存警告2次你还没有操作会闪退
}


#pragma mark -设置App支持的屏幕方向
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    // 如果这里设置了就以这里为准，如果这里没有设置以info.plist为准
    // https://www.jianshu.com/p/b061b4341afb
    // https://www.jianshu.com/p/aa6b22c289ad
    return UIInterfaceOrientationMaskPortrait;
    /*
     1、默认情况下，所有的页面只支持竖屏
     2、特定页面（播放视频页面media_VC）支持旋转：设备是什么方向页面就是什么方向
     3、点击特定按钮回到竖屏/横屏
     4、点击特定按钮设备不旋转
     */
}


#pragma mark -恢复处理程序
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void (^)(NSArray<id<UIUserActivityRestoring>> * _Nullable))restorationHandler {
    // 应用程序处理了程序
    return YES;
}


#pragma mark -push
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    /*
     接收到本地通知：满足以下条件就会调用
     1>.应用程序在前台
     2>.应用程序从后台进入到前台（锁屏）
     */
    // App完全退出，App收到通知，点击通知再进入App不会调用该方法
    // 此处需要监听点击必须借助“- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions”方法
    NSLog(@"接收到本地通知");
    switch ([UIApplication sharedApplication].applicationState) {
        case UIApplicationStateActive: {
            // 应用程序在前台
        }
            break;
        case UIApplicationStateInactive: {
            // 应用程序从后台进入前台
        }
            break;
        case UIApplicationStateBackground: {
            // 应用程序在后台
        }
            break;
    }
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)(void))completionHandler {
    // 如果实现下面的方法则不在执行该方法
}

- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification withResponseInfo:(NSDictionary *)responseInfo completionHandler:(void (^)(void))completionHandler {
    // 如果实现该方法则不在执行上面的方法
}

// 当请求完毕以后会调用该方法把获取的deviceToken返回给我们
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // deviceToken上传到“设备服务器”
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    /*
     接收到远程通知：满足以下条件就会调用
     1>.应用程序在前台
     2>.应用程序从后台进入到前台（锁屏）
     */
    // App完全退出，App收到通知，点击通知再进入App不会调用该方法
    // 此处需要监听点击必须借助“- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions”方法
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    // 如果实现该方法则不在执行上面的方法（App完全退出，App收到通知，点击通知再进入App也会调用该方法）
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    // 注册推送服务失败
}


#pragma mark - 应用间跳转
// iOS9.x以上
// 当别的App通过URL打开该App的时候调用该方法
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    /*
     ？？？怎么把url传给别的控制器？？？
     */
    // 当别的App通过URL打开该App的时候调用该方法
    if ([url.host containsString:@"friend"]) {
        NSLog(@"跳转到好友列表页面");
    }
    if ([url.host containsString:@"pengyouquan"]) {
        NSLog(@"跳转到朋友圈页面");
    }
    return YES;
}
// iOS9.x以下
// 当别的App通过URL打开该App的时候调用该方法
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url API_DEPRECATED_WITH_REPLACEMENT("application:openURL:options:", ios(2.0, 9.0)) API_UNAVAILABLE(tvos) {
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(nullable NSString *)sourceApplication annotation:(id)annotation API_DEPRECATED_WITH_REPLACEMENT("application:openURL:options:", ios(4.2, 9.0)) API_UNAVAILABLE(tvos) {
    return YES;
}

@end
