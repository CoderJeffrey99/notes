//
//  WMRuntimeViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/20.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMRuntimeViewController.h"
// 导入头文件
#import <objc/runtime.h>
#import <objc/message.h>

@interface WMRuntimeViewController ()

@end

@implementation WMRuntimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /*
     1.runtime简介：runtime简称运行时，oc就是运行时语言
     1>.对于C语言：函数的调用在编译的时候就会决定调用哪个函数
     2>.对于OC语言：编译的时候并不能决定真正调用哪个函数，只有运行的时候才会根据函数的名称找到对应的函数（动态调用过程）
     3>.在编译阶段：oc可以调用任何函数（即使这个函数未实现/只要声明了就不会报错）/C语言调用未实现的函数就会报错
     */
}


// 2.获取类的属性列表
-(void)listProperty {
    // 无符号整型用来存放属性列表中属性个数
    unsigned int propertyCount;
    // 通过此方法获取属性列表：可以简单理解为得到的是一个属性的数组
    /*
     第一个参数：要获取属性列表的类
     第二个参数：一个无符号整型的地址（得到的属性列表的个数存放在此位置）
     */
    objc_property_t *propertyList = class_copyPropertyList([WMRuntimeViewController class], &propertyCount);
    // 遍历属性列表
    for (int index = 0; index < propertyCount; index++) {
        objc_property_t property = propertyList[index];
        const char *propertyName = property_getName(property);
        NSLog(@"属性名称%@", [NSString stringWithUTF8String:propertyName]);
    }
}


// 3.获取类的方法列表
-(void)listMethod {
    // 准备一个无符号整型用来存放方法列表的个数
    unsigned int count = 0;
    // 通过此方法获取方法列表：可以简单理解为得到的是一个存放所有方法的数组
    /*
     第一个参数：要获取方法列表的类
     第二个参数：一个无符号整型的地址（得到的方法列表的个数存放在此位置）
     */
    Method *methodList = class_copyMethodList([WMRuntimeViewController class], &count);
    // 遍历方法列表
    for (int index = 0; index < count; index++) {
        Method method = methodList[index];
        NSLog(@"方法名称%@", NSStringFromSelector(method_getName(method)));
    }
}


/*
 4.消息机制：任何方法的调用本质就是发送一个消息（用runtime发送一个消息）
 必须导入#import <objc/message.h>
 */
-(void)sendMessage {
//    // 1.不推荐使用该方法
//    // Xcode编译器Clang -> 最终生成消息机制（可以将Objective-C的源码改写成C++语言）
//    // 终端命令：clang -rewrite-objc xxx.m
//    id obj = [NSObject alloc];
//    // runtime都有一个前缀（谁的事情使用谁）
//    // 类方法的本质 - 利用类对象调用方法
//    // [NSObject class] // 获取类对象
//    // 一般开发中不这样写/太恶心
//    obj = ((NSObject *(*)(id, SEL))(void *)objc_msgSend)([NSObject class], @selector(alloc));
//    obj = [obj init];
    
//    // 2.工程配置：build setting -> 搜索msg -> NO
//    // 类方法 - 使用“类对象”调用
//    //id obj = [NSObject alloc];
//    //id obj = objc_msgSend([NSObject class], @selector(alloc));
//    id obj = objc_msgSend(objc_getClass("NSObject"), sel_registerName("alloc"));
//    // 对象方法 - 使用“对象”调用
//    // obj = [obj init];
//    //obj = objc_msgSend(obj, @selector(init));
//    obj = objc_msgSend(obj, sel_registerName("init"));
//    // 调用带多个参数的方法
//    obj = objc_msgSend(obj, @selector(initWithInt:), 20);
    /*
     3.什么时候使用runtime
     1>.装逼/YYKit
     2>.可以帮我们调用私有方法
     */
    /*
     4.方法调用流程
     // 对象方法
     1.首先在对象的“缓存方法列表”中查找，如果找到直接执行
     2.如果没有找到，就通过isa指针去对应的类对象的“方法列表”中查找，如果找到直接执行
     3.如果没有找到，说明本类中没有该方法，就会去父类中查找（直至找到根类）
     // 类方法
     1.首先在类的“缓存方法列表”中查找，如果找到直接执行
     2.如果没有找到，就通过isa指针去对应的元类的“方法列表”中查找，如果找到直接执行
     3.如果没有找到，说明本类中没有该方法，，就会去元类的父类中查找（直至找到根类）
     // (元)类的方法列表 -> (元)类的父类的方法列表 -> ... -> NSObject（元）类类对象的方法列表 -> 方法动态解析（未处理） -> 消息转发流程 -> crash
     */
}


// 5.交换方法：一般写在category中/拦截系统或框架的方法（经常使用）/底层黑魔法（method swizzling）https://www.jianshu.com/p/551880b8feb0
// 1>.什么时候调用 - 给“[UIImage imageName:@""];（系统方法）”添加功能
// 1.自定义UIImage并重写“imageName:方法”（有弊端：每次写该方法都需要导入头文件、以前已经完成的代码需要修改调用子类的方法）
// 2.交换方法/推荐使用
// 2>.需要给系统方法添加功能的时候可以使用runtime
// 1.给系统的方法添加分类category
// 2.自己实现一个带有扩展功能的方法/写在category中
// 3.交换方法/只用交换一次/写在category的load方法中
// */
//+(UIImage *)sy_imageNamed:(NSString *)name {
//    // 1.加载图片
//    UIImage *image = [UIImage sy_imageNamed:@"image_demo"];
//    // 2.判断
//    if (image) {
//        NSLog(@"加载成功");
//    } else {
//        NSLog(@"加载失败");
//    }
//    return image;
//}
//+(void)load {
//    // 获取+imageNamed:方法
//    /**
//     获取类方法
//     第一个参数 - self（在类方法中表示类）/获取哪个类
//     第二个参数 - SEL/获取哪个方法
//     */
//    Method imageNamedMethod = class_getClassMethod(self, @selector(imageNamed:));
//    Method sy_imageNamedMethod = class_getClassMethod(self, @selector(sy_imageNamed:));
//    // 获取对象方法
//    class_getInstanceMethod(self, @selector(exchangeMethod));
//    // 交换方法
//    method_exchangeImplementations(imageNamedMethod, sy_imageNamedMethod);
//}


// 6.动态添加方法（使用较少）
/*
 1>.美团面试：有没有使用过“performSelector方法”？？？在什么情况下使用？为什么要动态添加方法？
 // oc基本都是lazy加载机制：只要一个方法实现了就会马上添加到方法列表中
 2>.任何方法中都默认有两个隐式参数"self"（当前调用的类或对象）/"_cmd"（当前方法的方法编号）
 */
-(void)dynamicAddMethod {
    // 调用一个没有实现的方法（这个调用的是类方法还是对象方法（根据调用者判断））
    [self performSelector:NSSelectorFromString(@"play")];
}
/*
 什么时候调用：只要一个对象调用了一个未实现的实例方法就会调用该方法进行处理
 作用：动态添加对象方法（不动态添加方法直接返回NO）
 */
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == NSSelectorFromString(@"play")) {
        /*
         动态添加方法 - 可以直接查看文档（window -> developer Documentation）了解方法
         第一个参数 - 给哪个类添加方法
         第二个参数 - 添加哪个方法
         第三个参数 - 函数名
         第四个参数 - 方法类型
         "v@:" - v/返回值、@/参数、:/参数
         */
        class_addMethod(self, sel, (IMP)play, "v@:");
//        class_getInstanceMethod(self, @selector(play));
//        method_getTypeEncoding(method);
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}
// 任何方法中都默认有两个隐式参数"self"（当前调用的类或对象）/"_cmd"（当前方法的方法编号）
void play(id self, SEL _cmd) {
    NSLog(@"吃东西");
}
/*
什么时候调用：只要一个对象调用了一个未实现的类方法就会调用该方法进行处理
作用 - 动态添加类方法
*/
+ (BOOL)resolveClassMethod:(SEL)sel {
    return [super resolveClassMethod:sel];
}


// 7.动态添加属性/一般写在category中（经常使用）
/*
 1>.什么时候需要动态添加属性：怎么让NSObject保存一个字符串？/给系统的类添加属性的时候可以使用“runtime动态添加属性”
 2>.添加属性的本质就是让某一属性与某个对象产生一个关联
 */
-(void)dynamicAddProperty {
//    // 1.在category.h中写上
//    // 因为不会生成_name（不用属性修饰符）
//    @property NSString *name;
//    // 2.在category.m中实现setter/getter方法
//    -(void)setName:(NSString *)name {
//        /*
//         第一个参数 - 给哪个对象添加属性
//         第二个参数 - 属性名称
//         第三个参数 - 属性值
//         第四个参数 - 保存策略
//            OBJC_ASSOCIATION_ASSIGN - assign
//            OBJC_ASSOCIATION_RETAIN_NONATOMIC - strong, nonatomic
//            OBJC_ASSOCIATION_COPY_NONATOMIC - copy, nonatomic
//            OBJC_ASSOCIATION_RETAIN - strong,atomic
//            OBJC_ASSOCIATION_COPY - copy, atomic
//         */
//        objc_setAssociatedObject(self, "name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    }
//    -(NSString *)name {
//        /**
//        第一个参数 - 给哪个对象添加属性
//        第二个参数 - 属性名称
//        */
//        return objc_getAssociatedObject(self, "name");
//    }
}

/*
 消息转发机制：可以使一个类响应另外一个类中实现的消息
 // 1.方法调用的本质就是发送消息：首先调用objc_msgSend方法查找消息，如果查不到则会进入“消息转发”流程
 // 2.一般情况下，发送一个无法识别的消息会产生一个运行时的错误，导致程序崩溃，但是注意的是：在崩溃之前系统运行时对象会为每个对象提供第二次机会来处理消息
 1.调用"+ (BOOL)resolveInstanceMethod:(SEL)sel {}"：若返回YES则通过class_addMethod动态添加方法，消息被处理，流程完毕；若返回NO则进入下一步
 // 动态方法解析
 + (BOOL)resolveInstanceMethod:(SEL)sel {
    // 不动态添加方法
    return NO;
 }
 2.调用“- (id)forwardingTargetForSelector:(SEL)aSelector {}”用于指定哪个对象响应这个selector：若返回某个对象则会调用该对象的方法；若返回nil表示没有响应者则进入下一步
 // 消息快速转发
 - (id)forwardingTargetForSelector:(SEL)aSelector {
    // 不备选提供响应aSelector的对象
    // 不能返回self不然会出现死循环
    return nil;
 }
 3.调用“- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {}”指定方法签名：若返回nil则表示不处理；若返回方法签名则进入下一步
 // 消息慢速转发：消息签名
 - (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"eat"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
 }
 4.调用“- (void)forwardInvocation:(NSInvocation *)anInvocation {}”：可以修改实现方法、修改响应对象等，若没有实现该方法则进入下一步
 // 消息分发
 - (void)forwardInvocation:(NSInvocation *)anInvocation {
    // 改变方法选择器
    [anInvocation setSelector:@selector(jump)];
    // 改变调用对象为person
    [anInvocation invokeWithTarget:[[Person alloc] init]];
 }
 5.调用“- (void)doesNotRecognizeSelector:(SEL)aSelector {}”：若没有实现该方法程序就会crash（提示找不到该方法），到此，消息转发流程结束
 - (void)doesNotRecognizeSelector:(SEL)aSelector {
    NSLog(@"无法处理消息：%@", NSStringFromSelector(aSelector));
 }
 - (void)eat {
 NSLog(@"eat方法");
 }
 - (void)jump {
     NSLog(@"由eat方法改成jump方法");
 }
 */
/*
 程序什么时候会报unrecognized selector的异常？
 简单的来说：当调用该对象的某个方法，但是该对象没有实现这个方法的时候，我们可以通过“消息转发”来解决该异常
 */
/*
 类方法存放在哪里？为什么要这样设计？
 存放于元类中（易于区分，方便管理）
 */
/*
 一个类的类方法没有实现为什么可以调用`NSObject`同名对象方法？
 因为类方法存放于元类中，NSObject类的元类的父类就是NSObject类
 */
/*
 runtime如何实现将weak修饰的对象自动设置为nil？
 runtime对注册的类会进行布局：对于weak对象会放入一个用weak指向的对象内存地址作为key，当对象销毁的时候会以这个key在这个hash表中搜索，将搜索到的对象设置nil
 */
/*
 objc中向一个对象发送消息[obj foo]和`objc_msgSend()`函数之间有什么关系？
 // 该方法编译之后就是`objc_msgSend()`函数调用
 [obj foo];
 */
@end
