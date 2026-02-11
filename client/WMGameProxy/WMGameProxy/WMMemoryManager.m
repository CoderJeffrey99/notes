//
//  WMMemoryManager.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/2/21.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMMemoryManager.h"
#import "WMGameProxy.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

/*
 1.内存管理概述
 1>.什么是内存管理：回收那些不需要再使用的对象
 2>.为什么需要内存管理：移动设备的内存极其有限，App占用内存较多时候系统会发生内存警告（回收一些不需要的内存空间），如果不进行内存管理系统会强制关闭App
 3>.增加一个App的内存占用行为：创建一个OC对象/定义一个变量/调用一个函数和方法
 4>.内存管理的范围：任何继承于NSobject的对象（对非对象类型（比如基本数据类型int/char/double）不需要进行内存管理）
 */

/*
 2.什么是引用计数器retainCount
 1>.每个对象都有一个自己的引用计数器、它是一个整数、表示对象被引用的次数（多少人正在引用这个对象）
 2>.系统如何判断什么时候需要回收一个对象：对象的"引用计数器retainCount = 0"
 3>.任何对象只要被创建出来“引用计数器retainCount = 1”
 */

/*
 3.怎么操作引用计数器
 1>.给对象发送一个retain消息：可以使对象引用计数器+1（retain方法返回对象本身）
 2>.给对象发送一个release消息：可以使对象引用计数器-1、release不代表销毁，回收对象（仅仅代表引用计数器-1）
 3>.给对象发送一个retainCount消息：可以获取当前引用计数器的值（获取的引用计数器个数不准确，要想准确判断对象是否销毁必须判断是否调用dealloc()方法）
 */

@implementation WMMemoryManager
/*
4.dealloc()方法
1>.什么时候调用：当对象的"引用计数器retainCount = 0"的时候（对象即将被销毁时系统会自动给对象发送一条dealloc()消息）
2>.作用：销毁对象、释放相关资源、必须调用“[super dealloc];”放在最后
3>.一旦对象被回收就不能在使用：如果坚持使用会导致程序崩溃（野指针错误）
*/
- (void)dealloc {
    // 一般会重写该方法
    /*
     执行代码：释放相关资源
     */
    // 这句代码放在最后一行（必须调用）
    // 为什么ARC环境下不允许我们调用[super dealloc]
    [super dealloc];
}

/*
 5.内存中有5块内存空间
 栈区：由编译器自动分配释放内存，主要存放函数的参数值、局部变量，栈是一块连续的内存区域
 堆区：由程序员手动分配释放内存（容易产生内存泄漏），若程序员不释放，程序结束的时候才会回收，堆是不连续的内存区域
 数据区：
    1>.静态区/方法区：存放静态变量、全局变量、方法和类，只要静态区被分配内存直到程序结束才会被释放
    2>.常量区：存放常量（多个内容相同的对象指向同一块存储空间）
 程序代码区：程序加载到内存（程序代码存放在"代码区(存放二进制代码)"）
 */

/*
 6.内存管理的黄金法则
 1>.如果一个对象使用了"alloc/copy[mutable]/retain/new"那么就必须使用"release/autorelease"
 2>.反之如果没有使用"alloc/copy/retain/new"就不能使用"release/autorelease"
 */

/*
 7.内存管理有三种方式
 1.ARC/自动引用计数：不需要开发人员自己管理内存，编译器会在适当的地方加上“release/retain代码”
 2.MRC/手动引用计数：所有对象的内存都需要开发人员手动管理，开发人员需要自己在适当的地方加上“release/retain代码”
 3.自动释放池：只要给对象发送“autorelease消息”就会将对象放到自动释放池。当自动释放池被销毁的时候会对自动释放池中所有的对象做一次“release操作”（并不代表会释放对象）
 */

// 8.MRC单个对象的内存管理
-(void)singleObjectMemoryManager {
    /*
     1.开辟内存空间（在堆中开辟内存空间存放对象和对象属性）
     2.初始化所有属性
     3.返回指针地址（指针地址保存在栈区）
     */
    /*
    WM - 指针变量WM
    [[WMGameProxy alloc]init] - WM指向的对象/WMGameProxy实例变量
    */
    /*
     “WM指向的对象/WMGameProxy实例变量”中包含
     1.属性（isa指针）- 属性可以指向别的实例变量
     2.引用计数器（retainCount）
     */
    WMGameProxy *WM = [[WMGameProxy alloc]init];  // 引用计数器 = 1
    /*
     混合编程
     // ARC工程
     1.整个工程支持MRC：选中工程 -> TARGET -> Build Settings -> Automatic Reference Counting -> NO
     2.单个文件支持MRC：Build Phases -> Compile Sources -> "-fno-objc-arc"
     // MRC工程（基本不存在）
     3.单个文件支持ARC：Build Phases -> Compile Sources -> "-fobjc-arc"
     4.MRC项目 -> ARC项目：Edit -> Convert -> to Objective-C ARC...
     */
    // 必须在“{}”前通过“指针变量WM”给“WM指向的对象”发送一条“release消息”
    [WM release];  // 引用计数器 - 1 = 0 -> 自动调用"dealloc方法"（release只会使“引用计数器 - 1”不会“自动调用'dealloc方法'”）
    
//    WMGameProxy *WM = [[WMGameProxy alloc]init];  // 引用计数器 = 1
//    [WM retain]; // 引用计数器 + 1 = 2，给“指针变量WM指向的对象”引用计数器 + 1
//    [WM release]; // // 引用计数器 - 1 = 1，这时候不会“自动调用'dealloc方法'”/给“指针变量WM指向的对象”引用计数器 - 1
    
    /*
     0>.僵尸对象：被释放的对象，开启监听"僵尸对象"(Edit Scheme->Run->Diagnostics->勾选Zombie Objects)...建议以后项目都开启该选项
     1>.野指针：指向僵尸对象的指针（只要给野指针发送消息就会报错）
     // 一般为了避免给野指针发送消息程序报错，当一个对象被释放后我们会将这个对象的指针设置为空指针
     */
    WMGameProxy *currentWM = [[WMGameProxy alloc]init]; // 引用计数器 = 1
    [currentWM release]; // 引用计数器 - 1 = 0 -> 对象被释放/此时[[WMGameProxy alloc]init]为僵尸对象/currentWM为野指针
    // 2>.空指针：指向没有储存空间的指针
    // 为了避免给野指针发送消息会报错，一般情况下当一个对象被释放后我们会将这个对象的指针设置为空指针
    // 因为在OC中给空指针发送消息程序不会报错
    currentWM = nil;
    // 指针变量currentWM调用release方法 <==> 给指针变量currentWM发送release消息
    [currentWM release]; // 给currentWM（野指针）发送消息程序会报错
    [currentWM release];
    [currentWM release];
}

// 9.MRC模式下多个对象的内存管理
-(void)doubleObjectMemoryManager {
    /*
     // B对象做为A对象的属性：有增就有减（有retain就有release）
     >当A对象想要使用B对象的时候（"setter方法"）一定要对B对象进行一次retain（拥有B对象的所有权：保证A对象存在B对象就一定存在）
     >当A对象释放的时候（“dealloc方法”）一定要对B对象进行一次release（释放B对象的所有权：保证A对象释放了B对象也会被随之释放）
     // A类
     @interface Person : NSObject {
        Dog *_dog;
     }
     -(void)setDog:(B *)dog;
     -(Dog *)dog;
     @end
     
     @implementation Person
     -(void)setDog:(B *)dog {
        // 如果两次对象不一样：避免重复赋值野指针错误
        if (_dog != dog) {
            // 将以前的对象release：避免旧对象内存泄露
            [_dog release];
            // 对现在的对象retain
            _dog = [dog retain];
        }
     }
     -(Dog *)dog {
        return _dog;
     }
     -(void)dealloc {
        // [_dog release];
        // _dog = nil;
        self.dog = nil;
        [super dealloc];
     }
     @end
     // B类
     @interface Dog : NSObject
     
     @end
     
     @implementation Dog
     
     @end
     // Main方法
     Person *p = [[Person alloc] init];
     Dog *d = [[Dog alloc] init];
     p.dog = d;
     [p release];
     [d release];
    */
//    // 以上代码太过于繁杂我们可以通过property简化代码
//    @property (retain) Dog *dog;
}

/*
 10.自动释放池Autoreleasepool
 1>.概念：一种支持引用计数的内存管理方式
 2>.作用：只要给对象发送“autorelease消息”就会将对象放到自动释放池：当自动释放池被销毁的时候会对池中所有的对象做一次“release操作”（并不代表会释放对象）
 3>.p = [p autorelease];  // autorelease返回对象本身（不会修改对象的引用计数器）
 4>.好处：1.不用关心对象释放的时间、2.不用关心什么时候调用release | 缺点：延迟释放会延长对象的生命周期，适合占用内存小的对象使用
 5>.原理：“autorelease”实际上是将“release”延迟执行：只要对象发送“autorelease”系统就会将对象放入“自动释放池”中，当“自动释放池”被销毁就会对内部的所有对象发送“release”
 6>.特点：加入到自动释放池以后可以接着使用该对象、release以后不可以接着使用该对象、自动释放池无序、自动释放池可以嵌套使用（就近原则）
 */
/*
 7>.自动释放池注意事项
 1.调用autorelease必须在autoreleasepool{}内部不然没有效果
 2.写在autoreleasepool{}内部的代码必须”调用autorelease“才会将对象放入自动释放池中
 3.只要在autoreleasepool{}内部”调用autorelease“就有效果
 4.尽量避免对大内存使用“autoreleasepool{}方法”（因为这是一种延迟释放机制）
 5.一个“alloc/new/copy/retain”对应一个“release/autorelease”（不要过度释放）
*/
/*
 8>.什么时候使用“自动释放池”？
 1.如果对象需要返回 -> 那么对象不能在返回之前release -> 那么在返回之前需要将对象放入自动释放池
 2.使用类工厂方法创建的对象如果在MRC中一般都使用autorelease
 +(instancetype)GameProxy {
    return [[[self alloc] init] autorelease];
 }
*/
-(void)setAutoRelease {
    /// 新建自动释放池
    // 1>.第一种方法：iOS5.x以后
    @autoreleasepool { // 创建自动释放池：iOS程序运行过程中会创建无数个“自动释放池”（可以嵌套）、“自动释放池”以栈结构存在（先进后出）
        // 执行代码块
        // 第一种写法
        WMGameProxy *wm = [[WMGameProxy alloc]init];
        // 把"指针变量p"指向的“实例变量”放到了“自动释放池”中（对象还是可以访问）
        // 只要调用了“autorelease”就不用在调用"release"
        // 将这个对象放到栈顶的自动释放池
        wm = [wm autorelease];
//        // 第二种写法
//        WMGameProxy *wm = [[[WMGameProxy alloc]init] autorelease];
        [wm setSdk:@"sdk"];
    }  // 销毁自动释放池：给自动释放池中所有对象发送一条“release消息”
//    // 2>.第二种方法：iOS5.x以前
//    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
//    // 执行代码块
//    [pool drain];
    // 3>.自动释放池的嵌套使用
    @autoreleasepool {
        @autoreleasepool {
            @autoreleasepool { // 栈顶自动释放池：离调用autorelease方法最近的自动释放池
                // 当一个对象调用autorelease方法时会将这个对象放到栈顶的释放池
                WMGameProxy *wm = [[[WMGameProxy alloc]init] autorelease];
//                // 注意：添加两次autorelease将来就会release两次
//                WMGameProxy *wm1 = [[[[WMGameProxy alloc]init] autorelease] autorelease];
            } // 此处就会销毁
        }
    }
    // 4>.自动释放池不适宜放占用内存比较大的对象
    // a、尽量避免对大内存使用该方法
    // b、不要把大量循环操作放在同一个"@autoreleasepool{}"之间，这样会造成内存峰值的上升
} // 自动释放池销毁：给自动释放池中的对象都发送一条release（不代表对象一定会销毁）
/*
 什么是自动释放池？简述一下自动释放池的原理，什么情况下需要使用自动释放池？
 // 什么是自动释放池？
 一种支持引用计数的内存管理方式
 // 简述一下自动释放池的工作原理
 “autorelease”实际上是将“release”延迟执行：只要对象发送“autorelease”系统就会将对象放入“自动释放池”中，当“自动释放池”被销毁就会对内部的所有对象发送“release”
 // 什么情况下需要使用自动释放池
 1.如果对象需要返回 -> 那么对象不能在返回之前release -> 那么在返回之前需要将对象放入自动释放池
 2.使用类工厂方法创建的对象如果在MRC中一般都使用autorelease
 +(instancetype)GameProxy {
    return [[[self alloc] init] autorelease];
 }
 */
/*
 释放池中的对象是用什么数据结构存储的？
 栈结构
 */
/*
 自动释放池autorelease和垃圾回收gc有什么不同？
 自动释放池autorelease：延迟释放对象（自动释放池autorelease释放就会自动让池中所有对象调用一次release）
 垃圾回收gc：每隔一段时间询问程序：是否有“无指针指向的对象”，如果有则将他回收
 */
/*
 在应用中可以创建多少autorelease对象？是否有限制？
 无限制
 */
/*
 不手动指定autoreleasepool的前提下，一个autorealese对象在什么时刻释放？
 // 手动干预释放
 指定autoreleasepool，当autoreleasepool的作用域结束的时候释放
 // 系统自动释放
 不指定autoreleasepool，autorelease对象出了作用域以后就会被添加到最近一次创建的autoreleasepool中，并会在当前runloop迭代结束的时候释放
 我们知道：所有autorelease对象在出了作用域以后就会被自动添加到最近创建的自动释放池中。如果每个都放到应用程序的main中的autoreleasepool中迟早会被撑满，所以必须在一次完整的运行循环结束之前销毁
 // 如果VC的viewDidLoad中创建一个autorelease对象，那么该对象会在viewDidAppear方法执行前被销毁
 */
/*
 什么时候会创建自动释放池？
 运行循环检测到事件并启动以后就会创建自动释放池：子线程的runloop默认不工作，无法主动创建，必须手动创建
 */
/*
 autorelease对象在什么时候释放？autorelease在什么时候使用比较适合呢？
 // autorelease对象在什么时候释放？
 autorelease会将对象放入autoreleasepool中，当autoreleasepool释放的时候所有的对象都会被release一次
 // autorelease在什么时候使用比较适合呢？
 当一个对象使用完成以后不能直接释放还有其它作用的时候使用autorelease最合适，比如当一个方法中需要返回对象的时候
 */

/*
 11.ARC
 1>.概念：自动引用计数、编译器特性（不是运行时特性）、Xcode5.x版本以后默认是ARC模式
 2>.不允许写retain/release/autorelease|可以调用dealloc()，但是不允许使用[super dealloc];
 3>.判断原则：只要还有一个强指针变量指向对象，对象就会保持在内存中（默认所有的指针都是强指针、忘记MRC，忘记引用计数...）
 4>.从执行效率上讲 - ARC优于MRC
 */
// ARC模式下可以使用autoreleasepool：在线程中大量分配对象而不使用autoreleasepool则可能会造成内存泄露
// 指向对象的强指针变量什么时候不再指向对象：1、过了作用域被销毁；2、设置为nil
// 其它语言的垃圾回收机制是定时去查看内存把不需要的内存进行回收；ARC是编译器在适当的位置写上retain/release代码然后执行代码
-(void)setARC {
    // 明确声明这是一个强指针（一般指针默认是强引用）
    __strong WMGameProxy *wm = [[WMGameProxy alloc]init];
    // 明确声明这是一个弱指针（只有弱指针指向的对象也会被释放）
    __weak WMGameProxy *wm1 = wm;
    // 刚创建出来就会被释放：在开发中不要使用一个弱指针保存一个刚刚创建的对象（一创建就会被释放）
    __weak WMGameProxy *wm2 = [[WMGameProxy alloc]init];
    // 执行完这行代码“对象wm”就会被释放
    wm = nil;
}
/*
 weak和strong的区别?
 1.用于ARC模式下修饰变量：weak是弱引用，strong是强引用
 2.strong类似于MRC机制下的retain，weak相当于MRC机制下的assign（weak比assign多一个功能：当对象消失后自动把指针变成nil，可以有效防止野指针）
 */

/*
 12.ARC模式下多个对象的内存管理
 1>.A对象想拥有B对象就需要用一个强指针指向B对象；A指针不再使用B对象什么都不需要做（编译器会自动帮我们释放）
 // A类
 @interface Person : NSObject
 // 在ARC中保存一个对象用strong：相当于MRC中的retain
 @property (nonatomic, strong) Dog *dog;
 @end
 
 @implementation Person
 
 @end
 // B类
 @interface Dog : NSObject
 // 在MRC中使用weak替代ARC中的assign：在ARC中assign是专门用来保存基本数据类型
 @property (nonatomic, weak) Person *owner;
 @end
 
 @implementation Dog
 
 @end
 // Main方法
 Person *p = [[Person alloc] init];
 Dog *d = [[Dog alloc] init];
 p.dog = d;
 d.owner = p;
*/

/*
 13.集合对象的内存管理
 1>.当创建数组的时候：对数组中的所有对象进行一次retain
 2>.当销毁数组的时候：对数组中的所有对象进行一次release
 1>.如果数组将一个对象添加：那么数组会对对象进行一次retain
 2>.如果数组将一个对象移除：那么数组会对对象进行一次release
 */

/*
 14.mutableCopy和Copy
 1>.mutableCopy - 创建可变对象
 2>.Copy - 创建不可变对象
 3>.使用Copy/mutableCopy的对象必须遵循NSCopying/NSMutableCopy协议（实现copyWithZone:/mutableCopyZone:方法）
 4>.oc中的对象全部默认遵循NSCopying/NSMutableCopy协议
 */
/*
 因为调用copy方法有时候会生成一个对象，有时候未生成一个新的对象
 1.如果生成一个新的对象我们称为深拷贝，本质就是会创建一个新的对象/原来对象的引用计数不变/新的对象引用计数 + 1
 2.如果未生成一个新的对象，我们称为浅拷贝，本质就是指针拷贝/引用计数 + 1
 */
-(void)setCopy {
    // 位于常量区 - 不需要手动管理内存
    NSString *str = @"str";
    // 会生成新的对象
    // 1.只要是拷贝出来的对象的内容和以前对象的内容一致
    // 2.一般情况下拷贝会生成一个新的对象
    // 3.修改原来的对象不会影响拷贝出来的对象/修改拷贝出来的对象也不会影响原来的对象
    // 4.生成一个新对象可以让"不可变对象"生成"可变对象"
    NSMutableString *newStr = [str mutableCopy];
    // 会生成新的对象
    // 虽然都是"可变对象"：但是因为会修改相互影响，所以必须生成新对象
    NSMutableString *copyStrM = [newStr mutableCopy];
    /// 不会生成新的对象
    // 此时不会生成一个新对象 - 因为原来的对象和拷贝出来的对象都是"不可变对象"（因为不能修改所以无法相互影响）
    NSString *copyStr = [str copy];
    /*
     深拷贝：生成值一样，内存地址不一样的全新对象（内容拷贝/生成新的对象）
     浅拷贝：使原对象的引用计数+1，没有创建全新的对象，直接返回被拷贝对象的地址（指针拷贝/没有生成新的对象）
     // 不可变字符串：右侧如果是copy，那么就是浅拷贝；右侧如果是mutableCopy，那么就是深拷贝
     NSString *msg0 = @"";
     NSString *msg2 = [msg1 mutableCopy]; // 深拷贝
     NSString *msg1 = [msg0 copy]; // 浅拷贝：对原对象进行一次retain
     // 可变字符串：右侧无论是copy还是mutableCopy都是深拷贝
     NSMutableString *msg3 = [NSMutableString stringWithString:@""];
     NSString *msg1 = [msg0 copy];// 深拷贝
     NSString *msg2 = [msg1 mutableCopy];// 深拷贝
     1.浅拷贝类似retain，深拷贝类似copy
     2.https://blog.csdn.net/chenyufeng1991/article/details/51771728
     -(id)copyWithZone:(NSZone *)zone {

     }
     -(id)mutableCopyWithZone:(NSZone *)zone {

     }
     */
    /*
     copy内存管理
     1.浅copy - 不会生成新的对象，所以系统会对以前的对象进行一次retain，之后对原来的对象进行一次release
     2.深copy - 生成新的对象，所以系统不会对以前的对象进行retain，但是我们需要对新的对象进行release（生成新的对象默认会retain一次）
     注意⚠️：如果已知字符串是不可变字符串（比如网络加载的数据）可以使用strong替代copy：因为使用copy会判断一次字符串是否是不可变字符串
    */
//    // ！！！Copy内存管理的正确写法！！！
//    NSString *str = [[NSString alloc]initWithString:@"xwj"];
//    NSString *newStr = [str copy];
//    [str release];
//    [str release];
//    // ！！！Copy内存管理的正确写法！！！
}
/*
 // 自定义类实现Copy
 - (id)copyWithZone:(nullable NSZone *)zone {
     // 1.创建一个新对象
     WMGameProxy *wm = [[[self class] allocWithZone:zone] init];
     // 2.设置当前对象的内容给新对象
     wm.mName = _mName;
     // 3.返回新对象
     return wm;
 //    // 如果父类已经实现该协议
 //    id obj = [super copyWithZone:zone];
 //    obj.age = _age;
 //    return obj;
 }

 - (id)mutableCopyWithZone:(NSZone *)zone {
     // 1.创建一个新对象
     WMGameProxy *wm = [[[self class] allocWithZone:zone] init];
     // 2.设置当前对象的内容给新对象
     wm.mName = _mName;
     // 3.返回新对象
     return wm;
 }
 */

/*
 调用autorelease的对象在什么时候会被release?
 1.对于每一个调用autorelease的对象，系统只是把该对象放入当前的autoreleasepool中，当autoreleasepool被释放的时候，autoreleasepool中所有的对象都会被release
 2.对于每个runloop，系统会隐式创建一个autoreleasepool（所有的autoreleasepool构成栈式结构），在一个runloop结束时，当前栈顶的autoreleasepool会被销毁
 */
/*
 简述一下Objective-C的内存管理方法（自动内存计数、手动内存计数、自动内存池）
 Objective-C的内存管理方法有3种：自动内存计数ARC、手动内存计数MRC、自动内存池Autorelease
 // 自动内存计数ARC
 不需要开发人员自己管理内存，编译器会在适当的地方加上“release/retain代码”
 // 手动内存计数MRC
 所有对象的内存都需要开发人员手动管理，开发人员需要自己在适当的地方加上“release/retain代码”
 // 自动内存池Autorelease
 只要给对象发送“autorelease消息”就会将对象放到自动释放池。当自动释放池被销毁的时候会对自动释放池中所有的对象做一次“release操作”
 */
/*
 刚刚创建的对象添加到可变数组，如果释放这个对象会发生什么？如果释放这个数组会发生什么？
 ```
 MyClass *obj = [[MyClass alloc] init]; // retainCount = 1
 [myMutableArray addObject:obj]; // retainCount = 2
 // 如果释放这个对象会发生什么？
 [obj release]; // retainCount = 1/对象将会被保留
 // 如果释放这个数组会发生什么？
 [myMutableArray release]; // retainCount = 0/对象将会被释放
 ```
 */
/*
 **下列代码输出什么？**
 ```
 NSString *name = [[NSString alloc] init]; // 在堆区开辟一块内存：name指向堆区
 name = @"hahahaha"; // name指向常量区：堆区的内存没有释放也没有指针指向
 [name release];
 ```
 >内存泄漏
 */
/*
 **执行下列代码会出现什么结果？简述原因**
 ```
 NSString *name;
 [name release];
 ```
 >内存泄漏：过度释放
 */

@end
