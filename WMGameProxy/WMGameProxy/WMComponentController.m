//
//  WMComponentController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/7/31.
//  Copyright © 2019 zali. All rights reserved.
//

#import "WMComponentController.h"
#import "WMSkillViewController.h"
#import "WMFoundationNSObject.h"
#import <WebKit/WebKit.h>

@interface WMComponentController () <
UITextFieldDelegate,
UITextViewDelegate,
UIAlertViewDelegate,
UIActionSheetDelegate,
UIPickerViewDelegate,
UIPickerViewDataSource,
UIScrollViewDelegate,
UIWebViewDelegate,
WKUIDelegate,
WKNavigationDelegate,
UINavigationControllerDelegate,
UITabBarControllerDelegate,
UIGestureRecognizerDelegate,
CAAnimationDelegate
>
 
@end

/*
 1.认识UI(User Interface)
 1>.概述：用户通过UI与App进行交互/传入用户的请求/反馈运行的结果
 2>.坐标系：坐标系(0, 0)在左上角/x轴向右x正向延伸/y轴向下正向延伸
 */
@implementation WMComponentController

// 这里做很多事情会导致页面加载的很慢
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UIView视图
// UIView是所有视图的父类：UIView的属性是子视图共有的
// 0.以父视图左上角为原点
// 1.UIView的基本属性
// 2.父视图/子视图之间的转化
// 3.形变属性
// 4.动画
// 5.停靠模式
/*
 总结一下UIView的属性：基础控件都可以使用
 1.subviews
 2.superview
 3.tag
 4.transform
 5.frame
 6.backgroundColor
 7.alpha
 */
/*
 关于坐标系
 1、iOS7.x以后translucent默认YES，坐标原点是屏幕左上角
 2、translucent设置NO，坐标原点是导航条右下角
 */
// https://www.cnblogs.com/niit-soft-518/p/6373601.html
-(void)setupView {
//    CGPoint point = CGPointMake(100, 100); // 坐标：保存坐标x,y|NSPoint == CGPoint，官方推荐使用CGPoint
//    CGSize size = CGSizeMake(100, 100);  // 尺寸：保存尺寸|NSSize == CGSize，官方推荐使用CGSize
//    CGRect rect = CGRectMake(100, 100, 100, 100); // 矩形：保存坐标 + 尺寸|NSRect == CGRect，官方推荐使用CGRect
//    CGRectZero - "高度/宽度 = 0"的矩形常量
    UIView *view = [[UIView alloc]init];
    // 设置是否能接收事件：UIView默认是true
    // 如果父视图不能接收事件、则子视图不能接收事件
    // 子视图超出父视图部分不能接收事件
    // 如果覆盖上面的视图可以接收事件、则下面视图不会再收到事件
    // UILabel/UIImageView默认是false
    view.userInteractionEnabled = true;
    // 是否开启多点触摸
    view.multipleTouchEnabled = true;
    // 可以控制位置&尺寸
    // 以父控件的左上角为原点
    view.frame = CGRectMake(100, 100, 100, 50);
    // 结构体
    // 结构体是值传递
    // 类是对象传递
    // 怎么改变控件的frame（改变尺寸：中心点不变，向四周延伸）
    // https://www.jianshu.com/p/b6ddfdef4147
    CGRect tempRect = view.frame;
    tempRect.origin.x = 100;  // 改变x
    tempRect.origin.y += 100; // 改变y
    tempRect.size.height += 50; // 改变height
    tempRect.size.width += 50;  // 改变width
    view.frame = tempRect;
    // 可以控制尺寸
    // 不可以控制位置
    // 以自己左上角为坐标原点：x和y一般为0
    view.bounds = CGRectMake(0, 0, 100, 50);
//    // 表示view与self.view大小一样
//    view.frame = self.view.bounds;
    // 可以控制位置
    // 控件的中心点：以父控件左上角为坐标原点
    // 默认情况下：子视图的边框不会被父视图的边框裁剪
    view.center = CGPointMake(100, 40);
    // 获取父视图对象：一个视图最多只有一个父视图
    // 一旦一个视图被添加到一个父视图上就会从上一个父视图移除
    // 移动父视图的时候子视图也会一起移动
    UIView *superView = view.superview;
    // 打印CGRect
    NSLog(@"%@", NSStringFromCGRect(superView.bounds));
    NSLog(@"%@", NSStringFromCGPoint(superView.center));
    // 获取最大值/最小值
    // 可以简化布局
    CGRectGetMaxX(view.frame);
    CGRectGetMaxY(view.frame);
    CGRectGetMidX(view.frame);
    CGRectGetMidY(view.frame);
    CGRectGetMinX(view.frame);
    CGRectGetMinY(view.frame);
//    // 设置frame的方式
//    // 第一种 - 直接设置
//    view.frame = CGRectMake(0, 0, 100, 100);
//    // 第二种 - 根据图片大小设置
//    UIImage *image = [UIImage imageNamed:@""];
//    view.frame = CGRectMake(0, 0, image.size.width, image.size.height);
//    // 第三种
//    view.frame = view.bounds;
    // 背景颜色
    // 这个已经封装
    //设置RGBA颜色
//    view.backgroundColor = [[UIColor alloc]initWithRed:238.0/255.0 green:238.0/255.0 blue:238.0/255.0 alpha:1];
    view.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
//    // 这里怎么理解？？？
//    view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@""]];
    // 0-透明、1-不透明
    // 如果设置为0则不响应事件：所以一般不设置View透明度、而设置View背景透明度
    view.alpha = 0;
    // 根据内容（图片/文字）计算出最优size
    // 根据最优size改变自己的size
    [self.view sizeToFit];
    
    // 获取子控件对象：一个视图可以有多个子视图
    // 在xib中只有UIView可以承载子视图
    NSArray *subViews = view.subviews;
    // 如果父视图隐藏，子视图也会隐藏
    // 设置父视图alpha = 0.5/子视图alpha = 0.8，则真实alpha = 0.5 * 0.8 = 0.4
    // 一般我们是相对父视图布局：所以父视图移动，子视图跟着移动
    // 先添加到父视图的子视图会被后添加的视图覆盖
    // 一个父视图会有多个子视图、一个子视图只能有一个父视图、任何视图都可以添加到另一个视图
    for (view in subViews) {
//        // 判断一个view是不是指定view的子视图
//        BOOL isChildView =  [childView isDescendantOfView:parentView];
       NSLog(@"%@", NSStringFromCGRect(view.superview.bounds));
    }
    // 把子视图放在最上面
    [self.view bringSubviewToFront:superView];
    // 把子视图放在最下面
    [self.view sendSubviewToBack:superView];
    // 交换两个视图位置
    [self.view exchangeSubviewAtIndex:0 withSubviewAtIndex:2];
    // 插入一个视图在另一个视图上面
    [self.view insertSubview:view aboveSubview:superView];
    // 插入一个视图在另一个视图下面
    [self.view insertSubview:view belowSubview:superView];
    // 插入子视图：默认会添加
    [self.view insertSubview:superView atIndex:0];
    // 任何视图都可以添加到另一个视图/每个视图只能有一个父视图
    // 子视图的坐标是相对于父视图的，移动父视图会使子视图一起移动
    // 执行：先判断该view有没有父控件，如果有就会拿到这个view从父控件先移除再添加（因为一个view只能有一个父控件）
    [self.view addSubview:superView];
    // 获取superView的父视图
    [superView superview];
    // ！！！父视图不能移除子视图/子视图可以从父视图中移除！！！
    [superView removeFromSuperview];
    view.tag = 0;
    
    /// 形变属性：一次只能利用一个形变属性
    // 1.！！！xxxMakexxx相对于“UIView的初始状态”进行形变！！！
    // 2.！！！xxxxxx相对于“UIView传入的状态”进行形变！！！
    // 可以用于动画（一般与渐变动画配合使用）
    // 一、缩放形变
    // 0.5 - 相对于水平x方向缩放的比例
    // 2 - 相对于垂直y方向缩放的比例
    view.transform = CGAffineTransformMakeScale(0.5, 2);
    // 相对于superView进行形变
    view.transform = CGAffineTransformScale(view.transform, 0.5, 2);
    // 二、旋转形变
    // 参数是弧度
    view.transform = CGAffineTransformMakeRotation(M_PI);
    view.transform = CGAffineTransformRotate(view.transform, M_PI);
    // 三、平移形变
    // 结构体
    // 2 -相对于水平x方向平移
    // 5 -相对于垂直y方向平移
    // x 负数代表向左平移
    // y 负数表示向上平移
    view.transform = CGAffineTransformMakeTranslation(2, -5);
    view.transform = CGAffineTransformTranslate(view.transform, 2, -5);
}
/*
 ### frame和bounds有什么不同？
 // frame和bounds都是属于CGRect类型的结构体，都是UIView的属性：
 1.frame表示UIView在父视图坐标系统中的位置和大小，参照点是父视图的坐标系统
 2.bounds表示UIView在本地坐标系统中的位置和大小，参照点是本地坐标系统
 // 每个UIView都有自己的坐标系，默认以自身的左上角为坐标原点，所有子UIView以这个坐标系的原点为基准点：
 1.bounds的位置改变：对于当前UIView没有影响，对于子UIView而言父UIView的左上角不再是(0,0)
 2.bounds的大小改变：当前UIView的中心点不会发生改变，大小改变（类似缩放）
 */


#pragma mark - UILabel文本框
-(void)setupLabel {
    // UILabel的包裹模式：UILabel的高度是随着文字内容的增加而拉伸
    // 1.设置UILabel的位置(x, y)
    // 2.设置UILabel的最大宽度
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 100, 100, 50);
    // 会先将label从别的父视图移除
    [self.view addSubview:label];
    label.backgroundColor = UIColor.whiteColor;
    label.text = @"hello world";
    label.textColor = UIColor.yellowColor;
    // 添加"Zapfino.ttf"字体
    label.font = [UIFont fontWithName:@"Zapfino" size:20];
    /*
     NSTextAlignmentRight - 居右
     NSTextAlignmentCenter - 居中
     NSTextAlignmentLeft - 居左
     */
    label.textAlignment = NSTextAlignmentCenter;
    // 自适应宽度：字体会缩小/不会放大
    label.adjustsFontSizeToFitWidth = true;
    label.tag = 0;
    // ！！！父控件隐藏会导致所有的子控件都隐藏！！！
    label.hidden = false;
    // 指定label的行数
    // numberOfLines == 0表示无限行
    label.numberOfLines = 0;
    /*
     // 指定换行模式
     NSLineBreakByWordWrapping - 单词包裹
     NSLineBreakByCharWrapping - 字符包裹
     NSLineBreakByClipping
     NSLineBreakByTruncatingHead
     NSLineBreakByTruncatingTail
     NSLineBreakByTruncatingMiddle
     */
    label.lineBreakMode = NSLineBreakByWordWrapping;
    // 设置文字的最大宽度
    // 让UILabel能够计算出自己最真实的尺寸
    label.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 15 * 2;
    // 让UILabel设置html文档
    // ？？？使用“NSAttributedString/NSMutableAttributedString（富文本）”渲染文字？？？
    NSString *htmlString = @"<html><body>Some html string\n<font size= \"13\" color=\"red\">This is some text!</font> </body></html>";
    NSAttributedString *attrString = [[NSAttributedString alloc]initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    label.attributedText = attrString;
    // 根据字体计算宽度（一行）
    NSString *name = @"谢吴军";
    NSDictionary *nameAttr = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGSize nameSize = [name sizeWithAttributes:nameAttr];
    CGFloat width = nameSize.width;
    // 根据最大宽度计算高度（多行）
    CGSize nameSize1 = CGSizeMake(100, MAXFLOAT); // 宽度固定100，高度不确定
    CGSize textSize = [name boundingRectWithSize:nameSize1 options:NSStringDrawingUsesLineFragmentOrigin attributes:nameAttr context:nil].size;
    CGFloat height = textSize.height;
    NSLog(@"width = %f---height = %f", width, height);
}
/*
 编程：使UILabel的高度自动适应文本行数：UILabel的高度会随着文本的行数多少自动变化，UILabel的最终区域刚好够显示下所有文本，并且没有多余的空行（文本的行数不会超过一万行）
 */


#pragma mark - 阴影
-(void)setupShadow {
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(100, 100, 100, 50);
    // 阴影颜色
    label.shadowColor = UIColor.grayColor;
    // 偏移量
    // 负值 - 向左边、向下走
    // 正值 - 向右走、向上走
    label.shadowOffset = CGSizeMake(100, 100);
}


#pragma mark - UIButton按钮
// 有那些类可以"事件监听"：继承于UIControl都可以"事件监听"
// UIControlEventTouchUpInside - UIButton/点击事件
// UIControlEventValueChanged - UISwitch/UISegmentControl/UISlider/值改变事件
// UIControlEventEditingChanged - UITextField/文字改变事件
// UIDatePicker
// UIPageControl
// ！！！需求：将常见UI控件分类（按照父类）！！！
-(void)setupButton {
//    // 尽量使用快速定义方法、如果没有快速定义方法，再考虑init
//    UIButton *btn = [[UIButton alloc]init];
//    btn.buttonType = UIButtonTypeCustom; // 报错
    // 工厂方法
    // 既可以显示文字也可以显示图片
    // 可以随时调整内部图片/文字的位置
    // 通过重写UIButton（设置buttonType只能在初始化的时候设置）
    // 在开发中一般使用UIButtonTypeCustom（不使用UIButtonTypeSystem）
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:btn];
    /*
     button有四种状态
     这个很重要：可以用来做很多事情
     UIControlStateNormal - 正常状态/默认状态
     UIControlStateHighlighted - 高亮状态/长按未松手
     UIControlStateDisabled - 禁用状态/不可以点击
     UIControlStateSelected - 选择状态
     */
    // 设置文字
//    btn.titleLabel.text = "无效";
    [btn setTitle:@"普通" forState:UIControlStateNormal];
    [btn setTitle:@"高亮" forState:UIControlStateHighlighted];
    [btn setTitle:@"选择" forState:UIControlStateSelected];
    [btn setTitle:@"禁用" forState:UIControlStateDisabled];
    btn.selected = YES; // 选择状态：设置该属性则btn默认是UIControlStateSelected状态
    // 字体字重
    btn.titleLabel.font = [UIFont systemFontOfSize:15 weight:5];
    // 文字颜色
    [btn setTitleColor:UIColor.greenColor forState:UIControlStateNormal];
    btn.enabled = NO; // 非禁用状态：设置该属性则btn默认是UIControlStateDisabled状态
    // 设置文字阴影颜色
    [btn setTitleShadowColor:UIColor.whiteColor forState:UIControlStateNormal];
    // 设置文字阴影偏移
    btn.titleLabel.shadowOffset = CGSizeMake(3, 2);
    /// 背景颜色
    // 仅仅自定义类型有效
    btn.backgroundColor = UIColor.grayColor;
    // 设置button图像：内容图像（如果想修改布局需要重写UIButton的方法）
    // 1.只有图片/文字居中显示在button中央位置
    // 2.如果按钮足够大、同时设置文字和图片、文字/图片会并列显示
    // 3.如果按钮不够大、优先显示图像
    // 居中不拉伸
    // 如果按钮小于图片会拉伸按钮
    [btn setImage:[UIImage imageNamed:@"image_demo"] forState:UIControlStateNormal];
    /// 设置背景图像
    // 1.创建UIImage对象
    UIImage *bgImage = [UIImage imageNamed:@"image_demo"];
    // 2.返回一张受保护而且拉伸的图片（可以总结为category）
    // 作用：即时通讯App中聊天内容气泡怎么拉伸？？？
    // 第一种方式
    // ！！！可以保证纯色图片拉伸不变形！！！
    // CapInsets - 保护的区域（只拉伸“1*1的矩形区域”）
    // UIImageResizingModeTile（默认：平铺）
    // UIImageResizingModeStretch（拉伸）
    UIImage *resizableImage = [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(bgImage.size.height/2,
                                                                                    bgImage.size.width/2, bgImage.size.height/2 - 1, bgImage.size.width/2 - 1)
                                                      resizingMode:UIImageResizingModeTile];
//    // 第二种方式
//    // 右边需要保护的区域：default is 0. if non-zero, horiz. stretchable. right cap is calculated as width - leftCapWidth - 1
//    // 底部需要保护的区域：default is 0. if non-zero, vert. stretchable. bottom cap is calculated as height - topCapHeight - 1
//    [bgImage stretchableImageWithLeftCapWidth:bgImage.size.width/2 topCapHeight:bgImage.size.height/2];
    // 根据按钮的尺寸拉伸
    [btn setBackgroundImage:resizableImage forState:UIControlStateNormal];
    // 内边距
    // 上左下右
    btn.contentEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0); // 内容（图片 + title）
    btn.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0); // 图片
    btn.titleEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, 0); // title
//    // 获取属性
//    // nullable - 可以为空/可选类型
//    NSString *title = [btn titleForState:UIControlStateNormal];
//    UIImage *image = [btn imageForState:UIControlStateNormal];
    // 点击事件：记下来就好
    // 最多只能携带一个参数
    // TouchUpInside
    /*
     // 基于触摸
     UIControlEventTouchDown // 用户按下时触发
     UIControlEventTouchDownRepeat // 点击次数大于1时触发
     UIControlEventTouchDragInside // 当触摸在控件内拖动时触发
     UIControlEventTouchDragOutside // 当触摸在控件外拖动时触发
     UIControlEventTouchDragEnter // 当触摸在控件外拖动到控件内时触发
     UIControlEventTouchDragExit // 当触摸在控件内拖动到控件外时触发
     UIControlEventTouchUpInside // 控件内部触摸抬起时(☑️)
     UIControlEventTouchUpOutside // 控件外部触摸抬起时
     UIControlEventTouchCancel // 触摸取消事件：设置上锁、电话呼叫中断等
     // 基于值
     UIControlEventValueChanged // 当控件的值发生改变：一般用于滑块和分段视图(☑️)
     // 基于编辑
     // 一般 UITextField 使用较多
     UIControlEventEditingDidBegin // 文本控件开始编辑时
     UIControlEventEditingChanged  // 文本控件中文本发生改变时
     UIControlEventEditingDidEnd // 文本控件中编辑结束时
     UIControlEventEditingDidEndOnExit // 文本控件内通过按下回车键结束编辑时
     UIControlEventAllTouchEvents // 所有触摸事件
     UIControlEventAllEditingEvents //文本编辑的所有事件
     UIControlEventAllEvents // 所有事件
     */
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    // 移除某个事件
    [btn removeTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnAction:(UIButton *)btn {
    NSLog(@"button被点击");
}


#pragma mark - UIImageView图片视图
/*
 ### 加载图片的几种方式对比
 // imageNamed - 适用于加载小图片（加载图片的时候会缓存图片，所以当图片被频繁的使用的时候该方法比较好）
 UIImage *image = [UIImage imageNamed:@"icon.png"];
 // imageWithData - 适用于占用内存较大的图片：使用该方法加载的图片不会一直保存在内存中
 NSString *filePath = [[NSBundle mainBundle] pathForResource:@"icon" ofType:@"png"];
 NSData *imageData = [NSData dataWithContentsofFile:filePath];
 UIImage *image = [UIImage imageWithData:imageData];
 */
// UIImage -二进制的图像数据
-(void)setupImageView {
    // 创建图片对象
    // 该方法只能加载占用内存小的图片：因为这种方式加载的图片会一直保存在内存中，不会释放
    // Assets.xcassets中的图片只能通过该方法设置（默认就有缓存）
    // 一般经常使用的图片会通过该方式加载
    // png不需要后缀（jpg必须加后缀）
    // 使用两组图片image_demo.png和image_demo@2x.png：则会自动加载与该版本相符合的相应的图片
    UIImage *image0 = [UIImage imageNamed:@"image_demo"];
    // 打印图片大小
    NSLog(@"%@", NSStringFromCGSize(image0.size));
    /// 如果图片占用内存较大：使用下列方法（没有缓存）
    // 会从内存中释放
    // 一般不经常使用的图片会通过该方式加载
    // 进入"资源包"获取资源
    NSString *path = [[NSBundle mainBundle] pathForResource:@"image_demo" ofType:@"png"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    // 方法一
    UIImage *image1 = [UIImage imageWithData:data];
    // 方法二
    UIImage *image2 = [UIImage imageWithContentsOfFile:path];
    NSLog(@"%@===%@", image1, image2);
    /// UIImageView
    UIImageView *imageView = [[UIImageView alloc]init];
//    // 第一种设置位置（常用）
//    imageView.frame = CGRectMake(100, 100, 100, 50);
//    // 第二种设置位置（常用）
//    // 根据图片动态获取尺寸
//    imageView.frame = CGRectMake(0, 0, image0.size.width, image0.size.height);
//    // 第三种设置位置（骚操作）
//    // 有默认尺寸
//    UIImageView *defaultImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"image_demo"]];
//    defaultImageView.center = CGPointMake(100, 100);
//    [self.view addSubview:defaultImageView];
    /// 开发中常见的颜色
    // 颜色通道： ARGB/32位颜色 | RGB/24位颜色 | RGB/12位
    // 颜色通道越多，质量就越高，占用尺寸就越大，图像就越清晰
    imageView.backgroundColor = [UIColor.redColor colorWithAlphaComponent:1];
    imageView.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
    imageView.image = [UIImage imageNamed:@"image_demo"];
    imageView.highlightedImage = image0; // 设置高亮图片
    imageView.userInteractionEnabled = YES; // 默认为NO
    imageView.clipsToBounds = YES;  // 裁减超出部分
    /*
     填充模式：
     UIViewContentModeRedraw - 重新绘制（核心动画drawRect）
     UIViewContentModeScaleToFill - 拉伸填满/默认/不会超出：图片会变形
     UIViewContentModeScaleAspectFit - 按比例填充/宽或高一边靠近/不会超出
     UIViewContentModeScaleAspectFill - 按比例填满/宽和高全部靠近/会超出
     */
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    // 毛玻璃
    UIToolbar *toolBar = [[UIToolbar alloc]init];
    // toolBar沾满imageView全屏幕
    toolBar.frame = imageView.bounds;
    /*
     UIBarStyleDefault
     UIBarStyleBlack
     */
    toolBar.barStyle = UIBarStyleBlack;
    // 设置透明度
    toolBar.alpha = 0.5;
    [imageView addSubview:toolBar];
    
    // 1.帧动画
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"DOVE/image_bg.jpg"]];
    // 1).拿到数组
    NSMutableArray<UIImage *> *photos = [NSMutableArray array];
    for (NSInteger i = 1; i < 19; i++) {
        // 获取图片对象
        // 好好研究UIImage
        UIImage *birdImaga = [UIImage imageNamed:[NSString stringWithFormat:@"DOVE.bundle/DOVE %ld", (long)i]];
        [photos addObject:birdImaga];
    }
    // 2).设置动画
    // 动画需要时间前面一个动画会覆盖后面一个动画
    // 甚至会发生未知的错误
    // 所以一般需要前面一个动画结束再执行后一个动画
    // 动画数组
    imageView.animationImages = photos;
    // 动画执行时间/动画时长
    imageView.animationDuration = 0.5;
    // 播放动画次数/0为无数次
    imageView.animationRepeatCount = 0;
    // 启动动画
    [imageView startAnimating];
    if (imageView.isAnimating) {
        // 正在执行动画
    }
//    // 停止动画
//    [imageView stopAnimating];
    
    // 2.渐变动画
    // 只能修改“坐标系的属性、色彩、透明度”
    // 第一种方式：通过delegate（先不实现）
    // 第二种方式：通过block
    // 不会引起循环引用：为什么？组织一下语言
    // 目前有三种形式：应用也很多
    // 支持嵌套
    [UIView animateWithDuration:2 animations:^{
        // 这里还可以设置形变属性
        NSLog(@"这里可以改变“坐标/色彩/透明度”");
    }];
    [UIView animateWithDuration:2 animations:^{
        // ！！！这里还可以设置形变属性！！！
        NSLog(@"这里可以改变“坐标/色彩/透明度”");
    } completion:^(BOOL finished) {
        // 动画完成时需要的执行
        if (finished) {
            NSLog(@"动画完成");
        }
    }];
    // UIViewAnimationOptions - 动画属性设置
    // https://www.jianshu.com/p/ec73573e112a
    /*
     UIViewAnimationOptionCurveEaseInOut - 动画开始结束比较慢，中间比较快
     UIViewAnimationOptionCurveEaseIn - 动画开始比较慢
     UIViewAnimationOptionCurveEaseOut - 动画结束比较慢
     UIViewAnimationOptionCurveLinear - 线性
     */
    [UIView animateWithDuration:2 delay:0.5 options:UIViewAnimationOptionOverrideInheritedCurve animations:^{
        // 1.这里还可以设置形变属性
        NSLog(@"这里可以改变“坐标/色彩/透明度”");
        // 2.如果使用masonry则需要[xxx layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (finished) {
            NSLog(@"动画完成");
        }
    }];
}
// 裁剪图片
-(UIImage *)clipImage:(UIImage *)image rect:(CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect(image.CGImage, rect);
    return [UIImage imageWithCGImage:imageRef];
}


#pragma mark - UITextField文本输入框
-(void)setupTextField {
    UITextField *tf = [[UITextField alloc]init];
    tf.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:tf];
//    // 这两个方法正好相反
//    [tf removeFromSuperview];
    tf.text = @"我是文本框";
    tf.font = [UIFont systemFontOfSize:20];
    // 文本颜色
    tf.textColor = UIColor.redColor;
    // 文本对齐方式
    tf.textAlignment = NSTextAlignmentLeft;
    // 占位符
    tf.placeholder = @"请输入用户名";
    // 边框类型
    tf.borderStyle = UITextBorderStyleBezel;
    // 宽度自适应
    tf.adjustsFontSizeToFitWidth = true;
    // 开始编辑的时候清除文本框文字
    tf.clearsOnBeginEditing = true;
    // 设置清除UIButton
    tf.clearButtonMode = UITextFieldViewModeAlways;
    // 设置键盘外观
    tf.keyboardAppearance = UIKeyboardAppearanceDark;
    // 设置键盘类型
    tf.keyboardType = UIKeyboardTypeNumberPad;
    // 设置返回键类型
    tf.returnKeyType = UIReturnKeyDone;
    // 设置密文显示
    tf.secureTextEntry = true;
    // 自动大写类型
    tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
    // 设置代理
    tf.delegate = self;
    // 变成第一响应者
    // 只有成为"第一响应者"才可以弹出键盘
    // 结束编辑实际就是失去"第一响应者"
    [tf becomeFirstResponder];
    // 可以达到delegate一样的效果
    // 监听文本改变（也可以使用delegate）
    [tf addTarget:self action:@selector(editDidChanged:) forControlEvents:UIControlEventEditingChanged];
    /// 自定义清除按钮
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    view.backgroundColor = UIColor.yellowColor;
    tf.rightView = view;
    tf.rightViewMode = UITextFieldViewModeWhileEditing;
    // 自定义文本框弹出键盘
    // 一般银行App使用较多
    UIView *csView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20)];
    csView.backgroundColor = UIColor.redColor;
    tf.inputView = csView;
    // 自定义文本框弹出键盘Bar
    UIView *barView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44)];
    barView.backgroundColor = UIColor.blueColor;
    tf.inputAccessoryView = barView;
}
// editDidChanged:是方法名称
-(void)editDidChanged:(UITextField *)textField {
    NSLog(@"文字改变");
}
#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    // 是否允许开始编辑
    // YES代表可以成为第一响应者
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 开始编辑/点击输入框调用该方法
    // 成为 “第一响应者” 开始调用
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    // 是否允许结束编辑
    // NO代表不可以失去第一响应者
    return NO;
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    // 结束编辑
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    // 点击return的时候调用该方法
    // 第一种方式：放弃第一响应者（退出键盘）
    [textField resignFirstResponder];
//    // 第二种方式
//    [textField endEditing:YES];
//    // 第三种方式（常用）
//    [self.view endEditing:YES];
    return true;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField {
    // 是否允许全部清空
    return YES;
}
// ！！！重点！！！
// 当textField文字发生改变就会调用该方法
// 拦截用户输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // 是否允许改变文本框内容
    // 是否允许string去改变文本框内容
    return YES; // 允许输入
//    return NO; // 禁止输入
}
-(void)keyBoard {
    // 强行关闭键盘：设置为YES/NO都可以关闭键盘
    // 但是发生界面死锁NO可能不会关闭
    // 可以强制退出键盘
    [self.view endEditing:YES];
}


#pragma mark - UITextView能滚动的文本显示控件
-(void)setupTextView {
    // 可以滚动
    UITextView *textView = [[UITextView alloc]init];
    textView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:textView];
    textView.backgroundColor = [UIColor whiteColor];
    // 当文字超过视图边框时是否允许滑动 - 默认YES
    textView.scrollEnabled = YES;
    // 是否允许编辑内容 - 默认YES
    textView.editable = YES;
    // 设置字体名字和字体大小
    textView.font = [UIFont fontWithName:@"Arial" size:18.0];
    // return键的类型
    textView.returnKeyType = UIReturnKeyDefault;
    // 键盘类型
    textView.keyboardType = UIKeyboardTypeDefault;
    // 文本显示的位置默认为居左
    textView.textAlignment = NSTextAlignmentLeft;
    // 显示数据类型的链接模式（如电话号码、网址、地址等）
    textView.dataDetectorTypes = UIDataDetectorTypeAll;
    // 内容
    textView.text = @"请输入你想要说的话";
    // 设置代理
    textView.delegate = self;
}
#pragma mark - UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    // 将要开始编辑
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    // 将要结束编辑
    return YES;
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    // 结束编辑
    [textView resignFirstResponder]; // 放弃第一响应者
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    // 开始编辑
}
/*
 内容文字改变的时候调用
 text - 用户输入的内容
 return - YES允许用户输入/NO不允许使用输入
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // 内容将要发生改变
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView {
    // 内容发生改变
}
- (void)textViewDidChangeSelection:(UITextView *)textView {
    // 焦点发生改变
}


#pragma mark - UIScrollView滚动视图
// 用于显示超出App程序窗口大小的内容
// 允许用户通过拖动手势滚动查看内容
// 允许用户通过捏合手势缩放内容
// 用来滚动的视图，可以用来展示大量内容
// UIView不具备滚动功能
// ！！！不能用索引去查找UIScrollView的子控件（位置不确定）！！！
-(void)setupScrollView {
    // UIScrollView不可滚动的原因有哪些？？？
    // 1.没有设置contentSize
    // 2.设置scrollEnabled = NO
    // 3.设置userInteractionEnabled = NO
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.backgroundColor = UIColor.grayColor; // 设置颜色
//    scrollView.clipsToBounds = YES;  // 默认该属性为YES（超出边框的内容会隐藏）
    // 可视范围： scrollView的尺寸
    // 内容实际大小：contentSize的尺寸
    // 可滚动尺寸： contentSize的尺寸 - scrollView的尺寸
    // 不可以滚动： contentSize的尺寸 <= scrollView的尺寸
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width * 2, [[UIScreen mainScreen] bounds].size.height);  // 设置内容大小（左右滚动）/这里[[UIScreen mainScreen] bounds].size.height也可以设置为0
    scrollView.contentSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height * 2);  // 设置内容大小（上下滚动）/这里[[UIScreen mainScreen] bounds].size.width也可以设置为0
    // 结构体x|y
    // 内容偏移量 = UIScrollView左上角 - 内容左上角
    // 可以控制滚动的位置
    scrollView.contentOffset = CGPointZero; // 内容偏移量：内容和控件的距离（设置UIScrollView滚动的位置）
    // 增加额外滚动区域
    // 凡是在导航条下面的UIScrollView默认会设置偏移量
    // 可以通过self.automaticallyAdjustsScrollViewInsets = NO;设置
    // 参考UIScrollView的常见属性.png
    scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);  // 内边距：cell到边的距离
    // 凡是在导航条下面的UIScrollView都会默认设置偏移量（取消该操作：不要自动设置偏移量）
    // 取消该操作以后可以自行设置contentInset
    if (@available(iOS 11, *)) {
        // >= iOS11
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // < iOS11
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    scrollView.clipsToBounds = YES; // 超出边框的部分会被隐藏
    scrollView.bounces = NO;  // 设置是否反弹
    scrollView.pagingEnabled = YES; // 设置按页滚动（以UIScrollView尺寸为一页）
    scrollView.indicatorStyle = UIScrollViewIndicatorStyleWhite; // 设置滚动条样式
    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 30); // 一般不需要设置
    // 设置隐藏滚动条
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.scrollEnabled = true; // 设置是否可以滚动（设置为NO则UIScrollView不能滚动）
    scrollView.scrollsToTop = true;  // 是否滚动到顶部
    scrollView.userInteractionEnabled = NO; // 是否可以响应与用户的交互（设置为NO则UIScrollView不能滚动）
    scrollView.alwaysBounceHorizontal = YES; // 水平方向不管有没有设置contentSize，总有弹簧效果
    scrollView.alwaysBounceVertical = YES; // 垂直方向不管有没有设置contentSize，总有弹簧效果
    // UIScrollView通过delegate对WMComponentController弱引用
    // WMComponentController对UIScrollView强引用（这里只是一个局部变量）
    scrollView.delegate = self;
    //！！！以下一般不设置！！！//
    // UIScrollView很容易实现内容缩放
    // ！！！设置缩放功能：需要两步！！！
    // 1.设置pinch缩放属性：默认值为1
    // scrollView.minimumZoomScale == scrollView.maximumZoomScale不能缩放
    scrollView.minimumZoomScale = 0.5; // 缩小的最小比例
    scrollView.maximumZoomScale = 5;    // 放大的最大比例
    // 减速率：一般数值越大，停下来的时间越长
    scrollView.decelerationRate = 0;
    // 按住手指还没有开始拖动是YES
    // 是否正在被拖拽
    // 是否正在减速
    // 是否正在缩放
    NSLog(@"%d, %d, %d, %d", scrollView.tracking, scrollView.dragging, scrollView.decelerating, scrollView.zooming);
    [self.view addSubview:scrollView];
    // 原则：遍历一个数组最好要保证该数组不变
    // ！！！这里目前是没有问题的！！！
    for (UIView *subView in scrollView.subviews) {
        [subView removeFromSuperview];
    }
    // UIScrollView的自动布局：首先要确定UIScrollView滚动范围
}
// UIScrollView无法滚动的原因
// 1>.contentSize的尺寸 <= scrollView的尺寸
// 2>.scrollView.scrollEnabled = false;
#pragma mark - UIScrollViewDelegate
// 1&2&4 - 可以唯一确定上滑/下滑
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 1.不管怎么操作 - 只要拥有偏移量就执行
    // 实时监测滚动变化
    // 瀑布流：在该方法内部让多个scrollView同时有相同的偏移量可以实现瀑布流
}
// 2&4 - 可以唯一确定停止滚动
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    // 2.已经停止拖拽的时候执行
    if (decelerate == NO) {
        // 没有减速（表示已经停止滚动）
        // 4&5不会执行
    } else {
        // 停止拖拽，由于惯性会减速（表示没有停止滚动：4才是真正的停止滚动）
        // 4&5会执行
    }
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    // 3.将要停止拖拽的时候执行
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    // 4.已经减速结束的时候执行
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    // 5.将要减速的时候执行
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // 6.将要拖动的时候执行
}
- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    // 7.是否允许回到顶部 - 一般不用设置
    return YES;
}
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    // 8.已经回到顶部开始执行
}
//！！！以下处理缩放逻辑！！！//
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    // 2.设置对哪个视图缩放、返回缩放的视图对象
//    // ！！！不能用索引去查找UIScrollView的子控件（位置不确定）、所以此处写法有问题！！！
//    return scrollView.subviews.firstObject;
    // 直接返回需要缩放的控件
    return scrollView;
}
- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    // 将要开始缩放
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // 已经开始缩放（正在缩放）
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    // 已经结束缩放
}


#pragma mark - UIPageControl分页控件
-(void)setupPageControl {
    // 高度默认37（不能修改）
    UIPageControl *pc = [[UIPageControl alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    pc.currentPage = 5;  // 当前页码
    pc.numberOfPages = 10; // 总共页码
    pc.hidesForSinglePage = YES; // 只有一页时是否隐藏视图
    pc.pageIndicatorTintColor = UIColor.greenColor; // 控件颜色（未选中颜色）
    pc.currentPageIndicatorTintColor = UIColor.orangeColor; // 当前选中颜色
    pc.enabled = NO; // 一般都是屏蔽事件
    [pc addTarget:self action:@selector(updatePageChanged:) forControlEvents:UIControlEventValueChanged];
    pc.tag = 100;
    [pc updateCurrentPageDisplay]; // 刷新当前视图
    [self.view addSubview:pc];
    // 自定义"UIPageControl样式"
    // 利用KVC访问私有变量
    [pc setValue:[UIImage imageNamed:@"xxx"] forKeyPath:@"_currentPageImage"];
    [pc setValue:[UIImage imageNamed:@"xxx"] forKeyPath:@"_pageImage"];
}
-(void)updatePageChanged:(UIPageControl *)pc {
    NSLog(@"%ld", (long)pc.currentPage);
}


#pragma mark - UIMenuController菜单
// https://blog.csdn.net/woyangyi/article/details/45896859
-(void)setupMenuController {
    // 如果一个控件可以使用“单例”创建，那么最好让“init”创建报错
    UIMenuController *menu = [UIMenuController sharedMenuController];
    if (menu.isMenuVisible) {
        [menu setMenuVisible:NO animated:YES];
    }
    UIMenuItem *copyItem = [[UIMenuItem alloc]initWithTitle:@"copy" action:@selector(onCopy:)];
    UIMenuItem *deleteItem = [[UIMenuItem alloc]initWithTitle:@"delete" action:@selector(onDelete:)];
    menu.menuItems = @[copyItem, deleteItem];
    // 设置坐标
    // 这块坐标一般取“点击的位置”
    [menu setTargetRect:CGRectMake(100, 100, 80, 50) inView:self.view];
    // 显示menu
    [menu setMenuVisible:YES animated:YES];
    // 设置当前UIViewController为第一响应者
    // UIMenuController的显示依赖第一响应者（UIViewController取消第一响应者 -> UIMenuController自动消失）
    [self becomeFirstResponder];
}
-(void)onCopy:(UIMenuItem *)item {
}
-(void)onDelete:(UIMenuItem *)item {
}


#pragma mark - UIAlertController控件
// iOS8.0以上推荐使用
-(void)setupAlertController {
    // 1.创建控制器
    // UIAlertController是UIViewControlelr子类
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"确定删除？" message:@"删除以后别人将看不到你的动态" preferredStyle: UIAlertControllerStyleActionSheet];
    // 2.创建按钮
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"你点击了确认");
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"你点击了取消");
    }];
    // 3.添加按钮
    [alertVC addAction:sureAction];
    [alertVC addAction:cancelAction];
    // 4.还可以添加文本框
    // 如果需要给block中的对象赋值需要使用__block修饰
    [alertVC addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
    }];
    // 5.显示弹窗
    [self presentViewController:alertVC animated:YES completion:nil];
}


#pragma mark - UIPickerView/选择器
-(void)setupPickerView {
    UIPickerView *pickerView = [[UIPickerView alloc]init];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    // 默认选中
    [self pickerView:pickerView didSelectRow:0 inComponent:0];
    [pickerView selectRow:0 inComponent:1 animated:true];
    // 刷新数据
    [pickerView reloadAllComponents];
    [pickerView reloadComponent:0];
}
#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
// UIPickerViewDataSource
// 必须实现
// 总共多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
// 每列展示多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 10;
}
// UIPickerViewDelegate
// 非必须实现
// 返回每一列的宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.view.frame.size.width / 2;
}
// 返回每一行的高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 45;
}
/// 返回每一行的内容
// 1.字符串
// row - 行
// component - 列
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"xmg";
}
// 2.带属性字符串（大小、颜色、阴影、描边）
- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return nil;
}
// 3.每一行展示什么视图
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view {
    return [[UIView alloc] init];
}
// 当前选中的是哪一行哪一列
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}


#pragma mark - UIDatePicker/时间选择器
-(void)setupDatePicker {
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    // 修改datePicker日期格式
    // UIDatePickerModeTime
    // UIDatePickerModeDate
    // UIDatePickerModeDateAndTime
    // UIDatePickerModeCountDownTimer
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
    // 监听日期改变
    [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
}
-(void)dateChange:(UIDatePicker *)datePicker {
    // 获取当前选中的日期
    // NSDate和NSString相互转换
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    [fmt stringFromDate:datePicker.date];
}


#pragma mark - UIStackView线性布局
-(void)setupStackView {
    // https://www.jianshu.com/p/e53d8ab96c09
    // https://blog.csdn.net/liumude123/article/details/119348625?spm=1001.2101.3001.6661.1&utm_medium=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-119348625-blog-124796494.pc_relevant_3mothn_strategy_recovery&depth_1-utm_source=distribute.pc_relevant_t0.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1-119348625-blog-124796494.pc_relevant_3mothn_strategy_recovery&utm_relevant_index=1
}


#pragma mark - UIPopoverContrller/继承于NSObject
-(void)setupPopoverContrller {
    
}


#pragma mark - UISlider/滑块
// 作用：控制系统声音/表示播放进度
-(void)setupSlider {
    UISlider *slider = [[UISlider alloc]init];
    slider.frame = CGRectMake(100, 100, 100, 50);
    slider.maximumValue = 100; // 设置最大值
    slider.minimumValue = 0;   // 设置最小值
    slider.value = 20;  // 设置当前值：必须设置最大值和最小值以后才可以设置value
    // 设置颜色
    slider.maximumTrackTintColor = UIColor.purpleColor;
    slider.minimumTrackTintColor = UIColor.blueColor;
    slider.thumbTintColor = UIColor.greenColor;
    // 设置图片
    slider.maximumValueImage = [UIImage imageNamed:@""]; // 右边（最大）图片
    slider.minimumValueImage = [UIImage imageNamed:@""]; // 左边（最小）图片
    [slider setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    slider.continuous = NO; // 不接收连续点击
    // 设置UISlider的值
    [slider setValue:10 animated:YES];
    // 滑块拖动时的事件
    [slider addTarget:self action:@selector(onSliderChanged:) forControlEvents:UIControlEventValueChanged];
    // 滑块拖动后的事件
    // 一般都选择UIControlEventTouchUpInside
    [slider addTarget:self action:@selector(onSliderUp:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)onSliderChanged:(UISlider *)slider {
    NSLog(@"滑块拖动时的事件");
}
-(void)onSliderUp:(UISlider *)slider {
    NSLog(@"滑块拖动后的事件");
}


#pragma mark - UISwitch/开关
// ！！！不能设置尺寸的控件（只能通过缩放设置尺寸）！！！
// UISwitch
// UIActivityIndicatorView
// UISegmentControl
-(void)setupSwitch {
    UISwitch *sw = [[UISwitch alloc]init];
    // 因为iOS内置size（默认width51.0/height31.0）
    // 设置frame没有效果
    // 可以通过缩放来设置大小
    sw.frame = CGRectMake(100, 100, 100, 50);
    sw.on = true; // 是否打开
    sw.onTintColor = UIColor.orangeColor;
    sw.tintColor = UIColor.greenColor;
    sw.thumbTintColor = UIColor.purpleColor;
    [sw addTarget:self action:@selector(onSwitchChange:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sw];
    // 按钮转换拥有动画效果
    [sw setOn:YES animated:true];
}
-(void)onSwitchChange:(UISwitch *)sw {
    NSLog(@"打开开关");
}


#pragma mark - UIStepper/步数器
-(void)setupStepper {
    UIStepper *step = [[UIStepper alloc]initWithFrame:CGRectMake(100, 100, 100, 50)];
    [self.view addSubview:step];
    step.stepValue = 5;
    step.minimumValue = 0;
    step.maximumValue = 20;
    // 当前值
    step.value = 0;
    step.tintColor = UIColor.greenColor;
    // 可以从头开始
    step.wraps = YES;
    step.continuous = NO;
    step.autorepeat = YES;
    [step addTarget:self action:@selector(onStep:) forControlEvents:UIControlEventValueChanged];
}
-(void)onStep:(UIStepper *)step {
}


#pragma mark - UISegmentControl/多段选择视图、选项卡
-(void)setupSegmentControl {
    NSArray *array = @[@"居左", @"居中", @"居右"];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc]initWithItems:array];
//    segmentControl.frame = CGRectMake(100, 100, 100, 50);
    segmentControl.center = CGPointMake(100, 50);
    [self.view addSubview:segmentControl];
    segmentControl.tintColor = UIColor.orangeColor;
    segmentControl.selectedSegmentIndex = 0;  // 选中状态
    [segmentControl insertSegmentWithTitle:@"下一页" atIndex:1 animated:NO]; // 插入新段
    segmentControl.momentary = YES; // 默认为 NO（YES表示一会儿以后不显示被选中状态）
    [segmentControl addTarget:self action:@selector(onSegmentControl:) forControlEvents:UIControlEventValueChanged];
}
-(void)onSegmentControl:(UISegmentedControl *)segmentControl {
    
}


#pragma mark - UIAlertView/中间弹窗
// 不需要添加到父试图/不需要设置坐标
//-(void)setupAlertView {
//    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"输入密码错误" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",@"OK", nil];
//    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
//    [alert show];
//}


#pragma mark - UIAlertViewDelegate
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    // 点击第几个button
//}


#pragma mark - UIActionSheet/底部弹窗
//-(void)setupActionSheet {
//    UIActionSheet *alert = [[UIActionSheet alloc]initWithTitle:@"你确定需要删除吗？" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"删除" otherButtonTitles:@"确定", nil];
//    [alert showInView:self.view];
//}


#pragma mark - UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    // 点击第几个button
//}
//
//- (void)actionSheetCancel:(UIActionSheet *)actionSheet {
//    // 有系统事件（来电）时调用
//}


#pragma mark - UIProgressView/进度条
-(void)setupProgressView {
    UIProgressView *progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    progressView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:progressView];
    // 当前进度
    progressView.progress = 0.5;
    progressView.tag = 0;
    progressView.progressTintColor = UIColor.orangeColor;
}


#pragma mark - UIActivityIndicatorView/活动指示器
-(void)setupActivityIndicatorView {
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    // 不需要设置尺寸
    // 只需要设置位置
    // 可以通过缩放来设置大小
    view.frame = CGRectMake(100, 100, 100, 50);
    view.center = CGPointMake(100, 50);
    [self.view addSubview:view];
    view.hidesWhenStopped = YES; // 动画停止：是否隐藏视图、默认为YES
    // 开始动画
    [view startAnimating];
    //    // 结束动画
    //    [view stopAnimating];
    NSLog(@"当前动画的状态：%d", view.isAnimating);
}


#pragma mark - UIWebView（已废弃）
-(void)setupUIWebView {
    /*
     UIWebView
     1>.概念：UIWebView是iOS内置的浏览器控件
     2>.作用：UIWebView可以加载远程的网页资源和常见文件（.pdf/.txt）
     */
    // 3>.加载网络资源
    // 1.创建UIWebView
    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    // 2.创建远程url/也可以创建本地url
    NSURL *url = [NSURL URLWithString:@"http://www.baidu.com"];
    // 3.创建NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 4.加载url
    [webView loadRequest:request];
    // 5.添加到父视图
    [self.view addSubview:webView];
    // 4>.可以通过“UIScrollView属性”给UIWebView设置
    webView.scrollView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    // 5>.加载本地资源
    // 万能加载 - xxx.txt/xxx.mp4/xxx.pdf/xxx.ppt
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:@"/Users/xiewujun/Desktop/123.mp4"]]];
    // 设置自适应
    webView.scalesPageToFit = YES;
    // 加载“本地html”
    [webView loadRequest:[NSURLRequest requestWithURL:[[NSBundle mainBundle] URLForResource:@"NBSDK接口协议.html" withExtension:nil]]];
    // 设置需要识别什么类型字符串
    webView.dataDetectorTypes = UIDataDetectorTypeAll;
    // 后退 - 退到第一页代表不能再后退
    if (webView.canGoBack) {
        [webView goBack];
    }
    // 前进 - 前进最后一页代表不能再前进
    if ([webView canGoForward]) {
        [webView goForward];
    }
    // 刷新网页
    [webView reload];
    // 可以加载"html字符串"（很多"新闻类App"使用）
    // https://www.cnblogs.com/W-Kr/p/5248316.html
    [webView loadHTMLString:@"" baseURL:nil];
    // 停止加载网页
    [webView stopLoading];
    // 是否正在加载
    if ([webView isLoading]) {
        NSLog(@"正在加载");
    }
    // delegate
    webView.delegate = self;
    // 执行"js方法" - UIWebView可以主动调用js
    [webView stringByEvaluatingJavaScriptFromString:@"Callback()"];
}
#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    // 1.即将加载某个请求的时候调用 - 请求发送前会调用
    // 1>.拦截某个请求
    if ([request.URL.absoluteString containsString:@"360"]) {
        return NO;
    }
    return true;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // 2.开始加载网页 - 请求发送以后
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 3.网页加载完成 - 服务器返回数据以后
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 4.网页加载错误 - 网页加载失败
}


#pragma mark - WKWebView
-(void)setupWKWebView {
    // 1.创建WKWebView
    // iOS 8.x以后新增的类
    // 相对于UIWebView：内存的消耗很少、推荐使用
    // 支持更多的HTML5的特性
    // 高达60fps的滚动刷新率以及内置手势
    // Safari相同的JavaScript引擎
    WKWebView *wkWebView = [[WKWebView alloc]init];
    wkWebView.UIDelegate = self;
    wkWebView.navigationDelegate = self;
    [self.view addSubview:wkWebView];
    // 2.创建远程url/也可以创建本地url
    NSURL *remoteUrl = [NSURL URLWithString:@"http://www.baidu.com"];
    // 3.创建NSURLRequest
    NSURLRequest *request = [NSURLRequest requestWithURL:remoteUrl];
    [wkWebView loadRequest:request];
    // 执行"js方法" - WKWebView可以主动调用js
    [wkWebView evaluateJavaScript:@"Callback()" completionHandler:^(id _Nullable, NSError * _Nullable error) {
        
    }];
}
#pragma mark - WKUIDelegate
// 主要处理 js脚本、确认框、警告框
#pragma mark - WKNavigationDelegate
// 主要处理一些跳转、加载处理操作
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    // 请求前决定是否要跳转
    // WKNavigationActionPolicyCancel
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    
}
// 接收到服务器跳转以后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation {
    
}
/*
 // webview混排
 https://blog.csdn.net/u010960265/article/details/80563668
 */
/*
 如何实现oc和js交互？
 ### UIWebView
 // oc调用js
 1.在该方法‘- (void)webViewDidFinishLoad:(UIWebView *)webView {}’中调用‘[webView stringByEvaluatingJavaScriptFromString:@"Callback()"];’
 // js调用oc
 1.在该方法‘- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType’截取重定向
 ### WKWebView
 //iOS与H5的交互
 https://blog.csdn.net/sandyloo/article/details/65630863
 https://www.jianshu.com/p/b0c847dcea9c
 //利用WebViewJavascriptBridge
 https://blog.csdn.net/qq_20455399/article/details/80353164
 */
/*
 UIWebView和WKWebView有什么不同？
 1.WKWebView支持更多的h5特性
 2.WKWebView支持高达60FPS的滚动刷帧率和内置手势
 3.WKWebView加载网页占用内存更少，稳定性更高
 */
/*
 针对app显示WKWebView时的内存问题应该如何优化？
 1.启动阶段：预先初始化WKWebView、初始化WKWebView的同时让Native处理网络请求
 2.网页：js的加载会阻塞html的加载（将js代码放在html代码底部）
 */


#pragma mark - 触摸事件
/*
 1.iOS事件分类
 1>.触摸事件（点击按钮、长按）- UIGestureRecognizer
 2>.加速计事件（摇一摇）- 目前不讨论（实用技术部分学习）
 3>.远程控制事件（遥控）- 目前不讨论（实用技术部分学习）
 */
/*
 2.触摸事件相关概念
 1>.响应者对象：在iOS中不是所有对象都可以处理事件，只有继承UIResponder对象才可以接收并处理事件，我们称为“响应者对象”
 2>.响应者链条：由多个响应者对象连接起来的链条，可以让触摸事件发生的时候多个响应者同时响应该事件
 */
/*
 3.注意
 1>.UIApplication/UIViewController/UIView都是“响应者对象”（能够接收并处理对象）
 2>.UILabel/UIImageView默认不能接收事件
 3>.一个控件如果它的父控件不能够接收事件，那么它的子控件也是不能接收事件
 4>.一个控件隐藏的时候，那么它的子控件也是隐藏的
 5>.一个控件透明的时候，那么它的子控件也是透明的
 */
// 点击控制器View系统会自动调用
// 1.一根/多根手指开始触摸View
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 默认做法：将事件顺着响应者链条向上传递，将事件交给上一个响应者进行处理
    // 上一个响应者：控制器的View上一个响应者是控制器、其它View上一个响应者是父控件
    [super touchesBegan:touches withEvent:event];
    NSLog(@"touch begin");
    // 单点触摸：使用第一个参数
    // ！！！好好研究一下UITouch对象！！！
    // 一根手指对应一个UITouch对象，保存着与手指有关的信息（触摸的位置、时间、阶段）
    // 当手指移动时，UITouch对象会随之改变
    // 当手指离开屏幕时，UITouch对象会随之销毁
    // 注意：iOS开发中避免使用双击（容易出现点击冲突）
    UITouch *touch = [touches anyObject];
    // CGRect/CGSize/CGPoint/CGFloat都不是类
    // 返回的位置“相对于View的坐标系”（以View的左上角为[0, 0]）
    // 如果传入的"view参数"为nil则返回的触摸点在UIWindow的位置
    CGPoint currentPoint = [touch locationInView:self.view];
    CGPoint lastPoint = [touch previousLocationInView:self.view];
    NSLog(@"当前触摸点%@=上次触摸点%@", NSStringFromCGPoint(currentPoint), NSStringFromCGPoint(lastPoint));
    NSLog(@"触摸产生时所处的窗口%@=触摸产生时所处的视图%@=短时间内点击屏幕的次数%lu=触摸时间%f",
          touch.window, touch.view, touch.tapCount, touch.timestamp);
    // 多点触摸：使用第二个参数
    // 每产生一个事件就会产生一个UIEvent对象（事件对象）：记录事件产生的时刻和类型
    NSSet *touchSet = [event allTouches];
    for (UITouch *touch in touchSet) {
        CGPoint currentPoint = [touch locationInView:self.view];
        CGPoint lastPoint = [touch previousLocationInView:self.view];
        NSLog(@"当前触摸点%@=上次触摸点%@", NSStringFromCGPoint(currentPoint), NSStringFromCGPoint(lastPoint));
        NSLog(@"触摸产生时所处的窗口%@=触摸产生时所处的视图%@=短时间内点击屏幕的次数%lu=触摸时间%f",
              touch.window, touch.view, touch.tapCount, touch.timestamp);
    }
    // event事件类型
    UIEventType type = event.type;
}
// 2.一根/多根手指在View中移动（移动会持续调用）
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch move");
    // 手指移动的同时让UIView移动可以实现UIView拖拽
}
// 3.一根/多根手指离开View
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch end");
}
// 4.某个系统事件（电话呼入、自动关机）打断触摸过程
-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch cancel");
}


#pragma mark - 加速计事件
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motion begin");
}
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motion end");
}
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motion cancel");
}


#pragma mark - 远程控制事件
- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    
}


#pragma mark - UIGestureRecognizer/手势识别器
/*
 前提：通过touches方法监听view触摸事件有很明显的缺点：
 1.必须自定义view实现touches方法
 2.由于是在view内部的touches方法中监听触摸事件，因此默认情况下，无法让其他外界对象监听view的触摸事件
 3.不容易区分用户的具体手势行为
 */
// UIScreenEdgePanGestureRecognizer边缘手势
-(void)setupGestureRecognizer {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:imageView];
    imageView.backgroundColor = UIColor.redColor;
    imageView.userInteractionEnabled = YES;
    // 一个视图可以附着多个手势/一个手势只能附着一个视图
    // 0.单击
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    tap.numberOfTapsRequired = 1;  // 设置点击次数
    tap.numberOfTouchesRequired = 1; // 设置需要几根手指
    tap.delegate = self; // ！！！手势可以设置代理！！！
    [imageView addGestureRecognizer:tap];
    // 1.双击
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    doubleTap.numberOfTapsRequired = 2;
    [imageView addGestureRecognizer:doubleTap];
    [tap requireGestureRecognizerToFail:doubleTap]; // 单击会在双击失败以后才会识别单击手势
    // 2.长按手势/拖动的时候会持续调用
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(onLongPress:)];
    longPress.minimumPressDuration = 1;  // 最小按压时间
    [imageView addGestureRecognizer:longPress];
    // 3.拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(onPan:)];
    [imageView addGestureRecognizer:pan];
    // 4.捏合手势
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(onPinch:)];
    pinch.delegate = self;
    [imageView addGestureRecognizer:pinch];
    // 5.旋转手势
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(onRotation:)];
    rotation.delegate = self;
    [imageView addGestureRecognizer:rotation];
    // 6.轻扫手势（可以用于视频/直播方面）
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipe:)];
    // NS_OPTIONS
    // 设置轻扫手势方向
    // ！！！一个轻扫手势只能对应一个方向！！！
    // 默认 UISwipeGestureRecognizerDirectionRight
    swipe.direction = UISwipeGestureRecognizerDirectionUp;
    [imageView addGestureRecognizer:swipe];
}
/// 事件处理
-(void)onTap:(UITapGestureRecognizer *)tap {
    NSLog(@"点击的view%@", tap.view);
}
// 当长按移动的时候会持续调用
-(void)onLongPress:(UILongPressGestureRecognizer *)press {
    NSLog(@"长按");
    // 判断手势的状态
    switch (press.state) {
        case UIGestureRecognizerStatePossible:{
            NSLog(@"尚未识别是何种手势操作：可能已经触发");
        }
            break;
        case UIGestureRecognizerStateBegan:{
            NSLog(@"开始长按");
        }
            break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"开始时移动");
        }
            break;
            // 等同于UIGestureRecognizerStateRecognized
        case UIGestureRecognizerStateEnded:{
            NSLog(@"手指离开");
        }
            break;
        case UIGestureRecognizerStateCancelled:{
            NSLog(@"手势被取消：恢复到默认状态");
        }
            break;
        case UIGestureRecognizerStateFailed:{
            NSLog(@"手势识别失败：恢复到默认状态");
        }
            break;
        default:
            NSLog(@"");
            break;
    }
}
-(void)onPan:(UIPanGestureRecognizer *)pan {
    // 可以拿到拖动的偏移量
    // 相对于“最原始的位置”/需要做“复位”操作
    CGPoint point = [pan translationInView:self.view];
    NSLog(@"拖动的偏移量=%@", NSStringFromCGPoint(point));
    // 1.这里可以执行“平移”效果让控件移动
    // 假装这里有代码（形变）
    // 2.复位操作
    [pan setTranslation:CGPointZero inView:self.view];
}
-(void)onPinch:(UIPinchGestureRecognizer *)pinch {
    // 1.这里配合“形变属性”可以操作很多动画效果
    // 2.相对于“最原始的位置”/需要做“复位”操作
    NSLog(@"捏合的比例=%lf", pinch.scale);
    // 假装这里有代码（形变）
    // 3.复位操作
    [pinch setScale:1];
}
-(void)onRotation:(UIRotationGestureRecognizer *)rotation {
    // 1.这里配合“形变属性”可以操作很多动画效果
    // 2.相对于“最原始的位置”/需要做“复位”操作
    NSLog(@"旋转的角度=%lf", rotation.rotation);
    // 假装这里有代码（形变）
    // 3.复位操作
    [rotation setRotation:0];
}
-(void)onSwipe:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"向上轻扫");
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"向右轻扫");
    }
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 是否允许触发手势
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    // 是否允许同时支持多个手势：默认不支持/YES表示支持
    return YES;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    // 是否允许接收手势
    // 一边可以接收手势
    // 另一边不可以接收手势
    CGPoint point = [touch locationInView:self.view];
    if (point.x > self.view.frame.size.width / 2) {
        return NO;
    } else {
        return YES;
    }
}


#pragma mark - UIViewControllView
// 凡是继承于UIViewController的对象都是控制器
// 每个控制器都有一个UIView属性管理一个软件界面：控制器本身不可见、能够看见的是控制器的UIView
// 子类：UITabBarController/UINavigationController/UITableViewController
// 先执行“init()方法” -> 执行“loadView()方法”
-(void)setupController {
    // 颜色
    self.view.backgroundColor = UIColor.grayColor;
    // 模态跳转：区别于push
    // 1.任何控制器都可以通过“模态model”跳转
    // 2.“模态跳转”会将窗口上面的View移除，将需要“模态跳转”的“控制器View”添加到窗口上
    WMSkillViewController *conroller = [[WMSkillViewController alloc]init];
    // 设定动画样式
    conroller.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // 弹出
//    // 1>.将window上面的view移除，然后将model控制器的view添加到window上（但是window的rootController没有改变）
//    [[UIApplication sharedApplication].keyWindow addSubview:self.view]; // model的原理（可以自己实现一个model）
    // 2>.当一个控制器被销毁，控制器view不一定会被销毁，但是控制器view的业务逻辑没法处理
    [self presentViewController:conroller animated:YES completion:^{
        // self.presentingViewController强引用model控制器（model控制器没有被销毁）
        NSLog(@"模态弹出%@", self.presentingViewController);
    }];
    // 消失
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"模态消失");
    }];
#pragma mark - 父子控制器
    // UIViewController也可以管理子控制器
    // 便于开发：如果控制器A的view添加到控制器B的view上，那么控制器A必须成为控制器B的子控制器
    [self addChildViewController:conroller];
//    // 占位视图思想：可以先给父控制器添加一个containView（便于管理：不需要再分别进行适配）
//    [self.containView addSubview:conroller.view]
}


/*
// 非主流框架搭建（导航条内容无法改变）
UIWindow -> UINavigationController -> UITabBarController(只有一个) -> ChildViewControllers
// 主流框架搭建
UIWindow -> UITabBarController -> UINavigationControllers(多个) -> ChildViewControllers
*/
// [[UINavigationBar appearance] setTranslucent:NO]
#pragma mark - UINavigationBar导航条/UIToolBar工具条
-(void)setupNavigationBar {
    /*
     需要理解的内容：
     1.创建UINavigationController
     2.UINavigationController的常见属性和方法
     3.UINavigationController的层级关系
     4.UINavigationBar的常见属性和方法
     5.UINavigationItem的常见属性和方法
     6.iOS15+的导航栏默认透明（需要手动设置）
     7.工具条：默认隐藏
     8.案例：渐变的导航条
     */
    // 1.创建“导航视图控制器UINavigationController” - 轻松管理多个controller，完成controller之间的切换
    // 必须指定RootViewController：通过push/pop管理UIViewController
    // 继承UIViewController
    
    // 2.UINavigationController的常见属性和方法
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self];
    /*
     下面有什么区别？
     1、navigationController.viewControllers - 数组
     2、navigationController.childViewControllers - 只读数组
     */
    NSLog(@"获取导航控制器的顶部控制器=%@、获取导航控制器的可视控制器=%@、获取导航控制器的子控制器=%@、获取栈中视图控制器=%@", navigationController.topViewController, navigationController.visibleViewController, navigationController.childViewControllers, navigationController.viewControllers);
//    // 附：怎么让一个"拥有导航栏的VC"跳转到一个"没有导航栏的vc"
//    // 1.第一种方式（太麻烦）
//    - (void)viewWillAppear:(BOOL)animated {
//        [super viewWillAppear:animated];
//        [self.navigationController setNavigationBarHidden:YES animated:animated];
//    }
//    - (void)viewWillDisappear:(BOOL)animated {
//        [super viewWillDisappear:animated];
//        [self.navigationController setNavigationBarHidden:NO animated:animated];
//    }
//    // https://blog.csdn.net/cccccc1990/article/details/101718154
//    navigationController.delegate = self;
    
    // 3.UINavigationController的层级关系（参见UINavigationController的层级结构.png）
    /*
    1.UIWindow -> UINavigationController() -> 存放子控制器（通过栈的形式）
    2.rootViewController的view添加到UIWindow
    */
    // UITabBar隐藏（一般放在重写的push方法内部）
    self.hidesBottomBarWhenPushed = YES;
    // 压入栈：跳转到下一个UIViewController（当前控制器不会销毁）
    [self.navigationController pushViewController:self animated:YES];
    // 返回到上一个UIViewController/会将上面的控制器移除（移除的控制器会销毁）
    [self.navigationController popViewControllerAnimated:YES]; // 移除栈顶控制器
    [self.navigationController popToViewController:self animated:YES]; // 移除指定控制器（必须是导航控制器的子控制器）
    [self.navigationController popToRootViewControllerAnimated:YES];  // 移除栈底控制器
    
    // 4.UINavigationBar的常见属性和方法
    // 1>.导航条（只有一个/默认不隐藏）
    // 继承UIView，导航条位于状态栏底部（坐标{0, 20}）
    // 设置导航控制器的风格
    // UINavigationBar *bar = navigationController.navigationBar; // 获取导航栏：只读变量
    /*
     UIBarStyleDefault  // 默认白色
     UIBarStyleBlack     // 黑色
     */
    navigationController.navigationBar.barStyle = UIBarStyleBlack; // 导航条样式
    navigationController.navigationBarHidden = YES;  // 导航条隐藏：默认不隐藏
    [navigationController setNavigationBarHidden:YES animated:YES];
    navigationController.navigationBar.translucent = YES; // YES半透明（表示坐标原点在屏幕左上角）/NO不透明（表示坐标原点在导航条左下角）
    navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"image_demo"]]; // 左上角返回键字体颜色/以图片做为颜色
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:125.0/255.0 green:125.0/255.0 blue:125.0/255.0 alpha:1]; // 导航条颜色
    
    // 5.UINavigationItem的常见属性和方法
    // 每个UIViewController都有一个UINavigationItem
    // UINavigationItem在UINavigationBar上面，但是是由UIViewController控制UINavigationItem
    // ！！！“导航条UINavigationBar”的内容取决于“栈顶控制器的UINavigationItem属性”/需要在栈顶控制器中设置！！！
    // self.navigationItem.backBarButtonItem - 左上角的返回按钮
    self.navigationItem.title = @"导航视图控制器";  // 标题/如果需要修改字体颜色使用“富文本”/参考"eyee"/iOS13.x以后设置方法有所改变 | // navigationController.navigationBar.titleTextAttributes = xxx;
    self.navigationItem.titleView = [[UIView alloc]init]; // 标题视图
    // 初始化UIBarButtonItem有多种方法
    // 1.定制系统UIBarButtonItem
    UIBarButtonItem *item0 = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onAdd)];
    // 2.设置有图片的UIBarButtonItem
    // 设置图片让图片不要渲染就可以保持图片颜色不会变成蓝色而保持原色
    // 可以直接在Assets.xcassets中设置/也可以通过代码设置
    UIImage *image1 = [UIImage imageNamed:@"image_demo"];
    [image1 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithImage:image1 style:UIBarButtonItemStylePlain target:self action:@selector(onImage)];
    // 3.设置有文字的：自行百度
    // 怎么让文字不要默认蓝色：如果需要修改字体颜色使用“富文本”/参考"eyee"
    // 4.自定义UIBarButtonItem
    // 位置不需要设置/大小需要自己设置
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIBarButtonItem *customItem0 = [[UIBarButtonItem alloc]initWithCustomView:btn];
    // 让按钮自适应大小
    [btn sizeToFit];
    // 这两种写法有什么不同
    /*
     一个UINavigationController有若干个UIViewController
     一个UINavigationController包含一个navigationBar/toolbar
     navigationItem在navigationBar的上面
     navigationItem不是由navigationBar控制、也不是由UINavigationController控制
     navigationItem是由当前UIViewController控制
     */
    // UIBarButtonItem可以自定义/UINavigationItem决定着显示内容/子控制器的属性
//    // 每个"子控制器"都有一个navigationItem
//    self.navigationController.navigationItem.leftBarButtonItem = item0;  // 错误写法
    self.navigationItem.leftBarButtonItem = item0;   // 正确写法
    self.navigationItem.rightBarButtonItem = item1;
    self.navigationItem.leftBarButtonItems = @[item0, customItem0];
    self.navigationItem.rightBarButtonItems = @[item0, customItem0];
    self.navigationItem.hidesBackButton = YES;  // 隐藏返回按钮
//    self.navigationItem.prompt = @"加载中..."; // 一般不使用
    // ！！！默认图片/title都是蓝色！！！
    // 如果不需要图片蓝色使用：UIImageRenderingModeAlwaysOriginal
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"image_demo"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(onAdd)];
    // 如果不需要设置文字蓝色：使用“富文本”/参考"eyee"/自行百度
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(onAdd)];
    
    // 6.iOS15+的导航栏默认透明（需要手动设置）
    // https://www.jianshu.com/p/9b519673dcbd
    // https://baijiahao.baidu.com/s?id=1711749740139600655&wfr=spider&for=pc
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *navigationBarAppearance = [[UINavigationBarAppearance alloc]init];
        navigationBarAppearance.backgroundColor = UIColor.whiteColor;
        self.navigationController.navigationBar.scrollEdgeAppearance = navigationBarAppearance;
    } else {
        // Fallback on earlier versions
    }
    // ！！！导航栏无论透明还是非透明不影响坐标系的位置！！！
    
    // 7.工具条：位于底部、默认隐藏
    // 一般不用（默认就是隐藏）
    navigationController.toolbarHidden = NO;
    navigationController.toolbar.barStyle = UIBarStyleBlack;
    navigationController.toolbar.translucent = NO;
    navigationController.toolbar.tintColor = UIColor.yellowColor;
    // 继承UIView
    [self.navigationController setToolbarHidden:NO animated:YES];  // 设置"UIToolBar工具条"是否隐藏
    if (self.navigationController.toolbarHidden) {
        // UIToolBar工具条是否隐藏
    }
    
    // 8.案例：渐变的导航条
//    // 方法一：无效
//    // “导航条/导航条上的控件”设置alpha没有效果（只能设置颜色的透明度：还利用颜色生成图片）
//    navigationController.navigationBar.alpha = 0;
//    UILabel *label = [[UILabel alloc]init];
//    label.textColor = [UIColor colorWithWhite:1 alpha:0.5];
    // 方法二：有效（！！！利用颜色生成图片！！！）
    // 设置导航条背景（必须使用默认模式UIBarMetricsDefault）
    // 当背景图片设置为nil的时候系统会自动生成一张半透明的图片为导航条背景
    [navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"image_demo"] forBarMetrics:UIBarMetricsDefault];
//    // 系统会自动生成一张半透明的图片为导航条背景
//    [navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
//    // 系统会透明
//    [navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
/*
 导航控制器管理原则：
 // push
 1>.当调用导航控制器的push方法时，就会把一个控制器压入到导航控制器的栈中（在栈的最顶部）
 2>.将原来导航控制器View当中存放的子控制器View的内容移除（并没有把控制器从栈中移除：上一个控制器还在栈中）
 3>.将导航控制器栈顶控制器的View添加到导航控制器专门存放子控制器View当中
 // pop
 4>.当调用导航控制器的pop方法时，就会把导航控制器存放子控制器View当中控制器的View移除，并把该控制器从栈中移除
 5>.该控制器就会被销毁，接着它就会把上一个控制器的View添加到导航控制器专门存放子控制器的View中
 */
-(void)onAdd {
    /// 导航栏的跳转
    // self.navigationController是否有值取决于"当前controller"是否加入导航控制器
    // UINavigationController以栈的形式保存子控制器
    // 1.跳转到下一页
    WMSkillViewController *controller = [[WMSkillViewController alloc]init];
    [self.navigationController pushViewController:controller animated:true];
    // 2.返回上一页
    [self.navigationController popToViewController:controller animated:true];
    // 3.返回到任意页面
    // 这个页面必须是导航控制器的子控制器
    int index = 5;
    if (index < self.navigationController.viewControllers.count) {
        [self.navigationController popToViewController:self.navigationController.viewControllers[index] animated:true];
    }
    // 4.回到根视图控制器
    [self.navigationController popToRootViewControllerAnimated:true];
}
-(void)onImage {
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 将要显示控制器
    // 隐藏系统UINavigationBar
}
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 已经显示控制器
}


#pragma mark - TabBar
-(void)setupTabBar {
    // 1.创建UITabBarController（这里也有一个UIView）
    // 分栏控制器（继承UIViewController/最多显示5个）
    UITabBarController *tabBarController = [[UITabBarController alloc]init];
    tabBarController.view.backgroundColor = UIColor.redColor;
    // 2.添加子控制器（默认显示的是第一个子控件的View/默认加入的控制器都不会被释放）
    [tabBarController addChildViewController:self];
//    tabBarController.viewControllers = @[self];
    // 3.设置属性
    tabBarController.selectedIndex = 0;  // 选中的index
    // UITabBar：只有一个
//    UITarBar *bar = tabBarController.tabBar;  // 获取UITarBar
    tabBarController.tabBar.barStyle = UIBarStyleDefault; // UITabBar的样式
    tabBarController.tabBar.tintColor = UIColor.redColor; // 图标选中颜色
    tabBarController.tabBar.barTintColor = UIColor.yellowColor; // 分栏颜色
    tabBarController.tabBar.translucent = true;  // true透明/false不透明
    tabBarController.delegate = self;
    // UITabBarItem
    // 决定着每个UITabBarButton内容
    // ！！！每个"子控制器"都有一个tabBarItem/UITabBarItem决定着显示内容/子控制器的属性！！！
    // 添加完成"子控制器"就需要设置下面属性
    self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:[UIImage imageNamed:@""] selectedImage:[UIImage imageNamed:@""]];
    self.tabBarItem.title = @"";  // 标题文字/如果需要修改字体颜色使用“富文本”/参考"eyee"/iOS13.x以后设置方法有所改变UITabBarAppearance|直接使用带文字的图片
    self.tabBarItem.image = [UIImage imageNamed:@""]; // 图标
    self.tabBarItem.selectedImage = [UIImage imageNamed:@""]; // 选中的图标
    self.tabBarItem.badgeValue = @"5";  // 提醒数字
    
    // 6.iOS15+的分栏默认透明（需要手动设置）
    // https://www.jianshu.com/p/9b519673dcbd
    // https://baijiahao.baidu.com/s?id=1711749740139600655&wfr=spider&for=pc
    if (@available(iOS 15.0, *)) {
        UITabBarAppearance *tabBarAppearance = [[UITabBarAppearance alloc]init];
        tabBarAppearance.backgroundColor = UIColor.whiteColor;
        self.tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance;
    } else {
        // Fallback on earlier versions
    }
}
#pragma mark - UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    // 是否可以选择这个控制器
    // YES可以/NO不可以
    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    // 选中某一个控制器
}
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    // 将要开始编辑
}
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers changed:(BOOL)changed {
    // 结束编辑
}


#pragma mark - 屏幕适配：针对不同大小的屏幕尺寸进行适配
// 1.停靠模式Autoresize：仅仅能解决子控件和父控件之间的相对关系问题
// 1>.概念：控制父视图改变大小时，子视图的变化方式；服务于父视图边界修改后，子视图的重新布局
// 2>.作用：主要处理父子视图、等比例缩放、横竖屏旋转
// UIViewAutoresizingNone //NO
// UIViewAutoresizingFlexibleLeftMargin //右边界和父视图的距离不变，左边界自由（伸缩）
// UIViewAutoresizingFlexibleWidth //自由的宽度：左右边距与父视图保持不变
// UIViewAutoresizingFlexibleRightMargin //左边界和父视图的距离不变，右边界自由（伸缩）
// UIViewAutoresizingFlexibleTopMargin //下边界和父视图的距离不变，上边界自由（伸缩）
// UIViewAutoresizingFlexibleHeight //自由的高度，上下边距保持不变
// UIViewAutoresizingFlexibleBottomMargin //上边界和父视图的距离不变，下边界自由（伸缩）
// 3>.在xib中怎么使用autoresizingMask：外部4根线固定边距、内部2根线固定宽高和父视图的比例
-(void)setupAutoresize {
    // 创建父视图
    UIView *superView = [[UIView alloc] init];
    superView.frame = CGRectMake(100, 100, 100, 50);
    [self.view addSubview:superView];
    // 创建子视图
    UIView *subView = [[UIView alloc] init];
    subView.frame = CGRectMake(0, 0, 50, 25);
    [superView addSubview:subView];
    // 设置停靠模式
    subView.autoresizesSubviews = YES; // 自动适应父视图大小
    subView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth;
}
// 2.AutoLayout：可以解决任何控件之间的相对关系问题
// https://www.jianshu.com/p/4ef0277e9c5e
-(void)setupAutoLayout {
    // 1>.概念：一种“自动布局”技术，专门用来布局UI界面，iOS6.x开始引入
    // 2>.作用：可以很轻松的解决屏幕适配问题（苹果官方大力推荐）
    // 3>.核心概念：约束（通过给控件添加约束来决定控件的位置和尺寸）、参照（依据谁来添加约束）
    // 4>.自动布局的核心计算公式：obj1.property1 = (obj2.property2 * multiplier) + constant value
    /*
     5>.常见错误：
     a、警告：控件的frame不匹配添加的约束（比如约束控件width为100，而控件现在宽度为110）
     b、错误：缺少必要的约束（比如只约束width和height，没有约束具体位置）
     c、冲突：两个约束冲突（比如一个约束width为100，一个约束width为110）
     */
}
// 3.第三方库Masonry/SnapKit
// https://www.jianshu.com/p/ea74b230c70d
-(void)setupMasory {
    // 设置布局 - makeConstraints
    
    // 重新布局（移除以前的布局）- remakeConstraints
    
    // 更新布局 - updateConstraints
    
    // 设置约束的优先级
    // 只要保证View已经add的情况下，我们不用按顺序布局（可以直接先布局底下的样式，再布局上部的样式）
    
    // 约束冲突
    // https://blog.csdn.net/Haikuotiankong11111/article/details/51800761
}
// 4.XIB
// 1>.概念：可视化文件，可以通过拖拽进行界面布局，实质是一个xml文件
// 2>.特征：只可以显示一个视图，在创建视图的时候可以同时创建（无需关联）
-(void)setupXib {
//    // 3>.通过xib新建UIViewController
//    WMSkillViewController *controller = [[WMSkillViewController alloc]initWithNibName:@"WMSkillViewController" bundle:nil];
    
    // 4>.获取xib
    // 第一种方式：创建一个xib
    // 拿到的可能多个
    // 默认选中第一个
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"xib名称" owner:nil options:nil];
    UIView *customView = nibs.firstObject;
    NSLog(@"%@", customView);
    // 第二种方式：创建一个xib
    UINib *nib = [UINib nibWithNibName:@"xib名称" bundle:nil];
    UIView *view = [nib instantiateWithOwner:nil options:nil].firstObject;
    NSLog(@"%@", view);
    
    // 5>.注意事项
    // 1、xib不支持[[xxx alloc]init]创建（就算已经关联View）
    // 2、xib创建的UIView不进入"-(instancetype)init{}方法"
    // 3、xib创建的UIView进入"-(instancetype)initWithCoder:(NSCoder *)aDecoder{}方法"/"-(void)awakeFromNib方法"
    // 4、用代码给"xib创建的子控件"添加子控件需要先唤醒
    
    // 6>.xib和nib有什么区别？
    // 1.xib是一个XML格式的纯文本文件
    // 2.nib是一个二进制文件
    // 3.无论是xib文件还是nib文件编译以后都变成可执行的nib文件
    
    // 7>.Segue
    // xxx需要在xib中设置
    /*
     底层实现：
     1、到storyboard中查找有没有给定标识的segue
     2、根据指定的标识创建一个UIStoryboard对象之后把当前的控制器设置为源控制器
     3、再去创建它的目标控制器
     4、调用当前控制器的该方法告诉用户已经准备完毕
     */
    [self performSegueWithIdentifier:@"xxx" sender:self];
    /*
     1.command + D可以在xib中复制控件
     2.！！！删除xib需要同时删除“代码部分”和“xib连线”两处！！！
     */
    
    // 8>.xib拖线的三种方式（多个按钮可以关联一个方法|一个按钮可以关联多个方法）
    // 1、按住代码拖线到xib
    // 2、按住xib拖线到代码
    // 3、点击事件拖线到代码
}
// 9>.准备跳转前调用
// 这样就可以实现跳转
// 一般不使用xib做跳转
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    NSLog(@"%@=====%@", segue.destinationViewController, segue.sourceViewController);
//    WMSkillViewController *controller = (WMSkillViewController *)segue.destinationViewController;
//    // 可以传递数据
//    controller.title = @"123";
}

@end
