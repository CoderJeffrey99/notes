//
//  WMGameProxy.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

// 需要使用xxx文件就导入xxx.h
// 实际是将WMGameProxy.h文件拷贝到当前文件
#import "WMGameProxy.h"
#import "WMComponentController.h"
#import <objc/runtime.h>
// 类名
// @implementation类的实现
@implementation WMGameProxy {
    // 这里的私有变量无法查看，但是可以使用KVC赋值（OC没有真正的私有）
    int _gameCount;
}

// 什么时候调用：当程序一启动的时候调用（程序一启动就会将所有类的代码加载到内存中，放在代码区）
// 作用：将当前类加载进内存放在代码区（只会调用一次）
+ (void)load {
    // 如果存在继承关系：父类的load() -> 子类的load()
    // 有且仅有一次：加载到内存
    // 比“main()”函数还要先调用：这里的代码需要手动管理内存
}

// 什么时候调用：当第一次使用当前类的时候调用
// 作用：初始化当前类（会多次调用：被子类调用）
+ (void)initialize {
    // 如果存在继承关系：父类的initialize() -> 子类的initialize()
    // [xxx class] - 返回当前类的类对象
    if (self == [WMGameProxy class]) {
        // 第一次新建该类的时候调用：用于init某些静态变量
    }
}

// 构造方法
// 1>.概念：OC中称所有init开头的方法为构造方法
// 2>.特点：对象的初始化方法、以init开头的方法（必须的）、只能调用一次
// 3>.作用：初始化对象、初始化对象的成员变量
- (instancetype)init {
    // 4>.步骤（固定格式）
    // 1.必须先初始化父类：保留父类初始化操作
    self = [super init]; // self代表当前对象本身
    // 2.判断父类是否初始化成功
    if (self) {
        // 3.初始化子类（只有父类初始化成功才可以继续初始化子类）
        WMComponentController *vc = [WMComponentController alloc]; // 分配内存：创建对象后返回对象地址/堆空间
        vc = [vc init]; // 初始化
    }
    // 4.返回当前对象地址
    return self;
}

/*
 ### id和NSObject *有什么区别？
 // NSObject *是一个静态数据类型（也就是NSObject类型）：指向的必须是NSObject子类，调用的也只能是NSObject的方法（不是所有的oc对象都是NSObject的子类）
 // id是动态数据类型：通过动态数据类型定义变量可以调用任何方法（如果该方法不属于自己：编译不报错、运行报错）
 */
/*
 ### id/instancetype有什么区别？？？
 // 都是万能指针 == 指向任意类型
 // 1).id是一个动态数据类型（定义变量、作为函数参数、作为函数返回值）
 // 通过动态数据类型定义变量可以调用子类特有方法
 // 通过动态数据类型定义变量可以调用私有方法
 // 通过动态数据类型定义变量可以调用任何方法（如果该方法不属于自己：编译不报错、运行报错）
 // 2).instancetype
 // instancetype做为返回值赋值给一个其他类型会报警告（编译的时候可以判断对象的真实类型）
 // id做为返回值赋值给一个其他类型不会报警告（编译的时候不可以判断对象的真实类型）
 // instancetype只能做为返回值
 // id可以定义变量、作为返回值、形参
 */
/*
 ### 静态数据类型和动态数据类型的区别？？？
 1.静态数据类型：在编译期就明确变量的类型，可以访问属性和方法（不能调用子类特有的方法）/编译期就能发现错误
 2.动态数据类型：在编译期不清楚变量的类型，运行期才知道真实类型（可以调用子类特有的方法）/运行期才能发现错误
 */
/*
 ### 怎么避免动态数据类型运行期错误：由于动态数据类型可以调用任意方法(有可能调用到不属于自己的方法)、这样可能导致运行期错误
 // 应用场景：多态（可以减少代码量、避免调用子类特有的方法需要强制类型转换）
 id obj = [person new];
 // 判断某个对象是否属于某一个类（某一个类的子类）
 if ([obj isKindOfClass:[Person class]]) {
     [obj eat];
 }
 id obj = [self new];
 // 判断某个对象是否为当前类的实例
 if ([obj isMemberOfClass:[Person class]]) {
     [obj eat];
 }
*/

// 1>.自定义构造方法（也会被子类继承（Java中不行））尽量使用instancetype
// 自定义构造方法强制格式：大小写敏感、一个类可以有零个和多个自定义构造方法
// Objective-C中称所有init开头的方法为构造方法
// 构造方法用于“初始化对象”和“初始化对象的属性”
//-(instancetype)initWithXxx {
//
//}
// 属性名/方法名都尽量不要以new开头
-(instancetype)initWithSdk:(NSString *)sdk {
//    // 子类重写父类方法想要保留父类的对象方法
//    [self setName:name]; // 父类的属性init不要子类来做（狗拿耗子多管闲事）
//    self = [super initWithName:name]; // 父类的属性init应该调用父类的init方法
    
    // ！！！必须先赋值self！！！
    // super：仅仅是一个编译指示器指令：只要编译器看到super就会让“当前对象”去调用“父类方法”
    // 此处还是“WMGameProxy类的对象”在调用“NSObject类的对象”的“init()”方法
    self = [super init];
    // self不能离开类
    // self在对象方法中指向当前对象（谁调用对象方法self指向谁）
    // self在类方法中指向当前类
    // self->成员变量名; # 访问当前对象内部的成员变量
    // 不能在“对象方法/类方法”中使用self调用“自身对象方法/类方法”（死循环）
    if (self) {
        _name = @"";
        _age = @"";
        _height = @"";
        _sdk = sdk;
    }
    /*
     super：仅仅是一个编译指示器指令（给编译器看的：只要编译器看到super就会让“当前对象”去调用“父类方法”），不是一个指针（无法直接打印）
     1>.本质：只要编译器看到super就会让“当前对象”去调用“父类方法”（还是当前对象在调用方法）
     1、super在类方法中调用父类的类方法
     2、super在对象方法中调用父类的对象方法
     3、可以利用super在任意方法中调用父类方法
     4、子类重写父类的某个方法时候想要保留父类的一些行为：子类需要使用父类方法的时候也需要手动调用
     */
    /*
     class - 获取当前方法调用者的类
     superclass - 获取当前方法调用者的父类
     */
    // [self class] == [super class] = WMGameProxy
    // 当前类 = 父类 = 当前类 = 父类
    NSLog(@"%@ = %@ = %@ = %@", [self class], [self superclass], [super class], [super superclass]);
    return self;
}

// 对象方法中访问当前对象的属性_xxx
// 最大浮点数MAXFLOAT
-(void)loginWithGameId:(NSString *)gameId GameKey:(NSString *)gameKey {
    NSLog(@"login");
}

// 多态
-(void)polyMore {
//    // 1.有继承关系
//    // 2.有重写 - 重新实现父类方法（子类最终执行重写以后得方法）
//    // 3.父类指针a指向子类对象
//    Animal *a = [Dog new];
//    // 编译期：检查当前类型Animal有没有该方法
//    // 运行时：系统会判断a的真实类型
//    [a eat];
//    // 想要调用子类特有方法需要强制类型转换成子类
//    Dog *d = (Dog *)a;
//    [d eat];
}
/*
 **重写和重载的区别?**
 // 重写和重载都是多态的一种
 1.重写：子类方法重新实现父类方法（方法名和参数相同/实现不同/子类最终执行重写以后得方法）
 2.重载：在同一个类定义多个同名方法（每个方法具有不同参数类型或参数个数、与返回值无关）
 */

// 类工厂方法：Foundation框架的类但凡通过类工厂方法创建的对象都是autorelease的
// 1>.用于分配、初始化实例并返回一个自身的实例的类方法
// 2>.可以快速的创建对象（只使用一个步骤）
/*
 3>.自定义类工厂方法的规范
 a、一定是类方法+
 b、方法名称以“类名”开头：首字母小写
 c、一定有返回值id/instancetype
 */
+(instancetype)wmGameProxy {
//    // 4>.不要使用WMGameProxy（这样在继承的时候会出现问题）/改成self
//    // 5>.self在“类方法”中代表“类”：谁调用该方法self就代表谁
//    // 6>.apple规范：每个类都提供一个“自定义构造方法”和“自定义类工厂方法”用于创建对象
//    return [[WMGameProxy alloc] init];
    return [[self alloc] init];
//    // MRC环境下：可以自动释放内存
//    return [[[self alloc]init] autorelease];
}
+(instancetype)wmGameProxyWithSdk:(NSString *)sdk {
    // 父类指针指向子类对象
    WMGameProxy *p = [[self alloc] init];
    p.sdk = sdk;
    return p;
}
/*
 ### 类方法创造的对象要不要用release释放？？？
 任何方法创建的对象都必须遵从内存管理原则：用alloc方法分配的对象就需要释放；但是使用类方法创建对象的时候已经在方法内部做了处理（加上autorelease用于释放内存），所以我们就不需要再使用release释放内存
 ### 使用init()创建对象和使用initWithObject()创建对象有什么区别？？？
 使用init()创建对象：需要手动释放内存
 使用initWithObject()创建对象：无需使用release释放内存（系统自动加上autorelease用于释放内存）
 */

- (NSString *)description {
    // 死循环：输出self就是调用[self description];
    NSLog(@"%@", self);
    WMGameProxy *p = [[WMGameProxy alloc] init];
    // 调用方法：先从自己类中找 -> 再去父类中找
    // 1、返回当前对象
    // 只要利用%@打印对象就会调用“- (NSString *)description {}”方法：可以重写该方法让NSLog()返回我们需要的打印内容
    // 默认返回：<类名: 地址>
    NSLog(@"%@", p);
    // 2、返回当前类对象
    // 只要利用%@打印类调用“+ (NSString *)description {}”方法：可以重写该方法让NSLog()返回我们需要的打印内容
    // 默认返回：xxx
    NSLog(@"%@", [p class]);
    return [NSString stringWithFormat:@"%@", _height];
}

/*
 虚方法
 1>.定义：调用方法的时候不看指针看对象/对象的地址指向什么对象就调用什么方法
 2>.好处：可以描述不同事物被相同事件触发产生不同的响应
 3>.特征：OC中的每一个方法都是虚方法
 */

// 点语法
// 1>.引入：为了让程序设计简单化，属性可以在不使用"[对象指针 方法名称]"的情况下使用点语法
// 2>.实质：调用"setter/getter方法"（不是使用成员变量）
/*
 3>.特征
 // 点语法是一个编译器的特征（会在程序翻译成二进制的时候将点语法自动转换成"setter/getter方法"）
 // 点语法在等号左边就是setter方法，点语法在等号右边就是getter方法
 // 注意：一般情况下如果不是给成员变量赋值不建议使用点语法
 xiaoMing.name = @"小明"; <==> [xiaoMing setName:@"小明"];
 NSString *name = xiaoMing.name; <==> NSString *name = [xiaoMing getName];
 */
-(void)pointWay {
    WMGameProxy *wm = [[WMGameProxy alloc]init];
    wm.sdk = @"xxx"; // 在等号左边：编译器自动转换成“setter方法”
    NSString *name = wm.sdk; // 在等号右边（没有等号）：编译器自动转换成“getter方法”
    NSLog(@"%@", name);
    // 预置在编译器中的宏
    // __func__是一个字符串
    // 输出调用__func__的函数的函数名
    NSLog(@"%s", __func__);
    /*
     访问属性的方式：
     p->_age; // 真正Objective-C语法
     [p age];
     p.age;
     */
}

// 如果需要给属性赋值、可以使用setter方法
// 封装：屏蔽内部实现细节，对外提供共有的方法和接口
// 一定是对象方法：有参数无返回值
-(void)setSdk:(NSString * _Nonnull)sdk {
    _sdk = sdk;
//    // setter方法的实质
//    // 可以自己操作一把
//    if (_sdk != sdk) {
//        [_sdk release];
//        _sdk = [sdk retain];
//    }
}
// 获取属性内容、可以使用getter方法
// 一定是对象方法：无参数有返回值
-(NSString * _Nonnull)getSdk {
    return _sdk;
}

// 匿名对象：没有名字的对象
-(void)noNameObject {
    // 应用：当对象只需要使用一次的时候（对象作为实参传入方法中）
    // 每次使用new都会创建一个新对象
    /*
     1.为创建出来的对象开辟存储空间/将所有的属性设置为0/返回当前实例对象的地址 - alloc
     2.初始化对象所有的属性 - init
     3.返回对象的地址
     */
    [WMComponentController new];
}

#pragma mark - ！！！以下内容属于借用此处！！！
// json解析
// 实质：将所有的dict都转化成model放到对应NSArray中
// 把dict传入model
// model内部赋值
// 返回model
+(instancetype)gameWithDict:(NSDictionary *)dict {
    // 保证字典键（key）和模型的属性一致才可以使用KVC
    WMGameProxy *proxy = [[WMGameProxy alloc]init];
    
    [proxy setValuesForKeysWithDictionary:dict];
    return proxy;
}

// 归档
// 告诉需要保存当前对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.userName forKey:@"username"];
    [coder encodeInteger:self.weight forKey:@"weight"];
    [coder encodeObject:self.item forKey:@"item"];
}
// 当解析一个文件的时候调用
// 在xib中开始加载xib文件的时候就会调用
- (instancetype)initWithCoder:(NSCoder *)coder {
//    // 只有遵循“NSCoding协议”才可以调用
//    // 当前父类没有遵循“NSCoding协议”
//    self = [super initWithCoder:coder];
    self = [super init];
    if (self) {
        self.userName = [coder decodeObjectForKey:@"username"];
        self.weight = [coder decodeIntegerForKey:@"weight"];
        self.item = [coder decodeObjectForKey:@"item"];
    }
    return self;
}

// 通知相关
-(void)onChange:(NSNotification *)notifucaiton {
    // id属性没有“点语法”
    // 可以使用“get方法”
    NSLog(@"通知名称[%@]-通知内容[%@]-通知发布者[%@]",
          notifucaiton.name, notifucaiton.userInfo, notifucaiton.object);
}

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

// 实现类结束的标志
@end
