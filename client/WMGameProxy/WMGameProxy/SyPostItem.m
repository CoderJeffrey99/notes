//
//  SyPostItem.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/2/22.
//  Copyright © 2020 zali. All rights reserved.
//

#import "SyPostItem.h"

@implementation SyPostItem

-(instancetype)initWithDict:(NSDictionary *)dict {
    SyPostItem *item = [[SyPostItem alloc]init];
//    // 第一种方式
//    // 1.key容易写错 - 将可能出现的错误集中在此处
//    item.citys = dict[@"citys"];
//    item.name = dict[@"name"];
//    return item;
    
    // 第二种方式
    // 1.字典中的key必须在model中的属性中找到（一一对应）
    // 2.不适用于model中嵌套model
    // 3.应用场景 - 简单的字典转model -> MJExtention框架/JSONModel框架
    // 原理 - 遍历字典中所有的key -> 给字典中所有的value赋值
    [item setValuesForKeysWithDictionary:dict]; // KVC
    return item;
}
+(instancetype)itemWithDict:(NSDictionary *)dict {
    return [[self alloc]initWithDict:dict];
}

// 防止dict中的key在model中找不到属性对应崩溃就必须实现以下两个方法
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    // 此处需要重写
    if ([key isEqualToString:@"id"]) {
        _movieId = value;
    }
}
- (id)valueForUndefinedKey:(NSString *)key {
//    return @"没有key";
    return key;
}


// 归档部分 - start - 与上面部分内容无关
// 告诉需要保存当前对象的哪些属性
- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.citys forKey:@"citys"];
    [coder encodeObject:self.name forKey:@"name"];
}
// 当解析一个文件的时候调用
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.citys = [coder decodeObjectForKey:@"citys"];
        self.name = [coder decodeObjectForKey:@"name"];
    }
    return self;
}
// 归档部分 - end - 与下面部分内容无关

@end
