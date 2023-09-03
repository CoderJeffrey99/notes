//
//  WMGameProxy.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

// 由于继承NSObject、所以导入Foundation
// import可以防止重复导入（其它功能参考include）
#import <Foundation/Foundation.h>
#import "SyPostItem.h"

/*
 NS_ASSUME_NONNULL_BEGIN
 // 此处属性默认属性是nonnull
 NS_ASSUME_NONNULL_END
 */
NS_ASSUME_NONNULL_BEGIN
/*
 1.认识Objective-C语言
 1>.概述：面向对象(oop)的C语言（完全兼容C语言：C语言代码可以直接编译在Objective-C工程中）
 2>.源文件：.h/.m/.mm；
 3>.关键字：C语言关键字在Objective-C中都可以使用/新增部分关键字（interface、public、implementation等）
 4>.数据类型：BOOL/SEL/null
 5>.C语言/int <==> OC语言/NSInteger <==> swift语言/Int
 */

/*
 2.面向对象OOP
 1>.特点：面向对象编程是把问题中拥有相同属性的东西建立一个类，然后创建类的对象
 2>.不同点：面向对象编程注重生活逻辑、面向过程编程注重数学逻辑
 3>.面向对象的三大特征
 // a、封装
 利用类将数据和基于数据的操作封装在一起，数据被保护在类的内部，系统的其它部分只有通过被授权的操作才可以访问数据
 将不需要对外提供的内容隐藏起来：把属性隐藏起来，提供公共方法对外访问
 // b、继承/派生
 继承：父类的属性（成员变量：不包括私有）和方法（对象方法&类方法），子类可以直接获取
 派生：子类保持父类中的行为和属性，新增其它功能（对象方法&类方法可以重写、属性不能重写）
 提示：每个类的“[super class]指针”指向自己的父类/“isa指针”指向元类/OC只支持单继承
 好处：1).创建大量类抽取重复代码；2).建立类与类之间的关系
 缺点：1).耦合性（依赖性）太强
 特点：子类可以使用父类的所有方法（方法可以重写）/子类可以访问父类非私有的成员变量（成员变量不能重写）
 // c、多态：事物的多种表现形态/同一个接口不同的实现/通过不同的对象调用相同的名称的方法，却产生不同的结果
 特点：父类指针指向子类对象（不看指针看对象/想要调用子类特有的方法必须强制类型转换成子类才能调用）
 实现条件：有继承关系、有重写、父类的指针指向子类的对象
 优点：提高了代码的扩展性
 */

/*
 3.主头文件 - copy该工具箱中所有工具的头文件的文件
 1>.只需要导入主头文件就可以使用该工具箱中所有头文件，避免每次使用都需要导入一众对应的头文件
 2>.主头文件的名称都和工具箱的名称相同（导入该工具箱的所有头文件）
 */

/*
 4.类class：属性 + 行为（谁最清楚这个行为，那么行为就属于谁）
 1>.定义：具有相同和相似性质对象的抽象就是类；对象的抽象就是类，类的具体化就是对象（堆内存）
 2>.类 = 结构体(存储数据) + 函数(管理数据)
 3>.实质：类的实质是一个对象，该对象会在这个类第一次被使用的时候创建
 */

/*
 5.iphone应用程序的项目基本结构
 project
    Classes -源代码文件
    OtherSources -存放非OC源代码
    Resources -非代码文件
    Frameworks -框架
    Products -项目在编译时生成的应用程序（xxx.app）
 */

/*
 6.对象的内存存储细节
 1>.程序启动：将”程序写的代码类“加载在代码区 -> 系统会根据”程序写的代码类“自动在堆区创建类对象（一个类在内存中只有一份类对象、保存当前类中的所有对象方法）-> 调用[xxx new]其实就是在类对象中找到new方法帮我们创建一个实例对象（实例对象中第0个属性isa指针指向类对象）-> 在栈区有个局部变量p指向实例对象（保存实例对象的内存地址）
 2>.对象方法：给局部变量p发送消息 -> 根据p找到指向的存储空间 -> 根据存储空间中的isa指针找到类对象（方法列表）-> 执行
 3>.类方法：直接找到类对象（方法列表）-> 执行
 // 4>.获取类对象
 Person *p = [[Person alloc] init];
 [p class];
 [Person class];
 // 5>.应用
 // 直接调用类方法
 [[p class] test];
 // 用于创建实例对象
 Person *p1 = [[[p class] alloc] init];
 */

// .h文件用来声明类
// NSObject是基类（顶级父类）
// 子类可以继承父类的所有方法和属性（私有属性虽然拥有但是不能访问/非私有属性才可以访问）
// 父类的属性可以继承、但是方法只能通过super调用
// WMGameProxy类名/类名首字母必须大写
// .h/.m相互切换：command + control + 👆
// @interface声明类
// 自定义泛型
// __covariant协变：子类转父类
// __contravariant逆变：父类转子类
@interface WMGameProxy <__covariant ObjectType> : NSObject <NSCoding, NSCopying, NSMutableCopying> {
    // 7.定义属性
    /*
     成员变量和属性的区别
     // 成员变量
     成员变量的默认修饰符是`@protected`/不会自动生成`setter/getter`方法，需要手动实现/不能使用点语法调用，因为没有`setter/getter`方法，只能使用`->`
     // 属性
     属性会默认生成带下划线的成员变量和`setter/getter`方法/可以用点语法调用（实际调用的是`setter/getter`方法）
     */
    // 成员变量不能离开类：只能写在类内部
    // 在OC中：成员变量不能直接赋值（不能直接初始化）、swift可以
    // ！！！定义成员变量：变量必须使用下划线！！！
    // Objective-C语言没有真正意义的私有方法、只是一个约定而已、也是可以调用
    // Objective-C语言支持消息机制（运行时可以动态绑定）
    // 引用私用api（苹果官方私有方法）不能上架AppStore
    // 存储在堆区（当前对象对应的堆的存储空间中）：不会被自动释放（程序员手动释放）
    // 2>.Objective-C语言修饰符
    // 修饰范围：从出现的位置到第二个修饰符出现或者遇到"}"，可以同时修饰后面所有的成员变量
    @private  // 私有成员：只能被本类访问、不能被子类访问、不能被外部访问（虽然不能访问但是还可以查看，如果不想让其查看可以直接定义在.m中）
    NSString *_name;
    @protected  // 受保护的属性：默认属性、可以被本类访问、也能为子类访问、不能被外部访问
    NSString *_age;
    @public   // 公共成员：能被本类访问、能为子类访问、能被外部访问
    NSString *_height;
    @package  // 只能在当前包中才能被访问（在当前包中相当于public、在非当前包中相当于private）
}
// @property编译器指令
// 如果类中成员变量太多，setter/getter方法非常臃肿
// 1.让编译器自动声明“setter/getter方法”/2.生成_sdk成员变量（默认用private修饰）
// 持有的对象sdk引用计算 + 1
// 通过自动释放池管理内存
// 如果重写setter/getter方法，则以重写的为主/@property就不会自动声明setter/getter方法
// 自动生成的变量_sdk是私有变量
@property (strong, nonatomic) NSString *sdk;
// @synthesize编译器指令（孙色size）
// 让编译器自动实现setter/getter方法（Xcode4.6以后可以省略）
// atomic原子属性：对当前属性`setter/getter`方法进行加锁、线程安全、消耗大量的资源、访问速度慢、多线程环境下存在线程保护/默认
// nonatomic非原子属性：不加锁、线程不安全、访问速度快、多线程环境下不存在线程保护（因为开发中很少会遇到线程安全问题）
@property (strong, atomic) NSString *publishName;
// assign一般用于基本类型、直接赋值（默认）
// retain保留对象
// copy拷贝对象、修饰字符串（不可变字符串可以直接使用strong）
// 这里不需要加*
@property (assign, nonatomic) NSInteger publishAge;
// readonly只读：只生成getter方法
// readwrite缺省：生成“getter/setter方法”
@property (readonly, strong, nonatomic) NSString *GameKey;
// 可以增强代码的可读性
// 给getter方法取别名
// 一般使用于BOOL：改成isXxx
@property (getter = myWeight) NSInteger weight;
// 给setter方法取别名
// 一般不使用
@property (setter = myHeight:) NSInteger mheight;
// 多个属性使用","隔开
@property (setter = setUserName:, getter = getUserName, strong, nonatomic) NSString *mName;
/*
 // https://blog.csdn.net/conglin1991/article/details/77159652
 表示"可能为空"：用于属性、参数、方法返回值、为了迎合swift（不能用于基本数据类型）
 // nullable
 // 1>.修饰属性
 @property (nullable, strong, nonatomic) SyPostItem *item;
 // 2>.修饰形参
 -(void)getMax:(nullable NSString *)string {}
 // _Nullable（推荐使用）
 // 1>.修饰属性
 @property (strong, nonatomic) SyPostItem * _Nullable item;
 // 2>.修饰形参
 -(void)getMax:(NSString * _Nullable)string {}
 */
@property (nullable, strong, nonatomic) SyPostItem *item;
/*
 表示"不能为空"：用于属性、参数、方法返回值、为了迎合swift（不能用于基本数据类型）
 // 修饰属性
 @property (nonnull, strong, nonatomic) NSString *resetName;
 // 修饰形参
 -(void)getMax:(nonnull NSString *)string {}
*/
@property (nonnull, strong, nonatomic) NSString *resetName;
// // null_resettable
// 表示必须处理为空的情况（重写getter方法、不能用于基本数据类型）
// getter方法不能返回nil，setter方法可以传入nil
// // _Null_unspecified不确定是否为nil
//@property (null_resettable, strong, nonatomic) NSString *copyName;
// 如果想对传入的数据进行过滤需要重写“getter/setter方法”
// 如果重写“getter/setter方法”，property将不再生成“getter/setter方法”
@property (nonatomic, retain, readonly) NSString *userName;
// 自定义泛型
@property (strong, nonatomic) ObjectType obj;
/*
 __kindof：表示当前类或者子类
 作用：给某个类提供类方法，可以让外界知道创建了什么对象
 */
+(__kindof WMGameProxy *)WMGameProxy;

#pragma mark - 这是一个注释（可以用来分割功能点）
// 定义方法/行为
// 冒号也是方法名的一部分
// 定义在.h文件中的方法都会公有的、不能使用private/protected/public修饰（这点与java等其他语言不同）
// 对象方法：只能被对象名调用、以“-”开头
// 方法属于类
// ⚠️在oc中“()”只有一个作用：括住数据类型
// 对象作为参数传递是地址传递
-(void)loginWithGameId:(NSString *)gameId GameKey:(NSString *)gameKey;

/*
 8.类方法：以“+”开头
 1>.概念：C++中的静态方法/不属于任何一个对象/通过类名调用，不需要创建对象/不能直接调用对象方法和成员变量
 2>.对一个功能模块留下简单的对外接口
 3>.类方法的执行效率比对象方法高：对象方法可以访问成员变量/类方法中不可以直接访问成员变量
 */
+(instancetype)getInstance;

// 1>.一定是类方法+
// 2>.方法名称以“类名”开头/首字母小写
// 3>.一定有返回值id/instancetype
+(instancetype)wmGameProxy;
+(instancetype)wmGameProxyWithSdk:(NSString *)sdk;

-(id)initWithSdk:(NSString *)sdk;

#pragma mark - 只要给属性赋值或者取值都会第一时间想到getter/setter方法
// 不推荐直接给属性赋值
// 如果需要给属性赋值、可以使用setter方法
// 修改实例变量
-(void)setSdk:(NSString * _Nonnull)sdk;

// 获取属性内容、可以使用getter方法
// 读取实例变量
-(NSString * _Nonnull)getSdk;

// 通过传入NSDictionary赋值模型
// 返回的model放在数组
+(instancetype)gameWithDict:(NSDictionary *)dict;

// 消息中心
-(void)onChange:(NSNotification *)notifucaiton;

// 声明类结束的标志
@end

NS_ASSUME_NONNULL_END
