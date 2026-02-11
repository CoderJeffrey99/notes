# iOS面试题
### oc部分
**Objective-C语言有多继承吗？有什么替代方式**
```
1.Objective-C语言没有多继承
2.可以使用protocal协议来替代多继承
```

**Objective-C语言重写一个类的方式用继承好还是分类好**
```
一般情况下使用分类比较好，因为使用分类去重写类的方法仅对该分类有效，不会影响到其它类和原有类的关系
```

**Objective-C语言有私有方法吗？私有变量呢**
```
1.没有私有方法：Objective-C语言类中只有两种方法：静态方法和实例方法。虽然我们可以编写方法的时候不在.h文件中不声明，仅在.m文件中的匿名类别中声明，使方法对外不可见，但是外部仍然可以通过@selector来访问该方法，因此严格的来讲Objective-C语言不存在真正的私有方法
2.有私有变量：Objective-C语言使用@private修饰的成员变量和声明在xxx.m中的变量都是私有变量
```

**局部变量、全局变量和成员变量的区别**
```
// 局部变量
1.概念：定义在代码块（函数）中的变量
2.作用域：从定义的那一行开始，直至遇到'}'或return
3.特点：定义在“函数内部/代码块/形参”中的变量，可以定义的同时init也可以先定义再init（必须init：不init的局部变量的值是随机的）
4.存储：存储在栈中，当作用域结束系统会自动释放变量
// 全局变量
1.概念：定义在所有函数外部的变量
2.作用域：从定义的那一行开始，直至程序结束
3.特点：定义在所有函数外部的变量，定义的同时可以init（未init的全局变量默认为0）
4.存储：存储在静态区，随着程序的启动而创建，随着程序的结束而销毁
// 成员变量
1.概念：写在类声明中的变量，又称属性和实例变量，不能离开类
2.作用域：xxx
3.特点：不能在定义的同时初始化，只能通过对象调用
4.存储：存储在堆中，系统不会自动释放
https://www.jianshu.com/p/4ae48e4a84c9
```

**重写和重载的区别?**
```
// 重写和重载都是多态的一种
1.重写：子类方法重新实现父类方法（方法名和参数相同/实现不同/子类最终执行重写以后得方法）
2.重载：在同一个类定义多个同名方法（每个方法具有不同参数类型或参数个数、与返回值无关）
```

**Objective-C的类中有几种方法？**
```
1>.Objective-C的类中有两种方法：实例方法和类方法
// 实例方法
1.实例方法属于实例对象，只能通过实例对象调用（调用效率相对较低）
2.实例方法中可以访问成员变量
3.实例方法中可以直接调用实例方法，也可以通过类名调用类方法
// 类方法
1.类方法属于类对象，只能通过类对象调用（调用效率相对较高）
2.类方法中可以调用其它的类方法
3.类方法中不能直接访问成员变量，也不能直接调用实例方法
```

**id和NSObject *有什么区别？**
```
1.NSObject *是一个静态数据类型（也就是NSObject类型）：指向的必须是NSObject子类，调用的也只能是NSObject的方法（不是所有的oc对象都是NSObject的子类）
2.id是动态数据类型：通过动态数据类型定义变量可以调用任何方法（如果该方法不属于自己：编译不报错、运行报错）
```

**id/instancetype有什么区别？**
```
都是万能指针 == 指向任意类型
// id是一个动态数据类型（定义变量、作为函数参数、作为函数返回值）
1.通过动态数据类型定义变量可以调用子类特有方法
2.通过动态数据类型定义变量可以调用私有方法
3.通过动态数据类型定义变量可以调用任何方法（如果该方法不属于自己：编译不报错、运行报错）
// instancetype
1.instancetype做为返回值赋值给一个其他类型会报警告（编译的时候可以判断对象的真实类型）
2.id做为返回值赋值给一个其他类型不会报警告（编译的时候不可以判断对象的真实类型）
3.instancetype只能做为返回值
4.id可以定义变量、作为返回值、形参
```

**静态数据类型和动态数据类型的区别？**
```
1.静态数据类型：在编译期就明确变量的类型，可以访问属性和方法（不能调用子类特有的方法）/编译期就能发现错误
2.动态数据类型：在编译期不清楚变量的类型，运行期才知道真实类型（可以调用子类特有的方法）/运行期才能发现错误
```

**值传递和地址传递的区别？**
```
1.值传递：将原始对象的值传递给目标对象，系统将为目标对象重新开辟一个完全相同的内存空间（在函数中修改形参的值不会影响到外面实参的值）
2.地址传递：将原始对象对象在内存中的地址传递给目标对象，使目标对象和原始对象对应同一个存储空间（在函数中修改形参的值会影响到外面实参的值）
```

**import和include的区别？@class呢？“import <>”和“import ""”有什么区别**
```
// #import
可以引入头文件：将xxx.h复制到当前文件中，并且可以防止重复引入
// #include
可以引入头文件：将xxx.h复制到当前文件中，但是无法无法保证不会重复引入
// @class
1>.仅仅是告诉编译器后面的名称xxx.h是一个类，并不会包含这个类的任何内容，所以如果需要使用这个类需要在.m文件中import导入该类，@class可以提升编译效率，解决循环包含问题
2>.@class一般用于.h文件（除继承关系）/#import一般用于.m文件
// #import <>
表示先从开发工具的编译器环境中查找，如果找不到再到系统的编译环境中查找
// #import ""
>>表示先从当前文件所在的文件夹中查找，然后再从开发工具的编译器环境中查找，如果找不到再到系统的编译环境中查找
```

**下列方法的调用顺序是什么？**
```
// 从左到右：先算参数
// [object method1] -> [[object method1] method2] -> [object method4] -> [[[object method1] method2] method3:[object method4]]
[[[object method1] method2] method3:[object method4]];
```

**self.name = "object";和name = "object";有什么区别？**
```
// 会调用对象name的setter方法，引用计数+1
self.name = "object";
// 直接对当前对象name赋值，引用计数不增加
name = "object";
```

**self.name和self->name什么区别？**
```
1.self.name是点语法：调用属性name的setter/getter方法
2.self->name是直接访问成员变量name
```

**在NSString *obj = [[NSdata alloc]init];中obj编译和执行的时候分别是什么数据？**
```
编译：NSString对象
运行：NSData对象
```

**如何判断一个对象是否实现某方法？**
```
if ([self respondsToSelector:@selector(methodName)]) {
    // 已经实现该方法
} else {
    // 没有实现该方法
}
```

**‘setObject:forKey’和‘setValue:forKey’有什么区别？**
```
1.‘setObject:forKey’是NSMutableDictionary特有方法：key和value可以为除nil以外的任何对象
2.‘setValue:forKey’是KVC的主要方法：key只能是字符串，value可以为nil、[NSNull null]以及任何对象
```

**NSSet和NSArray的区别？**
```
1.NSArray表示数组：内部的元素是有序的，可以通过下标查找元素，内部元素可以重复，NSArray是通过链表实现的
2.NSSet表示集合：内部的元素是无序的，不可以通过下标查找元素，内部元素不可以重复（自动删除重复元素），NSSet是通过hash表实现的（查找速度比NSArray快）
```

**用property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？如果改用strong关键字，可能造成什么问题？**
```
// 用property声明的NSString（或NSArray，NSDictionary）经常使用copy关键字，为什么？
为了让本对象的属性不受外界影响。因为父类指针可以指向子类对象：使用copy无论给我传入是一个可变对象还是不可对象，本身持有的就是一个不可变的对象
// 如果改用strong关键字，可能造成什么问题？
如果我们使用strong关键字，那么这个属性就有可能指向一个可变对象，这个可变对象有可能被外部修改从而影响该属性
```

**如何让自定义类用copy修饰符？**
```
1.让自定义类遵循NSCopying协议
2.实现NSCopying协议方法“-(id)copyWithZone:(NSZone *)zone;”
```

**weak修饰的属性需要在dealloc方法中设置为nil吗？**
```
不需要
```

**IBOutlet连出来的视图属性为什么可以被设置成weak/用一个属性引用UI控件的时候为什么可以用weak？**
```
因为父控件的subViews数组已经对它有一个强引用
```

**nullable、__nullable和_Nullable之间有什么关系？**
```
三者引入的目的是为了兼容swift，三者之间没有任何的区别，只有书写位置的不同
```

**为什么内置类的delegate属性都是assign修饰而不是retain**
```
// 防止循环引用
1>.什么是循环引用：对象A引用对象B，对象B引用对象C，对象C引用对象A
2>.因为使用retain修饰delegate属性在遵循delegate的时候就会让内置类持有代理类，而内置类在创建的时候往往又会被代理类持有，从而形成循环引用，而使用assign修饰delegate属性赋值不会增加引用计数
```

**__block和__weak修饰符有什么区别？**
```
// __block
不管是ARC模式下还是MRC模式下都可以使用，它的作用：标识block外的变量在block内使用可以修改变量的值
// __weak
只能在ARC模式下使用，表示弱引用，它的作用：防止循环引用
```

**什么是安全释放？**
```
在对象release以后把指针设置为nil
```

**在obj-c中向一个nil对象发送消息将会发生什么？**
```
在Objective-C语言中向“nil对象”发送消息是完全有效的，只是在运行时不会有任何效果
```

**多条线程访问同一个变量怎么加锁？**
```
// 第一种方式
@synchronized (self) {
// 互斥锁
}
// 第二种方式
NSLock *theLock = [[NSLock alloc] init];
[theLock lock];
[theLock unlock];
```

**iOS开发中，开发证书根据用途划分可以分成哪两大类？分别作用是什么？**
```
// 开发证书
用于测试App：在开发过程中安装ipa到苹果手机真机上测试App的运行情况
// 发布证书
用于发布App：用iOS发布证书打包的ipa才能上传到App Store审核
```
FIXME - 各类证书过期会咋样？？？

**举例说明如何在多台机器上共享开发证书**
```
由固定一个人在开发者账号管理中心创建一个证书，然后从钥匙串中导出p12文件给其他人使用
```

**NSArray和NSMutableArray有什么区别？多线程操作哪个更安全？**
```
// NSArray
不可变数组：指向的内存区域一旦初始化就不能通过它对该区域的数据进行修改操作、数组元素固定不变、线程安全
// NSMutableArray
可变数组：数组元素可以动态添加和删除，线程不安全
```

**NSString和NSMutableString有什么区别？**
```
NSString是一个不可变的字符串对象：初始化以后不能改变该变量所分配的内存中的值
NSMutableString是一个可变的字符串对象：可以修改它所分配的内存空间中的值
```

**简述一下json解析和xml解析的区别？xml解析有哪几种方式？**
```
// 简述一下json解析和xml解析的区别？
1.json解析的难度低，xml解析需要考虑子节点和父节点
2.json相对于xml数据体积更小，传输速度更快
3.json和js的交互更加方便快捷
// xml解析有哪几种方式？
1、以DOM方式解析XML文件
2、以SAX方式解析XML文件
```

**一个对象被释放前加到了notificationCenter中，不在该notificationCenter中remove这个对象可能会出现什么问题？**
```
对象添加到notificationCenter，notificationCenter只是保存了该对象的地址，没有对该方法强引用。所以在该对象释放以后指针就成为野指针，向野指针发送消息会crash
```

**atomic和nonatomic有什么区别？atomic一定安全吗？nonatomic线程不安全为什么还推荐使用？**
```
// atomic和nonatomic有什么区别？
1.atomic - 原子性访问/线程安全（对当前属性"setter/getter方法"加互斥锁：防止读写未完成的时候被另一个线程读取造成数据错误）/性能低/默认属性
2.nonatomic - 非原子性访问/线程不安全（不对当前属性setter方法加锁）/性能高/UI所有的属性都要用nonatomic
// atomic一定安全吗？
atomic不一定安全：因为atomic只是保证了当前属性setter方法/getter方法的线程安全，其它方法则无法保证线程安全：比如对可变属性的操作和访问不属于atomic的负责范围
// nonatomic线程不安全为什么还推荐使用？
因为在日常开发中我们一般不需要考虑多线程安全问题，而且nonatomic性能比atomic更高
```

**什么情况下使用weak关键字，相比assign有什么不同？**
```
// 什么情况下使用weak关键字
1.在ARC模式下，有可能出现循环引用，往往要通过让其中一端使用weak来解决（delegate代理）
2.自身已经对属性进行了一次强引用，没有必要再强引用一次（自定义IBOutlet控件属性）
// 相比assign有什么不同
1.在weak所指的对象遭到释放时，该属性值也会清空；assign只会执行针对基本数据类型的简单赋值操作
2.weak必须用于oc对象；assign可以用非oc对象
```

**请指出IDFA、IDFV、UDID、UUID、IDFA、MAC地址、OpenUDID之间的区别**
```
// 都是iOS的设备识别码
1.IDFA - 广告标识符：适用于广告推广和用户追踪，用户可以手动关闭获取和还原（只要关闭“限制广告追踪”功能再次打开就会不一样）
2.IDFV - 同一个开发商在同一个设备上的不同App返回一致（线上：卸载重装也一致｜线下：所有App卸载会重置）
3.UDID - 唯一设备标识符：由40个数字字母组合，为了保护用户隐私，苹果已禁止读取
4.UUID - 通用唯一标识符：每次运行都会改变，可以通过UUID + Keychain的方式确定设备
5.MAC地址 - 定义网络设备地址：一个主机有一个MAC地址（由网卡决定、固定），为了保护用户隐私，苹果已禁止读取
6.OpenUDID - 第三方用来替代UDID的解决方案（非苹果官方）：删除应用会重新生成
```

**什么是自动释放池？简述一下自动释放池的原理，什么情况下需要使用自动释放池？**
```
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
```

**自动释放池中的对象是用什么数据结构存储的？**
```
栈结构
```

**自动释放池在什么时候被创建和销毁？有什么作用？底层如何实现？
```
// 自动释放池在什么时候被创建和销毁？
创建：可以手动创建自动释放池
销毁：一次完整runloop结束之前会被销毁
// 有什么作用？
自动释放对象：所有autorelease的对象，在出了作用域以后会被自动添加到最近创建的自动释放池中，自动释放池被销毁时会向池中所有对象发送release消息，自动释放池在ARC&MRC都有效
// 底层如何实现？
自动释放池以栈的形式实现：当你创建一个新的自动释放池时，它将被添加到栈顶。当一个对象收到autorelease消息时，该对象会被添加到这个处于栈顶的自动释放池中，当自动释放池被销毁时，它们会从栈中被删除，并且会给池子里面所有的对象都会做一次release操作
```

**自动释放池autorelease和垃圾回收gc有什么不同？**
```
自动释放池autorelease：延迟释放对象（自动释放池autorelease释放就会自动让池中所有对象调用一次release）
垃圾回收gc：每隔一段时间询问程序：是否有“无指针指向的对象”，如果有则将他回收
```

**在应用中可以创建多少autorelease对象？是否有限制？**
```
无限制
```

**不手动指定autoreleasepool的前提下，一个autorealese对象在什么时刻释放？**
```
// 手动干预释放
指定autoreleasepool，当autoreleasepool的作用域结束的时候释放
// 系统自动释放
不指定autoreleasepool，autorelease对象出了作用域以后就会被添加到最近一次创建的autoreleasepool中，并会在当前runloop迭代结束的时候释放
我们知道：所有autorelease对象在出了作用域以后就会被自动添加到最近创建的自动释放池中。如果每个都放到应用程序的main中的autoreleasepool中迟早会被撑满，所以必须在一次完整的运行循环结束之前销毁
// 如果VC的viewDidLoad中创建一个autorelease对象，那么该对象会在viewDidAppear方法执行前被销毁
```

**什么时候会创建自动释放池？**
```
运行循环检测到事件并启动以后就会创建自动释放池：子线程的runloop默认不工作，无法主动创建，必须手动创建
```

**类方法为什么不能直接访问属性？类方法怎么访问属性**
```
// 类方法为什么不能直接访问属性？
因为属性存在于对象中，类加载的时候不会创建对象，所以调用类方法的时候可能还没有属性
// 类方法怎么访问属性
可以在类方法中创建对象，使用对象调用属性
```

**Objective-c中的类型转换分为哪几类？**
```
1.自动类型转换
2.强制类型转换
```

**简述苹果的安全机制**
```
// 数字签名机制
在iOS中运行的App必须拥有自己的数字签名，开发者需要加入"iOS开发者计划"才能获取证书，而且开发者开发的App还要经过严格的审查才能在AppStore上架，保证了App的安全性，杜绝了第三方和未签名App的运行
// 沙盒保护机制
这种机制规定了应用程序只能在该应用创建的文件夹内读取文件，不可以访问其他地方的内容。使得设备内的各个App之间无法直接进行交流，只能通过iOS来进行数据传递，虽然降低了系统的扩展性但是却保证了安全性
```

### UI部分
**一个App可以有几个UIWindow？**
```
1.一个App可以有无数个UIWindow：至少有一个UIWindow
2.一个App只能有一个keyWindow：用来管理键盘以及非触摸类消息的UIWindow
```

**iOS-UI中图像存储类型是什么？**
```
UIImage
```

**UIImageView如何才能响应点击事件？**
```
设置userInteractionEnabled为YES
添加UITapGestureRecognizer手势
```

**UITableView中怎么解决缓存池满的问题**
```
1.一般情况下，在iOS中不存在缓存池满的情况：因为通常在iOS开发中对象都是在需要的时候才会创建（lazy加载），而在UITableView中一般也是只会创建刚开始出现在屏幕中的cell，之后都是从缓存池中取cell，不会再创建新对象
2.如果出现缓存池满的情况，我们一般会选择把最近最少使用的对象先释放
```

**了解过瀑布流吗？怎么实现简单的瀑布流？**
```
我们可以使用3个UITableView来实现瀑布流效果，任何一个UITableView滚动都带动其它两个UITableView滚动实现联动即可
```

**UITableView在快速滑动的时候App有可能会掉帧，具体原因是什么？怎么优化？**
```
https://www.jianshu.com/p/69a122f2bb80
```

**UITableViewCell中加载特别大的图片然后滑动的时候会掉帧？怎么优化？**
```
http://events.jianshu.io/p/a09b2e0db873
```

### 网络部分
**如果一个文件很大下载一次需要很长时间，我们有什么方法可以让下载时间更快一些？**
```
可以使用多线程下载同一个文件
需要注意的是：我们先要在请求体中设置需要下载的文件的范围，然后开多线程下载文件，然后在指定位置拼接文件（只能使用文件句柄）
```

**有些图片加载的比较慢如何处理？**
```
1.图片下载要放在异步线程中执行
2.图片下载过程中使用占位图片
3.如果图片较大，可以考虑使用断点下载
```

**网络图片处理中怎么解决一个相同的网络地址重复请求的问题？**
```
将图片地址设置为key，下载操作设置为value
```

### Code部分
**请交换两个数值（非封装方法）**
```
// 使用中间变量
int a = 10;
int b = 20;
int temp;
temp = a;
a = b;
b = temp;
// 不使用中间变量
int a = 10;
int b = 20;
a = a ^ b;
b = a ^ b;
a = a ^ b;
```

**请交换两个数值（封装方法）**
```
// 不能直接传值
void swap(int *v1, int *v2) {
    int temp = *v1;
    *v1 = *v2;
    *v2 = temp;
}
swap(&a, &b);
```

**用预处理指令#define声明一个常数，用以表示一年中有多少秒（忽略闰年）**
```
// 宏定义基本语法和注意事项
#define SECONDS_PER_YEAR (60 * 60 * 24 *365)UL
```

**定义一个求三个数最大值的宏**
```
#define MAX3(a,b,c) ((((a) > (b)) ? (a) : (b)) > (c) ? (((a) > (b)) ? (a) : (b)) : (c))
```

**标准有文件都有以下结构，主要作用是什么？**
```
#ifnded __INCvxWorksh
#define __INCvxWorksh
#ifdef __cplusplus
extern "C" {
#endif
/*...*/
#ifdef __cplusplus
}
#endif
#endif /* __INCvxWorksh */
```
>防止重复引用

**使用NSLog函数输出一个浮点类型，结果四舍五入，并保留一位小数**
```
float money = 1.011;
NSLog(@"%.1f", money);
```

**写出float x和零值比较的if语句**
```
// 第一种写法
if (x > 0.000001 && x < -0.000001) {
}
// 第二种写法
if (fabs(x) < 0.00001f) {
}
```

**下列代码有没有错误，如果有请指出**
```
-(void)setAge:(int)newAge {
self.age = newAge;
}
```
>有错误：调用会出现死循环（self.age会调用age的setter方法）

**下列代码输出什么（简单版）**
```
// 父类
@interface Father : NSObject
- (void)test;
@end

@implementation Father

@end
// 子类
@interface Son : Father
@end

@implementation Son
- (void)test {
NSLog(@"%@ = %@ = %@ = %@", [self class], [self superclass], [super class], [super superclass]);
}
@end
int main(int argc, char * argv[]) {
@autoreleasepool {
  Son *son = [[Son alloc] init];
  [son test];
}
}
```
>输出：Son = Father = Son = Father

**下列代码输出什么（复杂版）**
```
// 父类
@interface Father : NSObject
- (void)test;
@end

@implementation Father
- (void)test {
NSLog(@"%@ = %@ = %@ = %@", [self class], [self superclass], [super class], [super superclass]);
}
@end
// 子类
@interface Son : Father
@end

@implementation Son
- (void)test {
[super test];
}
@end
int main(int argc, char * argv[]) {
@autoreleasepool {
  Son *son = [[Son alloc] init];
  [son test];
}
}
```
>输出：Son = Father = Son = Father

**怎么避免动态数据类型运行期错误：由于动态数据类型可以调用任意方法(有可能调用到不属于自己的方法)、这样可能导致运行期错误**
```
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
```

**写一个NSString类的实现**
```
+(id)initWithCString:(const char *)nullTerminatedCString encoding:(NSStringEncoding)encoding {
NSString *obj;
obj = [self allocWithZone:NSDefaultMallocZone()];
obj = [obj initWithCString:nullTerminatedCString encoding:encoding];
return AUTORELEASE(obj);
}
```

**下列程序有什么问题？？？**
```
// 假设有⼀个字符串aabcad：请写一段程序，去掉字符串串中不相邻的重复字符串，即上述字符串串处理理之后的输出结果为aabcd
NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"aabcad"];
for (int i = 0; i < str.length - 1; i++) {
unsigned char a = [str characterAtIndex:i];
for (int j = i + 1; j < str.length; j++) {
unsigned char b = [str characterAtIndex:j];
if (a == b) {
  if (j = i + 1) {
  } else {
    [str deleteCharactersInRange:NSMakeRange(j, 1)];
  }
}
}
}
NSLog(@"%@",str);
```
>不能边循环边删除字符串（可以使用一个新的NSMutableString拼接）

**请写出Person类的"类工厂方法"**
```
// 1.不带参数
+(instancetype)Person {
return [[self alloc]init];
}
// 2.带参数
+(instancetype)PersonWithName:(NSString *)name {
return [[self alloc]initWithName:name];
}
```

**下列代码会crash吗？说说原因**
```
@property (copy, nonatomic) NSMutableArray *array;
// 不会crash：_array直接赋值还是NSMutableArray
[layout addObject:@"xwj"];
// 会crash：self.array调用setter方法会生成NSArray
[self.array addObject:@"xwj"];
```

**下列代码init有什么不同？**
```
// 1
id obj = [[NSMutableArray alloc] init];
// 2
id obj = [NSMutableArray array];
```
>ARC自动引用计数：两者没有本质区别
>MRC手动引用计数：1需要手动释放；2遵循autoreleasepool机制（不需要手动release）

**下列代码会crash吗？说说原因**
```
Class *obj1 = [[Class alloc] init];
Class *obj2 = obj1;
[obj1 hello];
[obj1 dealloc];
[obj2 hello];
[obj2 dealloc];
```
>obj1和obj2指向的是同一块空间：第一次释放以后再调用就会报错，而且只要释放一次即可

**发送一个同步http请求，并获取返回结果**
```
NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
[request setURL:[NSURL URLWithString:urlStr]];
[request setHTTPMethod:@"GET"];
NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
```

**下列代码输出结果是什么？**
```
-(void)viewDidLoad {
 [super viewDidLoad];
 NSLog(@"=================1");
 dispatch_sync(dispatch_get_main_queue(), ^ {
    NSLog(@"=================2");
 });
 NSLog(@"=================3");
}
```
>只能输出“=================1”
>发生主线程死锁


**下列代码输出结果是什么？**
```
-(void)viewDidLoad {
 [super viewDidLoad];
 dispatch_async(dispatch_get_global_queue(0, 0), ^ {
    NSLog(@"=================1");
    dispatch_sync(dispatch_get_main_queue(), ^ {
        NSLog(@"=================2");
    });
    NSLog(@"=================3");
 });
}
```

**下面代码是否有问题？如果有问题请指出**
```
// 获取全局并发队列
dispatch_queue_t concurrentQueue = dispatch_get_global_queue(0, 0);
for (int index = 0; index < 5000; index++) {
// 异步 + 并发队列 = 会开启多条线程
dispatch_async(concurrentQueue, ^{
NSString *imageName = [NSString stringWithFormat:@"%d.png", (i % 10)];
NSURL *url = [[NSBundle mainBundle] URLForResource:imageName withExtension:nil];
NSData *data = [NSData dataWithContentsOfURL:url];
UIImage *image = [UIImage imageWithData:data];
// 有错误
dispatch_barrier_async(concurrentQueue, ^{
  [self.mArray addObject:image];
});
});
}
```
>栅栏函数不能使用全局并发队列

**下面代码是否存在问题？如果有问题请指出问题，如果没有写出结果**
```
NSString *tempString = nil;
int length = [tempString length];
NSLog(@"%d", length);
```
>在Objective-C语言中向“nil对象”发送消息是完全有效的，只是在运行时不会有任何效果（没有输出）

**以下代码执行以后p对象的retain count分别是多少？**
```
Person *p = [[Person alloc] init];
[p retain];
[p release];
[p retain];
```
>2

**下列代码输出结果是什么？**
```
NSDictionary *dict = [NSDictionary dictionaryWithObject:@"a string value" forKey:@"akey"];
NSLog(@"%@", [dict objectForKey:@"akey"]);
[dict release];
```
>输出“a string value”
>>崩溃：便利构造器创建的对象release会造成过度释放

**下列代码有什么问题？会不会导致内存泄漏（多线程）？在内存紧张的设备上做大循环时自动释放池是写在循环内好还是循环外好？为什么**
```
for (int index = 0; index < someLargeNumber; index ++){
// NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
NSString *tempStr = @"tempStr";
NSLog(tempStr);
// 关键在于此处是通过"类工厂方法"创建的对象：使用的是autorelease管理内存
NSNumber *tempNumber = [NSNumber numberWithInt:2];
NSLog(tempNumber);
// [pool drain];
}
```
>会出现内存泄漏（因为循环会一直通过便利构造器方法创建autorelease对象造成内存一直增加，直到循环结束才会减少。所以需要在循环内加一个自动释放池）

**请分别写出下列代码的输出**
```
NSMutableArray *array = [[NSMutableArray array] retain];
NSString *str = [NSString stringWithFormat:@"test"];
[str retain];
[array addObject:str];
NSLog(@"%d", [str retainCount]);
[str retain];
[str release];
[str release];
NSLog(@"%d", [str retainCount]);
[array removeAllObjects];
NSLog(@"%d", [str retainCount]);
```
>结果：3、2、1

**下列代码有什么问题？**
```
@property (atomic, copy) NSMutableArray *array;
```
>.copy修饰词会复制一个NSArray对象，这样array进行增删改查的时候会因为找不到对应方法而crash
>.atomic改成nonatominc：因为atomic会使用同步锁，创建对象的时候会额外生成一些代码，影响性能

**如何实现一个带删除线的UILabel**
```
// 自定义View继承自UILabel重写drawRect方法
```

**Objective-C有几种延迟执行的方式**
```
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
// 设置“任务”在主线程中执行
dispatch_queue_t main = dispatch_get_main_queue();
// 设置“任务”在子线程中执行
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
// 单位 - 纳秒
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), queue, ^{
NSLog(@"GCD===%@", [NSThread currentThread]);
});
```

**在@property (retain, nonatomic) NSString *name;中setter方法的内存管理具体实现原理是什么？**
```
-(void)setName:(NSString *)name {
    if (_name != name) {
        [_name release];
        _name = [name retain];
    }
}
-(NSString *)getName {
    return [[_name retain] release];
}
```

**在@property (copy, nonatomic) NSString *name;中setter方法的内存管理具体实现原理是什么？**
```
-(void)setName:(NSString *)name {
    if (_name != name) {
        [_name release];
        _name = [name copy];
    }
}
-(NSString *)getName {
    return [[_name copy] release];
}
```


**在@property (assign, nonatomic) NSString *name;中setter方法的内存管理具体实现原理是什么？**
```
-(void)setName:(NSString *)name {
_name = name;
}
-(NSString *)getName {
return _name;
}
```

**写出打印结果，并说明原因?**
```
NSLog(@"1");
dispatch_group_t group = dispatch_group_create();
dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
dispatch_group_notify(group, queue, ^{
NSLog(@"2");
});
dispatch_group_enter(group);
dispatch_sync(queue, ^{
NSLog(@"3");
});
dispatch_group_leave(group);
dispatch_sync(dispatch_get_main_queue(), ^{
NSLog(@"4");
});
NSLog(@"5");
```

**在多线程中，下列代码有什么问题？怎么修改？**
```
interface A: NSObject {
NSMutableArray *array;
}
@end
@implementation A
-(void)add:(Item *item) {
[array addObject:item];
}
-(void)remove:(Item *item) {
[array removeObject:item];
}
@end
```
>加互斥锁

**下列代码有什么错误？怎么修改？**
```
NSString *resultStr = [[NSString alloc] init];
resultStr = [resultStr stringByAppendingString:@"\r\n"];
[result release];
```

**下列代码执行后会出现什么结果**
```
NSString *name;
[name release];
```
>内存泄漏：过度释放

**下列代码输出什么？**
```
NSString *name = [[NSString alloc] init]; // 在堆区开辟一块内存：name指向堆区
name = @"hahahaha"; // name指向常量区：堆区的内存没有释放也没有指针指向
[name release];
```
>内存泄漏

**以下代码是否有错？有错请指出**
```
NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:10];
for (int index = 0; index < 10; index++) {
[array addObject:[NSNumber numberWithInt:1]];
}
for (NSNumber *num in array) {
[array removeObject:num];
}
```

### 项目部分
**简单说明App的启动过程?**
```
// 第一种情况：通过storyboard启动
1.程序调用入口main函数
2.UIApplicationMain函数：创建UIApplication对象和UIApplication的delegate对象
3.根据info.plist文件加载MainStoryboard
4.创建UIWindow和rootViewController
5.调用makeKeyAndVisible方法显示UIWindow
// 第二种情况：通过code启动
1.程序调用入口main函数
2.UIApplicationMain函数：创建UIApplication对象和UIApplication的delegate对象
3.delegate对象开始监听系统事件
4.程序启动完毕时调用delegate的"application:didFinishLaunchingWithOptions:方法"
4.创建UIWindow和rootViewController
5.调用makeKeyAndVisible方法显示UIWindow
```

**main()之前的过程有哪些?**
```
1.将App对应的可执行文件加载到内存
2.将dyld加载到内存
3.dyld开始将程序二进制⽂文件初始化
4.由ImageLoader读取image：包含类Class、方法Method等多种符号
5.由于runtime向dyld绑定了回调，当image加载到内存以后dyld会通知runtime进行处理
6.runtime接手后调用map_images做解析和处理
7.接下来load_images中调用call_load_methods方法，遍历所有加载进来的Class，按继承层次依次调⽤用Class的+load和其他Category的+load方法
8.至此所有的信息都被加载到内存中：dyld开始调用真正的main函数（dyld会缓存上一次的信息，所以第二次比第一次启动会快一点3
```

**App需要加载大量的数据，给服务器发送网络请求的时候卡顿了怎么解决？**
```
1.检查网络请求操作是否被放在主线程中操作
2.设置请求超时，一旦超时及时提示用户
3.引导用户操作再次请求数据
```

**iOS开发中有哪些常见的异常？**
```
1.NSInvalidArgumentException非法参数异常：NSDictionary不能添加nil的对象
2.NSRangeException越界异常：数组下标处理错误
3.NSFileHandleOperationException文件处理异常：频繁保存文档导致内存不足
```

**App崩溃以后有哪些调试方法？**
```
1.断点单步调试
2.全局断点确定崩溃位置
3.僵尸调试查看崩溃日志原因
4.暴力调试
```

**在实际开发过程中，你遇到过项目crash或者内存泄漏问题吗？具体说说**
```
xxx
```

**有盟报错可以查到就具体某一行的错误，原理是什么？**
```
bugly
```

**在开发中你一般选择什么工具来追踪bug?**
```
xxx
```

**导致App异常假死的情况有哪些？有什么解决方案吗？**
```
xxx
```

**如果应用的新版本出现了Regression的情况，该如何补救？如何防止用户在使用过程中遇到新的Bug？**
```
xxx
```

### 基础部分
**队列和栈的区别？**
```
// 队列和栈是两种不同的数据结构，都是线性结构
1.队列是一种先进先出的数据结构，队列可以在两端进行操作：一端进行入队列操作，一端进行出队列操作
2.栈是一种先进后出的数据结构，栈只能在栈顶进行操作：入栈和出栈都在栈顶操作
```

**堆和栈的区别？**
```
// 管理方式
堆 - 由程序员手动管理（容易产生memory leak）
栈 - 由编译器自动管理：存放局部变量、函数参数等
// 申请方式
堆 - 向高地址扩展的数据结构，是不连续的内存区域（栈是先进先出，一一对应，以至于永远都不可能有内存块从栈中间弹出）
栈 - 向低地址扩展的数据结构，是一块连续的内存的区域（频繁的new/delete会造成内存空间的不连续，从而产生大量的碎片）
// 分配方式
堆 - 动态分配：创建对象的时候通过alloc开辟空间，不需要对象的时候通过release释放
栈 - 动态分配和动态分配：由编译器完成（系统自动分配）
```

**进程和线程的区别？**
```
// 进程和线程都是OS中程序运行的基本单位
// 进程
1>.进程是指系统中正在运行的某个应用程序（有状态：一个未运行的应用程序不是进程），而且在一个受保护的内存空间中独立运行（相互独立：一个进程crash以后在保护模式下不会对其他进程产生影响）
2>.进程是CPU资源分配的基本单位：同一个进程内的线程共享进程的资源
// 线程
1>.线程是进程的基本执行单元，一个进程所有的任务都要在线程上执行（一个程序至少要有一个进程（程序本身就是一个进程），一个进程至少要有一条线程（线程归属于进程而且可以访问该进程所拥有的资源，当OS创建一个进程以后会自动申请一个主线程））
2>.线程是CPU调度（执行任务）的最小单位：多个线程共享内存，可以提升运行效率
```

**链表和数组有什么不同？**
```
链表和数组都可以用来存放指定的数据类型
// 存储方法
1.链表：物理存储单元上非连续、非顺序的存储结构（链表每一个元素都会保存一个指向下一个元素的指针）
2.数组：元素在内存中连续存放（由于每个元素占用内存相同，可以通过下标迅速访问数组中任何元素）
// 操作元素
1.链表：在中间任意位置添加删除元素都非常快，不需要移动其他的元素
2.数组：由于每个元素占用内存相同，可以通过下标访问数组中任何元素
// 内存分配
1.链表：元素存放在堆区，内存申请管理比较麻烦
2.数组：元素存放在栈区，内存申请管理方便快速
```

**多线程中堆和栈是共有的还是私有的？**
```
// 栈
私有的：每个线程都有自己的栈
// 堆
公有的：同一进程中的不同线程可以通过堆共享数据
```

**你了解编译过程吗？分成哪几个步骤？**
```
// 1.预编译
1>.主要处理预编译指令：包括头文件导入、宏定义
// 2.编译
1>.词法分析：将字符序列分割成一系列的记号
2>.语法分析：根据产生的记号进行语法分析生成语法树
3>.语义分析：分析语法树的语义，进行类型的匹配、转换、标识
4>.中间代码生成：源码级优化器将语法树转换成中间代码，然后进行源码级优化（比如把1+2优化为3），中间代码使得编译器被分为前端和后端，不同的平台可以利用不同的编译器后端将中间代码转换为机器代码，实现跨平台
5>.目标代码生成：此后的过程属于编译器后端，代码生成器将中间代码转换成目标代码（汇编代码），其后目标代码优化器对目标代码进行优化（比如调整寻址方式、使用位移代替乘法、删除多余指令、调整指令顺序）
// 3.汇编：汇编器将汇编代码转变成机器指令
1>.静态链接：链接器将各个已经编译成机器指令的目标文件链接起来，经过重定位过后输出一个可执行文件
2>.装载：装载可执行文件、装载其依赖的共享对象
3>.动态链接：动态链接器将可执行文件和共享对象中需要重定位的位置进行修正
```

**在长度为n的线性表上进行顺序查找，在最糟糕的情况下需要比较多少次？**
```
n次
```

**已知二叉树后序遍历序列是dabec，中序遍历序列是debac，它的前序遍历序列是什么**
```
cedba
```

**现有两张表：用户表Z_User和黑名单表Z_BlackUser，其中userid是用户表Z_User的主键，黑名单表Z_BlackUser的外键。查询在用户表Z_User中不在黑名单表Z_BlackUser中的数据，写出sql语句**
```
// 连表查询
select * from Z_User where xxx
```

**写一条sql语句：取出表A中第31号~第40号记录（以自动增长的ID做为主键）**
```
select * from A where between 31 and 40;
```

**在数据库中，什么是视图？使用索引查询一定可以提高查询性能吗？为什么？**
```
xxx
```

**怎样才能一次遍历就能确认链表中存在环？**
```

```

**什么是平衡二叉树?**
```
xxx
```

**输出树的深度**
```
xxx
```

**写一个二叉树的广度遍历算法**
```
xxx
```

**编码代码实现单链表逆序**
```
xxx
```

**给定链表的头指针和一个结点指针，在O(1)时间删除该结点**
```
struct ListNode {
        int m_nKey;
        ListNode *m_pNext;
}
void deleteNode(ListNode *pListHead, ListNode *pToBeDeleted) {

}
```

**给定一个头节点为head的非空单链表，返回链表的中间结点；如果有两个中间结点，则返回第二个中间结点**
```
struct ListNode *middleNode(struct ListNode *head) {
    
}
```

**给定单链表的头节点head，请反转链表并返回反转后的链表的头节点**
```
struct ListNode *reverseList(struct ListNode *head) {

}
```

**合并两个排序的链表，输入两个递增排序的链表，合并这两个链表并使新链表中的节点仍然是递增排序**
```
struct ListNode *mergeTwoLists(Struct ListNode *l1, struct ListNode *l2) {

}
```

**分别以下列序列构造二叉排序树，其中构造的结果不同的是哪一个**
```
A、(100，80，90，60，120，110，130)
B、(100，120，110，130，80，60，90)
C、(100，60，80，90，120，110，130)
D、(100，80，60，90，120，130，110)
```

**给定一个无序的整数数组，找到其中最长上升子序列的长度**
```
xxx
```

**若一棵二叉树的前序遍历序列为{a， e， b， d， c}，后序遍历序列为{b， c， d， e， a}，则根结点的孩子结点有几个？分别是什么？**
```
xxx
```

链表操作
排序算法

https://blog.csdn.net/u014128241/article/details/53363077

https://www.cnblogs.com/mgla/p/5696277.html

https://www.cnblogs.com/Piosa/archive/2012/02/22/2363234.html

https://blog.csdn.net/mazaiting/article/details/79708605

https://blog.csdn.net/u010607889/article/details/12356619?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-2-12356619-blog-8543603.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-2-12356619-blog-8543603.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=3

https://blog.csdn.net/lfr_dev/article/details/26565177?spm=1001.2101.3001.6650.3&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-3-26565177-blog-8543603.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-3-26565177-blog-8543603.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=4

https://blog.csdn.net/longzs/article/details/7406220?spm=1001.2101.3001.6650.4&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-4-7406220-blog-8543603.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-4-7406220-blog-8543603.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=5

https://blog.csdn.net/weixin_33862041/article/details/91397759?spm=1001.2101.3001.6650.15&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-15-91397759-blog-7406220.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-15-91397759-blog-7406220.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=16

https://blog.csdn.net/qq_36237037/article/details/103674754?spm=1001.2101.3001.6650.14&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-14-103674754-blog-91397759.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-14-103674754-blog-91397759.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=15

https://blog.csdn.net/qq_34047841/article/details/54882714?spm=1001.2101.3001.6650.18&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-18-54882714-blog-91397759.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-18-54882714-blog-91397759.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=19

https://blog.csdn.net/yunhuaikong/article/details/113421391?spm=1001.2101.3001.6650.13&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-13-113421391-blog-91397759.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7EBlogCommendFromBaidu%7ERate-13-113421391-blog-91397759.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=14

https://www.jianshu.com/p/872610d33bec?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation

https://www.jianshu.com/p/196e4ecc5a61

https://blog.csdn.net/iOSvv/article/details/123825539
