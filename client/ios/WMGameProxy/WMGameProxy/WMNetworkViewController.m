//
//  WMNetworkViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/18.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMNetworkViewController.h"
#import "AFNetworking.h"

@interface WMNetworkViewController () <
NSURLConnectionDataDelegate,
NSXMLParserDelegate,
NSURLSessionDataDelegate,
NSURLSessionDownloadDelegate
>

@property (strong, nonatomic) NSMutableData *resultData;
@property (assign, nonatomic) NSInteger totalSize;
@property (assign, nonatomic) NSInteger currentSize;
@property (strong, nonatomic) NSString *fullPath;
@property (strong, nonatomic) NSFileHandle *handle;
@property (strong, nonatomic) NSOutputStream *outputStream;

@end

@implementation WMNetworkViewController

- (NSMutableData *)resultData {
    if (_resultData == nil) {
        _resultData = [NSMutableData data];
    }
    return _resultData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// JSON
// 1>.概念：json是一种轻量级的数据格式，一般用于数据交互
// 2>.特点：服务器返回给客户端的数据基本都是json和xml（文件下载除外）
/*
 // 3>.标准json格式中key必须使用双引号
 // {} -> NSDictionary
 {
    "name": "jack",
    // 10 -> NSNumber
    "age": 10,
    // [] -> NSArray
    "names": [
        // "" -> NSString
        "jack",
        "rose",
        "jim"
    ],
    // Boolean -> NSNumber
    "isDue": false,
    // null -> NSNull
    "height": null
 }
 "data":{
     // 这是一个字典（直接用model接收）
     // self.list = self.list.append(model.list)
 }
 "data"[{
     // 这是一个数组（必须用数组接收）
 },{
     
 }]
 */
// 4>.json解析方案：第三方框架（JSONKit（性能第二好）、SBJson、TouchJSON）、苹果原生（NSJSONSerialization（性能最好））
// 5>.plist文件 -> NSArray|NSDictionary -> JSON文件
-(NSDictionary *)analysisJSON:(NSData *)data {
    // 反序列化：json对象 -> oc对象
    /*
     第一个参数：json的二进制数据
     第二个参数：NSJSONReadingMutableContainers（得到的dict是一个可变的字典和数组）/NSJSONReadingAllowFragments（得到的oc对象既不是对象也不是数组则必须使用此选项）
     第三个参数：错误信息
     */
    NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    // 序列化：oc对象 -> json对象
    /*
     第一个参数：要转换的OC对象（并不是所有的oc对象都可以转换为json）
     第二个参数：NSJSONWritingPrettyPrinted（排版美观）
     第三个参数：错误信息
     */
    if ([NSJSONSerialization isValidJSONObject:dict1]) {
        /*
         必须同时满足以下条件：
         >最外层必须是NSArray或NSDictionary
         >所有元素必须是NSString、NSNumber、NSArray、NSDictionary、NSNull
         >字典中所有元素的key必须是NSString
         >NSNumber不能无穷大
         */
        // 该对象是否可以转换为json（数组/字典可以，字符串不可以）
        NSData *data1 = [NSJSONSerialization dataWithJSONObject:dict1 options:kNilOptions error:nil];
        NSLog(@"%@", [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding]);
    }
    // 6>.第三方框架
    // MJExtention框架（侵入性低）
    // JSONModel框架（侵入性高）
    return  dict1;
}

// XML可扩展性标记语言
// 1.特点：可扩展性（标签的名字可以自定义、标签可以嵌套）/标记/跨平台
// 2.作用：网络传输数据
// 3.json和xml的区别（json解析简单，但是结构不易理解、xml结构容易理解，但是数据冗余）
-(void)analysisXML:(NSData *)data {
    // 4.xml解析方式
    // 1>.DOM：一次性将整个XML文档加载进内存，然后解析（比较适合解析小文件）
    // 2>.SAX：从根元素开始，按照顺序一个元素一个元素往下解析，比较适合解析大文件
    
    // 5.具体操作
    // 1>.苹果原生NSXMLParser：SAX方式解析
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    // 开始解析：阻塞
    [parser parse];
    // 2>.三方框架GDataXML：DOM方式解析
    // a、基于libxml2（不过目前已经不需要导入libxml2）
    // b、在"Head Search Path"中加入libxml2的头文件搜索路径"/usr/include/libxml2"（为了能找到libxml2库的所有头文件）
    // c、在"Other Linker Flags"中加入"-lxml2"
    // d、在“Compile Sources”中找到对应文件加入“-fno-objc-arc”
//    // 加载xml文档
//    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:data options:kNilOptions error:nil];
//    // 得到根元素内部所有名称为video的子元素
//    NSArray *elements =  [doc.rootElement elementsForName:@"video"];
//    // 遍历操作
//    for (GDataXMLElement *element in elements) {
//        // 元素内部所有的属性 -> 模型 -> 添加到self.videos
//        XMGVideo *video = [[XMGVideo alloc]init];
//
//        video.name = [ele attributeForName:@"name"].stringValue;
//        video.length = [ele attributeForName:@"length"].stringValue;
//        video.image = [ele attributeForName:@"image"].stringValue;
//        video.ID = [ele attributeForName:@"id"].stringValue;
//        video.url = [ele attributeForName:@"url"].stringValue;
//
//        [self.videos addObject:video];
//    }
}

#pragma mark - NSXMLParserDelegate
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict {
    // 开始解析某个元素（多次调用）
    // 需要过滤根元素
    if ([elementName isEqualToString:@"根元素名称"]) {
        return;
    }
    // attributeDict转model
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // 结束解析某个元素（多次调用）
}
// 1.开始解析XML文档的时候
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
}
// 2.结束解析
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    
}

// 发送“http请求”的方案
// 1.苹果原生
// 1>.NSURLConnection（iOS7.0被废弃）
// 2>.NSURLSession
// 3>.CFNetwork（纯C语言）
// 2.第三方框架
// 1>.ASIHTTPRequest（作者已经不维护）
// 2>.AFNetworking
// a、概述：AFNetworking2.0使用NSURLConnection、AFNetworking3.0使用NSURLSession
// b、设置应用支持https：NSAppTransportSecurity -> NSAllowsArbitraryLoads -> YES
// 3>.MKNetworking（使用者较少）
-(void)sendHTTP {
    // 1>.NSURLConnection（iOS7.0被废弃）
    // a、GET请求：没有请求体
//    [self getURLConnection];
//    // b、POST请求
//    [self postURLConnection];
    
    // 2>.NSURLSession
    // a、GET请求
    [self getURLSession];
    // b、POST请求
    [self postURLSession];
    
    // 3>.AFNetworking
    // a、AFNetworking2.x基于NSURLConnection；AFNetworking3.x基于NSURLSession
    // b、GET请求
    [self getAFNetworking];
    // c、POST请求
    [self postAFNetworking];
}

#pragma mark - NSURLConnection（iOS7.0被废弃）
// get请求
//- (void)getURLConnection {
//    // 1>.确定请求地址
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
//    // 2>.创建请求对象（默认包含请求头）
//    // 默认请求方法GET请求
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    // 设置请求体（GET请求没有请求体）
//    // 设置请求体（NSURLRequest默认包含请求头）
//    // 3>.发送请求
//    /*
//     第一个参数 - 请求对象
//     第二个参数 - 响应头信息
//     第三个参数 - 错误信息
//     */
//    // a、同步线程（会阻塞线程）
//    NSURLResponse *response = nil;
//    // data是一次性返回的
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
//    /*
//     第一个参数 - 请求对象
//     第二个参数 - 队列
//     第三个参数 - 回调（请求完成回调）
//     */
//    // b、异步线程（不会阻塞线程）
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        // response响应头
//        // data响应体（data是一次性返回的）
//        // connectionError错误信息
//        // 4>.解析数据
//        NSString *String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    }];
//    // c、异步线程（delegate）
//    // 第一种方式
//    // delegate方法默认是在主线程中调用
//    NSURLConnection * connect = [NSURLConnection connectionWithRequest:request delegate:self];
//    // 设置delegate方法在哪个线程中调用
//    [connect setDelegateQueue:[[NSOperationQueue alloc] init]];
//    // 第二种方式
//    [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    // 第三种方式
//    // yes - 会发送请求
//    // no - 不会发送请求
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
//    // 开始发送请求
//    [connection start];
//    // 取消发送请求
//    [connection cancel];
//    // 4>.解析数据
//    NSString *String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//}


// post请求
//- (void)postURLConnection {
//    // 1>.确定请求地址
////    // 字符串有中文转换成URL的时候会出问题
////    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=小马哥&pwd=123&type=JSON"];
//    // 中文转码（中文在请求体里面不需要进行中文转码：关键在于URL中是否有中文）
//    // 多值参数
//    // 正确写法：http://120.25.226.186:32812/login?username=小马哥&pwd=123&type=JSON&type=XML
//    // 错误写法：http://120.25.226.186:32812/login?username=小马哥&pwd=123&type=JSON&XML
//    NSURL *url = [NSURL URLWithString:[@"http://120.25.226.186:32812/login?username=小马哥&pwd=123&type=JSON" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    // 2>.创建请求对象
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    // 3.修改请求方法（POST必须大写）
//    request.HTTPMethod = @"POST";
//    // 4.设置请求体
//    request.HTTPBody = [@"username=123&pwd=123&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
//    // 设置属性，请求超时
//    request.timeoutInterval = 10;
//    // 设置请求头
//    [request setValue:@"xxx" forHTTPHeaderField:@"User-Agent"];
//    // 5.发送请求（“可以发送同步请求、可以使用delegate请求对象...”这里不再演示）
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        // response响应头
//        // data响应体（data是一次性返回的）
//        // connectionError错误信息
//        // 4>.解析数据
//        NSString *String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    }];
//}

//#pragma mark - NSURLConnectionDataDelegate
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    // 1、当接收到服务器响应的时候调用
//    // 获取文件总大小（本次请求的文件数据总大小）
//    self.totalSize = response.expectedContentLength;
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    // 2、接收到服务器返回数据的时候调用（调用多次）
//    // 此处拼接data（data是分批返回的）
//    [self.resultData appendData:data];
//    // 下载进度 = 已经下载文件大小 / 文件总大小
//    NSLog(@"%f", 1.0 * self.resultData.length / self.totalSize);
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    // 3、请求结束的时候调用
//    // 此处解析data
//    NSString *String = [[NSString alloc] initWithData:self.resultData encoding:NSUTF8StringEncoding];
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    // 当请求失败的时候调用
//}


//// 文件下载
//// 1>.耗时操作（不推荐）
//-(void)download1 {
//    // 1>.获取url
//    NSURL *url = [NSURL URLWithString:@"http://img5.imgtn.bdimg.com/it/u=1915764121,2488815998&fm=21&gp=0.jpg"];
//    // 2>.下载二进制数据（耗时操作）
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    // 3>.转换
//    UIImage *image = [UIImage imageWithData:data];
//}
//
//// 2>.无法监听进度
//// 内存飙升（适合小文件下载）
//-(void)download2 {
//    // 1>.获取url
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
//    // 2>.创建请求对象
//    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
//    // 3>.发送请求
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        // 4>.写数据到沙盒中
//        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
//        [data writeToFile:fullPath atomically:YES];
//    }];
//}
//
//// 3>.内存飙升（适合小文件下载）
//// 此处通过改进适合下载大文件
//-(void)download3 {
//    // 1>.获取url
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
//    // 2>.创建请求对象
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    // 2.1>.断点下载：只下载文件的某一部分
//    /*
//     bytes=0-499 // 前500个字节
//     bytes=500-999 // 第二个500字节
//     byte=-500 // 最后500个字节
//     byte=500- // 500字节以后的范围
//     */
//    [request setValue:[NSString stringWithFormat:@"bytes=%zd-", self.currentSize] forHTTPHeaderField:@"Range"];
//    // 3>.发送请求
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    // 4>.取消下载
//    [connection cancel];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
//    // 1、当接收到服务器响应的时候调用
//    // 1>.获取文件总大小（本次请求的文件数据总大小）
//    // 本次请求的文件数据大小不一定等于文件的总大小（取消下载以后再次下载进度会出现问题）
//    self.totalSize = response.expectedContentLength + self.currentSize;
//    if (self.currentSize > 0) {
//        return;
//    }
//    // 2>.写数据到sandbox中
//    self.fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"123.mp4"];
//    // 3>.创建一个空文件
//    [[NSFileManager defaultManager] createFileAtPath:self.fullPath contents:nil attributes: nil];
//    // 4>.创建文件句柄（指针）
//    self.handle = [NSFileHandle fileHandleForWritingAtPath:self.fullPath];
//#pragma mark - 输出流
//    // NSOutputStream写数据
//    // NSInputStream读数据
//    /*
//     类似于水管
//     第一个参数：文件的路径
//     第二个参数：YES表示追加
//     特点：如果该输出流指向的地址没有文件，那么系统会自动创建一个空的文件
//     */
//    self.outputStream = [[NSOutputStream alloc] initToFileAtPath:self.fullPath append:YES];
//    // 打开输出流
//    [self.outputStream open];
//}
//
//- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
//    // 2、接收到服务器返回数据的时候调用（调用多次）
////    // 内存飙升的原因（大文件下载不要去拼接，可以直接写入sandbox）
////    // 此处拼接data（data是分批返回的）
////    [self.resultData appendData:data];
////    // 下载进度 = 已经下载文件大小 / 文件总大小
////    NSLog(@"%f", 1.0 * self.resultData.length / self.totalSize);
//    // 1>.移动文件句柄到数据的末尾
//    [self.handle seekToEndOfFile];
//    // 2>.数据写入
//    [self.handle writeData:data];
//    self.currentSize = data.length;
//    // 3>.获取进度
//    NSLog(@"%f", 1.0 * self.currentSize / self.totalSize);
//#pragma mark - 输出流
//    // 写数据
//    [self.outputStream write:data.bytes maxLength:data.length];
//}
//
//- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
//    // 3、请求结束的时候调用
//    // 1>.关闭文件句柄
//    [self.handle closeFile];
//    self.handle = nil;
//#pragma mark - 输出流
//    [self.outputStream close];
//    self.outputStream = nil;
//}
//
//- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
//    // 当请求失败的时候调用
//}


// 文件上传
//-(void)upload {
//    // 1>.确定请求路径
//    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
//    // 2>.创建请求对象
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
//    // 3>.设置请求方法
//    request.HTTPMethod = @"POST";
//    // 4>.设置请求头信息
//    [request setValue:@"multipart/form-data; boundary=----WebKitFormBoundaryjv0UfA04ED44AhWx" forHTTPHeaderField:@"Content-Type"];
//    // 5>.拼接请求体数据
//    NSMutableData *fileData = [NSMutableData data];
//    // 5.1>.文件参数
//    /*
//     --分隔符
//     Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
//     Content-Type: image/png
//     空行
//     文件参数
//     */
//    [fileData appendData:[@"------WebKitFormBoundaryjv0UfA04ED44AhWx" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Snip20160225_341.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:UIImagePNGRepresentation([UIImage imageNamed:@"xxx.png"])];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    // 5.2>.非文件参数
//    /*
//     --分隔符
//     Content-Disposition: form-data; name="username"
//     空行
//     123456
//     */
//    [fileData appendData:[@"------WebKitFormBoundaryjv0UfA04ED44AhWx" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"123456" dataUsingEncoding:NSUTF8StringEncoding]];
//    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//    // 5.3>.拼接结尾标识
//    [fileData appendData:[@"------WebKitFormBoundaryjv0UfA04ED44AhWx--" dataUsingEncoding:NSUTF8StringEncoding]];
//    request.HTTPBody = fileData;
//    // 6>.发送请求
//    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
//        // 7>.解析数据
//    }];
//}


// 获取文件的MIMEType
// 1.发送请求（在响应头内部可以拿到MIMEType）
// 2.百度
// 3.调用c语言的API
/*
 文件的MIMEType：具体请求中的媒体类型信息
 // 图片
 png - image/png
 jpe/jpeg/jpg - image/jpeg
 gif - image/gif
 // 多媒体
 mp3 - audio/mpeg
 mp4/mpg4/m4vmp4v - video/mp4
 // 文本
 js - application/javascript
 pdf - application/pdf
 text/txt - text/plain
 json - application/json
 xml - text/xml
 */
//Content-Type: image/png

// 第三方解压缩框架ZipArchive


#pragma mark - NSURLSession
-(void)getURLSession {
    // 1>.确定请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON"];
    // 2>.创建请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    // 3>.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4>.创建Task
    /*
     第一个参数：请求对象
     第二个参数：请求完成回调
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // data响应体信息
        // response响应头信息
        // error错误信息：当请求失败的时候error有值
        // 6>.解析数据
    }];
//    // 第二种方式（内部生成NSURLRequest：一定是get请求）
//    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:@"http://120.25.226.186:32812/login?username=123&pwd=123&type=JSON" completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        // data响应体信息
//        // response响应头信息
//        // error错误信息：当请求失败的时候error有值
//        // 6>.解析数据
//    }];
    // 5>.执行task
    [dataTask resume];
}

-(void)postURLSession {
    // 1>.确定请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    // 2>.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    request.HTTPBody = [@"username=123&pwd=123&type=JSON" dataUsingEncoding:NSUTF8StringEncoding];
    // 3>.创建会话对象
    /*
     第一个参数：配置信息
     第二个参数：代理
     第三个参数：设置代理方法在哪个线程中调用
     */
    // 具体用途可以BaiDu
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 15.0;
    // NSURLSessionDataDelegate
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 4>.创建Task
    /*
     第一个参数：请求对象
     第二个参数：请求完成回调
     */
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // data响应体信息
        // response响应头信息
        // error错误信息：当请求失败的时候error有值
        // 6>.解析数据（子线程调用）
    }];
    // 5>.执行task
    [dataTask resume];
}

-(void)download1 {
    // 1>.确定请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    // 2>.创建请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    // 3>.创建会话对象
    NSURLSession *session = [NSURLSession sharedSession];
    // 4>.创建Task
    /*
     第一个参数：请求对象
     第二个参数：回调
     */
    // 该方法内部已经实现了边接收数据边写入sandbox操作（写入临时文件tmp：我们还需要转换到我们需要保存的路径）
    // 优点：不需要担心内存
    // 缺点：无法监听文件下载进度
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // location
        // response响应头信息
        // error错误信息
        // 6>.解析数据
        // 拼接文件全路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        // 剪切文件
        [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
    }];
    // 5>.执行Task
    [downloadTask resume];
}

-(void)download2 {
    // 1>.确定请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/login"];
    // 2>.创建请求对象
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    // 3>.创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 4>.创建Task
    /*
     第一个参数：请求对象
     第二个参数：回调
     */
    // 该方法内部已经实现了边接收数据边写入sandbox操作（写入临时文件tmp：我们还需要转换到我们需要保存的路径）
    // 优点：不需要担心内存
    // 缺点：无法监听文件下载进度
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
    // 5>.执行Task
    [downloadTask resume];
    // 暂停（可以恢复下载）
    [downloadTask suspend];
    // 取消（不可以恢复）
    [downloadTask cancel];
    // 取消（可以恢复）
    // 用户退出App则无法恢复下载（实际操作性很难）
    [downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
        if (resumeData) {
            // resumeData有值就可以就继续创建一个下载
            NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithResumeData:resumeData];
            [downloadTask resume];
        }
    }];
    // 恢复下载
    [downloadTask resume];
//    // NSURLSession在不需要使用的时候需要在dealloc方法中调用方法释放对象
//    // 调用其中一个就可以了
//    [session finishTasksAndInvalidate];
//    [session invalidateAndCancel];
}

-(void)upload {
    // 1>.确定请求地址
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/upload"];
    // 2>.创建请求对象
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    request.HTTPMethod = @"POST";
    // 3>.创建会话对象
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    // 4>.创建Task
    // 5>.拼接请求体数据
    NSMutableData *fileData = [NSMutableData data];
    // 5.1>.文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="file"; filename="Snip20160225_341.png"
     Content-Type: image/png
     空行
     文件参数
     */
    [fileData appendData:[@"------WebKitFormBoundaryjv0UfA04ED44AhWx" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"Snip20160225_341.png\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"Content-Type: image/png" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:UIImagePNGRepresentation([UIImage imageNamed:@"xxx.png"])];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 5.2>.非文件参数
    /*
     --分隔符
     Content-Disposition: form-data; name="username"
     空行
     123456
     */
    [fileData appendData:[@"------WebKitFormBoundaryjv0UfA04ED44AhWx" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"Content-Disposition: form-data; name=\"username\"" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"123456" dataUsingEncoding:NSUTF8StringEncoding]];
    [fileData appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    // 5.3>.拼接结尾标识
    [fileData appendData:[@"------WebKitFormBoundaryjv0UfA04ED44AhWx--" dataUsingEncoding:NSUTF8StringEncoding]];
    /*
     第一个参数：请求对象
     第二个参数：传递需要上传的数据（请求体）
     第二个参数：请求完成回调
     */
    NSURLSessionUploadTask *uploadTask = [session uploadTaskWithRequest:request fromData:fileData completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    // 6>.执行task
    [uploadTask resume];
}

// NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    // 接收到服务器的响应（默认会取消该请求）
    // session会话对象
    // dataTask请求任务
    // response响应头信息
    // completionHandler回调
    
    self.totalSize = (NSInteger)response.expectedContentLength;
    // a、获取文件全路径
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
    // b、创建空的文件
    [[NSFileManager defaultManager] createFileAtPath:fullPath contents:nil attributes:nil];
    // c、创建句柄
    self.handle = [NSFileHandle fileHandleForWritingAtPath:fullPath];
    
    /*
     NSURLSessionResponseCancel - 取消（默认）
     NSURLSessionResponseAllow - 接收
     NSURLSessionResponseBecomeDownload - 变成下载任务
     NSURLSessionResponseBecomeStream - 变成流
     */
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    // 接收到服务器返回的数据（多次调用）
    // session会话对象
    // dataTask请求任务
    // data本次下载的数据
    // 1>.拼接数据
    self.resultData = [[NSMutableData alloc] init];
    [self.resultData appendData:data];
    // d、写入数据到文件
    [self.handle writeData:data];
    // 计算文件的下载速度
    self.currentSize = self.currentSize + data.length;
    NSLog(@"--%f--", 1.0 * self.currentSize / self.totalSize);
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    // 请求结束或失败的时候调用
    // session会话对象
    // dataTask请求任务
    // error错误信息
    // 2>.解析数据
    NSLog(@"--%@--", [[NSString alloc] initWithData:self.resultData encoding:NSUTF8StringEncoding]);
    // e、关闭句柄
    [self.handle closeFile];
    self.handle = nil;
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend {
    // 监听上传进度
    // bytesSent本次发送的数据
    // totalBytesSent上传完成的数据大小
    // totalBytesExpectedToSend文件的总大小
    NSLog(@"--%f--", 1.0 * totalBytesSent / totalBytesExpectedToSend);
}

// NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    // 写数据
    // session会话对象
    // downloadTask下载任务
    // bytesWritten本次写入的数据大小
    // totalBytesWritten下载的数据总大小
    // totalBytesExpectedToWrite文件总大小
    // 获取文件的下载速度
    NSLog(@"--%f--", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    // 当恢复下载的时候调用该方法
    // fileOffset从什么地方下载
    // expectedTotalBytes文件总大小
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    // 当下载完成的时候调用
    // location文件的临时存储路径
    // 写入临时文件tmp：我们还需要转换到我们需要保存的路径
    // 拼接文件全路径
    NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
    // 剪切文件
    [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:fullPath] error:nil];
}


#pragma mark - AFNetworking
// get请求
-(void)getAFNetworking {
    // 1>.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2>.发送get请求
    /*
     第一个参数：请求路径（不包含参数）
     第二个参数：字典（发送给服务器的参数）
     第三个参数：nil
     第四个参数：进度回调
     第五个参数：成功回调
     第六个参数：失败回调
     */
    // http://120.25.226.186:32812/login?username=小马哥&pwd=123&type=JSON
    NSDictionary *dict = @{
        @"username": @"小马哥",
        @"pwd": @"123",
        @"type": @"JSON",
    };
    [manager GET:@"http://120.25.226.186:32812/login" parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // task请求任务
        // responseObject响应体信息
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // error错误信息
    }];
}
// post请求
-(void)postAFNetworking {
    // 1>.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2>.发送get请求
    /*
     第一个参数：请求路径（不包含参数）
     第二个参数：字典（发送给服务器的参数）
     第三个参数：nil
     第四个参数：进度回调
     第五个参数：成功回调
     第六个参数：失败回调
     */
    // http://120.25.226.186:32812/login?username=小马哥&pwd=123&type=JSON
    NSDictionary *dict = @{
        @"username": @"小马哥",
        @"pwd": @"123",
        @"type": @"JSON",
    };
    [manager POST:@"http://120.25.226.186:32812/login" parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // task请求任务
        // responseObject响应体信息
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // error错误信息
    }];
}
// 下载文件（小文件）
-(void)downloadAFNetworking1 {
    // 1>.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2>.下载文件
    NSURL *url = [NSURL URLWithString:@"http://img5.imgtn.bdimg.com/it/u=1915764121,2488815998&fm=21&gp=0.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /*
     第一个参数：请求对象
     第二个参数：进度回调 downloadProgress
     第三个参数：目标回调
     第四个参数：下载完成以后的回调
     */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // targetPath临时文件路径
        // response响应头信息
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // response响应头信息
        // filePath最终文件路径（fullPath一致）
        // error错误信息
    }];
    // 3>.执行
    [downloadTask resume];
}
// 下载文件（大文件）
-(void)downloadAFNetworking2 {
    // 1>.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2>.下载文件
    NSURL *url = [NSURL URLWithString:@"http://120.25.226.186:32812/resources/videos/minion_01.mp4"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    /*
     第一个参数：请求对象
     第二个参数：进度回调 downloadProgress
     第三个参数：目标回调
     第四个参数：下载完成以后的回调
     */
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        // 监听下载进度
        // downloadProgress.completedUnitCount已经下载大小
        // downloadProgress.totalUnitCount下载总大小
        NSLog(@"%f", 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        // targetPath临时文件路径
        // response响应头信息
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        // response响应头信息
        // filePath最终文件路径（fullPath一致）
        // error错误信息
    }];
    // 3>.执行
    [downloadTask resume];
}
// 上传文件
-(void)uploadAFNetworking {
    // 1>.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 2>.发送请求上传文件
    /*
     第一个参数：请求路径
     第二个参数：字典(非文件参数)
     第三个参数：nil
     第四个参数：处理要上传的文件数据
     第五个参数：进度回调
     第六个参数：上传成功回调
     第七个参数：上传失败回调
     */
    [manager POST:@"http://120.25.226.186:32812/upload" parameters:nil headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /*
         第一个参数：二进制数据（要上传的文件参数）
         第二个参数：服务器规定的
         第三个参数：该文件上传到服务器以什么名称保存
         第四个参数：MIMEType
         */
        UIImage *image = [UIImage imageNamed:@"xxx"];
        NSData *imageData = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"xxx.png" mimeType:@"image/png"];
//        // 第二种方式
//        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"../xxx.png"] name:@"file" fileName:@"xxx.png" mimeType:@"image/png" error:nil];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        // 监听上传进度
        // downloadProgress.completedUnitCount已经下载大小
        // downloadProgress.totalUnitCount下载总大小
        NSLog(@"%f", 1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // responseObject响应体信息
        NSLog(@"上传成功---%@", responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"上传失败---%@", error);
    }];
}
// 序列化相关处理
-(void)showSerialization {
    // 1>.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    // 如果返回的是xml数据，那么应该修改AFNetworking解析方案
//    manager.responseSerializer = [AFXMLParserResponseSerializer serializer];
    // 如果返回的既不是json也不是xml，那么应该修改AFNetworking解析方案
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    // 告诉AFN能够接受哪些类型的数据
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/javascript", @"text/html", nil];
    NSDictionary *dict = @{
        @"username": @"小马哥",
        @"pwd": @"123",
        @"type": @"JSON",
    };
    [manager GET:@"http://120.25.226.186:32812/login" parameters:dict headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // task请求任务
        // responseObject响应体信息
        NSXMLParser *parser = (NSXMLParser *)responseObject;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // error错误信息
    }];
}
// 监听网络状态变化
-(void)netStatus {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                // 蜂窝网络
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                // wifi
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                // 没有网络
            }
                break;
            case AFNetworkReachabilityStatusUnknown: {
                // 未知
            }
                break;
        }
    }];
    [manager startMonitoring];
}


#pragma mark - Charles
-(void)showCharles {
    // 抓包：https://blog.csdn.net/qq_40126686/article/details/106994471
    // 1>.什么是抓包：将网络传输的数据包进行截获、重发、编辑等操作
    // 2>.为什么要抓包：查看隐藏字段、分析数据传输协议（方便开展接口和性能测试）、定位网络问题
    /*
     3>.抓包工具
     1.概念：Charles是一款代理服务器软件，可以用来拦截网络请求（抓包可以很快定位问题）
     2.下载地址：http://www.charlesproxy.com/download
     3.操作：https://www.jianshu.com/p/9f4ebde9c518
     */
    /*
     4>.原理
     `Charles`作为中间人，对客户端伪装成服务端，对服务端伪装成客户端。简单来说：
     1.截获客户端的HTTPS请求，伪装成中间人客户端去向服务端发送https请求
     2.接受服务端返回，用自己的证书伪装成中间人服务端向客户端发送数据内容
     */
    /*
     5>.面试题
     1.你平时在工作中使用过抓包工具吗？一般是用来干嘛的？（如果出现网络请求错误你会用什么方法调试？抓包用什么工具？）
     // 你平时在工作中使用过抓包工具吗？
     我平时在工作中使用过抓包工具，一般使用Charles
     // 一般是用来干嘛的？
     1.定位网络问题、2.进行接口测试
     2.抓包的步骤是怎么样的？通过步骤你能猜测一下抓包的工作原理吗？
     xxx
     3.如何用Charles抓https的包？其中原理和流程是什么？怎么才可以让https不被抓包工具抓取？
     https://zhuanlan.zhihu.com/p/393989801
     https://blog.csdn.net/cpcpcp123/article/details/122107538
     4.什么是中间人攻击？如何避免？
     // 什么是中间人攻击？
     中间人攻击就是截获到客户端的请求以及服务器的响应：比如`Charles`抓取https的包就属于中间人攻击
     // 如何避免？
     客户端可以预埋证书在本地，然后进行证书的比较是否匹配
     */
}


#pragma mark - 密码学
/*
 1.base64加密
 1>.概念：严格意义上来说base64加密不算加密算法，只是一种编码方式
 2>.作用：将二进制数据编码成文本，方便网络传输
 3>.特点
 a.使用`base64`编码以后数据会变大（增加大约1/3），但是编码以后的数据可以直接在网页中显示
 b.虽然`base64`可以加密，但是`base64`能够逆运算，不够安全
 c.`base64`编码末尾都有个'='号
 4>.原理：将所有字符转化为ASCII码 -> 将ASCII码转化为8位二进制 -> 将二进制三位一组不足补0，共24位，再拆分成6位一组共四组 -> 统一在6位二进制前补两个0到八位 -> 将补0后的二进制转为十进制 -> 最后从Base64编码表获取十进制对应的Base64编码
 */
/*
 MD5加密和Base64加密有什么区别？各自的使用场景是什么？
 // MD5加密
 MD5加密是一种不可逆的摘要算法，用于生成摘要，无法逆向破解得到原文，一般用于验证数据的有效性，客户端和服务端采用同样的规则生成摘要，可以防止篡改
 // Base64加密
 Base64加密属于可逆的加密算法，在开发中，上传图片一般采用将图片转换成Base64字符串再上传
 */
/*
 1.对称加密：加密和解密使用同一个密钥（DES、3DES、AES）
 a.加密解密过程：`明文->密钥加密->密文`、`密文->密钥解密->明文`
 b.优点：算法公开、计算量少、加密速度快、加密效率高、适合大批量数据加密
 c.缺点：双方使用相同的密钥，密钥传输的过程不安全，易被破解，因此为了保密其密钥需要经常更换
 
 2.非对称加密：非对称加密算法需要成对出现的两个密钥：公开密钥(`publickey`) 和私有密钥(`privatekey`)（RSA加密）
 a.加密解密过程：
 `对于一个私钥，有且只有一个与之对应的公钥。生成者负责生成私钥和公钥，并保存私钥，公开公钥`
 `公钥加密，私钥解密；或者私钥数字签名，公钥验证。公钥和私钥是成对的，它们互相解密`
 b.特点
 // 对信息保密，防止中间人攻击：用于交换对称密钥
 将明文通过接收人的公钥加密，传输给接收人，因为只有接收人拥有对应的私钥，别人不可能拥有或者不可能通过公钥推算出私钥，所以传输过程中无法被中间人截获。只有拥有私钥的接收人才能阅读
 // 身份验证和防止篡改：用于数字签名
 权限狗用自己的私钥加密一段授权明文，并将授权明文和加密后的密文，以及公钥一并发送出来，接收方只需要通过公钥将密文解密后与授权明文对比是否一致，就可以判断明文在中途是否被篡改过
 c.优点：加密强度小，加密时间长，常用于数字签名和加密密钥、安全性非常高、解决了对称加密保存密钥的安全问题
 d.缺点：加密解密速度远慢于对称加密，不适合大批量数据加密
 
 3.哈希算法加密：通过哈希算法对数据加密，加密后的结果不可逆，即加密后不能再解密（MD5加密、SHA加密、HMAC加密）
 a.特点：不可逆、算法公开、相同数据加密结果一致
 b.作用：信息摘要，信息“指纹”，用来做数据识别（比如：用户密码加密、文件校验、数字签名、鉴权协议）
 */
// 钥匙串加密KeyChain
/*
 // 数字签名
 数字签名是通过`HASH算法`和`RSA加密`来实现的：我们将明文数据加上**通过`RSA加密`的数据`HASH值`**一起传输给对方，对方可以解密拿出`HASH值`来进行验证。这个通过RSA加密`HASH值`数据我们称为数字签名
 */
-(void)showSecret {
    // 一、Base64编码：编码以后的数据会变大
    // 1>.特点：可以将任意的二进制数据进行Base64编码
    // 2>.结果：所有的数据都能够被编码成只用65个字符（A~Z a~z 0~9 + / =）就可以表示的文本文件
    // 3>.Base64编码
    // 命令行：echo -n 需要编码的字符串 |base64
    // 先转换为二进制数据
    NSData *data = [@"xxx" dataUsingEncoding:NSUTF8StringEncoding];
    // 对二进制数据进行Base64编码
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    // 4>.Base64解码
    // 命令行：echo -n 需要解码的字符串 |base64 -D
    NSData *data1 = [[NSData alloc] initWithBase64EncodedString:base64String options:0];
    NSString *string1 = [[NSString alloc] initWithData:data1 encoding:NSUTF8StringEncoding];
    // 5>.第三方库GTMBase64
    
    // 二、目前流行的加密方式
    /*
     提升MD5加密安全性：使用HMAC（给定一个秘钥，对明文进行加密，并且做两次散列，得到32位字符）
     */
    // 1>.哈希散列函数（算法是公开的、对相同的数据加密结果、对不同的数据加密结果是定长的、不能反算）：MD5、SHA1、SHA256...可以通过海量数据的搜索得到结果
    // 2>.对称加密算法（加密和解密使用同一个密钥）：DES、3DES、AES（高级密码标准：美国安全局使用的）
    // 3>.非对称加密（非对称加密算法需要成对出现的两个密钥：公开密钥(`publickey`) 和私有密钥(`privatekey`)）：RSA
    
    // 三、MD5加密
    // 1>.效果：对输入信息生成唯一的128位散列值（32个字符）
    // 2>.特点：输入两个不同的明文不会得到相同的输入值、根据输入值，不能得到原始的明文，即其过程不可逆
    // 3>.应用：数字签名、文件完整性验证、口令加密
    // 4>.MD5 + 盐：在明文的固定位置插入随机字符串，然后在进行MD5
}

/*
 1.get请求和post请求有什么区别？
 // get请求
 http://www.baidu.com/login?wd=ios开发&id=changmeng&name=畅梦
 1>.将参数附加在url后面：由于url长度有限制，所以参数的大小有限制，安全性低
 2>.get请求一般用于从服务器获取数据
 // post请求
 http://www.baidu.com/login
 1>.将参数放在请求体中，参数大小原则上没有限制，安全性高
 2>.post请求一般用于向服务器发送数据
 
 2.http协议和https协议有什么不同？简述OSI七层网络模型？
 // http协议和https协议有什么不同？
 1>.http超文本传输协议：信息明文传输、标准端⼝80
 2>.https具有安全性的ssl加密传输协议：需要到CA申请证书（一般需要收费）、标准端⼝443
 // 简述OSI七层网络模型？
 1>.物理层 - 建立/维护/断开物理连接
 2>.数据链路层 - 提供介质访问和链路管理
 3>.网络层 - IP选址及路由选择
 4>.传输层 - 建立/管理/维护端到端的连接（tcp/upd）
 5>.会话层 - 建立/管理/维护会话
 6>.表示层 - 数据格式转化/数据加密
 7>.应用层 - 为应用程序提供服务（http）
 
 3.常见的网络协议：http协议、https协议、TCP协议、UDP协议、FTP协议
 
 4.NSURLConnection和NSURLSession的区别？
 1>.NSURLConnection在iOS9.x以后已经被NSURLSession所替代
 2>.NSURLSession对普通请求/上传/下载提供不同的方案NSURLSessionDataTask/NSURLSessionUploadTask/NSURLSessionDownloadTask
 3>.NSURLConnection先将文件下载到内存再写入沙盒（文件太大的时候容易造成内存爆增）/NSURLSession可以直接将文件下载到沙盒
 4>.NSURLConnection停止请求的发送以后就不能继续使用，NSURLSession有三个控制方法：取消、暂停、继续，暂停以后可以通过继续恢复当前的请求任务
 */
// AFNetWorking2.0需要常驻线程是因为请求回调依赖当前线程
// AFNetWorking3.0不需要常驻线程是因为NSURLSession的请求回调不需要依赖当前线程：可以指定回调的delegateQueue

@end
