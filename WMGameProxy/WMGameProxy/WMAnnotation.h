//
//  WMAnnotation.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2022/11/9.
//  Copyright © 2022 zali. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN
// 定义显示标注的类，实现MKAnnotation协议
@interface WMAnnotation : NSObject <MKAnnotation>
// 从协议复制属性，初始化协议属性
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, nullable) NSString *title;
@property (nonatomic, copy, nullable) NSString *subtitle;

@end

NS_ASSUME_NONNULL_END
