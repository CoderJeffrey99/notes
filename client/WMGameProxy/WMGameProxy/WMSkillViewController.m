//
//  WMSkillViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/8/5.
//  Copyright © 2019 zali. All rights reserved.
//

#import "WMSkillViewController.h"
#import "WMGameProxy.h"
#import <StoreKit/StoreKit.h>
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import <ContactsUI/ContactsUI.h>
#import <Contacts/Contacts.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import <objc/message.h>
#import <MessageUI/MessageUI.h>
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"
#import "SDWebImageManager.h"

@interface WMSkillViewController () <
SKProductsRequestDelegate,
SKPaymentTransactionObserver,
ABPeoplePickerNavigationControllerDelegate,
CNContactPickerDelegate>

@property (strong, nonatomic) NSArray *dataArray;

@property (strong, nonatomic) void(^block)(void);
// 这里使用weak/strong都可以
// 因为此处有一个看不到的强指针引用
@property (weak, nonatomic) NSTimer *timer;

@end

@implementation WMSkillViewController
#pragma mark - 控制器view的生命周期
/*
 // 首次进入
 1.第一次加载vc：loadView->viewDidLoad->viewWillAppear->viewWillLayoutSubviews->viewDidLayoutSubviews->viewDidAppear
 // push
 2.跳转第二个vc：viewWillDisappear->loadView->viewDidLoad->viewWillAppear->viewDidDisappear->viewDidAppear
 // present
 2.跳转第二个vc：loadView->viewDidLoad->viewWillDisappear->viewWillAppear->viewDidAppear->viewDidDisappear
 // pop、dismiss
 // 不重新创建第一个vc
 // 第二个vc销毁
 3.返回第一个vc：viewWillDisappear->viewWillAppear->viewDidDisappear->viewDidAppear->dealloc
 https://blog.csdn.net/spicyshrimp/article/details/70886516
 */
// 系统调用
- (void)loadView {
    /*
    作用：控制器会调用该方法去创建控制器的View（控制器View懒加载：只有使用到View才会加载View进而调用该方法）
    什么时候调用：当第一次使用控制器的View
    使用场景：自定义控制器的View（一旦重写loadView，必须自己创建控制器的View）
    注意：在View没有赋值之前不可在loadView中调用View的getter方法，因为getter方法底层会调用loadView方法造成死循环
    */
    // 保留父类方法
    // 一般都需要调用
    // “自定义self.view”不用调用该方法
    [super loadView];
    // 0.初始化控制器的self.view/创建self.view
    // 当self.view第一次使用的时候调用
    // self.view是lazy
    // ！！！self.view还没有加载完成 ！！！
    /*
     底层原理：
     先判断当前VC是不是从storyboard中加载的？？？
     1.如果当前VC是从storyboard中加载的：把storyboard中的View设置为self.view
     2.如果当前VC不是从storyboard中加载的：创建一个空白的View
     */
    // 系统调用：当控制器view第一次使用的时候调用该方法
    // 一旦重写该方法：需要自定义view
    self.view = [[UIView alloc]init];
    // 通过该方法设置alpha = 0不能响应事件
    self.view.alpha = 0;
    // 如果需要透明控件响应事件：颜色透明/可以处理事件
    self.view.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.控制器View加载完毕：创建所有子视图
    // 2.控件的初始化
    // 3.数据的初始化（懒加载）
    // view是否加载
    if (self.viewIfLoaded) {
    }
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // 2.当view为nil的时候（一般发生在内存警告：用于释放部分内存）
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 3.控制器View将要出现
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 4.控制器View已经出现（显示完毕）
    // 只能在这里移除self.view
    // 只要有父视图都可以移除
    // self.view的父视图是self.window
    [self.view removeFromSuperview];
}
- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    // 5.控制器View将要布局子控件
    // 会调用多次
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 6.控制器View布局子控件完毕
    // 会调用多次
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 7.控制器View将要消失
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    // 8.控制器View已经消失
}


#pragma mark - block
// 1.概念：block是iOS中一种比较特殊的数据类型（官方特别推荐使用）
// 2.作用：用来保存“代码块”，在恰当的时候再取出来调用（类似于函数，效率高）
-(void)shouBlock {
    // 3.block的基本写法
    // 1).无参数无返回值
    /*
     void返回值 - 表示myBlock保存的代码没有返回值
     (^myBlock) - 代表myBlock是一个"block变量"：可以保存一段block代码
     (void参数) - 表示myBlock保存的代码没有形参
     */
    void (^myBlock)(void);
    // 只能保存“block代码段”
    // ！！！如果没有“形参”的话()可以省略！！！
    myBlock = ^(){
        NSLog(@"这是一个block");
    };
    // 想要执行“block保存的代码”，需要调用block
    myBlock();
    // 2).无参数有返回值
    // ！！！如果没有“形参”的话()可以省略！！！
    NSString* (^plus)(void);
    plus = ^ {
        return @"这是一个block";
    };
    plus();
    // 3).有参数无返回值
    void (^add)(int, int);
    add = ^ (int value1, int value2){
        NSLog(@"这是一个block");
    };
    add(10, 20);
    // 4).有参数有返回值
    int (^sum)(int, int);
    sum = ^ (int value1, int value2){
        return value1 + value2;
    };
    sum(10, 20);
    
    // 4.block是一种数据类型
    // 1>.先定义再初始化
    int (^log)(int, int);
    log = ^ (int value1, int value2){
        return value1 + value2;
    };
    log(10, 20);
    // 2>.定义的同时初始化
    int (^request)(int, int) = ^ (int value1, int value2){
        return value1 + value2;
    };
    request(10, 20);
    
    // 5.利用"typedef"给"block取别名"（因为block是一种数据类型）
    // “block变量名称”就是别名
    typedef int (^sumBlock)(int, int);
    sumBlock sumP = ^ (int value1, int value2){
        return value1 + value2;
    };
    sumP(10, 20);
    
    // 6.block作为函数参数
    // 普通数据类型作为函数参数只可以传递“数字/字符串”
    // block作为函数参数直接可以传递“代码块”
    
    // 7.注意事项
    // 1).block中可以访问外部的变量
    // 如果想要在block中修改外部变量的值，必须在外界变量前面加上__block
    // 如果在block中修改了外部变量的值，会影响到外部变量的值
    /*
     如果是局部变量 -> 值传递 -> 不能被内部修改（什么修饰都不加不能被传递）
     如果是静态变量/全局变量/__block -> 地址传递 -> 能够被内部修改
     */
    __block int m1 = 10;
    void (^yourBlock)(void) = ^{
//        // 2).block中可以定义和外界同名的变量（就近原则）
//        int m1 = 20;
        
        // 3).默认情况下，不可以在block中修改外部的变量
        // 因为block中的变量和外界的变量并不是同一个变量
        // 如果block中访问到外界的变量会将外界的变量copy一份到堆内存
        m1 = 30;
        NSLog(@"m1 = %d", m1);
    };
    // 因为block使用外界的变量是copy的，所以此处修改变量值不会影响block中变量值
    m1 = 20;
    yourBlock();

    // 8.面试题
    // 1>.block是存储在“堆内存”还是“栈内存”中
    /*
     1.默认情况下block存储在栈中，如果对block进行一个copy操作就会转移到堆中
     2.如果block在栈中访问了外部的对象，不会对外部的对象进行retain操作
     3.如果block在堆中访问了外部的对象，会对外部的对象进行retain操作
     */
//    // 如果在block中访问外部的对象，一定需要给对象加上__block，只要加上__block哪怕block在堆中也不会对外界的对象进行retain操作
//    WMGameProxy *wm = [WMGameProxy new];
//    NSLog(@"retainCount = %lu", [wm retainCount]);
//    void (^proxy)(void) = ^ {
//        NSLog(@"%@", wm);
//        NSLog(@"retainCount = %lu", [wm retainCount]);
//    };
//    proxy();
    
    // 9.block的快捷方式 - inlineBlock
    
    // 10.block作为返回值
}
// 将 “void (^myBlock)(void)” 中myBlock取出来即可
-(void)completeBlock:(void (^)(void))myBlock {
    // 代码块
    
    myBlock();
    
    // 代码块
}
// 内存管理
-(void)setMemoryManager {
    // 1>.block是不是一个对象？？？
    // 是一个对象（需要管理内存）
    // 2>.MRC
    // block代码块中引用外部局部变量 -> 栈
    // block代码块中没有引用外部局部变量 -> 全局区
    /*
     1.只能使用copy修饰block/copy可以让block从栈区转移到堆区
     2.不能使用retain修饰block/retain修饰的block还是在栈区/调用会crash
     */
    void(^block)(void) = ^{
        NSLog(@"调用block");
    };
    NSLog(@"%@", block);
    // 3>.ARC
    // block代码块中引用外部局部变量 -> 堆
    // block代码块中没有引用外部局部变量 -> 全局区
    // 最好使用strong/也可以使用copy
}
/*
 什么是循环引用：A引用B、B引用A导致A和B都不能够释放内存
 1>.block为什么会导致循环引用？- block会对“代码块”中的强指针变量全部进行一次强引用
 __weak typeof(self) weakSelf = self;
 */
// 使用系统的某些api（比如UIView的block动画）的时候需要考虑循环引用问题吗？？？-不需要
-(void)setCycle {
    // 指明“self”为“弱指针变量”
    __weak typeof(self) weakSelf = self;
    /*
     __weak修饰的弱引用：如果指向的对象销毁，那么指针会立马指向nil
     __unsafe_unretained修饰的弱引用：如果指向的对象销毁，那么指针依然指向之前的内存地址，很容易产生'野指针'
     */
    _block = ^ {
        // block内部如果有延迟操作需要用一个强指针指向，不然拿不到结果
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"%@", strongSelf);
        });
    };
}
// UIViewController强引用UITableView，UITableView通过delegate强引用UIViewController


#pragma mark - KVC/KVO
// 1>.KVC - Key Value Coding键值编码
// 提供一种机制来间接访问对象的属性
-(void)showKVC {
    // 1.常规赋值
    WMGameProxy *wm = [[WMGameProxy alloc]init];
    wm.publishName = @"谢吴军";
    wm.publishAge = 18;
    // 常规赋值的也可以使用KVC取到值
    NSLog(@"%@",[wm valueForKeyPath:@"publishName"]);
    // model -> NSDictionary
    NSDictionary *dict = [wm dictionaryWithValuesForKeys:@[@"publishName", @"publishAge"]];
    NSLog(@"%@", dict);
    // 可以取出“数组”中所有对象的某个属性
    NSArray *array = @[wm, wm, wm];
    NSArray *arrayPublishName = [array valueForKeyPath:@"publishName"];
    NSLog(@"%@", arrayPublishName);
    
    // 2.KVC赋值
    // key属性值千万不能写错、不然会崩溃
    [wm setValue:@"谢吴军" forKey:@"publishName"];
    // KVC可以自动类型转换
    // 对于“网络请求”十分有用（我们不用特别关注后台返回的数据类型/只用保证key一致即可）
    [wm setValue:@"18" forKey:@"publishAge"];
    NSLog(@"%@===%ld", wm.publishName, (long)wm.publishAge);
    // ‘forKeyPath’包含‘forKey’的功能/尽量使用‘forKeyPath’
    // ‘forKeyPath’进行内部的点语法可以层层访问内部的属性
    // “key”必须在“属性”中找到，不然会崩溃
    [wm.item setValue:@"小陈" forKey:@"name"];
    [wm setValue:@"小陈" forKeyPath:@"item.name"];
    
    // 3.给数组赋值
    [[wm mutableSetValueForKeyPath:@"dateArray"] addObject:@"xwj"];
    [[wm mutableSetValueForKeyPath:@"dateArray"] removeObject:@"xwj"];
    
    // 4.给对象赋值
    // 字典中的key必须在wm中的属性中找到（一一对应）
    // 不适用于model中嵌套model
    [wm setValuesForKeysWithDictionary:dict];
    
    // 5.使用KVC给私有属性赋值
    // nbplus
    // 两种方式都可以
    [wm setValue:@"88" forKeyPath:@"_gameCount"];
    [wm setValue:@"88" forKeyPath:@"gameCount"];
}
// 2>.KVO - Key Value Observing键值监听
// 监听某个对象的属性变化
/*
 ！！！可以监听“系统类（比如UIScrollView/UITableView）”的一些属性去做一些特定操作！！！
 比如有contentOffset
 */
-(void)showKVO {
    WMGameProxy *wm = [WMGameProxy new];
    // 1.先绑定监听器
    /*
     给"对象wm/被观察者"绑定一个监听器（观察者）
     第一个参数 - 观察者
     第二个参数 - 需要监听的属性
     第三个参数 - 选项
     第四个参数 - nil
     */
    [wm addObserver:self forKeyPath:@"publishName" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    // 2.再修改属性值（只有通过setter方法改变属性值才可以被KVO监听）
    wm.publishName = @"wj";
    wm.publishName = @"fj";
    // 3.移除监听/一般写在“dealloc方法”
    // 现在可以不再写
    [wm removeObserver:self forKeyPath:@"publishName"];
}
/*
 当监听的属性值发生改变调用
 @param keyPath - 要改变的属性/publishName
 @param object - 要改变的属性所属的对象/wm地址
 @param change - 改变的内容/NSDictionary/change[NSKeyValueChangeNewKey]/change[NSKeyValueChangeOldKey]
 @param context - 上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
}
/*
 1.KVC的底层原理（可以通过重写“setter方法”做一些操作）
 1>.查看当前key值的set方法，如果有set方法就会调用set方法，给对应的属性赋值
 2>.如果没有set方法就会去查看是否有与key值相同并且带有下划线的成员属性，给对应的属性赋值
 3>.如果没有与key值相同并且带有下划线的成员属性，就会去查看有没有与key值相同名称的成员属性，给对应的属性赋值
 4>.如果还是没有找到会调用“- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key”（默认抛出异常）
 */
/*
 2.KVO的实现原理
 // KVO的实现是基于runtime机制实现的
 1.当某个类Person的属性对象第一次被观察时，系统就会在运行期动态的创建该类的一个派生类NSKVONotifying_Person
 2.在这个派生类NSKVONotifying_Person中重写基类Person中任何被观察的属性的setter方法（被观察对象的isa指针指向派生类NSKVONotifying_Person）
 3.在重写的setter方法中实现真正的通知机制：
 a、调用willChangeValueForKey:（在一个被观察属性发生改变之前一定会被调用）
 b、调用父类[super setValue:newName forKey:@"name"]
 c、调用didChangeValueForKey:（当属性发生改变以后一定会被调用并回调）
 4.当属性没有观察者时就会删除重写的setter方法，当没有观察者观察任何一个属性时，就会动态删除这个类的子类
 */
/*
 3.若一个类有实例变量NSString *_foo，调用setValue:forKey:时，是以foo还是_foo作为key？
 都可以
 */
/*
 4.如何关闭KVO的默认实现？用什么方式实现对一个对象的KVO？
 + (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
     // 如果监测到键值为age，则指定为非自动监听对象
     if ([key isEqualToString:@"age"])   {
         return NO;
     }
     return [super automaticallyNotifiesObserversForKey:key];
 }
 // 手动设定KVO
 - (void)setAge:(NSString *)age {
     if (_age != age) {
        [self willChangeValueForKey:@"age"];
        _age = age;
        [self didChangeValueForKey:@"age"];
    }
 }
 - (NSString *)age {
     return _age;
 }
 */
/*
 5.如何手动触发一个value的KVO？
 // 自动触发
 在注册KVO之前设置一个初始值，在注册以后设置一个不一样的值就可以自动触发
 // 手动触发：KVO依赖于NSObject的两个方法（willChangeValueForKey/didChangevlueForKey），在一个被观察属性发生改变之前，willChangeValueForKey一定会被调用，这就会记录旧的值；当改变发⽣以后，didChangeValueForKey会被调用。如果可以手动实现这些调用，就可以实现手动触发
 @property (strong, nonatomic) NSDate *now;
 -(void)viewDidLoad {
    [super viewDidLoad];
 
    [self addObserver:self forKeyPath:@"now" options:NSKeyValueObservingOptionNew context:nil];
    
    [self willChangeValueForKey:@"now"];
 
    [self didChangeValueForKey:@"now"];
 }
 */
/*
 6.swift中是怎么实现KVO（分两种情况）？
 // NSKeyValueObservation
 https://www.jianshu.com/p/dc39708438a2
 */


#pragma mark - 通知机制
// 1.每个App都有一个通知中心：专门负责不同对象之间的消息通信
// 2.任何对象都可以向通知中心发布通知，其他对象（观察者）都可以申请在某个特定通知发布时接收该通知（一对多）
// 某个对象A（创建通知：名称、发布者、携带参数） --发布通知--> 通知中心 --传递通知1--> 观察者1
// 某个对象A --发布通知--> 通知中心 --传递通知2--> 观察者2
// 3.可以降低对象之间的耦合度（解耦）
-(void)showNotification {
    WMGameProxy *wm = [WMGameProxy new];
    // 方式一
    // 一、监听通知（监听通知必须在发送通知之前）
    // ！！！先注册“接收通知”，再“发送通知”！！！
    // 另外一个对象接收通知
    /*
     参数一：添加的观察者、接收通知的对象（“响应方法”一般在“该类”中实现）
     参数二：观察者的响应方法（一旦被观察者消息发生变化就会触发该方法）
     参数三：通知的名称 - 明确告诉系统想要监听“什么通知”/可以为nil（不关注是“什么通知”）
     参数四：通知的发布者 - 被观察者/明确告诉系统想要监听“谁发布的通知”/可以为nil（不关注是“谁发布的通知”）
     */
    // 不接收“匿名通知”
    [[NSNotificationCenter defaultCenter] addObserver:wm selector:@selector(onChange:) name:@"network3" object:wm];
    // 接收“匿名通知”
    [[NSNotificationCenter defaultCenter] addObserver:wm selector:@selector(onChange:) name:@"network3" object:nil];
    // 二、创建通知对象
    /*
     参数一：通知的名称
     参数二：通知的发布者（可以为nil）
     参数三：通知传递的参数
     */
    NSNotification *notification1 = [[NSNotification alloc]initWithName:@"network1" object:wm userInfo:@{@"title": @"中国大佬"}];
    NSNotification *notification2 = [NSNotification notificationWithName:@"network2" object:nil userInfo:@{@"title": @"中国大佬"}];
    // 三、发送通知
    // 任何对象 -> “通知中心[NSNotificationCenter defaultCenter]” -> 另外一个对象/观察者
    [[NSNotificationCenter defaultCenter] postNotification:notification1];
    // 匿名通知
    [[NSNotificationCenter defaultCenter] postNotification:notification2];
    /// 四、移除通知（ iOS9.x以后可以不做 ）
    [[NSNotificationCenter defaultCenter] postNotificationName:@"network3" object:wm userInfo:@{@"title": @"中国大佬"}];
    // ！！！一般在“被观察者对象wm”的“- (void)dealloc;”方法中移除移除通知！！！
    // ！！！移除通知必须要在“wm被销毁”之前！！！
    // 移除“network3通知”
    [[NSNotificationCenter defaultCenter] removeObserver:wm name:@"network3" object:nil];
    // 移除“wm所有监听的通知”
    [[NSNotificationCenter defaultCenter] removeObserver:wm];
    /// 常见通知
    /*
     UIDevice对象不间断发布以下通知
     1.UIDeviceOrientationDidChangeNotification - 设备旋转
     2.UIDeviceBatteryStateDidChangeNotification - 电池状态改变
     3.UIDeviceBatteryLevelDidChangeNotification - 电池电量改变
     4.UIDeviceProximityStateDidChangeNotification - 近距离传感器
     */
     /*
      // 键盘对象会发布以下通知
      1.UIKeyboardWillShowNotification - 键盘即将显示
      2.UIKeyboardDidShowNotification - 键盘显示完毕
      3.UIKeyboardWillHideNotification - 键盘即将隐藏
      4.UIKeyboardDidHideNotification - 键盘隐藏完毕
      5.UIKeyboardDidChangeFrameNotification - 键盘的位置尺寸即将发生改变
      6.UIKeyboardWillChangeFrameNotification - 键盘的位置尺寸改变完毕
      // 系统会附带一些额外信息
      1.UIKeyboardFrameBeginUserInfoKey - 键盘刚开始的 frame
      2.UIKeyboardFrameEndUserInfoKey - 键盘最终的 frame
      3.UIKeyboardAnimationDurationUserInfoKey - 键盘动画的时间
      4.UIKeyboardAnimationCurveUserInfoKey - 键盘动画的执行节奏/快慢
      */
    // 方式二
    /*
     参数一：通知名称
     参数二：谁发出通知
     参数三：决定block在哪个线程执行（nil代表在发布通知的线程中执行）
     */
    // 只要使用[NSOperationQueue mainQueue]无论代码在哪里都会在主线程接收通知
    id observer = [[NSNotificationCenter defaultCenter] addObserverForName:@"network3" object:wm queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
        // 只要监听到通知就会调用
        NSLog(@"%@", [NSThread currentThread]);
    }];
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:observer];
#pragma mark - 通知和多线程
    // 通知是同步的（接收通知代码由发出通知线程决定：所以需要手动切换到主线程更新UI）
    // 1.主线程发出通知，异步线程监听通知，接收通知代码在主线程
    // 2.异步线程发出通知，主线程监听监听通知，接收通知代码在异步线程
}
-(void)onChange {
    // 由于不知道是在哪个线程发送通知，我们在更新UI的时候最好加上
    dispatch_async(dispatch_get_main_queue(), ^{
        // 更新UI
    });
}


#pragma mark - 定时器
-(void)createTimer {
    // 创建定时器
    // NSTimer可以直接用weak
    // 定时器会在1s以后开始
    // 第一种方式：需要加入到NSRunLoop中
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
//    // 第二种方式 - 不需要加入到NSRunLoop中/内部已经加入默认模式中
//    // 这种创建方式定时器在UI界面滑动的时候也是不工作 - 需要重新添加
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    // 解决定时器在主线程不工作的原因
    // ！！！主线程无论在处理什么操作都会抽时间处理NSTimer：这会导致定时器不准确！！！
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // 立即开始
    [timer fire];
//    // 停止定时器
//    // NSTimer停止以后就不能再使用（需要再重新创建一个）
//    [timer invalidate];
//    // 如果self持有timer则需要再加上这句话（存在循环引用）
//    timer = nil;
    // 开启定时器
    // 骚操作
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(onTimer:)
                                           userInfo:@"123" repeats:YES];
    // CADisplayLink
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeY)];
    // 想要让CADisplayLink工作，必须把它添加到NSRunLoop
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}
-(void)onTimer:(NSTimer *)timer {
    NSLog(@"%@", timer.userInfo);
    // 根据tag值获取self.view的子视图
    // 尽量少使用tag：比较消耗性能、容易乱
    // 会递归一直遍历self.view的子控件
    UILabel *myLabel = [self.view viewWithTag:0];
    myLabel.text = @"我过分";
}
-(void)changeY {
    // 当每次屏幕刷新就会调用一次（屏幕每秒刷新60次）
    // 因为可以与setNeedsDisplay()方法在频率上保持一致，所以可以看到很平滑的效果
}


#pragma mark - 懒加载（延时加载）
// 1>.概念：在开发中程序启动的时候不加载资源，只有在程序运行中有需要的时候再去加载资源（又称延迟加载）
// 2>.格式：重写"getter方法"，如果为空加载数据，如果不为空直接返回数据（oc中重写getter方法实现懒加载/swift中通过lazy关键字实现懒加载）
// 3>.特点：用到的时候再加载，全局只会被加载一次，全局都可以使用
/*
 4>.懒加载的好处：
 1.不用将创建对象的代码全部写在“viewDidLoad()”中，代码的可读性更强
 2.每个属性的“getter方法”分别负责各自的实例化处理，只有真正需要资源的时候才会加载，降低了耦合性，节省了内存
 3.延迟加载可以避免内存过高，异步加载可以避免线程堵塞
 */
// 5>.说一说懒加载的常用场景？- 定义UI会使用懒加载、网络请求的数据源
- (NSArray *)dataArray {
    // 不能使用self（会导致死循环）
    if (_dataArray == nil) {
        _dataArray = @[@"", @"", @""];
    }
    return _dataArray;
}


#pragma mark - 传值
-(void)jumpPage {
//    // 1.普通传值
//    WMSkillViewController *controller = [[WMSkillViewController alloc]init];
//    controller.mainText = @"普通传值";
//    [self.navigationController pushViewController:controller animated:YES];
//    // 2.delegate传值
//    // 那个页面需要调用该方法就需要遵循该delegate
//    // delegate是否实现了该方法
//    if ([_delegate respondsToSelector:@selector(jumpPage:)]) {
//        [_delegate jumpPage:@"delegate传值"];
//    }
//    // 3.block传值（与delegate一样）
//    // 调用block：防止其他线程导致block为空而crash
//    if (self.myBlock) {
//        self.myBlock(YES);
//    }
//    // 4.单例传值：单例保存的数据全程序共享，只有等程序杀死数据才会清空
}


#pragma mark - 异常处理
// 异常处理：不要轻易使用异常的捕获、要尽可能捕获具体的异常
// 对于异常的处理最好能够采用封装的方式：这样可以保证异常处理的一致性也可以保证当异常出现时性能的稳定
-(void)showException {
    NSArray *array = [NSArray array];
    @try {
        // 可能会出现异常的代码
        [array objectAtIndex:5];
    } @catch (NSException *exception) {
        // 如果捕捉到错误：执行此处的代码
        NSLog(@"%@", exception);
    } @finally {
        // 可选：必执行代码
        NSLog(@"finally");
    }
    // 新建异常
    NSException *exception = [NSException exceptionWithName:@"异常名称" reason:@"异常原因" userInfo:nil];
    // 抛出异常
    // 就会崩溃
    [exception raise];
}


#pragma mark - 谓词NSPredicate
-(void)showNSPredicate {
    // 谓词NSPredicate操作时针对于数组、字典等集合类型：可以设置一定的条件来过滤数据
    // 这样做的好处就是我们可以不需要编写很多的代码就可以操作数据，过滤数据
    NSString *searchString = @"";
    NSMutableArray *array = [NSMutableArray array];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    // 过滤数据
    [NSMutableArray arrayWithArray:[array filteredArrayUsingPredicate:predicate]];
}


#pragma mark - const/static/extern
-(void)showKeyWord {
    // 1.const类型修饰符：防止变量被修改
    // 1>.修饰基本变量或指针变量（修饰右边）、被const修饰的变量只能读
    // 2>.使用const修饰变量可以让变量的值不能改变
    // 写在数据类型的左边
    const int age = 18;
    // 写在数据类型的右边
    int const height = 18;
    // 3>.使用const可以节省空间避免不必要的内存分配（const修饰的变量系统不会重复分配内存空间）
    // 编译器不会为普通const常量分配存储空间，而是将它们保存在符号表中，这使得它们成为编译期常量，没有存储和读取内存的操作，效率更高
    // const修饰谁谁就是只读
    // const和int位置随便
    int * const p; // p只读、*p变量
    int const *p1; // p1变量、*p1只读
    const int *p2; // p2变量、*p2只读
    const int * const p3; // p3只读、*p3只读
    int const * const p4; // p4只读、*p4只读
    /*
    4>.const在开发中的应用
    1.const修饰全局变量
    NSString * const name = @"name"; // 不希望name被修改
    2.修饰方法中参数
    -(void)test:(int const)m; // 传入的参数m不被修改
    */
    /*
    5>.const与宏的区别
    1.编译时刻：宏是预编译（编译之前处理），const是编译阶段
    2.编译检查：宏不做检查，不会报编译错误，只是替换，const会编译检查，会报编译错误
    3.宏的好处：宏能定义一些函数，方法，const不能
    4.宏的坏处：使用大量宏，容易造成编译时间长。每次都需要重新编译
    5.使用宏不会消耗很多内存：宏定义的是常量，常量都放在常量区，只会生成一份内存
    */
    
    // 2.static修饰符
    // 1>.修饰局部变量：会延长局部变量生命周期（生命周期延长到程序结束）/只会分配一次内存（在程序一启动就分配）/修改局部变量的存储位置从栈区转移到静态区
    // 2>.修饰全局变量：表示定义一个内部全局变量（作用域会改变：只能被当前文件访问）
    // 3>.修饰函数：表示定义一个内部函数（只能被当前文件访问/调用的时候分配内存）
    
    // 3.extern：先会去当前文件下查找有没有对应全局变量，如果没有才会去其他文件查找
    // 1>.extern只能用于声明，不能用于定义（用于提供一个全局变量的引用）
    // 2>.声明外部全局变量（没有被static修饰的全局变量）、仅仅告诉系统这个是全局变量：不开辟内存空间
    
    // 为了避免在不同的文件定义相同的全局变量，我们规定：全局变量不能定义在自己的类中，自己创建全局文件管理全局东西
    // GlobalConst.h
    // extern NSString * const name;
    // GlobalConst.m
    // #import "GlobalConst.h"
    // NSString * const name = @"xxx";
      
    /*
    // static和const联合使用：表示只读的内部全局变量
    // const修饰全局变量：const表示“只读”，修饰的变量无法被改变（常量：存放于静态区）
    // static修饰全局变量，修改作用域：只能在文件内部使用
    static NSString * const name = "name";
    // name可以在全局使用
    extern NSString * const name;
    */
    /*
     常见设置常量的办法
     1.宏定义
     #define NAME @"谢吴军"
     2.const xxx
     3.枚举：OC语言的枚举 == 常量
     */
}


#pragma mark - SEL
-(void)showSEL {
    // 1.SEL是一个类型：表示方法名标识
    // 1>.每个方法都有一个与之对应的“SEL类型”的对象（通过该方法可以获取）
    // 2>.把“setAge:方法”包装成“SEL类型”的对象
    // NSSelectorFromString(@"setAge:")
    // 3>.通过“SEL类型”的对象我们可以在“方法列表”中找到对应方法的imp
    SEL sel = @selector(setAge:);
    WMGameProxy *wm = [WMGameProxy new];
    // 2.判断wm有没有实现“-(void)setAge:(int)age;对象方法”（对象调用）
    if ([wm respondsToSelector:sel]) {
        // 实现
    }
    // 3.判断WMGameProxy有没有实现”+(void)setAge:(int)age;类方法“（类调用）
    if ([WMGameProxy respondsToSelector:sel]) {
        // 实现
    }
    // ARC的条件下，使用选择器很可能会报警/参照该方式去除报警
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    // 4.调用“SEL包装的方法”
    // NSSelectorFromString(@"test:") - 把NSString转换成SEL
    [wm performSelector:NSSelectorFromString(@"test:")];
    // sel - 方法
    // 10 - 方法参数：必须是一个对象（不能是普通数据类型）
    [wm performSelector:sel withObject:@"10"];
    // 最多传递2个参数（多个参数只能传递dict）
    [wm performSelector:@selector(sendMsg:number:) withObject:@"谢谢你" withObject:@"15601749931"];
    #pragma clang diagnostic pop
    // 6.作为函数形参 - 在函数内部操作“SEL类型”
    // 7.注意
    NSString *key = @"key";
    NSString *childSelectorName = [NSString stringWithFormat:@"add%@", key];
    SEL childSelector = NSSelectorFromString(childSelectorName);
    if ([self respondsToSelector:childSelector]) {
//        // 这行代码有问题？？？
//        // https://www.jianshu.com/p/6517ab655be7
//        [self performSelector:childSelector withObject:nil];
    }
}
/*
 SEL是什么？IMP是什么？两者有什么关系？
 SEL是方法名标识：可以通过下面的调用来给一个对象发送消息（实际运行时需要通过消息发送来调用）
 [obj performSelector:SEL withObject:参数1 withObject:参数2];
 IMP是method实现代码块的地址（类似函数指针），通过IMP可以直接访问任意一个方法，免去发送消息的代价
 */


#pragma mark - UIApplication
// 1.UIApplication对象是应用程序的象征
// 2.iOS程序启动以后创建的第一个对象就是UIApplication对象
// https://www.cnblogs.com/wendingding/p/3766347.html
- (void)showApplication {
    // 每个应用程序都有自己的UIApplication对象（单例）
    // 获取UIApplication对象
    UIApplication *app = [UIApplication sharedApplication];
//    // 不可以手动创建
//    UIApplication *app_01 = [[UIApplication alloc]init]; // 报错（怎么模拟该写法报错？？？）
    // 1>.设置“App图标”右上角的红色提醒数字
    // 之前必须注册用户通知
    // 会弹出“是否允许通知”弹窗
    UIUserNotificationSettings *notice = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
    [app registerUserNotificationSettings:notice];
    app.applicationIconBadgeNumber = 400;
    // 2>.设置联网指示器的可见性
    // 状态栏会出现一个"菊花"
    app.networkActivityIndicatorVisible = YES;
    // 3>.屏幕常亮不变暗
    app.idleTimerDisabled = YES;
    // 4>.设置状态栏
    // iOS7.0以后系统提供2种管理状态栏的方法
    // 1.通过UIViewController管理：每个UIViewController可以拥有自己不同的状态栏
    // 2.通过UIApplication管理：一个App的状态栏统一管理
    // 默认通过“方法1”管理状态栏
    // 如果使用“方法2”需要配置info.plist文件
    // https://www.jianshu.com/p/52300d0df3e5
    app.statusBarHidden = YES;
    app.statusBarStyle = UIStatusBarStyleLightContent;
    /* 必须先判断是否可以打开url */
    // 5>.打开其他App
    [app openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    // 6>.打电话
    [app openURL:[NSURL URLWithString:@"tel://15601749931"]];
    // 7>.发短信
    [app openURL:[NSURL URLWithString:@"sms://15601749931@163.com"]];
}
// 3.隐藏状态栏
// 方法一、通过UIViewController管理状态栏(每个VC都拥有自己不同的状态栏)
// 状态栏样式
// UIStatusBarStyleDarkContent黑色
// UIStatusBarStyleLightContent白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}
// 是否隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}
/*
 方法二、通过UIApplication管理状态栏(app状态栏统一管理)
 不让VC管理状态栏：修改info.plist（View controller-based status bar appearance，设置为NO）
 [UIApplication sharedApplication].statusBarHidden = YES;
 [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
 */


#pragma mark - UIDevice
// [UIDevice currentDevice]代表设备，通过它可以获取一些设置相关信息
// 如果需要获取设备的硬件信息（1.使用第三方库uidevice-extension、2.百度）
// 私有api：不能在头文件中找到的api/不能上架App store
-(void)showDevice {
    // 当前设置的“系统版本”
    if ([UIDevice currentDevice].systemVersion.doubleValue >= 9.0) {
        NSLog(@"系统版本大于等于9.0");
    }
    if (@available(iOS 9.0, *)) {
        NSLog(@"系统版本大于等于9.0");
    }
    [[UIDevice currentDevice] localizedModel]; // 什么设备
    [[UIDevice currentDevice] systemName]; // 系统名称
    [[UIDevice currentDevice] systemVersion]; // 系统版本号
    // 近距离感应
    // 打开红外线开关
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeAction:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}
- (void)changeAction:(NSNotification *)notification {
    if([[UIDevice currentDevice] proximityState]) {
        NSLog(@"靠近");
    } else {
        NSLog(@"远离");
    }
}


#pragma mark - 富文本
-(void)showAttribute {
    // NSAttributedString
    NSString *s1 = @"";
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:s1];
    /*
     NSAttributedStringKey
        NSFontAttributeName文本大小
        NSParagraphStyleAttributeName段落风格
        NSForegroundColorAttributeName文本颜色
        NSBackgroundColorAttributeName文本背景颜色
        NSLigatureAttributeName设置为文本连体
        NSKernAttributeName字符间隔
        NSStrikethroughStyleAttributeName文本添加删除线
        NSUnderlineStyleAttributeName文本设置下划线
        NSStrokeColorAttributeName设置文本描边颜色
        NSStrokeWidthAttributeName设置描边宽度
        NSShadowAttributeName设置文本阴影
        NSTextEffectAttributeName设置文本特殊效果
        NSAttachmentAttributeName设置文本附件
        NSLinkAttributeName链接
        NSBaselineOffsetAttributeName文字基线偏移
        NSUnderlineColorAttributeName下划线颜色
        NSStrikethroughColorAttributeName删除线颜色
        NSObliquenessAttributeName设置字体倾斜度
        NSExpansionAttributeName设置字体的横向拉伸
        NSWritingDirectionAttributeName设置文字书写方向
        NSVerticalGlyphFormAttributeName设置文字排版方向
     */
    [attrString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:NSMakeRange(0, s1.length)];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, s1.length)];
    [attrString addAttribute:NSForegroundColorAttributeName value:UIColor.redColor range:NSMakeRange(0, s1.length)];
    [attrString addAttribute:NSBackgroundColorAttributeName value:UIColor.redColor range:NSMakeRange(0, s1.length)];
    // 0表示没有连体字符
    // 1表示使用默认的连体字符
    [attrString addAttribute:NSLigatureAttributeName value:@(1) range:NSMakeRange(0, s1.length)];
    [attrString addAttribute:NSKernAttributeName value:@(10) range:NSMakeRange(0, s1.length)];
    // 1-7表示单删除线：依次加粗
    // 9-15表示双删除线：依次加粗
    [attrString addAttribute:NSStrikethroughStyleAttributeName value:@(10) range:NSMakeRange(0, s1.length)];
    [attrString addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, s1.length)];
    [attrString addAttribute:NSStrokeColorAttributeName value:UIColor.redColor range:NSMakeRange(0, s1.length)];
    // 正值镂空
    // 负值描边
    [attrString addAttribute:NSStrokeWidthAttributeName value:@(-2) range:NSMakeRange(0, s1.length)];
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeMake(5, 5);
    shadow.shadowColor = UIColor.redColor;
    shadow.shadowBlurRadius = 5;  // 模糊度
    [attrString addAttribute:NSShadowAttributeName value:shadow range:NSMakeRange(0, s1.length)];
    [attrString addAttribute:NSTextEffectAttributeName value:NSTextEffectLetterpressStyle range:NSMakeRange(0, s1.length)];
    // 常用于图文混排
    NSTextAttachment *textAttachment = [[NSTextAttachment alloc] init];
    textAttachment.image = [UIImage imageNamed:@""];
    [attrString addAttribute:NSAttachmentAttributeName value:textAttachment range:NSMakeRange(0, s1.length)];
    // 不能在UILabel和UITextField使用
    // 只能用UITextView来进行：在delegate方法中实现url跳转
    [attrString addAttribute:NSLinkAttributeName value:@"https:www.baidu.com" range:NSMakeRange(0, s1.length)];
    // 正数上移
    // 负数下移
    [attrString addAttribute:NSBaselineOffsetAttributeName value:@(3) range:NSMakeRange(0, s1.length)];
    // 必须设置下划线才会生效
    [attrString addAttribute:NSUnderlineColorAttributeName value:UIColor.redColor range:NSMakeRange(0, s1.length)];
    // 必须设置删除线才会生效
    [attrString addAttribute:NSStrikethroughColorAttributeName value:UIColor.redColor range:NSMakeRange(0, s1.length)];
    // 正值右倾
    // 负值左倾
    [attrString addAttribute:NSObliquenessAttributeName value:@(3) range:NSMakeRange(0, s1.length)];
    // 正值拉伸
    // 负值压缩
    [attrString addAttribute:NSExpansionAttributeName value:@(3) range:NSMakeRange(0, s1.length)];
    // LRE = 0
    // RLE = 1
    // LRO = 2
    // RLO = 3
    [attrString addAttribute:NSWritingDirectionAttributeName value:@[@(3)] range:NSMakeRange(0, s1.length)];
    // 0为水平排版的字
    // 1为垂直排版的字
    // 在iOS中，总是以横向排版
    [attrString addAttribute:NSVerticalGlyphFormAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(0, s1.length)];
//    label.attributedText = attrString;
}


#pragma mark - TouchID
-(void)showTouchID {
    LAContext *context = [[LAContext alloc] init];
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:nil]) {
        // 支持TouchID验证
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:@"请进行touchID验证" reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                // 验证成功
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
            } else {
                NSLog(@"-----%ld-----", error.code);
            }
        }];
    } else {
        // 不支持TouchID验证
    }
}


#pragma mark - 通讯录
-(void)showAddressBook {
//    // 1>.AddressBookUI：低于iOS9.0使用（提供了联系人界面、联系人详情界面、添加联系人界面）
//    ABPeoplePickerNavigationController *vc1 = [[ABPeoplePickerNavigationController alloc] init];
//    vc1.peoplePickerDelegate = self;
//    [self presentViewController:vc1 animated:YES completion:^{
//
//    }];

//    // 2>.AddressBook：低于iOS9.0使用（无UI界面、需要用户授权）
//    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
//    switch (status) {
//        case kABAuthorizationStatusNotDetermined: {
//            // 用户没有决定
//            // 请求授权
//            ABAddressBookRef addressBook = ABAddressBookCreate();
//            /*
//             第一个参数：通讯录对象
//             第二个参数：回调
//             */
//            ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
//                if (granted) {
//                    // 授权成功
//                } else {
//                    // 授权失败
//                }
//            });
//        }
//            break;
//        case kABAuthorizationStatusRestricted: {
//            // 受限制（没有访问权限）
//        }
//            break;
//        case kABAuthorizationStatusDenied: {
//            // 用户拒绝（没有访问权限）
//        }
//            break;
//        case kABAuthorizationStatusAuthorized: {
//            // 用户同意
//            // 1>.创建通讯录对象
//            ABAddressBookRef addressBook = ABAddressBookCreate();
//            NSArray *array = (NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
//            // 2>.遍历
//            for (int index = 0; index < array.count; index++) {
//                ABRecordRef person = array[index];
//                ABRecordCopyValue(person, kABPersonFirstNameProperty);
//            }
//        }
//            break;
//    }

//     // 3>.第三方库RHAddressBook（必须使用静态库）
//     https://github.com/heardrwt/RHAddressBook
    
//    // 4>.ContactsUI
//    CNContactPickerViewController *vc2 = [[CNContactPickerViewController alloc] init];
//    vc2.delegate = self;
//    [self presentViewController:vc2 animated:YES completion:^{
//
//    }];
    
    // 5>.Contacts
    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    switch (status) {
        case CNAuthorizationStatusNotDetermined: {
            // 用户没有决定
            // 1>.创建联系人仓库
            CNContactStore *store = [[CNContactStore alloc] init];
            [store requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                if (granted) {
                    // 授权成功
                } else {
                    // 授权失败
                }
            }];
            // 2>.取出所有联系人
            // 创建请求对象
            // 过滤一些字段（凡是写到这个数组里面的字段都代表你要获取的字段）
            CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:@[CNContactFamilyNameKey, CNContactPhoneticGivenNameKey]];
            [store enumerateContactsWithFetchRequest:request error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
                NSLog(@"---%@", contact.phoneNumbers);
                *stop = YES;
            }];
        }
            break;
        case CNAuthorizationStatusRestricted: {
            // 受限制（没有访问权限）
        }
            break;
        case CNAuthorizationStatusDenied: {
            // 用户拒绝（没有访问权限）
        }
            break;
        case CNAuthorizationStatusAuthorized: {
            // 用户同意
        }
            break;
    }
}

//#pragma mark - ABPeoplePickerNavigationControllerDelegate
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person {
//    // 选中某一个联系人
//    ABRecordCopyValue(person, kABPersonFirstNameProperty);
//}
//
//- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
//    // 选择某一个联系人某一个属性时调用
//    // 如果上面“选中某一个联系人”的方法实现，该方法则不会执行（因为界面压根都不会跳转到详情页面）
//}
//
//- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
//    // 取消选中联系人
//}

//#pragma mark - CNContactPickerDelegate
//- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker {
//    // 取消选择联系人
//}
//
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
//    // 选择某一个联系人时调用
//}
//
//- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact *> *)contacts {
//    // 选择某一个联系人的某一个属性
//    // 调用该方法必须把上面的方法注释掉
//}


#pragma mark - 真机调试/打包测试
- (void)showTrueDevice {
    // 1>.为什么需要真机调试？
    // 1、真机和模拟器的环境（内存环境、网络环境）存在差异
    // 2、传感器不能在模拟器上使用
    // 3、打电话、发短信、拍照、LBS、蓝牙等功能均不能再模拟器上使用
    
    // 2>.怎么做真机调试（限制人、限制电脑、限制App、限制真机设备）
    // 1、Xcode7.0之前，并不是任何人、任何电脑、任何真机设备都可以进行真机调试
    // 2、Xcode7.0以后只需要拥有“Apple ID”就可以自动生成对应证书进行真机调试
    
    // 3>.限制人
    // 1、免费申请Apple ID
    // 2、加入开发者计划（升级为“开发者账号”）
    /*
     // a、个人账号/公司账号
     1.价格：99美元
     2.要求：个人账号申请简单快捷/公司账号申请必须要"邓白氏编码"
     3.特点：个人账号申请大概3天/公司账号申请大概30天/个人账号必须使用账号和密码才可以使用（不能创建和管理团队）/公司账号可以创建和管理团队（加入用户、删除用户），无需给新人账号密码
     // b、企业账号
     1.价格：299美元
     2.要求：申请必须要"邓白氏编码"
     3.特点：App针对某一个特定人群使用，不能上架AppStore/可以创建和管理团队（加入用户、删除用户）/需要"邓白氏编码"
     */
    // 3、申请“邓白氏编码”（类似国内的工商执照）：直接与苹果客服MM询问
    
    // 4>.限制电脑
    // 1、需要使用真机调试的电脑生成CSR文件（“证书签名请求文件”可以唯一识别不同的电脑）
    // 2、真机调试证书最多只能够配置2个
    // 3、不要删除别人的证书：别人电脑生成的证书（.cer文件是身份证）我这边不能直接下载使用（如果需要使用必须让别人生成.p12文件（.p12是复印件）给我）
    
    // 5>.限制App
    // 1、根据bundle ID区分App：bundle ID使用通配符会导致很多App服务（push/iap）无法使用
    // 2、新建App ID：Explicit App ID（确定的App ID）/Wildcard App ID（模糊的App ID）：App Services中很多功能无法选择（不可以使用push/iap）
    
    // 6>.限制真机设备
    // 1、根据UDID区分手机 - 禁止代码获取UDID
    // 2、添加设备 - 最多添加100次（不是100台）
    // 每年有一次机会删除设备：关键字 - Reset your device list before adding any new devices./Get Started勾选 - 不需要的设备 -> 删除不需要的设备 -> 保存
    // 3、项目的最低部署版本 < 真机设备系统版本
    
    // 7>.打包测试：！！！描述文件就算是别人创建的我们也可以直接去苹果后台下载使用，但是证书必须由创建人导出p12文件给我们使用！！！（？？？各种证书过期会发生什么？？？）
    // 生成描述文件（Provisioning Profiles）：登录账号（限制人） + 证书（限制电脑） + App ID（限制App） + UDID（限制真机设备）
    // /Users/xiewujun/Library/MobileDevice/Provisioning/Profiles
    // 此证书签发者无效：不能导出ipa
    // 描述文件位置：点击Finder -> 前往 -> 资源库 -> MobileDevice/Provisioning Profiles
    // 打包测试：设备选择“Any iOS Device” -> Product -> Archive
    // 导出ipa：Window -> Organizer
    
    // 获取一台设备唯一标识的方法有哪些方法？
    // https://www.jianshu.com/p/0dce89cdf9f6
//    1.IDFA - 广告标识符：适用于广告推广和用户追踪，用户可以手动关闭获取和还原（只要关闭“限制广告追踪”功能再次打开就会不一样）
//    2.IDFV - 同一个开发商在同一个设备上的不同App返回一致（线上：卸载重装也一致｜线下：所有App卸载会重置）
//    3.UDID - 唯一设备标识符：由40个数字字母组合，为了保护用户隐私，苹果已禁止读取
//    4.UUID - 通用唯一标识符：每次运行都会改变，可以通过UUID + Keychain的方式确定设备
//    5.MAC地址 - 定义网络设备地址：一个主机有一个MAC地址（由网卡决定、固定），为了保护用户隐私，苹果已禁止读取
//    6.OpenUDID - 第三方用来替代UDID的解决方案（非苹果官方）：删除应用会重新生成
}


#pragma mark - TestFlight
-(void)testFlight {
    // 1.概念：TestFight最初是一个独立的测试分发平台（支持iOS和安卓），后来被Apple收购集成到iTunes Connect
    // 2.作用：对发布之前的应用程序做测试分发（打包测试针对公司内部测试人员，TestFight面向真实用户）
    // 3.内部测试：在你的公司内使用TestFight测试构建版本，不需要审核（必须提供邮箱地址）
    // 4.外部测试：让使用App的任何人测试你的构建版本，需要审核（可以使用邮箱地址/可以启用公开链接）
    // 5.注意：90天有效期/可以中途停止测试
    // https://www.ifeegoo.com/using-testflight-for-ios-app-internal-testing.html
}


#pragma mark - 应用发布
-(void)publishApplication {
    // 1.广告植入
    // a>.作用：属于创收的一种方式（在你的App内部展示广告，苹果会付费给你3:7）
    // b>.iAd.framework ｜ ADBannerView
    
    // 2.企业包
    
    // 3.上架AppStore
    // 1>.申请Apple ID（免费）
    // 2>.加入开发者计划（$99）
    // 3>.配置开发者证书（限制电脑）
    // 4>.添加测试设备UDID（限制设备）
    // 5>.配置App ID（限制App）
    // 6>.生成配置文件
    // 7>.新建App基本信息
    // 8>.上传构建版本
    /*
     版本号问题
     1>.新发布版本必须大于已有版本（Apple强制规定）
     2>.新版本最小必须从1.0开始（0.1不行）
     */
    
    /*
     上架App到AppStore被拒过吗？一般是什么原因？
     // 上架App到AppStore被拒过吗？
     被拒过
     // 一般是什么原因？
     非技术原因：公司要求使用支付宝/微信支付。被苹果打回
     技术原因：不能点击的按钮不要置灰也不要弹窗提示，直接隐藏
     其它原因：需要添加演示账号、crash（测试不会出现需要查看堆栈）、黑屏
     */
}


#pragma mark - 静态库/动态库
-(void)showLib {
    // 1.库
    // 1>.概念：程序代码的集合、共享程序代码的一种方式
    // 2>.开源库：公开源代码的库（MJRefresh/AFNetworking）
    // 3>.闭源库：不公开源代码的库、经过编译后的二进制文件、静态库和动态库都是闭源库
    // 4>.静态库：xxx.a（swift不支持创建.a静态库）/xxx.framework
    // 5>.动态库：xxx.dylib/xxx.framework
    
    // https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=iOS%E5%BC%80%E5%8F%91%20%E5%8A%A8%E6%80%81%E5%BA%93%E5%92%8C%E9%9D%99%E6%80%81%E5%BA%93&fenlei=256&oq=swift%25E6%2594%25AF%25E6%258C%2581%25E9%259D%2599%25E6%2580%2581%25E5%25BA%2593%25E5%2590%2597&rsv_pq=d565d11900017df3&rsv_t=cfc2XQdw6vLpqMbC%2BRKlOa%2Bzp%2BZvRxxumjEQcjpGhcCgPWHXlAPn5bRXbco&rqlang=cn&rsv_enter=0&rsv_dl=tb&rsv_sug3=61&rsv_sug1=59&rsv_sug7=101&rsv_btype=t&prefixsug=iOS%25E5%25BC%2580%25E5%258F%2591%2520%25E5%258A%25A8%25E6%2580%2581%25E5%25BA%2593%25E5%2592%258C%25E9%259D%2599%25E6%2580%2581%25E5%25BA%2593&rsp=0&inputT=17095&rsv_sug4=17395
    // 2.静态库：静态库解决不了第三方库的重复代码问题
    // 1>.概念：在程序编译时会被链接到代码中，程序运行时将不再需要改动（每一个程序单独打包一份）
    // 2>.特点：整个函数库的数据都会被整合到代码中，编译后的程序不需要外部的函数库支持，如果改变静态函数库，就需要程序重新编译，多次使用就有多份冗余拷贝
    // 3>.作用：模块化（提高了代码的复用率）、避免少量改动经常导致大量的重复编译连接
    
    // 3.动态库：https://www.jianshu.com/p/4ef8528182b6
    // 1>.概念：在编译时不会被链接到代码中，只有程序运行时才会被载⼊（系统只加载一次，多个程序之间共享）
    // 2>.特点：多个应用程序共享内存中得同一份库文件，节省资源/可以不重新编译连接可执行程序的前提下，更新动态库文件达到更新应用程序的目的
    
    /*
     4.iOS设备架构
     1>.模拟器
     4s-5 //i386
     5s-6splus //x86_64
     2>.真机
     3gs-4s //armv7
     5/5c //armv7s(armv7兼容armv7s)
     5s-6splus //arm64
     3>.查看xxx.a/xxx.framework支持哪些架构
     cd ~/xxx（包含xxx.a/xxx.framework的文件夹）
     lipo -info xxx.a/xxx.framework
     4>.支持编译所有架构设置 - Build Settings-Build Active Architecture Only设置为NO
     5>.合并支持模拟器的.a/支持真机的.a
     lipo -create xxx.a路径 yyy.a路径 -output zzz.a
     */
    
    /*
     https://www.baidu.com/s?ie=utf-8&f=8&rsv_bp=1&rsv_idx=1&tn=baidu&wd=swift%E6%94%AF%E6%8C%81%E9%9D%99%E6%80%81%E5%BA%93%E5%90%97&fenlei=256&oq=https%253A%252F%252Fblog.csdn.net%252Fsinat_%2526lt%253B1177681%252Farticle%252Fdetails%252F107460600&rsv_pq=c5ddfea5000301ef&rsv_t=80b8ms9wJFISLiczGvbnkuxB%2F9%2FLM8B3DLAAnpBHyAzxohtY9P1iz5QiQf4&rqlang=cn&rsv_enter=0&rsv_dl=tb&rsv_btype=t&inputT=5171&rsv_sug3=30&rsv_sug1=27&rsv_sug7=101&rsv_sug4=5185
     // 5>.制作静态库SDK：swift新建动态库与新建xxx.framework一致（第一步不用修改为静态库、第二步没有头文件导入、使用的时候需要链接为动态库）
     //打包.a：
     https://www.jianshu.com/p/a1dc024a8a15
     //打包framework：
     https://blog.csdn.net/sadsadaadsd/article/details/77878279
     //swift打包静态库
     https://blog.csdn.net/lvchenqiang_/article/details/79077679
     */
    
    // 6.注意事项
    /*
     xxx.a和xxx.framework的区别？
     1.xxx.a：纯二进制文件、不可以直接使用（需要xxx.h配合）、.a + .h + sourceFile = .framework
     2.xxx.framework：除二进制文件还有资源文件、可以直接使用（建议使用）
     */
    /*
     静态库采用静态链接：linker会剔除所有它认为⽆用的代码，需要在Other Linker Flags中添加'-ObjC'和‘-all_load’
     1.如果静态库中使用了category：需要在Other Linker Flags中添加'-ObjC'
     2.如果静态库中只有category没有其它任何类的情况下：需要在Other Linker Flags中添加‘-all_load’
     */
    /*
     现在有一个iOS库frameworkToLink.framework
         $file frameworkToLink.framework/frameworkToLink
             current ar archive静态库：选择Do not Embed
         $codesign -dv frameworkToLink.framework
             code object is not signed at all/adhoc未签名：Embed and sign
             其它：Embed Without Signing
     */
}


#pragma mark - 三方库
-(void)showThirdLib {
    /*
     // 常见系统库
     // 1.基础框架
     NSObject - 基类（考虑分析源码）
     Foundation - 提供OC的基础类
     UIKit - 创建和管理App的UI
     // 2.核心框架
     QuartzCore - 提供动画特效以及通过硬件进行渲染能力/画图相关库
     CoreGraphics - 提供2D绘制的基于C的API/画图相关库
     SystemConfiguration - 检测当前网络是否可用和硬件设备状态
     CFNetwork - 访问和配置网络
     CoreFoundation - 提供抽象的常用数据类型
     GameKit - 为游戏提供网络功能：点对点互联和游戏中的语音交流
     AddressBook - 提供访问用户联系人信息的功能
     AddressBookUI - 提供用户界面：显示存储在地址簿中的联系人信息
     AudioToolBox - 提供音频录制和回放的底层API，同时负责管理音频硬件
     AudioUnit - 提供一个接口，让App可以对音频进行处理
     CommonCrypto/Security.framework - 系统加密接口
     // 3.地图框架
     MapKit - 为App提供内嵌地图的接口
     CoreLocation - 使用GPS和WI-FI获取位置信息
     // 4.音视频框架
     AVFoundation - 提供音频录制和回放的c底层API，同时负责管理音频硬件
     MediaPlayer - 提供播放视频和音频的功能
     MessageUI - 提供视图控制接口用以处理E-mail和短信
     OpenGLES - 提供动画特效以及通过硬件进行渲染的能力
     StoreKit - 为App提供在程序运行中消费的支持
     CommonCrypto/Security.framework - 系统加密接口
     libsqlite3.tbd - 数据库相关库
     libsqlite3.0.tbd - 数据库相关库

     // 常见三方libs
     1>.需要分析理解源码
     AFNetworking/Alamofire - 网络请求下载相关库
     Masonry - 用于屏幕适配
     FMDB - 操作数据库相关库
     MagicRecord - 用于简化CoreData
     MJReFresh/SVPullToRefresh - 上拉刷新/下拉加载
     JSONKit - json解析
     JSONModel/MJExtention - 字典转模型
     HandyJSON/SwiftyJSON - 字典转模型
     SDWebImage - 图片下载/上传
     fmmpeg - 音视频编解码框架
     2>.需要知道怎么使用
     JXSegmentedView - 多控制器滑动视图
     MBProgressHUD - 加载loading
     SAMKeychain - keyChain保存
     Reachability - 用于检测网络类型
     CSStickyHeaderFlowLayout - 实现头部悬停
     FLAnimatedImage - 让GIF播放不卡
     FXBlurView - 实现高斯模糊
     SPAlertController - 各种alert
     JCAlertView - 各种alert
     SPScrollPageView - 集成UIScrollView
     SSToolkit - 实现各种“UI效果”
     GPUImage - 图像处理库
     HockeyKit - adHoc自动更新框架
     https://blog.csdn.net/liuzhihui666/article/details/70152940
     https://blog.csdn.net/MinggeQingchun/article/details/77160892
     https://www.jianshu.com/p/f4282df18537
     https://www.jianshu.com/p/c74f6abc2eb7
     https://www.jianshu.com/p/68e12b966d86
     */
}


#pragma mark - 内购
/*
 1.基本概念
 1>.概念：Apple规定如果你在App中销售的商品与App的功能相关就必须使用内购方式购买（会员，点卡）
 2>.缺点：对于商家而言（苹果分成3成）/对于用户而言（第一次使用必须绑定银行卡）/内购商品的价格不能自定义
 3>.开发者创收模式：下载收费/广告/内购
 4>.注意：如果销售的商品应该使用内购而开发者没有使用内购会被拒绝上架
 2.流程
 1>.商户（App）告诉商场（苹果）你准备卖什么东西 - 去苹果开发者后台创建商品
 2>.商户（App）需要进货（从自己服务器下载），并到商场（苹果）验证进货商品是否为“第1步”注册的可以销售的商品 - 需要代码操作
 3>.顾客（用户）去商户（App）购买一个商品，商户（App）会给顾客（用户）开一个小票（订单号）
 4>.顾客（用户）拿着小票（订单号）去商场（苹果）付款
 3.App内购类型：必须先同意协议（不然只会出现"免费订阅"一个选项）
 1>.消耗性项目：只可使用一次的产品，使用之后即失效，必须再次购买（游戏金币）
 2>.非消耗性项目：只需购买一次，不会过期或随着使用而减少的产品（游戏新赛道）
 3>.自动续订订阅：允许用户在固定时间段内购买动态内容的产品，除非用户选择取消，否则此类订阅会自动续期（每月订阅提供流媒体服务的App）
 4>.非续订订阅：允许用户购买有时限性服务的产品，此App内购买项目的内容可以是静态的，此类订阅不会自动续期（为期一年的已归档文章目录订阅）
 */
// https://blog.csdn.net/YHXSunny123456789/article/details/117120763
// 创建App -> （必须先同意协议）点击"功能"（配置计费点）-> 写代码 -> 配置沙盒账号（用户与协议）
-(void)storeKit {
    // 1.从我们自己的服务器获取需要销售的商品
    NSArray * productIds = @[@"com.shiyi.zidan", @"com.shiyi.jiguanqiang", @"com.shiyi.yifu"];
    // 2.拿到需要销售的商品到苹果服务器进行验证
    // 1>.创建商品请求 - 哪些商品可以真正被销售
    NSSet *set = [NSSet setWithArray:@[productIds.firstObject]];
    SKProductsRequest *request = [[SKProductsRequest alloc]initWithProductIdentifiers:set];
    // 2>.设置代理 - 接收可以被销售的商品列表
    request.delegate = self;
    // 3>.发送请求
    [request start];
}
/*
 request - 我们传过去的
 response - 返回的数据
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    // 当请求完毕执行该代理
    // request - 是我们发起的
    // response - 苹果返回数据
    /*
     products - 可以被销售的商品/SKProduct
     invalidProductIdentifiers - 无效的商品ID/NSString
     */
    NSLog(@"可以被销售的商品%@===无效的商品ID%@", response.products, response.invalidProductIdentifiers);
    NSLog(@"基本描述：%@", response.products.firstObject.description);
    NSLog(@"商品ID：%@", response.products.firstObject.productIdentifier);
    NSLog(@"地区编码：%@", response.products.firstObject.priceLocale.localeIdentifier);
    // 根据什么判断的当地指什么地方？- 根据AppleID账号地区确定
    // 最低6元/最高6498元
    NSLog(@"本地价格：%@", response.products.firstObject.price);
    NSLog(@"本地标题：%@", response.products.firstObject.localizedTitle);
    NSLog(@"本地描述：%@", response.products.firstObject.localizedDescription);
    NSLog(@"语言代码：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleLanguageCode]);
    NSLog(@"国家代码：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleCountryCode]);
    NSLog(@"货币代码：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleCurrencyCode]);
    NSLog(@"货币符号：%@", [response.products.firstObject.priceLocale objectForKey:NSLocaleCurrencySymbol]);
    
    if ([SKPaymentQueue canMakePayments]) {
        // 3.购买商品
        // 1.取出需要购买的商品
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:response.products.firstObject];
        // 2.添加到支付队列，开始进行购买操作
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        // 3.交易队列的监听
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    } else {
        // 不支持购买
    }
//    // 恢复购买
//    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray<SKPaymentTransaction *> *)transactions {
    // 当交易队列中添加的每一笔交易状态发生改变的时候调用
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing: {
                // 正在支付
            }
                break;
            case SKPaymentTransactionStatePurchased: {
                // 支付成功
                // 移除交易队列
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateFailed: {
                // 支付失败
                // 移除交易队列
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                // 恢复购买
                // 移除交易队列
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateDeferred: {
                // 延迟处理（不要移除交易队列）
            }
        }
    }
}
// 内购怎么完成补单操作的？？？（防止多次支付、苹果验证商品失败、我们服务器验证订单失败：服务器轮询、重启补单、联系客服）


#pragma mark - 设计模式
-(void)showModel {
    // 1>.什么是设计模式：一套被反复使用的代码设计经验的总结
    // 2>.常见的设计模式
    /*
     // MVC
     1>.概述
     a.M - Model模型对象（负责数据的定义和操作）
     b.V - View视图对象（负责UI界面的显示）
     c.C - Controller控制器对象（负责协调Model和View）
     2>.特点：View接收事件传递给Controller，Controller通知Model更新数据，Model数据更新完毕通过Controller去更新View（数据驱动UI）
     3>.优点：MVC设计模式重用性高，可维护性强
     4>.缺点：对于大型项目中Controller作为一个协调者代码会非常臃肿，而且在MVC设计模式下网络请求一般也只能在Controller中处理
     */
    /*
     // MVVM：由于MVC设计模式会导致Controller代码非常臃肿，所以我们引入MVVM
     1>.概述
     a.M - Model模型对象（负责数据的定义和操作）
     b.V - View视图对象（负责UI界面的显示）
     c.VM - 负责网络请求和数据处理
     c.C - Controller控制器对象（负责拿到结果通过View处理UI）
     2>.优点：不会导致Controller的代码过于臃肿
     4>.缺点：过多的数据绑定会导致很难定位bug
     */
    /*
     // 单例：单例保存的数据全程序共享，只有等程序杀死数据才会清空
     1>.在整个应用程序中，共享一份资源（保证在程序运行过程中，一个类只有一个实例，而且该实例只提供一个全局访问点供外界访问）
     2>.优点：提供一个标准的实例化访问接口，避免频繁创造实例影响性能
     3>.常见的单例：[UIApplication sharedApplication]应用程序/[NSNotificationCenter defaultCenter]通知中心/[NSFileManager defaultManager]文件管理
     4>.创建：单例的创建方法通常以default/shared开头
     +(AccountManager *)sharedManager {
         static AccountManager *instance = nil;
         // static dispatch_once_t once; &once
         dispatch_once(dispatch_once_t * _Nonnull predicate, ^{
             instance = [[AccountManager alloc] init];
         });
         return instance;
     }
     +(AccountManager *)sharedManager {
         static AccountManager *instance = nil;
         // 在多线程访问单例时的安全性
         @synchronized (self) {
             if (instance == nil) {
                 instance = [[AccountManager alloc] init];
             }
         }
         return instance;
     }
     
     // 手写一个完整的单例
     #import "NBSDK.h"
     
     @interface NBSDK () <
     NSCopying,
     NSMutableCopying
     >
      
     @end
     
     @implementation NBSDK
     
     // 1.为单例对象实现一个静态实例，初始化为nil
     static NBSDK *_instance = nil;
     // 2.重写allocWithZone方法：保证直接使用alloc和init试图获得一个新实力的时候不产生一个新实例
     +(instancetype)allocWithZone:(struct _NSZone *)zone {
        // 第一种方式：加互斥锁解决多线程访问安全问题
        @synchronized (self) {
         // 3.实现一个实例构造方法检查上面声明的静态实例是否为nil：如果是则新建并返回一个本类的实例
         if (_instance == nil) {
             _instance = [[super allocWithZone:zone];
         }
        }
        return _instance;
        //第二种方式：线程安全
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
         _instance = [super allocWithZone:zone];
        });
        return _instance;
     }

     +(instancetype)shareInstance {
         return [[self alloc] init];
     }

     // 4.严谨：适当实现
     -(id)copyWithZone:(NSZone *)zone {
         return _instance;
     }

     -(id)mutableCopyWithZone:(NSZone *)zone {
         return _instance;
     }

     @end
     */
    /*
     // 代理模式
     1>.概念：给某一个对象提供一个代理对象，并由代理对象控制源对象的引用
     2>.应用场景：当一个类的某些功能需要由别的类来实现，但是又不确定具体会是哪个类实现
     */
    /*
     // 观察者模式
     1>.概念：观察者模式定义了一种一对多的依赖关系（让多个观察者对象同时监听某一个对象，对象在状态上发生变化时，会通知所有观察者对象，使它们能够执行某些操作）
     2>.包含：基于观察者设计模式，apple实现了notification和kvo两套监听机制，
     */
    // 3>.面试题
    /*
     a.如果让你负责一个项目，你会怎么做？
     如果让我负责一个项目，首先我会先熟悉产品研发的方向和需求，然后根据产品需求列举出具体的功能模块构思出整个项目框架，最后对整个项目的设计模式和后期版本迭代和维护有一个统筹全面的认识
     */
    /*
     b.protocol协议和继承的区别?
     1>.继承是可以继承父类的方法和实现，遵循protocol只是拥有方法的声明没有方法的实现
     2>.相同类型的类可以使用继承，不同类型的类只能使用protocol
     3>.protocol可以用于存储方法的声明：可以将多个类中共同的方法抽取出来，让这些类遵循protocol
     */
    /*
     c.简述什么时候使用delegate代理？什么时候使用notification？两者之间有什么区别？
     利用delegate和notification都可以完成对象之间的通信
     // 简述什么时候使用delegate代理？
     delegate针对一对一通信
     // 什么时候使用notification？
     notification针对一对多通信
     */
    /*
     d.如果一个对象被释放之前加到了notificationCenter中，但是不在notificationCenter中remove该对象可能会出现什么问题？
     对象添加到notificationCenter，notificationCenter只是保存了该对象的地址，没有对该方法强引用。所以在该对象释放以后指针就成为野指针，向野指针发送消息会crash
     */
    /*
     e.notification是同步还是异步? kvo是同步还是异步？delegate是同步还是异步
     1.notification是同步
     2.kvo是同步
     3.delegate是同步
     */
}


#pragma mark - SDWebImage
-(void)showSDWebImage {
    // 1.SDWebImage
    // 1>.概述：SDWebImage是一个开源的第三方库（提供了UIImageView的category以支持从远程服务器下载并缓存图片）
    // 2>.功能：异步图片加载、支持GIF、支持缓存（确保同一个URL图片不被多次下载）
    /*
     SDWebImage
        SDWebImageManger
            // 负责具体下载任务
            SDWebImageDownloader
            // 负责缓存：添加、删除、查询缓存
            SDImageCache
     */
    /*
     执行下载任务
     if (有内存缓存) {
     } else if (有磁盘缓存) {
        添加到内存缓存
     } else {
        执行下载操作
        将当前操作加入到操作缓存
        下载完成
        将当前操作从操作缓存移除
        将图片放入内存缓存和磁盘缓存中
     }
     执行下载任务完成
     显示图片
     */
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@""]];
    /*
     // 图片显示很小：我们需要手动设置imageView的尺寸
     第一个参数：下载图片的url地址
     第二个参数：占位图片
     第三个参数：下载策略
     第四个参数：进度回调
     第五个参数：下载完成
     */
    /*
     SDWebImageRetryFailed
     SDWebImageLowPriority
     SDWebImageProgressiveLoad
     SDWebImageRefreshCached
     SDWebImageContinueInBackground
     SDWebImageHandleCookies
     SDWebImageAllowInvalidSSLCertificates
     SDWebImageHighPriority
     SDWebImageDelayPlaceholder
     SDWebImageTransformAnimatedImage
     SDWebImageAvoidAutoSetImage
     SDWebImageScaleDownLargeImages
     SDWebImageQueryMemoryData
     SDWebImageQueryMemoryDataSync
     SDWebImageQueryDiskDataSync
     SDWebImageFromCacheOnly
     SDWebImageFromLoaderOnly
     SDWebImageForceTransition
     SDWebImageAvoidDecodeImage
     SDWebImageDecodeFirstFrameOnly
     SDWebImagePreloadAllFrames
     SDWebImageMatchAnimatedImageClass
     SDWebImageWaitStoreCache
     SDWebImageTransformVectorImage
     */
    [imageView sd_setImageWithURL:[NSURL URLWithString:@""]
                 placeholderImage:[UIImage imageNamed:@""]
                          options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        // 进度回调
        // receivedSize已经下载的图片大小
        // expectedSize下载图片的总大小
        // receivedSize / expectedSize * 1.0
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        // 下载完成
        // image要下载的图片
        // error错误信息
        // cacheType缓存类型
        switch (cacheType) {
            case SDImageCacheTypeNone: {
                // 直接下载
                // 1>.图片的下载顺序，默认是FIFO原则
            }
                break;
            case SDImageCacheTypeDisk: {
                // 磁盘缓存
                // 1>.命名方式：对该图片的URL进行MD5加密
            }
                break;
            case SDImageCacheTypeMemory: {
                // 内存缓存
                // 1>.当接收到内存警告之后，内部会自动清理内存缓存
            }
                break;
            case SDImageCacheTypeAll: {
                
            }
                break;
            default:
                break;
        }
    }];
    
    // 2.处理GIF：一般使用"帧动画"替代"GIF"
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"gif"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    [UIImage sd_imageWithGIFData:data];
    /*
     如何播放GIF图片
     1.把GIF图片转换成NSData类型
     2.根据NSData类型创建一个图片数据源CFImageSourceRef
     3.计算该数据源中一共有多少帧：把每一帧数据取出来放到图片数组中
     4.执行帧动画
     */
    
//    // 3.清除缓存
//    // 1>.计算缓存：利用NSFileManager深层遍历'Library/Caches文件夹'
//    NSUInteger imageCacheSize = [[SDImageCache sharedImageCache] getSize];
//    NSString *myCachePath = [NSHomeDirectory() stringByAppendingString:@"Library/Caches"];
//    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:myCachePath];
//    __block NSUInteger count = 0;
//    for (NSString *fileName in enumerator) {
//        NSString *path = [myCachePath stringByAppendingString:fileName];
//        NSDictionary *fileDict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
//        count += fileDict.fileSize;
//    }
//    CGFloat totalSize = ((CGFloat)imageCacheSize+count) / 1024 / 1024;
//    // 2>.clear直接删除缓存目录下面的文件，然后重新创建空的缓存文件
//    [[SDWebImageManager sharedManager].imageCache clearMemory];
//    // 3>.clean清除过期缓存（有效期7天），计算剩余缓存文件的大小currrentSize > 设置的最大缓存文件的大小maxSize则继续删除（按照文件创建的先后顺序），直到currrentSize <= maxSize
//    [[SDWebImageManager sharedManager].imageCache cleanDisk];
//    // 4>.删除自己缓存
//    [[NSFileManager defaultManager] removeItemAtPath:myCachePath error:nil];
    
    // 4.NSCache：专门用来进行缓存处理的（和NSDictionary用法一摸一样）
    // 1>.NSCache是苹果官方提供的缓存类，在AFNetworking和SDWebImage中被用来管理缓存
    // 2>.苹果官方解释NSCache在系统内存很低的时候会自动释放对象（模拟器演示不会释放）
    // 建议：收到内存警告的时候主动调用removeAllObject方法释放内存
    // 3>.NSCache是线程安全的，在多线程操作中，不需要对NSCache加锁
    // 4>.NSCache的key只是对对象进行strong引用，不是copy
    NSCache *cache = [[NSCache alloc] init];
    // name名称
    // delegate代理
    // totalConstLimit缓存空间的最大总成本，超出上限会自动回收对象。默认值为0，表示没有限制
    // countLimit能够缓存的对象的最大数量，默认值为0，表示没有限制
    // evictsObjectsWithDiscardedContent标识缓存是否回收废弃的内容
    cache.totalCostLimit = 10; // 存储数据的时候，如果发现当前计算得到的成本超过总成本就会自动开启一个回收过程把之前的数据删除
    cache.countLimit = 5;
    NSData *data1 = [NSData dataWithContentsOfFile:@""];
    // 在缓存中设置指定键名对应的值
    [cache setObject:data1 forKey:@"data1"];
    // 在缓存中设置指定key对应的值，并指定该键值对的成本，用于计算记录在缓存中的所有对象的总成本，出现内存警告或超出缓存总成本的时候，缓存会开启一个回收过程，删除部分元素
    [cache setObject:data1 forKey:@"data1" cost:2];
    // 获取数据
    NSData *data2 = [cache objectForKey:@"data1"];
    // 删除缓存中指定key的对象
    [cache removeObjectForKey:@"data1"];
    // 删除缓存中所有的对象
    [cache removeAllObjects];
}
/*
 1.简单描述下客户端的缓存机制？
 // 缓存分类：内存数据缓存、数据库缓存、文件缓存
 每次想要获取数据的时侯：
 1>.先检查内存中有无缓存
 2>.再检查本地数据缓存（数据库、文件）
 3>.如果都没有，则发送网络请求获取数据
 4>.将网络数据进行缓存，以便下次读取
 */
/*
 2.SDWebImage内部实现过程，如何解决卡顿的问题？
 // 卡顿的原因：从缓存中或本地读取图片资源给UIImage的时候耗费时间
 // 将以下代码写在子线程中
 NSData *data;
 UIImage *image = [UIImage imageWithData:data];
 */
/*
 3.实现缓存的LRU算法是什么？
 // LRU算法 == 最近最少使用算法
 一种简单的缓存策略：LRU算法会选出最近最少使用的数据进行淘汰
 */
/*
 4.如果数据做了缓存，服务器数据发生改变，客户端和服务器端的数据之间怎么同步数据？
 给缓存设置有效期，到期后自动删除缓存，再次请求服务器
 */
/*
 5.数据缓存和数据持久化使用场景有什么区别？
 数据缓存一般分为内存缓存（内存过多会删除）和磁盘缓存（数据持久化）
 */


#pragma mark - 后台运行
-(void)showBackgroundRun {
    // 1.应用程序5种状态
    // a.停止运行（未启动）
    // b.不活动（处于前台但不再接收事件）
    // c.活动（使用中）
    // d.后台（不再显示在屏幕上，仍然执行代码）
    // e.挂起（App驻留内存但是不执行代码）
    
    // 2.后台运行机制
    // 1>.前台 -按下home键-> 后台 -180s时间处理后台操作（用完可以继续申请时间最多10分钟）-> 挂起（内存紧张的时候系统首先关闭处于挂起状态的App）
    // 2>.如果app申明需要在后台运行就可以不限时运行：只能是播放音乐、使用GPS和VOIP、下载
    
    // 3.后台保活
    // 1>.短时间保活
    // iOS7.x-iOS13.x一般可以申请180秒
    // iOS13.x以后一般可以申请30秒
    UIBackgroundTaskIdentifier backgroundId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        // 申请时间即将到时回调该方法
//        [[UIApplication sharedApplication] endBackgroundTask:backgroundId];
//        backgroundId = UIBackgroundTaskInvalid;
        // 先结束，再申请：建议不要无限申请保活时间，因为系统如果发现该app一直在后台运行，可能会直接杀掉app
    }];
    // 2>.长时间保活：播放无声音乐、后台持续定位、后台下载资源
    // a.播放无声音乐：在app进入后台时开启无声音乐，进入前台后停止无声音乐
    // b.后台持续定位
    // c.后台下载资源：创建指定标识的后台NSURLSessionConfiguration
}


#pragma mark - 正则表达式
// https://www.runoob.com/regexp/regexp-operator.html
-(void)showRegular {
    // 1.概念：描述字符串结构模式的形式化表达方法，是强大、便捷、高效的文本处理工具
    /*
     // +表示代表前面的字符必须至少出现一次
     run+b // runb/runnb/runnnb
     // *表示代表前面的字符可以不出现也可以出现多次
     run*b // rub/runb/runnb
     // ?表示代表前面的字符最多出现一次
     run?b // rub/runb
     // [abc]匹配内部所有字母
     run[abc]b // runab/runbb/runcb
     // [^abc]匹配除内部以外所有字母
     run[abc]b // rundb/runeb/runfb
     // [A-Z]表示一个区间：匹配所有大写字母
     run[A-Z]b // runAb/runBb/runCb
     // [a-z]表示一个区间：匹配所有小写字母
     run[a-z]b // runab/runbb/runcb
     // .匹配除\n和\r的任何字符，相当于[^\n\r]
     run.b // runab/runbb/runcb
     // [\s]匹配所有空白符（包括换行）
     // [\S]匹配所有非空白符（不包括换行）
     // [\w]匹配所有字母、数字、下划线，相当于[A-Za-z0-9_]
     // i-ignore不区分大小写
     /run*b/i
     // g-global全局匹配
     /run*b/g
     // m-multi line多行匹配
     /run*b/gm
     // s-.的匹配包括换行符
     /run.b/s
     */
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"正则表达式" options:NSRegularExpressionAnchorsMatchLines error:nil];
}


#pragma mark - 发送短信
-(void)sendMessage {
    if ([MFMessageComposeViewController canSendText]) {
        // 用户已设置短信
        // 短信服务器
        MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc]init];
        // 设置短信代理
        controller.messageComposeDelegate = self;
        // 设置短信主题
        [controller setSubject:@"短信主题"];
        // 设置短信的正文内容
        controller.body = @"分享内容";
        // 弹出邮件发送视图
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        NSLog(@"设备不支持发邮件");
    }
}
// MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:^{
        switch (result) {
            case MessageComposeResultCancelled: {
                NSLog(@"用户取消发送");
            }
                break;
            case MessageComposeResultSent: {
                NSLog(@"用户已经发送");
            }
                break;
            case MessageComposeResultFailed: {
                NSLog(@"用户发送失败");
            }
                break;
            default:
                break;
        }
    }];
}

#pragma mark - 发送邮件
// 添加 "系统库MessageUI.framework"
-(void)sendEmail {
    if ([MFMailComposeViewController canSendMail]) {
        /// 用户已设置邮件账户
        // 邮件服务器
        MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
        // 设置邮件代理
        [controller setMailComposeDelegate:self];
        // 设置邮件主题
        [controller setSubject:@"邮件主题"];
        // 设置收件人
        [controller setToRecipients:@[@"15601749931@163.com"]];
        // 设置抄送人
        [controller setCcRecipients:@[@"18642963201@163.com"]];
        // 设置密抄
        [controller setBccRecipients:@[@"1822512598@qq.com"]];
        // 设置邮件的正文内容/是否为HTML格式
        [controller setMessageBody:@"邮件的正文内容" isHTML:NO];
//        [controller setMessageBody:@"这里填写html代码块" isHTML:YES];
        // 弹出邮件发送视图
        [self presentViewController:controller animated:YES completion:nil];
    } else {
        NSLog(@"设备不支持发邮件");
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(nullable NSError *)error {
    [self dismissViewControllerAnimated:YES completion:^{
        switch (result) {
            case MFMailComposeResultCancelled: {
                NSLog(@"用户取消编辑");
            }
                break;
            case MFMailComposeResultSaved: {
                NSLog(@"用户保存邮件");
            }
                break;
            case MFMailComposeResultSent: {
                NSLog(@"用户点击发送");
            }
                break;
            case MFMailComposeResultFailed: {
                NSLog(@"尝试保存或发送邮件失败：%@", [error localizedDescription]);
            }
            default:
                break;
        }
    }];
}


#pragma mark - 性能测试
-(void)showTest {
    /*
     1.简述你如何对app的性能进行测试？
     xxx
     2.如何对iOS设备进行性能测试？
     Profile-> Instruments ->TimeProfiler
     3.程序crash有哪些常见原因？如果监测不同类型的crash？
     // 程序crash有哪些常见原因？
     1>.程序无限递归导致死循环
     2>.程序运行过程中没有找到方法实现
     3>.访问野指针
     4>.数组越界
     // 如果监测不同类型的crash？
     1>.在设置断点的地方，选择Add Exception Breakpoint，之后crash就会停在出错的位置
     2>.如果在测试阶段crash的话，可以在"设置 - 通用 - 关于本机 - 诊断与用量"里面看到crash的堆栈信息
     3>.使用第三方库bugly
     4.对于App的启动优化你有哪些建议？
     xxx
     5.谈谈对UITableView的优化建议？
     1>.cell的复用：对于UITableView而言每一行都有一个cell，如果不重复使用cell则会出现100行创建100个cell，这样势必会消耗大量的内存。于是当UITableView滚动的时候，离开屏幕的cell我们不进行销毁而是被放到UITableViewCell复用池，这个时候如果有新的cell进入屏幕我们先从UITableViewCell复用池中寻找指定标识的cell，如果有直接使用，如果没有我们再创建新的cell
     2>.缓存cell高度：对于不等高cell在布局的时候可以计算并缓存cell高度
     3>.异步绘制：对于复杂页面可以考虑异步绘制，减少子视图的层级关系
     4>.不要动态操作子控件：可以在init(){}中加载完毕以后通过hidden/show来控制子控件
     5>.避免CAlayer特效：给cell中view添加阴影会引起性能问题
     6>.不要使用太复杂的xib：载入xib的时候将所有的资源全部载入内存（即使这些资源未来很久才会使用）
     7>.数据缓存：对于网络数据不需要每次都请求，可以写入数据库
     8>.正确使用数据结构：NSArray使用index查找很快；NSDictionary存储键值对：用key来查找很快；NSSet无序：insert/delete很快
     9>.对于耗时任务注意开辟子线程：不要阻塞主线程
     6.在平时开发中你一般使用什么工具优化App？例如：一个页面crash你会用什么工具去查询内存的状态？
     xxx
     6.图片加载比较慢的话怎么优化比较好？
     1>.可以将图片下载的放在异步线程中操作（SDWebImage）
     2>.图片下载过程中可以先使用一张占位图
     3>.如果图片太大可以考虑多线程断点续传
     7.简述一下Instruments的作用？
     // https://juejin.cn/post/7025246329072943112
     1>.Allocations - 可以显示内存使用和分配情况
     2>.Leaks - 可以找到内存泄漏的地方
     3>.Time Profiles - 可以对设备进行性能测试
     8.App启动如何优化？
     1>.通过Xcode-Edit scheme-Run-Auguments将环境变量DYLD_PRINT_STATISTICS设为1，在控制台查看main()函数之前的启动时间
     2>.如果启动流程依赖网络请求完成才能继续，我们需要考虑网络极差情况下的启动速度
     3>.如果App有loading广告页并且对分辨率要求高，可以尝试做图片缓存
     4>.主页面的viewDidLoad和viewWillAppear方法尽量少做操作
     5>.清除项目中未使用的类库、静态变量和方法
     9.电商类App你做过哪些性能优化？
     1>.启动：比如“减少启动页过多的操作”/“不要在主线程处理UI”/“减小包体”...
     2>.UI卡顿：UITableView的优化、离屏渲染
     10.App从服务器请求数据卡住了怎么优化？
     1>.检查网络请求操作是否被放在主线程中操作
     2>.设置请求超时，然后给用户提示
     3>.根据用户操作再次试图请求数据
     */
    
    // 内存分析：https://www.jianshu.com/p/92cd90e65d4c
    // 1.目的：为了检测程序是否存在内存泄露
    // 2.静态内存分析：Product->Analyze
    // a、概念：不运行程序直接对代码进行分析、根据代码的上下文的语法结构来分析内存状况、调整环境到MRC
    // b、作用：1.逻辑错误（访问未初始化的变量、野指针错误）2.声明错误（从未使用过的对象）3.内存管理错误（内存泄漏）
    // c、缺点：测试可能不准确
    // 测试可能不准确
    //-(void)staticAnalyze {
    //    NSObject *obj = [self getObjc];
    //    [obj release];
    //}
    //-(NSObject *)getObjc {
    //    return [[NSObject alloc]init];
    //}
    // 3.内存分配
    // a、作用：1.查看内存分配情况、2.查看内存是否释放
    // 4.动态内存分析：程序运行的时候通过Product->Profile->Instruments动态查看内存情况
    /*
     你在开发项目的时候怎么进行内存泄露检测？发生内存泄露怎么处理？
     // 你在开发项目的时候怎么进行内存泄露检测？
     可以通过Xcode自带的工具Instruments下的leaks工具，启动leaks工具以后运行项目，在leaks工具里就可以显示内存泄漏的情况，双击可以找到源码位置
     */
}


#pragma mark - 国际化
-(void)showInternationalization {
    // 1>.什么是国际化：根据用户设置的Language and Region Format(语言和区域格式)修改应用本地化信息(语言、货币、日期格式等)
    // 2>.多语言
    // en英文
    // tw台湾
    // hk香港
    // cn大陆
    // 3>.分类
    // 文字的国际化
    // 图片的国际化
    // 4>.参考
    // http://www.cocoachina.com/ios/20170122/18609.html
    // https://www.jianshu.com/p/c7a6408410aa
    // http://www.cocoachina.com/ios/20170122/18609.html/https://www.jianshu.com/p/c7a6408410aa
}
    

#pragma mark - 二维码
-(void)showQRCode {
    // https://blog.csdn.net/he_jiabin/article/details/47786031
    
}
+(UIImage *)excludeImageFromCIImage:(CIImage *)image size:(CGFloat)size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size / CGRectGetWidth(extent), size / CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    
    // 创建灰度色调空间
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    
    return [UIImage imageWithCGImage:scaledImage];
}


#pragma mark - App换肤
-(void)getSkinChanged {
    // http://www.cocoachina.com/ios/20171012/20762.html
}


#pragma mark - 折线图
-(void)showTk {
    // https://www.jianshu.com/p/4da2d7958a99
    // 添加QuartzCore.framework
    // Charts第三方库
}


#pragma mark - ！！！以下内容不属于任何知识点！！！
// 协议protocol一般是用来增加类方法
-(void)showProtocol {
#warning - 代码过几天补充
    // 哈哈哈
}

// id动态类型
// 可以调用任何方法（包括私有方法）
-(void)dynamic {
    id obj = [WMGameProxy new];
    // 这样可以避免调用方法出现崩溃
    if ([obj isKindOfClass:[WMGameProxy class]]) {
        [obj loginWithGameId:@"" GameKey:@""];
    }
}

// 逆序一个字符串
-(NSString *)reverseWord:(NSString *)word Oprater:(NSString *)oprater {
    NSArray *array = [word componentsSeparatedByString:oprater];
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *str in [array reverseObjectEnumerator]) {
        [mArray addObject:str];
    }
    return [mArray componentsJoinedByString:oprater];
}

// 泛型（怎么研究新特性：使用新Xcode创建项目，用旧Xcode去打开）
// 1>.为什么要推出泛型：迎合swift
// 2>.泛型的作用：1、限制类型 | 2、提高代码规范，减少沟通成本
// 3>.用法：类型<限制类型>
// 4>.好处：1、从数组中取出来可以使用点语法 | 2、给数组添加元素有提示
// 5>.使用场景：用于限制集合类型
// https://blog.csdn.net/imkata/article/details/78859482
// 6>.自定义泛型：在声明类的时候，不确定某些属性或者方法类型，在使用这个类的时候才确定就可以使用泛型
-(void)showObj {
    WMGameProxy<NSString *> *wm = [WMGameProxy new];
    wm.obj = @"哈哈";
}
// 注意：在数组中，一般用可变数组添加方法泛型才会生效，如果使用不可变数组，泛型没有效果


#pragma mark - 系统相关
- (void)dealloc {
    [super dealloc];
    // 对象销毁之前自动调用该方法
}

- (void)didReceiveMemoryWarning {
    // 系统调用
    // 当控制器接收到“内存警告”的时候调用，尝试释放一些"不必要、耗时"的内存
    // 默认操作[super didReceiveMemoryWarning]
}

@end
