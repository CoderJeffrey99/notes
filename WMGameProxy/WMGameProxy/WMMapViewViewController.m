//
//  WMMapViewViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2021/10/8.
//  Copyright © 2021 zali. All rights reserved.
//

#import "WMMapViewViewController.h"
#import <MapKit/MapKit.h>
#import "WMAnnotation.h"

@interface WMMapViewViewController () <
MKMapViewDelegate,
CLLocationManagerDelegate
>

@property (strong, nonatomic) CLLocationManager *locationManager;

@end

@implementation WMMapViewViewController

- (CLLocationManager *)locationManager {
    if (_locationManager == nil) {
        // 由于不需要每次都创建对象，我们可以使用lazy
        [self setupLocation];
    }
    return _locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 地图和定位
    // 1.有哪些技术可以实现定位？
    // gps 网络 基站
    // 2.需要使用的框架
    // MapKit.framework - 地图框架（地图展示、路线规划）
    // CoreLocation.framework - 定位框架（地理定位、地理编码、区域监听）
    // 3.应用场景：周边找场所、导航（路线规划）
    // 4.热门专业术语：LBS/Location Based Service基于位置的服务 ｜ SoLoMo/Social社交化 Local本地化 Mobile移动化
}

-(void)setupMapView {
    // 创建MKMapView
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
#pragma mark - 显示用户位置
    // 第一个方法
    // 是否显示用户当前位置（必须先请求授权）
    // 显示一个蓝点，在地图上标注用户的位置信息，但是不会自动放大地图，并且用户位置移动的时候地图不会自动跟着移动
    mapView.showsUserLocation = YES;
    // 第二个方法（该方法有时候不灵光）
    // 用户的追踪模式（必须先请求授权）
    /*
     MKUserTrackingModeNone不进行用户位置跟踪
     MKUserTrackingModeFollow跟踪用户的位置变化
     MKUserTrackingModeFollowWithHeading跟踪用户位置和方向变化
     */
    // 显示一个蓝点，在地图上标注用户的位置信息，但是会自动放大地图，并且用户位置移动的时候地图会自动跟着移动
    mapView.userTrackingMode = MKUserTrackingModeFollow;
#pragma mark - 模拟追踪显示用户
//    // 1>.显示一个蓝点
//    mapView.showsUserLocation = YES;
//    // 2>.设置delegate
//    mapView.delegate = self;
    
    // 地图类型
    // MKMapTypeStandard普通地图
    // MKMapTypeSatellite卫星云图
    // MKMapTypeHybrid混合模式（普通地图覆盖于卫星云图之上）
    // MKMapTypeSatelliteFlyover（3D立体卫星）
    // MKMapTypeHybridFlyover（3D立体混合）
    // MKMapTypeMutedStandard
    mapView.mapType = MKMapTypeStandard;
    // 设置地图控制项
    mapView.scrollEnabled = NO; // 是否可以滚动
    mapView.rotateEnabled = NO; // 是否可以旋转
    mapView.zoomEnabled = NO; // 是否可以缩放
    // 设置地图的显示项
    mapView.showsBuildings = YES; // 建筑物
    mapView.showsCompass = YES; // 指南针
    mapView.showsPointsOfInterest = YES; // POI兴趣点
    mapView.showsScale = YES; // 比例尺
    mapView.showsTraffic = YES; // 交通状况
    // 设置delegate
    mapView.delegate = self;
    // 显示MKMapView
    [self.view addSubview:mapView];
#pragma mark - 大头针
    // 按照MVC原则：在地图上操作大头针的数据模型
    // 1>.创建“大头针数据模型”（必须自定义，因为系统提供的无法赋值）
    WMAnnotation *annotation = [[WMAnnotation alloc] init];
    annotation.coordinate = mapView.centerCoordinate;
    annotation.title = @"123";
    annotation.subtitle = @"1234";
    // 2>.添加“大头针数据模型”
    [mapView addAnnotation:annotation];
    // 3>.移除“大头针数据模型”
    [mapView removeAnnotation:annotation];
//    // 点击屏幕某一个点 -> 获取该点的经纬度 -> 反地理编码获取位置信息 -> 制作大头针
//    // 思考：点击地图上的某一个点获取该点的经纬度
//    [mapView convertPoint:CGPointZero toCoordinateFromView:mapView];
}

// 下列操作只能在前台更新位置信息，如果需要后台更新位置信息需要Targets -> Signing&Capabilities -> Background Modes进行勾选（实际会在plist文件中有字段/其它后台操作，例如后台播放音乐也是这样操作）
-(void)setupLocation {
#warning 局部变量执行完就会被销毁（不能使用）
    // 创建定位管理者
    self.locationManager = [[CLLocationManager alloc]init];
    // 设置代理
    self.locationManager.delegate = self;
    // 每隔0.5米更新一次定位
    // kCLDistanceFilterNone
    self.locationManager.distanceFilter = 0.5;
    // 精确度（米）
    // kCLLocationAccuracyBest
    self.locationManager.desiredAccuracy = 0.3;
//    // 获取一次位置信息（比如城市定位）
//    // 定位逻辑：按照定位位置大小依次定位（3000-1000-100-10-best），只到超时或者定位到best将会把相应信息返回
//    // 支持iOS9.0
//    // 必须实现-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error方法
//    // 不能与startUpdatingLocation一起使用
//    [self.locationManager requestLocation];
#pragma mark - 从iOS6.0开始，只要App内部使用了用户隐私，系统就会弹窗让用户进行授权（iOS8.0之前会自动弹窗、iOS8.0以后需要主动授权）
#warning 该方法只是请求什么授权方法，而最终决定用户开启什么定位（前台OR后台）需要用户自己决定（在手机Setting）
    // 如果在Info.plist文件中没有相关Key则该方法调用无效
    // 请求前台定位授权（默认情况下只能在前台获取用户定位信息，如果想要在后台获取用户定位信息可以勾选后台模式）
    // 在后台获取用户信息的时候会在屏幕上方出现一个蓝色的横幅不断提醒用户当前App正在使用你的位置信息（无法做到后台偷偷定位）
    [self.locationManager requestWhenInUseAuthorization]; // NSLocationWhenInUseUsageDescription
    // iOS9.0以后想要获取后台用户位置信息
    // 必须勾选后台模式：不然会crash
    self.locationManager.allowsBackgroundLocationUpdates = YES;
    // iOS8.0以后
    // 如果在Info.plist文件中没有相关Key则该方法调用无效
    // 请求前后台定位授权（默认情况下就可以在后台获取用户信息，无需勾选）
    [self.locationManager requestAlwaysAuthorization]; // NSLocationAlwaysUsageDescription
#pragma mark - 利用CLLocationManager实现某个服务：以startXXX开启某个服务，以stopXXX停止某个服务
    // 开始更新：不断刷新用户位置然后利用delegate告诉外界
    // 模拟器可以设置位置信息用于测试
    // 标准定位服务
    // 实现定位的方案：基于"基站、gps、wifi"定位，具体使用那种由苹果自行决定
    // 优点：定位精准度高
    // 缺点：app关闭就无法获取位置，耗电量高
    // 应用：要求定位及时，精确度高，并且运行时间短
    [self.locationManager startUpdatingLocation];
    // 显著位置变化的服务
    // 实现定位的方案：基于"基站"定位，设备中必须有电话模块
    // 优点：当App被完全关闭时也可以接收到位置信息，并让App进入到后台处理
    // 缺点：定位精确度低
    // 应用：长时间监听用户位置，用户移动速度较快（比如打车软件）
    [self.locationManager startMonitoringSignificantLocationChanges];
//    // 停止更新
//    [self.locationManager stopUpdatingLocation];
#pragma mark - 区域监听（iOS8.0以后必须要请求用户的位置授权）
    // 0>.判断当前是否可以监听某个区域
    if ([CLLocationManager isMonitoringAvailableForClass:[CLCircularRegion class]]) {
        // 1>.创建区域
        // 区域不能过大（超高某一个数字会无效）
        CLLocationDistance distance = 1000;
        if (self.locationManager.maximumRegionMonitoringDistance < 1000) {
            distance = self.locationManager.maximumRegionMonitoringDistance;
        }
        CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:CLLocationCoordinate2DMake(21.123, 121.345) radius:distance identifier:@"xxxxx"];
        // 2>.监听区域
        [self.locationManager startMonitoringForRegion:region];
        // 请求某一个区域的状态（如果不写该代码第一次则无法显示内容）
        [self.locationManager requestStateForRegion:region];
    }
}

-(void)mapNavigation {
    // 1.概念：根据用户指定的位置进行路线规划，然后根据用户在行走的过程中实时的给出指引提示
    // 2.导航实现的方案
    // 第一种：可以将需要导航的位置发给系统的地图App进行导航
    // 第二种：发送网络请求到公司服务器获取导航数据，然后手动绘制导航（太复杂）
    // 第三种：利用第三方sdk实现导航
}
/*
 // iOS8.0之前
 前台定位：系统会自动弹窗让用户授权
 后台定位：勾选后台模式
 // iOS8.0之后
 前台定位：系统不会自动弹窗让用户授权（需要主动授权requestWhenInUseAuthorization）
 后台定位：前台定位 + 勾选后台模式（屏幕上方出现一个蓝色的横幅不断提醒用户当前App正在使用你的位置信息）｜requestAlwaysAuthorization（无需勾选后台模式｜可以偷偷定位）
 // iOS9.0之后
 前台定位：系统不会自动弹窗让用户授权（需要主动授权requestWhenInUseAuthorization）
 后台定位：前台定位 + 勾选后台模式 + self.locationManager.allowsBackgroundLocationUpdates = YES;（屏幕上方出现一个蓝色的横幅不断提醒用户当前App正在使用你的位置信息）｜requestAlwaysAuthorization（无需勾选后台模式｜可以偷偷定位）
 */
/*
 // 定位的应用场景
 1、导航：百度地图、腾讯地图、高德地图
 2、获取用户所在城市：电商App、携程
 3、采集用户信息：统计App
 4、查找周边：美团、饿了吗
 // 定位开发经验：由于定位十分耗电
 1、不需要获取用户位置的时候一定要关闭定位服务
 2、如果可以尽可能使用低精度的desiredAccuracy
 3、如果是数据采集（一般会周期性轮询用户位置），在轮询期间要关闭定位
 */
// 利用第三方框架LocationManager

#pragma mark - MKMapViewDelegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    // 当地图更新用户信息的时候调用
    // MKUserLocation大头针数据模型
//    // 位置是否更新
//    @property (readonly, nonatomic, getter=isUpdating) BOOL updating;
//    // 大头针的位置信息
//    @property (readonly, nonatomic, nullable) CLLocation *location;
//    // 设备朝向
//    @property (readonly, nonatomic, nullable) CLHeading *heading NS_AVAILABLE(10_9, 5_0) API_UNAVAILABLE(tvos);
//    // 弹窗标题
//    @property (nonatomic, copy, nullable) NSString *title;
//    // 弹窗子标题
//    @property (nonatomic, copy, nullable) NSString *subtitle;
    userLocation.title = @"123";
    userLocation.subtitle = @"12345";
    
    // 3>.移动地图中心，显示当前用户所在位置
    [mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    // 4>.设置地图显示区域
    [mapView setRegion:MKCoordinateRegionMake(userLocation.location.coordinate, MKCoordinateSpanMake(0.01, 0.01)) animated:YES];
    
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    // 区域改变的时候调用
//    mapView.region.span.latitudeDelta // 纬度跨度
//    mapView.region.span.longitudeDelta // 经度跨度
}

// MKMapView - 地图
// MKAnnotation - 大头针数据模型
// MKAnnotationView - 大头针视图
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
#pragma mark - 还是在使用系统类（不算真正意义的自定义）
//    // 当我们添加一个“大头针数据模型”到地图的时候就会调用该方法来查找对应的“大头针视图”（如果这个方法没有实现或返回nil则就会使用系统默认的“大头针视图”来显示）
//    // 系统大头针视图对应的类MKPinAnnotationView（大头针视图和cell一样，都有一个“循环利用”的机制）
//    // 1>.从缓存池取出大头针视图
//    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"item"];
//    if (annotationView == nil) {
//        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"item"];
//    }
//    // 大头针颜色
//    annotationView.pinTintColor = UIColor.yellowColor;
//    // 显示弹窗
//    [annotationView canShowCallout];
//    // 设置下落动画
//    annotationView.animatesDrop = true;
//    return annotationView;
    
    // 自定义大头针
    // 如果想要自定义大头针，要不使用MKAnnotationView，要不使用自定义的子类
    // 第一种方式：使用MKAnnotationView
    // 1>.从缓存池取出大头针视图
    MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"item"];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"item"];
    }
    // 重新刷新数据
    annotationView.annotation = annotation;
    // 设置大头针的图片
    annotationView.image = [UIImage imageNamed:@""];
    // 设置大头针中心偏移量
    annotationView.centerOffset = CGPointMake(10, 10);
//    // 设置弹窗
//    annotationView.leftCalloutAccessoryView = mapView;
//    annotationView.rightCalloutAccessoryView = mapView;
    // 设置大头针可以拖动
    annotationView.draggable = YES;
    // 显示弹窗
    [annotationView canShowCallout];
    return annotationView;
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 更新定位以后调用
    // 1>.问题：该方法默认会一直调用
    NSLog(@"已经获取到位置信息");
    // a、如果只想定位一次（比如获取用户当前所在城市）
    [self.locationManager stopUpdatingHeading];
    // b、导航
    // 1>.每隔一段时间定位一次（不推荐）
    // 2>.每隔一段距离定位一次（推荐）
    // 如果最新的位置距离上一次的位置之间的物理距离大于100米，就会通过delegate来告诉我们最新的位置数据
    self.locationManager.distanceFilter = 100;
    // 精确度（米）：精确度越高越耗电耗时
    // kCLLocationAccuracyBestForNavigation最适合导航
    // kCLLocationAccuracyBest最好的
    // kCLLocationAccuracyNearestTenMeters附近10米
    // kCLLocationAccuracyHundredMeters附近100米
    // kCLLocationAccuracyKilometer附近1000米
    // kCLLocationAccuracyThreeKilometers附近3000米
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    // 2>.获取定位信息
    // 按照时间升序排列：获取最新定位信息取lastObject
    /*
     // 经纬度
     @property(readonly, nonatomic) CLLocationCoordinate2D coordinate;
     // 海拔
     @property(readonly, nonatomic) CLLocationDistance altitude;
     // 如果整个数字是负数就代表位置数据无效
     @property(readonly, nonatomic) CLLocationAccuracy horizontalAccuracy;
     // 如果整个数字是负数就代表海拔无效
     @property(readonly, nonatomic) CLLocationAccuracy verticalAccuracy;
     // 航向（真北/磁偏角）
     @property(readonly, nonatomic) CLLocationDirection course;
     // 速度
     @property(readonly, nonatomic) CLLocationSpeed speed;
     // 楼层（必须先注册）
     @property(readonly, nonatomic, copy, nullable) CLFloor *floor;
     */
    CLLocation *location = locations.lastObject;
    // 计算两个经纬度坐标之间的直线物理距离
    [location distanceFromLocation:location];
    // locations.firstObject.coordinate.latitude - 纬度
    // locations.firstObject.coordinate.longitude - 经度
    // 3>.地理编码：给定具体位置获取经纬度
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:@"地图上的地址" completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"地理编码成功");
            // CLPlacemark地标对象
        }
    }];
    // 4>.反地理编码：给定经纬度获取具体位置信息
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error == nil) {
            NSLog(@"反地理编码成功");
            // 地标 - 封装“详细的地址信息”
//            1.地理位置（经纬度）
//            @property (nonatomic, readonly) CLLocation *location;
//            2.区域
//            @property (nonatomic, readonly) CLRegion *region;
//            3.地址详情
//            @property (nonatomic, readonly) NSString *name;
//            4.城市
//            @property (nonatomic, readonly) NSString *locality;
            CLPlacemark *placeMark = placemarks.firstObject; // 按照相关性排序：一般我们取数组第一个，也可以使用UITableView显示让用户选择
        } else {
            NSLog(@"解析失败");
        }
    }];
}
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    // 更新定位失败调用
}
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    // 授权状态发生改变
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"用户没有决定");
        }
            break;
        case kCLAuthorizationStatusRestricted: {
            NSLog(@"受限制");
        }
            break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"拒绝授权");
            // 判断当前设备是否支持定位，并且定位服务是否开启
            if ([CLLocationManager locationServicesEnabled]) {
                // App问题
                NSLog(@"真正拒绝授权");
                if ([UIApplication.sharedApplication canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                    // Setting里面有3个选项的原因：你在Info.plist文件中加入两个字段
                    [UIApplication.sharedApplication openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                }
            } else {
                // 当我们的App内部想要访问用户位置，但是当前的定位服务是关闭状态，那么系统会自动弹出一个alert快速跳转到Setting页面让用户设置
                // 设备问题
                NSLog(@"设备定位服务没有打开");
            }
        }
            break;
        case kCLAuthorizationStatusAuthorizedAlways: {
            NSLog(@"前台定位授权");
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse: {
            NSLog(@"前后台定位授权");
        }
            break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    // 调用该方法会调用该delegate
    // 该代码不能写在此处（此处只是演示）
    if (CLLocationManager.headingAvailable) {
        [self.locationManager startUpdatingHeading];
    }
//    // 获取当前设备位置朝向（借助“磁力计传感器”：一种硬件）
//    newHeading.magneticHeading // 相对于磁北方向
}

// 调用该方法的时候触发该delegate
// [self.locationManager startMonitoringForRegion:region];
- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    // 进入区域时调用
}
- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    // 离开区域时候调用
}

// 调用该方法的时候触发该delegate
// [self.locationManager requestStateForRegion:region];
- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region {
    
}

@end
