//
//  WMThreadViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/16.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMThreadViewController.h"

@interface WMThreadViewController ()

@property (strong, nonatomic) UIImageView *imageView;

@property (strong, nonatomic) NSLock *lock;

@end

@implementation WMThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 1.NSThread
// 1>.概述：使用更加面向对象，简单易用，可以直接操作线程对象（程序员管理线程生命周期）
// 2>.基本使用
// 线程的生命周期：当线程中的任务执行完毕以后才会被释放（不是遇到"}"释放）
-(void)setupNSThread {
    // 1>.创建线程（第一种方式）：需要手动启动线程
    /*
     第一个参数 - self目标对象
     第二个参数 - 方法选择器/调用的方法
     第三个参数 - 调用的方法需要传递的参数（最多只有一个：如果想要传递多个参数可以使用dict）
     */
    // 1.新建New（线程对象）
    NSThread *threadA = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    // 设置属性需要在“手动启动线程”之前
    threadA.name = @"线程A";
    /*
     设置优先级
     默认优先级 - 0.5
     取值范围 - 0.0低 ～ 1.0高
     */
    // 线程的优先级越高 -> CPU调度的概率越高（线程的优先级低的也会调用）
    threadA.threadPriority = 1.0;
    // 立即启动线程 - 默认是暂停
    // 2.就绪Runnable（进入可调度线程池）-cpu调度当前线程-> 运行Running -cpu调度其他线程-> 就绪Runnable（进入可调度线程池）
    // 线程任务执行完毕会自动进入死亡状态
    [threadA start];
    // 取消线程
    [threadA cancel];
    if ([threadA isCancelled]) {
        NSLog(@"线程被取消");
    }
    // 3.阻塞Blocked（移除可调度线程池、还存在于内存中）
    [NSThread sleepForTimeInterval:2.0]; // 阻塞2s
//    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:3.0]]; // 阻塞3s
    NSThread *threadB = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    threadB.name = @"线程B";
    [threadB start];
    NSThread *threadC = [[NSThread alloc]initWithTarget:self selector:@selector(run:) object:@"ABC"];
    threadC.name = @"线程C";
    [threadC start];
    // 2>.创建线程（第二种方式）：自动启动线程/无法对线程进行更详细的设置
    [NSThread detachNewThreadSelector:@selector(run:) toTarget:self withObject:@"分离子线程"];
    // 3>.创建线程（第三种方式）：自动启动线程/无法对线程进行更详细的设置
    [self performSelectorInBackground:@selector(run:) withObject:@"开启后台线程"];
    // 4>.获取主线程
    NSThread *mainThread = [NSThread mainThread];
    // 5>.获取当前线程
    NSThread *currentThread = [NSThread currentThread];
    // 5>.判断是否是主线程
    if ([NSThread isMainThread]) {
        NSLog(@"当前线程是主线程");
    }
    if ([mainThread isMainThread]) {
        NSLog(@"当前线程是主线程");
    }
    // 4.死亡Dead（一旦线程停止就不能再次重启任务）
    // 结束当前线程/进入死亡状态
    [NSThread exit];
    // 输出当前方法名（必须在方法内部使用）
    NSLog(@"输出当前方法名%s", __FUNCTION__);
}
-(void)run:(NSString *)param {
    /*
     2.线程安全/线程同步
     1>.原因：多个线程访问同一块资源（用一个对象/同一个变量/同一个文件），很容易引发数据错乱和数据安全问题（存钱取钱）
     2>.解决：互斥锁（需要消耗大量的CPU资源）、线程锁NSLock、信号量
     */
    // 第一个：互斥锁（必须全局唯一）
    // 这里使用self（锁对象）保证全局唯一
    // 1.注意加互斥锁的位置
    // 2.注意加互斥锁的前提条件：多条线程访问同一块资源
    // 3.加互斥锁需要耗费性能的
    // 4.加互斥锁结果会导致“线程同步”（多条线程按顺序的执行任务）/默认多线程是异步的
    @synchronized (self) {
        // 需要锁定的代码
        // 锁定一份代码只需要一把锁，用多把锁匙无效的 - 保证多条线程执行到这里使用的都是同一把锁（锁对象不变）
        NSLog(@"获取当前线程的名称%@", [NSThread currentThread].name);
        for (int index = 0; index < 10000; index++) {
            if (index == 100) {
//                // 1>.强制结束当前线程/进入死亡状态
//                [NSThread exit];
                // 2>.任务执行完毕以后自动结束当前线程
                break;
            }
        }
    }
    
    // 第二个：创建线程锁
    self.lock = [[NSLock alloc] init];
    // 2.创建队列组（管理队列）
    dispatch_group_t group = dispatch_group_create();
    for (NSInteger index = 0; index != 100; index++) {
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 等待排号
            [NSThread sleepForTimeInterval:1];
            [self.lock lock];
            // 开始存钱操作...
            [self.lock unlock];
            // 离开队列组
            dispatch_group_leave(group);
        });
    }
    // 当队列组中所有任务都执行完毕的时候调用该方法
    // 内部本身是异步的（不会阻塞）
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 回到主线程
    });
    
    // 第三个：信号量（同时可以执行几个多线程）
    // 线程锁就是信号量等于1的时候
    // 创建信号量
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);
    for (NSInteger index = 0; index != 100; index++) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            // 占用信号量
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            // 开始存钱操作...
            // 释放信号量
            dispatch_semaphore_signal(semaphore);
        });
    }
}
/*
 1.线程间通信
 1>.概念：在一个进程中，线程往往不是孤立存在的，多个线程之间需要经常进行通信
 2>.特点：一个线程传递数据给另一个线程/一个线程执行完毕特定任务后通知另一个线程继续执行任务
 */
-(void)setupDownload {
    [NSThread detachNewThreadSelector:@selector(download) toTarget:self withObject:nil];
}
-(void)download {
    /// 下载网络图片
    // 1>.确定URL
    NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584524053542&di=11684008fd1275a02127eb8e878ff887&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F68%2F61%2F300000839764127060614318218_950.jpg"];
    // 2>.根据url下载图片/能下载下来的是二进制数据
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    // 3.转换图片格式
    UIImage *image = [UIImage imageWithData:imageData];
//    // 5.显示UI/不能放在子线程修饰
//    self.imageView.image = image;
    // 4.回到主线程
    /*
     1>.第一种方式
     第一个参数 - 回到主线程调用哪个方法
     第二个参数 - 前面方法传递的参数
     第三个参数 - 是否等待/YES - 表示“reloadImageView:”执行结束才会打印/NO - 表示不用等待“reloadImageView:”执行结束就会打印
     */
    [self performSelectorOnMainThread:@selector(reloadImageView:) withObject:image waitUntilDone:YES];
    /*
     2>.第二种方式
     第二个参数 - 表示回到哪条线程
     */
    [self performSelector:@selector(reloadImageView:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
//    /*
//     3>.第三种方式
//     直接调用self.imageView的setImage:方法
//     */
//    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    // YES - 表示“reloadImageView:”执行结束才会打印/ NO - 表示不用等待“reloadImageView:”执行结束就会打印
    NSLog(@"---end---");
    
//    // 附加部分
//    CFTimeInterval start = CFAbsoluteTimeGetCurrent(); // 获取当前时间：绝对时间
}
-(void)reloadImageView:(UIImage *)image {
    // 5.显示UI/不能放在子线程修饰
    self.imageView.image = image;
}

// 2.GCD - Grand Central Dispatch强大的中枢调度器
//http://www.cocoachina.com/ios/20161031/17887.html
//https://blog.csdn.net/u011146511/article/details/79300015
//https://www.jianshu.com/p/96032a032c7c
// 1>.基本使用
// GCD纯C语言，提供了非常多强大的函数
// GCD是苹果公司为多核的并行运算提出的解决方案
// GCD会自动利用更多的CPU内核（比如双核、四核）
// GCD会自动管理线程的生命周期（创建线程、调度任务、销毁线程）
// 开发人员只需要告诉GCD想要执行什么任务，不需要编写任何线程管理代码
/*
 GCD中两个核心概念
 1.任务：执行什么操作
 2.队列：用来存放任务（FIFO原则）
 */
/*
 GCD的执行步骤
 1.定制任务
 2.将任务添加到队列：GCD会自动将队列中的任务取出，放在对应的线程中执行（任务的取出遵循队列的FIFO原则）
 */
// 栈 - 先进后出
// 队列 - 先进先出
/*
 全局并发队列和自己创建的并发队列的区别？
 1.全局并发队列：整个程序中本身默认存在的并对应有优先级/栅栏函数不能使用/ARC模式下不需要释放内存
 2.自己创建的并发队列：需要我们手动创建/栅栏函数只能使用自己创建的并发队列/ARC模式下需要释放内存
 */
-(void)setupGCD {
    // 1.GCD用来执行任务的常用函数
    /*
     1.queue队列：存放任务/安排任务在哪里线程执行
     // 3>.并发队列
     // 可以将多个任务并发（同时）执行：自动开启多个线程同时执行任务
     // 并发功能只有在异步函数在才有效（因为同步函数不支持开启多线程）
     // 4>.串行队列
     // 让任务一个接着一个的按顺序执行：一个任务执行完毕在执行下一个任务
     2.block任务
     // 1>.用同步的方式来执行任务
     // 同步 - 只能在当前线程中执行任务，不具备开启新线程的能力（任务创建以后需要立即执行完毕）
     // 2>.用异步的方式来执行任务
     // 异步 - 可以在新的线程中执行任务，具备开启新线程的能力（任务创建以后可以先绕开）
     */
    // 1.异步函数 + 并发队列：会开启多条子线程（具体开启多少条线程是由系统内部决定的，不受我们控制（不是有多少任务就开多少子线程））/队列并发执行任务
    // 1>.创建并发队列
    /*
     第一种方式
     第一个参数 - C语言的字符串（不需要@）/标识符（区分队列）
     第二个参数 - 队列类型：DISPATCH_QUEUE_SERIAL串行队列/DISPATCH_QUEUE_CONCURRENT并发队列
     */
    dispatch_queue_t ConcurrentQueue = dispatch_queue_create("com.easy.download", DISPATCH_QUEUE_CONCURRENT);
    /*
     第二种方式 - 获取全局并发队列
     第一个参数 - 优先级
     DISPATCH_QUEUE_PRIORITY_HIGH - 2
     DISPATCH_QUEUE_PRIORITY_DEFAULT - 0
     DISPATCH_QUEUE_PRIORITY_LOW - (-2)
     DISPATCH_QUEUE_PRIORITY_BACKGROUND - INT16_MIN（优先级最低）
     第二个参数 - 为未来使用
     */
    // ConcurrentQueue == mainQueue等价的
    dispatch_queue_t mainConcurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 2>.封装任务 -> 添加任务到队列中
    /*
    第一个参数 - 队列
    第二个参数 - 需要执行的任务
    */
    // 一个队列中添加多个任务
    dispatch_async(ConcurrentQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_async(ConcurrentQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_async(ConcurrentQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    
    // 2.异步函数 + 串行队列：会开启一条子线程/队列串行执行任务
    // 1>.创建串行队列
    /*
     第一个参数 - C语言的字符串/标识符
     第二个参数 - 队列类型：DISPATCH_QUEUE_SERIAL串行队列/DISPATCH_QUEUE_CONCURRENT并行队列
     */
    dispatch_queue_t SerialQueue = dispatch_queue_create("com.easy.download", DISPATCH_QUEUE_SERIAL);
//    dispatch_queue_t SerialQueue = dispatch_queue_create("com.easy.download", NULL);
    /*
     获取主队列：跟主线程相关联的串行队列
     1.主队列是GCD自带的一种特殊的串行队列
     2.放在主队列的任务必须在主线程中执行
     */
    /*
     串行队列 - 在当前线程执行任务/有任务就必须执行（不会检查主线程的状态（是否在忙）都会强制让当前线程来执行任务）
     主队列 - 如果主队列发现当前主线程有任务在执行那么主队列就会暂停调用队列中的任务直到主线程空闲为止
     */
    dispatch_queue_t mainQueue = dispatch_get_main_queue();
    // 2>.封装任务 -> 添加任务到队列中
    /*
    第一个参数 - 队列
    第二个参数 - 需要执行的任务
    */
    // 一个队列中添加多个任务
    dispatch_async(SerialQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_async(SerialQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_async(SerialQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    
    // 3.同步函数 + 并发队列：不会开启子线程/队列串行执行任务（单个线程中的任务是串行执行的）
    // 1>.创建队列
    // 2>.封装任务 -> 添加任务到队列中
    /*
    第一个参数 - 队列
    第二个参数 - 需要执行的任务
    */
    // 一个队列中添加多个任务
    dispatch_sync(mainConcurrentQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_sync(mainConcurrentQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_sync(mainConcurrentQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    
    // 4.同步函数 + 串行队列：不会开启子线程/队列串行执行任务
    // 1>.创建队列
    // 2>.封装任务 -> 添加任务到队列中
    /*
    第一个参数 - 队列
    第二个参数 - 需要执行的任务
    */
    // 一个队列中添加多个任务
    dispatch_sync(SerialQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_sync(SerialQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_sync(SerialQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    
    // 5.异步函数 + 主队列：不会开启子线程/所有任务都在主线程中执行
    // 同步 - 如果当前没有执行完毕，后面也可以执行
    dispatch_async(mainQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_async(mainQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    
    // 6.同步函数 + 主队列：死锁（相互等待）
    // 如果把该段代码放在子线程就不会发生死锁
    // 同步函数：立刻马上执行（如果我没有执行完毕后面的也别想执行）
    // 主队列：如果主队列发现当前主线程有任务在执行那么主队列就会暂停调用队列中的任务直到主线程空闲为止
    dispatch_sync(mainQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_sync(mainQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    dispatch_sync(mainQueue, ^{
        NSLog(@"download---%@", [NSThread currentThread]);
    });
    
    /*
     // 7.死锁（概念不一样）
     1.概述：多个进程在执行过程中因为资源竞争而造成的阻塞现象
     2.产生死锁的原因：资源竞争及进程推进顺序非法
     3.产生死锁的必要条件
     1>.互斥条件 - 在某一段时间某资源仅为一进程占用
     2>.请求和保持条件 - 当进程因为请求资源而阻塞的时候对已获取的资源保持不放
     3>.不剥夺条件 - 已获得的资源不可以被剥夺，只可以自己释放
     4>.环路等待条件 - 发生死锁必然存在一个进程-资源的环形链
     4.解决死锁的方法
     1>.预防死锁 - 通过设置一些限制条件，去破坏产生死锁的必要条件
     2>.避免死锁 - 在资源分配过程中，使用某种方法避免系统进入不安全的状态，从而避免发生死锁
     3>.检测死锁 - 允许死锁的发生，但是通过系统的检测之后，采取一些措施，将死锁清除掉
     4>.解除死锁 - 该方法与检测死锁配合使用
     */
}
// 2>.线程通信
-(void)notificationGCD {
    // 1.创建子线程下载图片（只有一个任务所以既可以使用并发队列，也可以使用串行队列）
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // UITableView滑动卡的原因
        // 1>.确定URL
        NSURL *url = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1584524053542&di=11684008fd1275a02127eb8e878ff887&imgtype=0&src=http%3A%2F%2Fa3.att.hudong.com%2F68%2F61%2F300000839764127060614318218_950.jpg"];
        // 2>.根据url下载图片/能下载下来的是二进制数据
        NSData *imageData = [NSData dataWithContentsOfURL:url];
        // 3.转换图片格式
        UIImage *image = [UIImage imageWithData:imageData];
//        // 5.显示UI/不能放在子线程修饰
//        self.imageView.image = image;
        // 4.回到主线程（必须写在子线程内部）
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
//        // 这里不会发生死锁
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            self.imageView.image = image;
//        });
    });
}
// 3>.GCD其他常见函数
-(void)notify {
    // 1>.延迟执行
    // 第一种方法
    [self performSelector:@selector(onTask) withObject:nil afterDelay:2.0];
    // 第二种方法
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(onTask) userInfo:nil repeats:YES];
    // 第三种方法
    /*
     第一个参数 - 从什么开始计算时间
     第二个参数 - 需要延迟的时间
     第三个参数 - 队列
     第四个参数 - 任务
     */
//    // 设置“任务”在主线程中执行
//    dispatch_queue_t main = dispatch_get_main_queue();
    // 设置“任务”在子线程中执行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 单位 - 纳秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
        NSLog(@"GCD===%@", [NSThread currentThread]);
    });
    
    // 2>.一次性代码（区别于lazy加载）
    // 整个应用程序运行期间只会执行一次
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 默认线程安全
        NSLog(@"----once----");
    });
    
    // 3>.栅栏函数
    // 1.可以控制异步函数的执行顺序
    // 2.同步函数不需要使用栅栏函数
    // 3.栅栏函数不能使用全局并发队列
    // 执行顺序 - downloadA/downloadB(它们俩还是并发执行) -> 栅栏函数 -> downloadC
    dispatch_queue_t zhanLanQueue = dispatch_queue_create("com.easy.download", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(zhanLanQueue, ^{
        NSLog(@"downloadA---%@", [NSThread currentThread]);
    });
    dispatch_async(zhanLanQueue, ^{
        NSLog(@"downloadB---%@", [NSThread currentThread]);
    });
    dispatch_barrier_async(zhanLanQueue, ^{
        NSLog(@"========================");
    });
    dispatch_async(zhanLanQueue, ^{
        NSLog(@"downloadC---%@", [NSThread currentThread]);
    });
    
    // 4>.快速迭代(遍历)
    // 1.for循环是同步执行的
    /*
     第一个参数 - 遍历的次数
     第二个参数 - 队列（必须是并发队列/如果是全局队列会发生死锁/如果是串行队列会没有效果）
     第三个参数 - 索引
     */
    // 并发执行/迭代速度特别快
    dispatch_apply(10, dispatch_get_global_queue(0, 0), ^(size_t index) {
        // 任务的执行是并发的
    });
}
-(void)onTask {
    NSLog(@"task===%@", [NSThread currentThread]);
}
// 4>.队列组：监听异步所有任务执行结束
-(void)groupMethod {
    // 1.创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 2.创建队列组（管理队列）
    dispatch_group_t group = dispatch_group_create();
    // 第一种写法
    // 3.异步函数
    // 把任务添加到队列中
    // 监听任务的执行情况通知group
    dispatch_group_async(group, queue, ^{
        NSLog(@"downloadA---%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"downloadB---%@", [NSThread currentThread]);
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"downloadC---%@", [NSThread currentThread]);
    });
    // 第二种写法（老代码）
    // 在该方法后面的异步任务会被纳入到队列组的监听范围
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"downloadA---%@", [NSThread currentThread]);
        // 离开队列组
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"downloadB---%@", [NSThread currentThread]);
        // 离开队列组
        dispatch_group_leave(group);
    });
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        NSLog(@"downloadC---%@", [NSThread currentThread]);
        // 离开队列组
        dispatch_group_leave(group);
    });
    // 当队列组中所有任务都执行完毕的时候调用该方法
    // 内部本身是异步的（不会阻塞）
    dispatch_group_notify(group, queue, ^{
        /*
         queue - 并发队列 - 子线程执行
         queue - 主队列 - 主线程执行
         */
    });
    /*
     等待（会阻塞）
     DISPATCH_TIME_NOW - 立即检查
     DISPATCH_TIME_FOREVER - 死等/直到队列中所有的任务都执行完毕以后才能执行
     */
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}
// 5>.补充
// 两者是等价的（封装任务的方法不一样）
-(void)testMethod {
    // 第一种方式
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
    });
    /*
     第二种方式
     第一个参数 - 队列
     第二个参数 - 参数
     第三个参数 - 要调用的函数的名称
     */
    dispatch_async_f(dispatch_get_global_queue(0, 0), NULL, task);
}
void task(void *param) {
    NSLog(@"%s", __func__);
}

// 3.NSOperation抽象类
/*
 **什么是抽象类？有什么作用？可以实例化吗？？？**
 1>.什么是抽象类：使用abstract修饰的类称为抽象类，它只能用来作为父类，不可以实例化
 2>.原理：抽象类将一些公有的属性和方法（声明为抽象方法：只有声明没有实现）抽取出来，实现新类的时候只需要继承抽象类实现抽象方法就可以了，降低了实现新类的难度
 3>.作用
 a.用于类型隐藏：我们可以构造出一个固定的一组行为的抽象描述，但是这组行为却能够有任意种可能的具体实现方式
 b.用于拓展对象的行为功能：一组任意个可能的具体实现则表现为所有可能的子类，模块可以操作一个抽象体。由于模块依赖于一个固定的抽象体，因此它可以是不允许修改的
 */
/*
 1.NSOperation和NSOperationQueue可以实现多线程编程
 2.NSOperation继承NSObject
 3.操作 == 任务
 4.底层是GCD
 5.自动管理线程生命周期
 */
-(void)setNSOperation {
    // 1.NSInvocationOperation
//    // 1>.创建操作
//    // 此处还是主线程（没有开子线程）/没有意义
//    /**
//     第一个参数 - 目标对象
//     第二个参数 - SEL
//     第三个参数 - 方法需要接收的参数
//     */
//    NSInvocationOperation *optA = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationA) object:nil];
//    // 2>.执行操作
//    [optA start];
    // 2.如果开子线程
    // 1>.创建操作
    NSInvocationOperation *optA = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationA) object:nil];
    NSInvocationOperation *optB = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationB) object:nil];
    NSInvocationOperation *optC = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(operationC) object:nil];
    // 2>.添加操作依赖：optA依赖于optB/可以控制子线程的执行顺序
    // 执行顺序：optC > optB > optA
    // 不可以循环依赖：不会崩溃/死锁
    // 可以跨队列依赖
    [optA addDependency:optB];
    // optB依赖于optC
    [optA addDependency:optC];
    // 3>.操作监听
    optA.completionBlock = ^{
        // 当“操作optA”执行完毕就会执行此处
        // 此处跟“操作optA”不一定在同一个子线程操作
    };
    // 4>.创建队列
    /*
     主队列：[NSOperationQueue mainQueue]/与GCD一样/也是串行队列
     非主队列：[[NSOperationQueue alloc]init]/同时具备并发和串行的功能/默认情况下是并发队列
     */
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    // 同一时间最多有多少个任务可以执行（一般3～5个）
    // maxConcurrentOperationCount > 1  // 并发队列
    // maxConcurrentOperationCount = 1  // 串行队列
    // maxConcurrentOperationCount = 0  // 一条任务都不会执行
    // maxConcurrentOperationCount = -1  // 特殊意义/表示最大值/表示最大并发数不受限制
    // 串行执行任务 != 只开一条线程/串行执行任务主要看执行任务的顺序
    queue.maxConcurrentOperationCount = 1;
    // 暂停队列 - 可以恢复/不能暂停当前正在处于执行状态的任务
    // 队列中的任务也有状态 - 已经执行完毕/正在执行/排队等待状态
    /*
     // 1.——自定义NSOperation没有效果——
     // 2.该方法本质：内部调用了所有操作的“cancelled方法”
     // 3.解决办法/官方建议：没执行完毕一段耗时操作都需要判断一下该操作有没有被取消
     -(void)main {
         // 第一段耗时操作
         if (self.isExecuting) {
             return
         }
         // 第二段耗时操作
         if (self.isExecuting) {
             return
         }
         // 第三段耗时操作
          if (self.isExecuting) {
              return
          }
     }
     */
    [queue setSuspended:YES];
    // 继续执行
    [queue setSuspended:NO];
    // 取消 - 不可以恢复
    /*
    // 1.——自定义NSOperation没有效果——
    // 2.该方法本质 - 内部调用了所有操作的“cancelled方法”
    // 3.解决办法/官方建议 - 没执行完毕一段耗时操作都需要判断一下该操作有没有被取消
    -(void)main {
        // 第一段耗时操作
        if (self.isCancelled) {
            return
        }
        // 第二段耗时操作
        if (self.isCancelled) {
            return
        }
        // 第三段耗时操作
         if (self.isCancelled) {
             return
         }
    }
    */
    [queue cancelAllOperations];
    // 5>.添加操作到队列
    // 此处内部已经调用[optA start]
    [queue addOperation:optA];
    [queue addOperation:optB];
    [queue addOperation:optC];
    
//    // 2.NSBlockOperation
//    // 此处还是主线程（没有开子线程）/没有意义
//    // 1>.创建操作
//    NSBlockOperation *blockA = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    NSBlockOperation *blockB = [NSBlockOperation blockOperationWithBlock:^{
//        NSLog(@"%@", [NSThread currentThread]);
//    }];
//    // 2>.追加任务
//    // 1.如果一个操作中的任务数量 > 1 -> 那么就会开子线程并发执行任务
//    [blockA addExecutionBlock:^{
//        // 不一定是子线程/也有可能是主线程
//    }];
//    [blockA addExecutionBlock:^{
//        // 不一定是子线程/也有可能是主线程
//    }];
//    // 3>.执行操作
//    [blockA start];
//    [blockB start];
    // 2.如果开子线程
    // 1>.创建操作
    NSBlockOperation *blockA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
        // 线程通信
        // 更新UI - 回到主线程
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
        }];
    }];
    NSBlockOperation *blockB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    NSBlockOperation *blockC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    // 2>.追加任务
    // 1.如果一个操作中的任务数量 > 1 -> 那么就会开子线程并发执行任务
    [blockA addExecutionBlock:^{
        // 不一定是子线程/也有可能是主线程
    }];
    [blockA addExecutionBlock:^{
        // 不一定是子线程/也有可能是主线程
    }];
    // 3>.创建队列
    /*
     主队列 - [NSOperationQueue mainQueue]/与GCD一样/也是串行队列
     非主队列 - [[NSOperationQueue alloc]init]/同时具备并发和串行的功能/默认情况下是并发队列
     */
    NSOperationQueue *blockQueue = [[NSOperationQueue alloc]init];
    // 4>.添加操作到队列
    // 此处内部已经调用 [optA start]
    [blockQueue addOperation:blockA];
    [blockQueue addOperation:blockB];
    [blockQueue addOperation:blockC];
    
    // 3.简便方法/将上面四步操作合并成两步
    [blockQueue addOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    
    /*
     4.自定义类继承NSOperation也可以实现多线程 - 因为NSOperation是抽象类
     1>.让XMGOperation继承NSOperation/创建[[XMGOperation alloc]init];
     2>.创建队列把XMGOperation加入到队列
     3>.重写XMGOperation中-(void)main {}执行操作
     */
    // 应用场景 - 当任务的代码量很大可以考虑该方法/有利于代码隐蔽/有利于代码复用
}
//-(void)operationA {
//    NSLog(@"%s - %@", __func__, [NSThread currentThread]);
//}

/*
 1.进程与进程之间可以通信吗？
 可以（应用跳转）
 2.为什么子线程的延迟方法不执行？
 子线程需要手动开启runloop
 3.什么是线程同步？什么是线程异步？如何实现线程同步？
 // 什么是线程同步？什么是线程异步？
 线程同步：多个线程同时访问同一资源，一个线程要等待上一个线程执行完毕，浪费时间，效率低
 线程异步：访问资源时在空闲等待时同时访问其他资源，实现多线程机制
 // 如何实现线程同步？
 通过添加线程锁实现线程同步：单线程可以不加锁，多线程访问公共资源必须加锁
 */
/*
 简述一下iOS中几种常见的多线程？谈谈多线程安全问题的几种解决方案？你在项目中使用过多线程吗，说说具体使用场景？
 // 简述一下iOS中几种常见的多线程？
 在iOS中，一般有三种多线程操作方案，分别是NSThread、GCD、NSOperation
 // 谈谈多线程安全问题的几种解决方案？
 对于多个线程访问同一块资源可能引发的数据安全和数据错乱问题我们可以通过加锁的方法处理，比如互斥锁和NSLock（其本质都是实现线程同步）
 // 你在项目中使用过多线程吗，说说具体使用场景？
 项目中一般有耗时操作都会考虑使用多线程防止卡顿：比如检测新版本（网络请求）、切换图片，对于多张图片的缓存问题有时候还会使用到线程组
 */
/*
 在内存中维护一份数据：有多处地方可能会同时操作这块数据，怎么保证数据安全？
 // 读写互斥/写写互斥/读读并发
 dispatch_queue_t concurrentQueue = dispatch_queue_create("com.easy.download", DISPATCH_QUEUE_CONCURRENT);
 NSMutableDictionary *dict = [NSMutableDictionary dictionary];
 -(void)setSafeObject:(id)object forKey:(NSString *)key {
    key = [key copy];
    dispatch_async(concurrentQueue, ^{
        [dict setObject:object key:key];
    });
 }
 -(id)safeObjectForKey:(NSString *)key {
    __block NSString *temp;
    dispatch_sync(concurrentQueue, ^{
        temp = [dict objectForKey:key];
    });
 }
 */

@end
