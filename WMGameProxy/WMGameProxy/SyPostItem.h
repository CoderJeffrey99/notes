//
//  SyPostItem.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/2/22.
//  Copyright © 2020 zali. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SyPostItem : NSObject <NSCoding>
// 1.新建字段
// 保持"属性"和"字段"保持一致
@property (strong, nonatomic) NSArray *citys;
@property (strong, nonatomic) NSString *name;
// 如果遇到后台字段为关键字（比如id）
// 此时不能使用id，需要改名称，但是改标识符又会导致KVC报错
@property (strong, nonatomic) NSString *movieId;

// 2.字典转模型
// 在controller中可以通过“循环”创建出更多model
// 利用model可以实现数据源
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)itemWithDict:(NSDictionary *)dict;

+(instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
