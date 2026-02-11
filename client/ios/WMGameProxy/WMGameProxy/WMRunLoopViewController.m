//
//  WMRunLoopViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/25.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMRunLoopViewController.h"

@interface WMRunLoopViewController ()

@end

@implementation WMRunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
// https://www.jianshu.com/p/d6b12f775328
// 1>.第一种获取方式：通过“Foundation框架”获取
// oc语言方式
-(void)setNSRunLoop {
    // 获取主线程的RunLoop对象
    NSRunLoop *mainRunLoop = [NSRunLoop mainRunLoop];
    // 获得当前线程的RunLoop对象
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
    NSLog(@"%p - %p - %p", mainRunLoop, currentRunLoop, mainRunLoop.getCFRunLoop);
    // 创建子线程
    NSThread *threadA = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    [threadA start];
}
-(void)run:(NSString *)param {
    // 如果存在NSRunLoop就返回NSRunLoop
    // 如果不存在NSRunLoop就新建NSRunLoop再返回
    NSRunLoop *currentRunLoop = [NSRunLoop currentRunLoop];
}

// 2>.第二种获取方式：通过Core Foundation框架获取
// C语言方式
//-(void)setCFRunLoop {
//    // 获得当前线程的RunLoop对象
//    // 获取主线程的RunLoop对象
//    NSLog(@"%@ - %@", CFRunLoopGetCurrent(), CFRunLoopGetMain());
//}


/*
 3>.RunLoop相关类
 1.在RunLoop中有多个运行模式(Mode)：用来指定事件在运行循环中的优先级/但是启动以后只能选择一种模式运行（称为CurrentMode）/一个模式中至少有一个timer或者source
 2.如果需要切换Mode：只能退出当前Loop，再重新指定一个Mode进入（为了分隔开不同组的Source/Timer/Observer让其互不影响）
 3.一个Runloop包含若干个mode，每个mode包含若干个source/timer/observer
 */
/*
 1>.CFRunLoopModeRef - 系统默认注册五个Mode
 1.kCFRunLoopDefaultMode - App的默认Mode/通常主线程在该Mode下运行
 2.UITrackingRunLoopMode - 界面跟踪Mode/用于UIScrollView追踪触摸滑动（保证界面滑动时不受其他Mode影响）
 3.UIInitializationRunLoopMode - 在刚启动App时进入的第一个Mode（启动完成就不再使用）
 4.GSEventReceiveRunLoopMode - 接收系统事件的内部Mode/绘图使用（通常用不到）
 5.kCFRunLoopCommonModes - 占位使用的Mode（不是一种真正的Mode）
 */
/*
 2>.CFRunLoopTimerRef
 1.为什么需要把NSTimer加入到NSRunLoop？
 Q.界面滑动的时候定时器不工作
 2.为什么界面滑动的时候定时器会不工作？
 Q.因为界面滑动的时候NSRunLoop切换到了UITrackingRunLoopMode（界面跟踪Mode）
 导致kCFRunLoopDefaultMode（默认Mode）下的事件不会再执行
 */
-(void)setupMode {
    // 1>.创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    // 2>.添加定时器到NSRunLoop
    /*
     NSDefaultRunLoopMode
     UITrackingRunLoopMode
     NSRunLoopCommonModes
     */
    // 只有在界面不滑动的时候定时器才会工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    // 只有在界面滑动的时候定时器才会工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    // 凡是添加到NSRunLoopCommonModes中的事件都会被同时添加到打上common标签的运行模式上
    // 定时器会一直工作
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    /*
     1.通过该方法创建的定时器不需要加入NSRunLoop
     2.因为该方法内部自动添加NSRunLoop中并且设置运行模式为默认
     3.这种创建方式定时器在UI界面滑动的时候也是不工作 - 需要重新添加
     4.该方法在子线程中不会工作 - 因为当前子线程的RunLoop不存在，需要手动创建
     */
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    // 子线程下执行定时器
    [NSThread detachNewThreadSelector:@selector(run) toTarget:self withObject:nil];
}
-(void)run {
    // 子线程的RunLoop不存在，需要手动创建
    NSRunLoop *runloop = [NSRunLoop currentRunLoop];
    // 创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [runloop addTimer:timer forMode:NSRunLoopCommonModes];
    // 子线程的RunLoop默认不开启，需要手动开启
    [runloop run];
//    // ！！！以下方法仅仅适用于子线程的runLoop！！！
//    // 开启RunLoop后10s以后退出RunLoop
//    [runloop runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
//    // 以什么模式开启RunLoop/10s以后退出RunLoop
//    [runloop runMode:NSRunLoopCommonModes beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
//    // ！！！以上方法仅仅适用于子线程的runLoop！！！
    // 此处代码不执行 - 因为runLoop是一个死循环
    NSLog(@"---end---");
}
/*
 3>.CFRunLoopSourceRef - 事件源
 1>.Source0 - 非基于Port/用户主动触发
 2>.Source1 - 基于Port/非用户主动触发
 */
/*
 4>.CFRunLoopObserverRef - 观察者：能够监听RunLoop的状态改变
 // CFRunLoopActivity
 1>.kCFRunLoopEntry - 即将进入RunLoop
 2>.kCFRunLoopBeforeTimers - 即将处理Timer
 3>.kCFRunLoopBeforeSources - 即将处理Source
 4>.kCFRunLoopBeforeWaiting - 即将处理休眠
 5>.kCFRunLoopAfterWaiting - 刚从休眠中唤醒
 6>.kCFRunLoopExit - 即将退出RunLoop
 */
-(void)setObserver {
    // 1>.创建监听者
    /*
    第一个参数 - 怎么分配存储空间
    第二个参数 - 要监听的状态/kCFRunLoopAllActivities - 所有状态
    第三个参数 - 是否需要持续监听
    第四个参数 - 优先级/总是传入0
    第五个参数 - 当状态改变的时候调用
    */
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry: {
                NSLog(@"即将进入RunLoop");
            }
            break;
            case kCFRunLoopBeforeTimers: {
                NSLog(@"即将处理Timer");
            }
                break;
            case kCFRunLoopBeforeSources: {
                NSLog(@"即将处理Source");
            }
                break;
            case kCFRunLoopBeforeWaiting: {
                NSLog(@"即将处理休眠");
            }
                break;
            case kCFRunLoopAfterWaiting: {
                NSLog(@"刚从休眠中唤醒");
            }
                break;
            case kCFRunLoopExit: {
                NSLog(@"即将退出RunLoop");
            }
                break;
            default:
                break;
        }
    });
    /*
    第一个参数 - 要监听哪个RunLoop
    第二个参数 - 观察者
    第三个参数 - 运行模式
    */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
}


/*
 6.GCD定时器
 1.不受RunLoop的影响
 2.绝对精准
 */
-(void)setTimer {
    // 1>.创建GCD中定时器
    /*
     第一个参数 - source类型/DISPATCH_SOURCE_TYPE_TIMER表示定时器
     第二个参数 - 描述信息/线程ID
     第三个参数 - 更详细的描述信息
     第四个参数 - 队列/决定GCD定时器中的任务在哪个线程中执行
     */
    // 此处timer不执行 - 需要给timer一个强引用
    // @property (strong, nonatomic) dispatch_source_t timer;
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    // 2.设置定时器
    /*
    第一个参数 - 定时器对象
    第二个参数 - 起始时间/DISPATCH_TIME_NOW - 从现在开始
    第三个参数 - 间隔时间/每隔2.0s/NSEC_PER_SEC == 10^9
    第四个参数 - 精准度/0代表绝对精准
    */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    // 3>.设置定时器的任务
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    // 4>.启动定时器
    dispatch_resume(timer);
}

/*
 1.什么是RunLoop
 1>.RunLoop是一个运行循环，本质是一个do...while的死循环，在循环的内部不断处理各种任务（timer事件/touch事件），保证程序不退出
 2>.一个线程对应一个RunLoop，主线程的RunLoop默认开启，子线程的RunLoop需要手动开启

 2.自动释放池什么时候释放？
 1>.第一次创建 - 启动runLoop的时候
 2>.最后一次销毁 - runLoop退出的时候
 3>.其他时间的创建和销毁 - runloop即将进入休眠的时候会销毁之前的释放池，重新创建新的释放池（因为这样不会导致自动释放池过大）
 
 3.runLoop的内部实现？（伪代码）
 void RunLoop(Mode: mode) {
     int result;
    // 1.runLoop是do...while的死循环
     do {
         result = run(mode);
     } while (runLoopIsFinished != result);
 }
 int run(Mode: mode) {
    // 2.runLoop至少有一个timer或source
    timer = fromT(mode);
    source = formS(mode);
     if (mode == NULL || (timer == NULL && source == NULL)) {
         return runLoopIsFinished;
     }
     return runLoopNoStoped;
 }
 
 4.如何让一个runLoop的线程常驻？- runLoop至少有一个timer或source/只要有timer或source的话runLoop就会继续执行/没有timer或source的话就会马上退出
 // https://www.jianshu.com/p/bc04369ce69d
 1>.将线程设置为全局变量
 @property (strong, nonatomic) NSThread *thread;
 2>.新建子线程
 self.thread = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:nil];
 [self.thread start];
 3>.在子线程开启一个runLoop和定时器
 -(void)run {
    // 第一种方式 - 添加一个timer/不推荐使用-定时器没啥作用
    NSTimer *timer = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    // 第二种方式 - 添加一个source/推荐使用
    [[NSRunLoop currentRunLoop] addPort:[NSPort port] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
 }
 4>.目前在主线程想要该线程工作可以切换到该线程
 [self performSelector:@selector(reloadImageView) onThread:self.thread withObject:nil waitUntilDone:YES];
 
 5.“NSTimer定时器”和“GCD定时器”有什么区别
 self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
 // NSTimer定时器可以调用invalidate进行销毁（创建和销毁必须在同一线程）
 [self.timer invalidate];
 // 循环引用：类持有timer -> timer持有self
 self.timer = nil;
 // NSTimer定时器需要添加到当前的runloop
 // 时间单位是秒
 [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
 // CGD定时器一旦执行就不能撤销
 // CGD定时器不受runloop模式的影响
 // 时间单位是纳秒
 
 6.为什么main函数能够保持一直存在且不退出？
 在main函数内部会调用`UIApplicationMain`这样一个函数，而在`UIApplicationMain`内部会启动主线程的runloop，可以做到有消息处理时，能够迅速从内核态到用户态的切换，立刻唤醒处理，而没有消息处理时通过用户态到内核态的切换进入等待状态，避免资源占用，因此main函数能够一直存在且不退出
 
 7.NSTimer是否是多线程的？使用的时候需要加同步锁吗？
 NSTimer不是多线程的，只能加到RunLoop中特定模式下才能工作。使用的时候不需要加同步锁，因为NSTimer只在单一线程工作
 
 8.NSTimer的间隔周期准吗？为什么？怎么实现一个精准的NSTimer？
 // https://www.jianshu.com/p/c50c8c4b6ce8
 */
/*
 1.runloop的5个mode(为什么NSTimer需要加到runloop)
 2.runloop的作用（自动释放池什么时候释放？/常驻子线程）
 3.source0/source1的区别？
 4.runloop的内部实现(伪代码)
 // 代码题
 https://www.jianshu.com/p/5e8a7ecfcad7?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
 [NSThread detachNewThreadSelector:@selector(runA:) toTarget:self withObject:@"分离子线程"];
 -(void)runA:(NSString *)param {
   [self performSelector:@selector(onTask) withObject:nil afterDelay:2.0];
 }
 -(void)onTask {
   NSLog(@"---");
 }
 为什么不执行？？？
 */

@end
