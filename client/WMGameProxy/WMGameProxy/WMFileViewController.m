//
//  WMFileViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2022/12/15.
//  Copyright © 2022 zali. All rights reserved.
//

#import "WMFileViewController.h"
#import "WMGameProxy.h"
#import "FMDB.h"

// 类扩展/匿名类别：当定义不想对外公开一些类的方法和属性时可以使用类扩展
// 可以定义属性和方法
// 可以声明私有方法和私有变量
@interface WMFileViewController ()

// 可以声明私有成员变量
//@property (weak, nonatomic) UIImageView *iconImageView;
// 可以声明私有方法：声明和实现都在“.m文件”中
//-(void)song;

@property (strong,nonatomic) FMDatabase *db;

@end

@implementation WMFileViewController

// 1.数据持久化
// 1.概述
// 1>.什么是数据持久化
// 2>.为什么需要数据持久化：通常程序在运行中或者程序结束以后，需要保存一些信息（登录信息、播放记录等）
// 3>.数据持久化存放的位置：sandbox沙盒
// 4>.数据持久化方案：文件操作 ｜ NSUserDefaults偏好设置 ｜ plist文件 ｜ 数据库 ｜ NSKeyedArchiver归档
// 5>.方案性能对比：文件操作 > core data > NSKeyedArchiver归档 > sqllite > NSUserDefaults偏好设置
// 6>.对比：单例保存的数据App杀死数据清空 ｜数据持久化保存的数据App杀死数据不会清空（App卸载数据才会清空）
- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// 2.沙盒机制NSHomeDirectory()
// 1>.概念：“沙盒机制”是一种安全体系，规定了App只能在自己创建的文件夹内读取文件，不可以访问其他地方的内容。所有的非代码文件都保存在沙盒：比如图片、声音等
/*
 2>.文件
 AppSand
    // 存放程序源文件：上架前经过数字签名，上架后不可以修改
    MyApp.app
    // 1.持久化数据
    // 保存应用程序运行时生成的需要持久化的数据（不可再生的数据/会备份）
    // 不能保存网络下载的大数据，比如视频、图片等（如果放在该目录会被Apple打回/一般放在“Library/Caches”）
    Documents
    // 2.缓存
    Library
        // 保存应用程序运行时生成的需要持久化的数据（可再生的数据/不会备份/缓存/一般较大）
        // 网络请求数据（通常还需要负责删除这些文件）
        Caches
        // 保存应用的所有偏好设置（缓存/会备份）
        Preference
    // 3.临时文件
    // 保存应用程序运行时所需要的临时数据（临时文件（应用没有运行的时候系统可能会清除该目录下的文件：随时可能被系统清除）/不会备份）
    tmp
 */
/*
 3>.特点
 1.每个iOS应用程序都有自己的沙盒（应用沙盒就是文件系统目录/与其他的文件隔离）
 2.不能随意跨越自己的沙盒去访问别的应用程序沙盒的内容
 3.应用程序向外请求或接收数据都需要经过权限认证
 */
-(void)showSandBox {
    //沙盒根目录
    NSLog(@"获取该应用沙盒根目录===%@", NSHomeDirectory());
    NSString *string = @"我的小可爱";
//    // 第一种方式：
//    // 不推荐使用：新版本的OS可能会修改目录名
//    NSString *documentPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    /*
     第二种方式：
     获取../Documents
     第一个参数：搜索的目录
     第二个参数：搜索的范围
     第三个参数：是否展开路径
     */
    // NSCachesDirectory
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                        NSUserDomainMask, YES).firstObject;
//    // 获取../Library
//    NSString *libarayPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
//    NSUserDomainMask, YES).firstObject;
//    // 获取 ../tmp
//    NSString *tempPath = NSTemporaryDirectory();
    // 拼接一个文件名
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"nick.txt"];
    // 路径是沙盒路径
    // [string writeToFile:filePath atomically:YES]
    if ([string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil]) {
        NSLog(@"存储成功");
    }
}

// 3.文件操作：少量数据
-(void)showFile {
    NSString *path = @"/Users/xiewujun/Desktop/Gravity";
    NSError *error = nil;
    // 浅度遍历当前目录下的文件（只遍历一层）
    [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:&error];
    // 深度遍历当前目录下的文件
    [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:&error];
    //判断“文件/文件夹”是否存在：返回BOOL
    [[NSFileManager defaultManager] fileExistsAtPath:path];
    BOOL isDir = NO;
    if ([[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        NSLog(@"“文件/文件夹”存在");
        if (isDir) {
            NSLog(@"该路径为文件夹");
        }
    }
    // 获取“文件/文件夹”的属性
    NSDictionary *info = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
    NSLog(@"%@", info);
    // 获取当前文件夹中所有的文件（不能获取子文件夹）
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSLog(@"%@", array);
    /*
     创建目录（文件夹）
     path - 指定创建文件夹的路径
     YES - 是否有中间目录（是否自动创建不存在的文件夹）
     nil - 采用默认的设置
     nil - 错误
     @return YES：创建成功、NO：创建失败
     */
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    // 无法创建abc这个文件夹
    BOOL flag = [[NSFileManager defaultManager] createDirectoryAtPath:@"/Users/xiewujun/Desktop/abc/Gravity" withIntermediateDirectories:NO attributes:nil error:nil];
    /*
     创建文件：如果文件已经存在，会覆盖原来文件
     path - 指定创建文件的路径
     nil - 创建内容为空的文件（文件的内容）
     nil - 采用默认的设置（指定创建文件的文件属性）
     @return YES：创建成功、NO：创建失败
     */
    [[NSFileManager defaultManager] createFileAtPath:path contents:[@"" dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    [[NSFileManager defaultManager] createFileAtPath:path contents:nil attributes:nil];
    //copy文件：如果文件存在就copy不成立
    NSString *fromPath = @"/Users/xiewujun/Desktop/abc/Gravity";
    NSString *toPath = @"/Users/xiewujun/Desktop/abc/Gravity/copy";
    [[NSFileManager defaultManager] copyItemAtPath:fromPath toPath:toPath error:nil];
    //移动文件
    [[NSFileManager defaultManager] moveItemAtPath:fromPath toPath:toPath error:nil];
    //删除文件
    [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    //获取文件属性：返回字典
    NSDictionary *dic = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];

    //NSData：二进制数据类
    NSData *data = [path dataUsingEncoding:NSUTF8StringEncoding];
    //将data写入文件：单线程下，传入NO/YES无区别，NO的效率更高；多线程下，应该填入YES
    [data writeToFile:path atomically:YES];
    //data -> NSString
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //从文件中读取数据，存储在二进制对象中
    NSData *data1 = [[NSData alloc]initWithContentsOfFile:path];
    
    // 字符串的读写
    // 一、第一种方式
    /*
     从文件中读取字符串
     第一个参数 - 文件路径/必须传“绝对路径”
     第二个参数 - 编码/英文编码 - iOS-5988-1/中文 - GBK（一般填写UTF8）
     第三个参数 - 错误信息（如果有）/&error表示“两个*”
     */
    NSString *fileString = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
    NSLog(@"获取的字符串 == %@/真正的错误原因 == %@", fileString, [error localizedDescription]);
    /*
     将字符串写入到文件中
     第一个参数 - 文件路径/必须传“绝对路径”
     第二个参数 - YES(字符串写入文件过程中没有写完不会生成文件)/NO(字符串写入文件过程中没有写完会生成文件)
     第三个参数 - 错误信息（如果有）/ &error表示“两个*”
     */
    [@"12345" writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    // 二、第二种方式
    // 该方法既可以加载“本地资源”也可以加载”网络资源“
    /*
     1.file:// - 协议头
     2.192.168.5.102 - 主机域名
     3./Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx - 路径
     file://192.168.5.102/Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx
     file:///Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx
     */
//    // 创建url
//    // 第一种方式（手动）
//    // 因为url不支持中文，如果包含中文则无法访问
//    NSString *path1 = @"file://192.168.5.102/Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx";
//    // 如果加载本机上资源，那么url中的主机地址可以省略
//    NSString *path2 = @"file:///Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx";
//    // 如果path包含中文需要手动给path进行转码
//    NSString *path3 = [path2 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSURL *url = [NSURL URLWithString:path3];
//    // 第二种方式（推荐使用/自动 - 使用该方法就算url包含中文也可以进行访问，系统内部会自动对url的中文进行处理）
//    // 如果通过该方法“创建url”系统会自动添加“协议头”（ file:// ）
//    NSString *filePath = @"192.168.5.102/Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx";
//    NSURL *url = [NSURL fileURLWithPath:filePath];
//    NSError *error = nil;
//    NSString *fileString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
//    NSLog(@"获取的字符串==%@/真正的错误原因==%@", fileString, [error localizedDescription]);
//    /*
//     从文件中读取字符串
//     第一个参数 - URL/统一资源定位符/互联网上每个资源都有一个唯一的url/协议头://主机域名/路径
//     第二个参数 - 编码/英文编码 - iOS-5988-1/中文 - GBK（一般填写UTF8）
//     第三个参数 - 错误信息（如果有）/ &error表示“两个*”
//     */
//    // 多次往同一个文件中写入内容，那么后一次会覆盖前一次
//    [fileString writeToURL:url atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    // 字符串和绝对路径：！！！记住 - 字符串和路径之间有很多方法可以使用！！！
    // 1>.判断是否为绝对路径：本质就是判断字符串是否以“/”开头
    NSString *filePath = @"/Users/xiewujun/Desktop/技术部-iOS开发组-第1周-周报.docx";
    if ([filePath isAbsolutePath]) {
        NSLog(@"绝对路径");
    } else {
        NSLog(@"不是绝对路径");
    }
    // 2>.获取文件路径的最后一个目录
    NSString *newString = [filePath lastPathComponent];
    NSLog(@"%@", newString);
    // 3>.删除文件路径中的最后一个目录
    // 本质就是删除“/XXX”所有内容
    newString = [filePath stringByDeletingLastPathComponent];
    // 4>.给文件路径添加一个目录
    // 本质就是在字符串的末尾加上一个"/XXX"
    // 如果路径后面已经有一个或者多个“/”都会把“/”删除
    newString = [filePath stringByAppendingPathComponent:@"xmg"];
    // 5>.获取路径中文件的扩展名
    // 本质就是从字符串的末尾开始截取到第一个"."
    newString = [filePath pathExtension];
    // 6>.删除路径中文件的扩展名
    // 本质就是从字符串的末尾开始查找第一个"."，删除掉“.”和“,”后面的字符串
    newString = [filePath stringByDeletingPathExtension];
    // 7>.给路径添加一个扩展名
    // 本质就是在路径结尾添加".XXX"
    newString = [filePath stringByAppendingPathExtension:@"png"];

    // 文件读写
    /*
     1.将数组写入到文件中
     如果将一个数组写入到文件中之后本质上是一个“XML文件”
     “XML文件”的扩展名保存为.plist
     */
    // 如果数组中的元素是“自定义对象”不能使用该方法保存
    // 保存“自定义对象”需要使用“归档”
    NSArray *array2 = @[@"lnj", @"yz", @"xwj"];
    if ([array2 writeToFile:@"/Users/xiewujun/Desktop/abc.plist" atomically:YES]) {
        NSLog(@"写入成功");
    }
    // 2.从文件中读取一个数组
    array = [NSArray arrayWithContentsOfFile:@"/Users/xiewujun/Desktop/abc.plist"];

    // 文件读写
    // 写入
    NSMutableDictionary *mDict = [[NSMutableDictionary alloc] init];
    [mDict writeToFile:@"/Users/xiewujun/Desktop/info.plist" atomically:YES];
    // 读取
    NSDictionary *newDict = [NSDictionary dictionaryWithContentsOfFile:@"/Users/xiewujun/Desktop/info.plist"];
    NSLog(@"%@", newDict);
    
    /*
     NSFileHandle文件句柄类
     1.对文件进行读写首先需要NSFileHandle打开文件
     2.NSFileHandle对文件进行读写都是NSData类型的二进制数据
    */
    //读取文件：readOnlyHandle为nil的时候表示文件不存在
    NSFileHandle *readOnlyHandle = [NSFileHandle fileHandleForReadingAtPath:path]; // 以只读方式打开
    NSFileHandle *writeOnlyHandle = [NSFileHandle fileHandleForWritingAtPath:path]; // 以只写方式打开
    NSFileHandle *readWriteHandle = [NSFileHandle fileHandleForUpdatingAtPath:path]; // 以读写方式打开
    //读取指定长度的数据：单位为字节
    [readOnlyHandle readDataOfLength:5];
    [readWriteHandle readDataOfLength:5];
    //从当前偏移量读到文件尾
    [readOnlyHandle readDataToEndOfFile];
    //设置文件偏移量：单位为字节
    [readOnlyHandle seekToFileOffset:5];
    //将文件偏移量定位到文件尾
    [readOnlyHandle seekToEndOfFile];
    /*
     如果希望这次写入的数据完全覆盖原来数据：
     短文件写入，无法覆盖长文件
     可以截断原来的数据
     */
    [readWriteHandle truncateFileAtOffset:0]; // 截断到0字节，清空原有数据

    //写文件
    [readWriteHandle seekToEndOfFile]; // 当前偏移量指到文件结尾
    [readWriteHandle writeData:data]; // 写入数据
    [readWriteHandle writeData:[@"12345" dataUsingEncoding:NSUTF8StringEncoding]];

    //关闭文件句柄：不能再操作文件
    [readOnlyHandle closeFile];
    [readWriteHandle closeFile];
    [writeOnlyHandle closeFile];
}
/*
 1.将下列一首诗写入文件，并且在诗的前面插入标题和作者信息
 ```
 春眠不觉晓，
 处处闻啼鸟，
 夜来风雨声，
 花落知多少。
 ```
 2.给NSFileManager类添加一个类别，实现以下功能
 -(void)copyItemInPath:(NSString *)src toPath:(NSString *)dst;
 3.将以下信息写入plist文件中
 ```
 001：何畅
 002：白日明
 003：刘俊宇
 004：董佳迪
 005：姚亚运
 ```
 4.计算一个文件夹中所有文件的大小（思路：需要不断遍历获取每个文件夹下的文件，然后计算大小，最后相加）
 */

// 4.Preference偏好设置
// 保存一些简单数据（主要是存储应用程序中的一些轻量级数据：用户基础配置、保存位置“Library/Preference”、会备份、也是一个plist文件）
// 不能保存自定义对象（自定义对象使用“归档”保存）
-(void)showPreference {
    // 1>.写入数据
    // 实例化
    [[NSUserDefaults standardUserDefaults] setObject:@"value" forKey:@"key0"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"key1"];
    [[NSUserDefaults standardUserDefaults] setValue:@(10) forKey:@"key2"];
    [[NSUserDefaults standardUserDefaults] setInteger:10 forKey:@"key3"];
    // 同步到持久状态
    [[NSUserDefaults standardUserDefaults] synchronize];
    // 2>.读取数据（任何位置都可以获取）
    NSString *value = [[NSUserDefaults standardUserDefaults] objectForKey:@"key0"];
    BOOL shouldHide = [[NSUserDefaults standardUserDefaults] boolForKey:@"key1"];
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"key2"];
    NSLog(@"%@===%d===%ld", value, shouldHide, count);
}

// 5.XML属性列表归档plist
// 只能存放NSString/NSNumber/NSDate/NSArray/NSDictionary
// 不能保存自定义对象（自定义对象使用“归档”保存）
// plist的手动创建（右键 -> New File -> Resource -> Property List）
-(void)showPlist {
    // 1.写入数据myConfig.plist
    // 把NSDictionary/NSArray写入到myConfig.plist
    NSArray *names = @[@"yjn", @"mj", @"gxq", @"nj"];
    NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                            NSUserDomainMask, YES).firstObject;
    // 拼接一个文件名
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"myConfig.plist"];
    // 路径是沙盒路径
    [names writeToFile:filePath atomically:YES];
    
    // 2.获取myConfig.plist数据
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"myConfig" ofType:@"plist"];
    // 通过路径转化数组（字典）
    // 1>.如果root是dic使用NSMutableDictionary接收
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
    // 2>.如果root是Array使用NSMutableArray接收
    NSMutableArray *array = [[NSMutableArray alloc] initWithContentsOfFile:path];
    NSLog(@"%@===%@", dict, array);
}

// 6.归档NSCoding：怎么利用runtime实现自动化归档NSCoding
// 一种序列化与反序列化，可以用来保存“对象”
// 对象必须实现"NSCoding协议"才可以
// https://www.jianshu.com/p/3e08fa21316d
-(void)showCoding {
    // 新建对象
    WMGameProxy *wm0 = [WMGameProxy new];
    wm0.userName = @"谢吴军";
    wm0.weight = 150;
    // 如果需要保存SyPostItem对象
    // SyPostItem也需要实现“NSCoding协议”
    // 实现"NSCoding协议"就是告诉用户：我准备存储哪个属性
    SyPostItem *item = [SyPostItem new];
    item.citys = @[@"A", @"B", @"C"];
    item.name = @"安庆";
    wm0.item = item;
    // 获取“沙盒目录”
    NSString *tempPath = NSTemporaryDirectory();
    // 拼接文件
    NSString *filePath = [tempPath stringByAppendingPathComponent:@"sdk.data"];
    // 归档
    // 会调用“-(void)encodeWithCoder:(NSCoder *)coder方法”
    if (@available(iOS 12.0, *)) {
        NSError *error;
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:wm0 requiringSecureCoding:YES error:&error];
        [data writeToFile:filePath atomically:YES];
    } else {
        [NSKeyedArchiver archiveRootObject:wm0 toFile:filePath];
    }
    // 解档
    // 会调用“-(instancetype)initWithCoder:(NSCoder *)coder方法”
    if (@available(iOS 12.0, *)) {
        NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
        NSError *error;
        WMGameProxy *wm1 = (WMGameProxy *)[NSKeyedUnarchiver unarchivedObjectOfClass:[WMGameProxy class] fromData:data error:&error];
        if (error) {
        }
        NSLog(@"%@", wm1.userName);
    } else {
        WMGameProxy *wm1 = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        NSLog(@"%@", wm1.userName);
    }
}

// 4.数据库FMDB
- (void)showSQL {
    // 如果我们的app需要多线程操作数据库，那么就需要使用FMDatabaseQueue来保证线程安全
    [self executeSQL:^(FMDatabase *db) {
        [db executeUpdate:@"create table if not exists sso \
         (id integer primary key autoincrement,\
         author text,\
         price real,\
         pages integer);"];
    }];
    //插入：加入主键防止重复插入
    [self executeSQL:^(FMDatabase *db) {
        [db executeUpdate:@"insert or replace into sso (id,author,price,pages) values(?,?,?,?);",@1,@"XWJ",@50.00,@546];
    }];
    //更新
    [self executeSQL:^(FMDatabase *db) {
        [db executeUpdate:@"update sso set price = ?,pages = ? where author = ?;",@50.55,@568,@"XWJ"];
    }];
    //删除
    [self executeSQL:^(FMDatabase *db) {
        [db executeUpdate:@"delete from sso where pages > ?;",@569];
    }];
    //查询
    [self executeSQL:^(FMDatabase *db) {
        FMResultSet *set = [db executeQuery:@"select * from sso;"];
        while ([set next]) {
            // 写入数据库，字符串可以使用char类型
            // 从数据库读取字符串的时候，如果使用char类型有表示中文字符的时候会出现乱码（需要使用NSString）
            NSString *name = [set stringForColumn:@"author"];
            double price = [set doubleForColumn:@"price"];
            int age = [set intForColumn:@"pages"];
            NSLog(@"%@===%lf===%d",name,price,age);
        }
    }];
}
//操作数据库
-(void)executeSQL:(void(^)(FMDatabase *db))block {
    _db = [[FMDatabase alloc] initWithPath:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"sso.db"]];
    [_db open];
    block(_db);
    [_db close];
}
// 1.多表查询
// 2.数据回滚

// 5.Core Data（苹果官方推荐）
-(void)showCoreData {
    // 1>.Core Data
    // iOS3.x以后引入的数据库持久化解决方案，在使用过程中不需要写sql语句就可以方便的将数据存储到数据库中
    // Core Data是不是关系型数据库？Core Data不是一个关系型数据库，也不是关系型数据库管理系统
    // https://www.jianshu.com/p/1648f03d040f
    
    // 2>.第三方库MagicalRecord
    // https://www.jianshu.com/p/504f5a617cd4
}

@end
