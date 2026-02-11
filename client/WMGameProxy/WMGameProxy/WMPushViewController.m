//
//  WMPushViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/17.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMPushViewController.h"
#import <CoreMotion/CoreMotion.h>
#import <Social/Social.h>

@interface WMPushViewController ()

@end

@implementation WMPushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     1.推送通知：向用户发送一条消息来通知用户某件事情
     1>.NSNotification是抽象的一种模式，推送通知是可见的（有界面展示）
     2>.推送通知可以在“App退到后台、App关闭”的时候继续发送消息告诉用户某件事情
     */

    /*
     2.推送应用场景
     1>.一些任务管理App会在任务时间即将到达的时候通知你做该任务（健身App提醒你该健身、电影类App提醒电影即将开场）
     2>.当QQ和微信收到消息时即使退到后台或者关闭App都可以收到信息通知
     */

    /*
     3.推送分类：能够确定推送的时间点使用“本地推送”，不能确定推送时间点使用"远程推送"
     1>.本地推送
     a、特征：不用联网也可以推送通知消息
     b、通知发送方：开发人员负责在App内发送（App -> 当前设备）
     c、应用场景：确定在未来某个时间点应该提醒用户做什么
     2>.远程推送
     a、特征：必须在联网情况下才会向用户推送通知消息
     b、通知发送方：服务器通过"APNs：Apple Push Notification Service/苹果远程推送服务"发送（App服务端 -> APNs服务器 -> 设备）
     c、应用场景：App给用户发信息
     */

    /*
     4.推送通知的呈现效果设置：由用户自行设置（设置 - 通知中心）、开发人员无法由代码确认
     a、在屏幕顶部显示一块横幅（显示具体内容）
     b、在屏幕中间弹出UIAlertView（显示具体内容）
     c、在锁屏界面显示一块横幅（锁屏状态下，显示具体内容）
     d、更新app图标的数字（说明新内容的数量）
     e、播放音效（提醒作用）
     // 发送推送通知时，如果“当前程序正运行在前台”，那么推送通知就不会被呈现出来
     // 点击推送通知后，系统默认会自动打开发送推送通知的app
     */
}

#pragma mark - 本地通知
// 发送通知
-(void)sendNotification {
    // 需要主动的请求授权才可以发送本地通知
    // 该方法一般放在AppDelegate.h 中（表示程序一启动就主动请求授权）
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
    if (@available(iOS 10.0, *)) {
        // http://t.zoukankan.com/xianfeng-zhang-p-8310394.html
    } else {
        // 1.创建本地通知
        UILocalNotification *notice = [[UILocalNotification alloc]init];
        // 设置本地通知内容（必选项）
        notice.alertBody = @"顺子要不要";
        // 设置本地通知的发送时间
        notice.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];
        // 设置本地通知的时区
        notice.timeZone = [NSTimeZone systemTimeZone];
        // 设置重复周期
        notice.repeatInterval = NSCalendarUnitMinute;
        // 设置锁屏滑动文字
        notice.hasAction = YES;
        notice.alertAction = @"回复";
        // 启动图片/直接填写图片名称
        notice.alertLaunchImage = @"DOVE.png";
        // 设置通知弹窗的标题
        // 只对“通知中心”有效
        notice.alertTitle = @"斗地主";
        // 设置通知的声音
        notice.soundName = @"win.mp3";
        // 设置图标右上角的数字
        notice.applicationIconBadgeNumber = 10;
        // 设置本地通知的标识
        // 取消push操作的时候可以根据userInfo找到需要取消的推送
        notice.userInfo = nil;
        // 2.发送本地通知
        [[UIApplication sharedApplication] scheduleLocalNotification:notice];
    }
    // 查看所有通知
    NSLog(@"%@", [[UIApplication sharedApplication] scheduledLocalNotifications]);
    // 取消通知
    for (UILocalNotification *notification in [[UIApplication sharedApplication] scheduledLocalNotifications]) {
        [[UIApplication sharedApplication] cancelLocalNotification:notification];
    }
}
// 取消发送
-(void)cancelNotification {
    // 取消所有的计划通知
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


#pragma mark - 远程通知
/*
 简述一下远程推送的流程？远程推送怎么识别deviceToken？哪一步需要使用push证书？
 // 简述一下远程推送的流程？：APNS推送消息无法保证100%到达
 1.应用程序把要‘发送的消息’和‘目的ios设备标识’打包发给APNS（Apple Push Notification Service苹果推送服务器）
 2.APNS在自身已注册push服务的ios设备列表中查找相应标识的ios设备
 3.ios设备把发来的消息传递给相应的应用程序，并且按照设定弹出push通知
 // 哪一步需要使用push证书？
 第3步
 */
-(void)remotePush {
    // 1>.什么是远程推送
    // a、概念：从远程服务器推送给客户端的通知（需要联网），又称为APNs
    
    // 2>.为什么需要远程推送通知
    // a、传统获取数据的局限性（只要关闭app就无法与app服务器沟通获取数据）
    // b、无论用户打开还是关闭app只要联网都可以收到服务器推送的通知（所有苹果设别只要在联网状态下都会与苹果的服务器建立长链接）
    
    // 3>.什么是长链接
    // a、概念：只要是联网状态就一直建立链接（客户端 <-----> 服务器）
    // b、作用：时间校准、系统升级
    // c、好处：数据传输速度快、数据保持最新状态
    
    // 4>.推送步骤
    // 第一阶段
    // a、“设备A”发送“设备的UDID”和应用的“Bundle Identifier”给“APNs服务器”
    // b、“APNs服务器”经过加密生成deviceToken返回给“设备A”
    // c、“设备A”将“deviceToken和用户标识”上传到“设备服务器”保存
    // 第二阶段（如果“设备服务器”和“设备A”之间存在长链接就可以不经过APNs直接发送消息）
    // a、“设备B”发送消息给“设备A”
    // b、通过“设备A”的用户标识找到“设备A”的deviceToken
    // c、“设备服务器”将“设备A的deviceToken“和消息给到“APNs服务器”
    // d、“APNs服务器”通过deviceToken找到“设备A”
    
    // 5>.极光推送
    // https://docs.jiguang.cn/jpush/quickstart/iOS_quick
}


#pragma mark - 传感器
// 1.概述
// 1>.什么是传感器：传感器是一种“感应/检测”装置
// 2>.作用：用于“感应/检测”设备周边的信息
// 3>.特点：不同类型的传感器检测的信息也不一样
// 4>.iphone内置传感器：运动传感器、环境光传感器、距离传感器、磁力传感器、内部温度传感器、湿度传感器、陀螺仪
// a、环境光传感器：感应周边环境光线的强弱（自动调节屏幕亮度）、无api
// b、距离传感器：感应是否有其它物体靠近设备屏幕（打电话自动锁屏）、有api
// c、磁力传感器：感应周边的磁场（合盖锁屏）、不讲
// d、内部温度传感器：感应设备内部的温度（提醒用户降温，防止损伤设备）、无api
// e、湿度传感器：感应设备是否进水（方便维修人员）、无api
// f、陀螺仪：感应设备的持握方式（赛车类游戏）、不讲
// g、加速计：感应设备的运动（摇一摇、计步器）、有api
// 2.距离传感器
-(void)rangeSensor {
    // 1>.开启距离传感器功能
    UIDevice.currentDevice.proximityMonitoringEnabled = YES;
    // 2>.监听物体靠近/离开设备的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statuChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
}
-(void)statuChange {
    if (UIDevice.currentDevice.proximityState) {
        // 有物体靠近
    } else {
        // 有物理离开
    }
}
// 3.加速计
-(void)accelerometer {
    // 1>.创建运动管理者对象
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    // 2>.判断当前加速计时候可用
    if (![manager isAccelerometerAvailable]) {
        // 加速计不可用
        return;
    }
    // 3>.设置采样间隔
    manager.accelerometerUpdateInterval = 1.0 / 2;
    // 4>.开始采集
//    // pull（外界自己获取）
//    // manager.accelerometerData.acceleration.x
//    [manager startAccelerometerUpdates];
    // push（把数据主动告诉外界）
    [manager startAccelerometerUpdatesToQueue:NSOperationQueue.mainQueue withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"--%lf--", accelerometerData.acceleration.x);
        }
    }];
}
// 4.摇一摇
-(void)showShake {
    // 方法一、通过分析加速计数据来判断是否进行了摇一摇操作（比较复杂）
}
// 方法二、iOS自带的Shake监控api（比较简单）
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // 摇一摇开始
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // 摇一摇结束
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // 摇一摇取消
}
// 5.计步器
-(void)showStep {
    if (![CMPedometer isStepCountingAvailable]) {
        // 计步器不可用
        return;
    }
    
    CMPedometer *pedometer = [[CMPedometer alloc] init];
    [pedometer startPedometerUpdatesFromDate:[NSDate dateWithTimeIntervalSinceNow:0] withHandler:^(CMPedometerData * _Nullable pedometerData, NSError * _Nullable error) {
        if (error == nil) {
//            pedometerData.numberOfSteps // 走了多少步
//            pedometerData.distance // 走了多远
//            pedometerData.floorsAscended // 上楼层数
//            pedometerData.floorsDescended // 下楼层数
        }
    }];
    
}
// 6.UIDynamic
-(void)showDynamic {
    // 1>.概述：iOS7.x引入，可以认为是一种物理引擎。能够模拟和仿真现实世界中的物理现象（重力、弹性碰撞）
    // 2>.提供多种仿真行为（继承自UIDynamicBehavior）：UIGravityBehavior重力行为、UICollisionBehavior碰撞行为、UISnapBehavior捕捉行为、UIPushBehavior推动行为
    // 3>.UIGravityBehavior重力行为
    // 创建物理仿真器
    UIDynamicAnimator *animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // 仿真行为
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[self.view]];
    // 设置重力行为的方向（速度）
//    gravityBehavior.gravityDirection = CGVectorMake(10, 10);
    gravityBehavior.angle = (CGFloat)M_PI;
    // 把仿真行为添加到仿真器里面
    [animator addBehavior:gravityBehavior];
}


#pragma mark - 应用间跳转
/*
 1.应用间跳转/scheme(skim/协议)
 0>.https://blog.csdn.net/cc1991_/article/details/79050275
 1>.如果想要跳转到不同的App：1.定义需要跳转到的App的“scheme”/2.打开对应App的“scheme”
 2>.应用间跳转代表进程之间可以通信（线程之间也可以通信）
 */
-(void)setupJump {
    /*
     1>.URL的组成
     http://www.520it.com/query?name=sz&age=18
     scheme协议 - http
     host主机名 - www.520it.com
     path路径 - /query
     query查询 - name=sz&age=18
     */
    NSURL *url = [NSURL URLWithString:@"http://www.520it.com/query?name=sz&age=18"];
    NSLog(@"协议 = %@/ 主机名 = %@/ 资源路径 = %@/ 请求参数 = %@", url.scheme, url.host, url.path, url.query);
    /*
     2.应用间跳转：从"应用A -> 应用B"
     1>.先在“应用B”设置“scheme协议”（注意不要加上"://"）
     2>.iOS9.0以后：再在“应用A”上添加白名单/info.plist -> LSApplicationQueriesSchemes（注意不要加上"://"）
     3>.写代码实现跳转
     注意：如果在同一个设备上scheme定义一样则无法确定到底打开哪一个App
     */
    // winxin://
    NSURL *schemeUrl = [NSURL URLWithString:@"scheme协议://"];
    if ([[UIApplication sharedApplication] canOpenURL:schemeUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:schemeUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] canOpenURL:schemeUrl];
        }
    } else {
        NSLog(@"尚未安装App");
    }
    /*
     3.应用跳转到指定页面
     1>.在“2”的基础上添加一个标识 -> 根据标识在“AppDelegate回调”中自行处理
     2>.详情见"AppDelegate.m"应用间跳转
     */
    NSURL *pUrl = [NSURL URLWithString:@"scheme协议://pengyouquan"];
    if ([[UIApplication sharedApplication] canOpenURL:pUrl]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:pUrl options:@{} completionHandler:^(BOOL success) {
                
            }];
        } else {
            [[UIApplication sharedApplication] canOpenURL:pUrl];
        }
    } else {
        NSLog(@"尚未安装App");
    }
    // 4.跳转回原App：给原App也设置一个scheme然后执行跳转逻辑
    
    // 4.打电话、发短信、发邮件
    // 1>.打电话
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://15601749931"]];
    // 2>.发短信
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://15601749931"]];
    // 3>.发邮件
}


#pragma mark - 社交分享
/*
 2.社交分享
 // 对于系统自带的分享
 a、如果是分享到短信、邮箱，需要导入MessageUI.framework,然后创建分享
 b、如果是分享到新浪微博、腾讯微博，需要导入Social.framework，然后分享创建
 c、优点：不需要集成第三方库，不需要App Key
 d、缺点：页面简单，不能自定制
 https://blog.csdn.net/qq_28009573/article/details/77744001
 //对于第三方分享
 a、友盟分享：对于不同平台需要分别注册
 b、shareSDK（支持Android和iOS）
 https://www.cnblogs.com/xubojoy/p/3885932.html
 */
-(void)systemShared {
    /*
     SLServiceTypeTwitter
     SLServiceTypeFacebook
     SLServiceTypeSinaWeibo
     SLServiceTypeTencentWeibo
     SLServiceTypeLinkedIn
     */
    // 1>.判断用户是否有绑定账号密码
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeSinaWeibo]) {
        // 2>.弹出一个分享窗口，让用户开始输入内容（无法定制UI）
        SLComposeViewController *vc = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeSinaWeibo];
        [vc setInitialText:@"设置默认分享的内容"];
        [vc addImage:[UIImage imageNamed:@"xxx.png"]];
        // 监听分享状态
        vc.completionHandler = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultDone: {
                    // 分享完成
                }
                    break;
                case SLComposeViewControllerResultCancelled: {
                    // 分享取消
                }
                    break;
                default:
                    break;
            }
        };
        [self presentViewController:vc animated:YES completion:nil];
    } else {
        // 请输入对应的账号和密码（必须在“设置”中输入账号密码才可以拉起来分享）
    }
}


#pragma mark - 第三方登录
/*
 3.第三方登录：基于OAuth2.0协议构建的OAuth2.0授权登录系统
 // 1>.利用用户在第三方平台上已有的账号来快速完成自己应用的登录或注册的功能
 // 2>.微信登录：只提供原生登录方式(必须安装客户端)，所有使用之前必须判断
 https://www.cnblogs.com/sunfuyou/p/7843612.html
 // 3>.QQ登录
 https://blog.csdn.net/alexander_wei/article/details/72626396
 https://www.jianshu.com/p/133d84042483
 // 4>.微博登录
 https://blog.csdn.net/zhonggaorong/article/details/51724810
 https://blog.csdn.net/u010545480/article/details/53004699
 https://www.jianshu.com/p/87d1d397d269
 */


#pragma mark - 应用统计
// 4.应用统计
// 1>.友盟统计：https://www.umeng.com


#pragma mark - 三方支付
- (void)showThirdPay {
    /*
     //内购
     https://blog.csdn.net/xiaoxiangzhu660810/article/details/17434907#0-qzone-1-51422-d020d2d2a4e8d1a374a433f596ad1440
     //第三方支付
     http://www.cocoachina.com/ios/20151008/13506.html#0-qzone-1-88885-d020d2d2a4e8d1a374a433f596ad1440
     1.支付宝
     https://openhome.alipay.com/platform/document.htm#down
     http://www.cnblogs.com/siyuan123/p/4872378.html?from=timeline&isappinstalled=0
     2.微信
     https://www.jianshu.com/p/af8cbc9d51b0
     https://www.jianshu.com/p/162ece335b31
     3.集成三方平台支付：海马、同步推、爱思
     */
    /*
     什么情况下必须使用内购？有没有绕过使用内购直接使用第三方支付的办法？
     1.购买的功能于"应用程序有关"而且不属于"实物购买"的必须使用内购
     2.可以让服务器控制什么时间点什么版本的App使用什么支付方式（动态配置）来绕过内购
     */
    /*
     支付的流程？支付是怎么保证数据不被篡改的？
     非对称加密（公钥加密、私钥解密）
     */
}
// 支付宝支付流程：当用户发起支付的时候 --> 我们会将支付的基本信息发送给服务端进行下单 --> 服务端会使用rsa算法进行加密
// 返回给我们一个orderString
// 我们拿到orderString调用支付宝sdk支付、支付完成以后支付会通知我们支付成功

@end
