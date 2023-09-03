//
//  WMGameView.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/1/13.
//  Copyright © 2020 zali. All rights reserved.
//

#import "WMGameView.h"

@interface WMGameView() <
CAAnimationDelegate,
NSCopying,
NSMutableCopying>

@end

static WMGameView *_instance = nil;

@implementation WMGameView

// 1.通过该方法init控件
// 然后直接frame在该方法中拿不到尺寸
- (instancetype)init {
    self = [super init];
    if (self) {
//        [self layoutSubviews];
        // 在这里init
    }
    return self;
}

// 2.通过该方法init控件
// 可以直接拿到frame
// 调用[[xxx alloc]init]/[[xxx alloc]initWithFrame:xxx]都会调用该方法
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 这里添加控件
    }
    return self;
}

// 当解析一个文件的时候会调用
// 如果子控件从xib中创建则处于未唤醒状态
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        // 先调用
        // 这里还没有创建子控件（可以在这里用代码创建子控件添加到xib）
        // 不要在这里操作“xib中创建的子控件的子控件”（处于未唤醒状态）
    }
    return self;
}

// 从xib中唤醒
// 当xib加载完毕的时候调用
// 添加xib中的子控件
- (void)awakeFromNib {
    [super awakeFromNib];
    // 后调用
    // 必须在这里操作“xib中创建的子控件的子控件”
}
// initWithNibName - 当一个控制器或某个控件在xib中创建，在Xcode中需要调用这个方法来实例化该控制器或控件

// 通过"方法1"只能在该方法中拿到frame
// 必须到这里布局子控件
- (void)layoutSubviews {
    // 0.一定要调用super
    [super layoutSubviews];
    // ！！！在这里布局！！！
}


#pragma mark - 事件传递
// ！！！处理手势事件部分 - start - 与上面部分内容无关！！！
/*
 1.事件传递
 第一步：
 1>.发生触摸事件以后，系统会将该事件加入到一个由UIApplication管理的事件队列中（首先接收事件的是UIApplication）
 2>.UIApplication会从事件队列中取出最前面的事件分发一下以便处理，通常先发送事件到App主窗口(keyWindow)
 3>.主窗口会在视图层次结构中找到一个“最合适的视图”来处理触摸事件（怎么找到“最合适的视图”重点讲讲）
    // 如何找到最合适的控件来处理事件？（有没有比自身控件更合适的控件）
    1.自己是否能够接收触摸事件
    2.触摸点是否在自己身上
    3.从后往前遍历子控件：重复步骤1/2
    4.如果没有符合条件1/2的子控件就自己最适合处理
 第二步：
 1>.找到合适的视图控件以后就会调用视图控件的touches方法来做具体的事件处理
 2>.触摸事件的传递是从父控件传递到子控件的（最后传递到自身控件）：UIApplication -> UIWindow -> 父控件 -> 子控件（触摸事件发生在该控件）
 */
// 2.事件传递的注意点
// 1>.事件传递：UIApplication -> UIWindow -> 父控件 -> 子控件
// 2>.如果“父控件”不能响应事件：事件中断（子控件不可能接收事件）
// 3>.如果“子控件”不能响应事件：事件传递到“父控件”终止（“父控件”响应事件）
/*
 3>.事件响应
 1>.若View的Viewcontroller存在，则将该事件传递给它的Viewcontroller响应，如若不存在，则传递给它的父视图
 2>.若View的最顶层都不能处理事件，则传递给UIWindow进行处理
 3>.若UIWindow不能处理事件，则传递给UIApplication进行处理
 4>.若UIApplication不能处理事件，则将该事件丢弃
 */
/*
 4.控件不能接收事件的四种可能性
 1>.userInteractionEnabled = NO
 2>.hidden = YES
 3>.alpha = 0.0 ~ 0.01
 4>.父控件不能接收事件：子视图无法监听事件、子视图超出父视图的部分无法监听事件
 */
// 5.怎么找到最适合的控件？？？
// 利用该方法寻找到最适合的view
// 什么时候调用：当一个事件传递给当前View
// 返回“哪个view”，“哪个view”就是最适合的view
// ！！！点击“父视图”：如果“父视图”可以响应事件就会调用“所有子视图”的该方法！！！
// 调用该方法如果没有找到“最适合的view”，“最适合的view”就是“父视图返回的该方法view”
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {  // 每产生一个事件就会产生一个UIEvent对象
    // 6.保持系统默认方法
    /*
     该方法“系统默认方法”所做的操作就是这个
     问题：如何找到最合适的控件来处理事件？（有没有比自身控件更合适的控件）
     1.自己是否能够接收触摸事件；
     2.触摸点是否在自己身上；(这一步也可以重写/- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event;)
     3.从后往前遍历子控件：重复步骤1/2；
     4.如果没有符合条件1/2的子控件就自己最适合处理；
    */
    return [super hitTest:point withEvent:event];
    
//    /// 7.自定义方法
//    /*
//     1.直接返回“某个控件”：可以重写该方法让“某个控件”一直响应事件
//     2.不会再向上接着寻找
//     */
//    /*
//     ！！！如果重写该方法就不需要再执行下列操作（系统默认方法）！！！
//     // 下列操作（系统默认方法）会被拦截
//     “
//     如何找到最合适的控件来处理事件？（有没有比自身控件更合适的控件）
//     1.自己是否能够接收触摸事件；
//     2.触摸点是否在自己身上；
//     3.从后往前遍历子控件：重复步骤1/2；
//     4.如果没有符合条件1/2的子控件就自己最适合处理；
//     ”
//     */
//    return self.subviews.firstObject;
    
//    /// 8.！！！底层实现！！！
//    // 1>.判断自身能否接收事件
//    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
//        return nil;
//    }
//    // 2>.判断当前点在不在当前view
    // 此处“point”需要保证与“self”在同一个坐标系
//    if (![self pointInside:point withEvent:event]) {
//        return nil;
//    }
//    // 3>.从后往前遍历自己的子控件，让子控件重复前两部操作
//    for (UIView *subView in self.subviews) {
//        // 把当前控件的点转换成子控件坐标系的点
//       // point点必须跟“它方法的调用者”在“同一个坐标系”中
//        CGPoint subPoint = [self convertPoint:point toView:subView];
//        UIView *fitView = [subView hitTest:subPoint withEvent:event];
//        if (fitView) {
//            return fitView;
//        }
//    }
//    // 4>.如果没有找到比它自身更适合的View，则返回自身
//    return self;
}

// 9.判断“当前点”是否在“当前view”上
// 1>.什么时候调用：在“hitTest方法”中调用/“系统默认方法”第二步
// 2>.point点必须跟“它方法的调用者”/“当前view”在“同一个坐标系”中/当前view为坐标原点
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return NO;
}
/*
 10.常见练习
 1>.实现控件在屏幕上的任意拖拽
 2>.点击上面的子控件的某小块会让底部的子控件响应事件
 3>.点击子控件超过父控部分可以响应事件
 */
// ！！！处理手势事件部分 - end - 与下面部分内容无关！！！


#pragma mark - CLayer(Core Animation Layer)
/*
 1.CALayer和UIView有什么联系和区别？UIWindow呢？
 // CALayer
 CALayer表示图层：CALayer不能响应事件，无法直接渲染到屏幕上
 CALayer是用来绘制内容的，对内容进行动画处理，依赖UIView来进行显示，不能处理用户事件
 // UIView
 UIView表示控件：UIView可以响应用户事件
 UIView本身更像一个CALayer的管理器：一个UIView上可以有n个CALayer
 // UIWindow
 UIWindow表示窗口：一个App中至少有一个UIWindow
 UIWindow的作用：包含App所要显示的所有视图、传递触摸消息给view和其他对象
 */
/*
 2.谈谈你对离屏渲染的理解
 离屏渲染是相对于当前屏幕渲染而言的：当帧缓冲区的数据不能被视频控制器扫描显示的时候会将这些数据放入到离屏缓冲区，在离屏缓冲区渲染完毕以后，等到我们确定当前View怎么显示的时候会被再次添加到帧缓冲区，因为离屏渲染会涉及到开辟离屏缓冲区和切换上下文环境，所以会有一定的性能消耗。Xcode自带检测离屏渲染（设置阴影NSShadow、设置圆角会导致离屏渲染）
 */
-(void)setupCALayer {
    // 1>.概述
    // a、在iOS中我们可以看得见摸得着的东西都是UIView
    // b、UIView之所以可以显示在屏幕上，完全因为内部的一个图层（CALayer对象）
    // c、创建UIView对象的时候会自动创建一个图层（CALayer对象）
    // d、通过 @property(nonatomic,readonly,strong) CALayer *layer; 可以访问这个图层（CALayer对象）
    // e、CALayer不能处理用户事件
    self.layer.borderWidth = 1.0; // 边框宽度
    self.layer.borderColor = UIColor.orangeColor.CGColor; // 边框颜色
    self.layer.cornerRadius = 5;  // 设置圆角半径
    self.layer.masksToBounds = true; // 将位于它之下的layer都挡住（设置这个就会不显示阴影）
    
    /*
     2>.原理
     UIView本身不具备显示的功能，是它内部的图层才有显示的功能：
     1.当UIView需要显示在屏幕上的时候会调用“drawRect方法”进行绘图
     2.将所有的功能绘制在自己的图层上，绘制完毕后，系统会将图层copy到屏幕上，完成UIView的显示
     */
    
    // 3>.CALayer的基本使用
    // 第一种方式
    UIView *view = [[UIView alloc] init];
    // 设置阴影的颜色
    view.layer.shadowColor = UIColor.blueColor.CGColor;
    // 设置阴影不透明度（1 - 不透明/0 - 透明）
    view.layer.shadowOpacity = 1;
    // 设置阴影偏移量
    // 30 - 阴影向右移动30
    // 40 - 阴影向下移动40
    view.layer.shadowOffset = CGSizeMake(30, 40);
    // 设置阴影模糊半径（默认为3）
    view.layer.shadowRadius = 5.0;
    // 边框宽度（向里面走）
    view.layer.borderWidth = 3.0;
    // layer里面的所有Color必须为xxx.CGColor
    view.layer.borderColor = UIColor.greenColor.CGColor;
#pragma mark - 设置圆角必须设置以下两个方法
    // 设置圆角（只能设置layer层上的控件，对于layer层以外的控件部分只能使用下面方法进行裁剪）
    view.layer.cornerRadius = 30.0;
    // 超过"根层（UIView自带的层，此处指layer）"以外的部分都会裁剪掉
    // UIImageView中的UIImage不在layer的sublayers上
    // UIImageView中的UIImage在layer的contents上
    view.layer.masksToBounds = YES;
    // 第二种方式
    CALayer *layer = [[CALayer alloc] init];
//    layer = [CALayer layer];
    layer.backgroundColor = UIColor.redColor.CGColor;
    layer.frame = CGRectMake(50, 50, 100, 100);
    layer.contents = (id)[UIImage imageNamed:@"image_demo"].CGImage;
    [self.layer addSublayer:layer];
    
    // 4>.CALayer的3D效果
    // a、旋转（只有旋转的时候才会有3D效果）
    // 第一种方式：直接赋值
    view.layer.transform = CATransform3DMakeRotation(M_PI, 0, 0, 1);
    // 第二种方法：kvc赋值
    // 结构体转对象
    [view.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 0, 0, 1)] forKeyPath:@"transform"];
    // 第三种方式：kvo简写
    /*
     transform.rotation
     transform.rotation.x
     transform.rotation.y
     transform.rotation.z
     transform.scale
     transform.scale.x
     transform.scale.y
     transform.scale.z
     transform.translation
     transform.translation.x
     transform.translation.y
     transform.translation.z
     */
    [view.layer setValue:@(M_PI) forKeyPath:@"transform.rotation.x"];
    
    // 5>.UIView和CALayer都可以实现相同的效果，平时开发如何选择呢？
    // a、UIView可以直接处理事件，CALayer不能处理事件（没有继承UIResponder）
    // b、CALayer性能可能会更高一些（因为减少了事件处理功能）
    
    // 6>.常用属性
    // 用来设置CALayer在父层中的位置（以父层的左上角为原点）
    view.layer.position = CGPointZero;
    // 定位点/锚点：决定着CALayer身上的哪个点会在position属性所指的位置（重合）
    // 以自己的左上角为原点（取值范围0～1）/默认为(0.5, 0.5)
    view.layer.anchorPoint = CGPointZero;
    
    // 7>.隐式动画
    // a、概述：每个UIView内部都默认关联着一个CALayer，我们称这个Layer为RootLayer（根层）
    // b、特征：只有非RootLayer（手动创建的CALayer对象）才存在着隐式动画
    // c、什么是隐式动画：当对非RootLayer的部分属性进行修改时，默认会自动产生一些动画效果。这些属性称为Animatable Properties（可动画属性）
    /*
     d、常见的可动画属性
     1>.bounds - 用于设置CALayer的宽度和高度，修改改属性会产生缩放动画
     2>.backgroundColor - 用于设置CALayer的背景色，修改该属性会产生背景色的渐变动画
     3>.position - 用于设置CALayer的位置，修改该属性会产生平移动画
     */
    CALayer *layer1 = [CALayer layer];
    // 设置隐式动画的属性
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:2];
    layer1.backgroundColor = UIColor.redColor.CGColor;
    layer1.frame = CGRectMake(50, 50, 100, 100);
    [self.layer addSublayer:layer1];
    [CATransaction commit];
    
    // 8>.核心动画Core Animation
    // a、概念：一组非常强大的动画处理API，使用它能做出非常炫丽的动画效果
    // b、跨平台：MacOS/iOS
    // c、Core Animation的动画执行过程都是在后台操作的，不会阻塞主线程，作用在CALayer上
    /*
     核心动画继承结构
     CAAnimation --> CAMediaTiming
        CAAnimationGroup
        CAPropertyAnimation
            CABasicAnimation
            CAKeyframeAnimation
        CATransition
     */
#pragma mark - 基础动画CABasicAnimation
    // 1>.创建动画对象
    CABasicAnimation *anim = [CABasicAnimation animation];
    // 2>.本质：设置layer的属性
    anim.keyPath = @"position.x";
    anim.toValue = @300;
    // 动画执行次数
    anim.repeatCount = MAXFLOAT;
    // 动画执行时间
    anim.duration = 3.0;
    // 自动翻转（怎么样去怎么回来）
    anim.autoreverses = YES;
    // 动画完成以后不要自动删除动画（默认会自动删除动画）
    anim.removedOnCompletion = NO;
    anim.delegate = self;
    /*
     kCAFillModeForwards
     kCAFillModeBackwards
     kCAFillModeBoth
     kCAFillModeRemoved
     */
    anim.fillMode = kCAFillModeForwards;
    // 3>.添加动画对象
    [view.layer addAnimation:anim forKey:nil];
#pragma mark - 关键帧动画CAKeyframeAnimation
    // 创建动画对象
    CAKeyframeAnimation *anim1 = [CAKeyframeAnimation animation];
    // 第一种方式：设置layer的属性（根据设置的属性出现动画）
    anim1.keyPath = @"transform.rotation";
    anim1.values = @[@-3, @3, @-3];
    // 第二种方式：设置路径，按照路径出现动画
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(50, 50)];
    [path addLineToPoint:CGPointMake(300, 50)];
    anim1.path = path.CGPath;
    anim1.repeatCount = MAXFLOAT;
    // 添加动画对象
    [view.layer addAnimation:anim1 forKey:nil];
#pragma mark - 转场动画CATransition
    // 转场代码（修改数据源的代码）必须和转场动画在一个方法内（与顺序无关）
    CATransition *anim2 = [CATransition animation];
    // 设置转场动画的类型（类型很多）
    anim2.type = @"cube";
    // 设置动画的起始位置
    anim2.startProgress = 0;
    // 设置动画的结束位置
    anim2.endProgress = 0.5;
    [view.layer addAnimation:anim2 forKey:nil];
#pragma mark - 动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    // 会自动执行animations数组当中所有的动画对象
    group.animations = @[anim, anim1, anim2];
    [view.layer addAnimation:group forKey:nil];
#pragma mark - UIView动画和核心动画的区别
    // 1.核心动画只作用在layer上
    // 2.核心动画看到的一切都是假象，它并没有去修改UIView的真实位置
    // 什么时候使用核心动画
    // 1>.当不需要与用户进行交互的时候
    // 2>.当要根据路径做动画的时候
    // 3>.当需要做转场动画的时候（UIView动画也可以做转场动画）
}
// 动画开始时执行
- (void)animationDidStart:(CAAnimation *)anim {
}
// 动画完成时执行
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
}


#pragma mark - Quartz2D部分
// ！！！Quartz2D部分 - start - 与上面部分内容无关！！！
// 1>.什么是Quartz2D?
// 1、概念：Quartz2D是一个基于CoreGraphics框架来实现的二维绘图引擎，同时支持iOS和MacOS
// 2、作用：绘制图形、绘制文字、绘制/生成图片、读取/生成pdf、裁剪图片、自定义UI、涂鸦/画板、手势解锁、折线图/饼状图/柱状图

// 2>.图形上下文（类似画板）：CGContextRef类型
// 1、作用：保存绘图信息和绘图状态、决定绘制的输出目标（绘制到什么地方）
// 2、特点：相同的一套绘图序列，指定不同的"图形上下文Graphics Context"，就可以将相同的图像绘制到不同的目标上
// 3、类型：Bitmap Graphics Context | PDF Graphics Context | Window Graphics Context | Layer Graphics Context

// 3>.自定义UIView
// 1、新建一个类（继承于UIView）
// 2、实现“-(void)drawRect:(CGRect)rect”方法（获取与当前view相关联的图形上下文）
// 3、基本线条绘制

//https://blog.csdn.net/potato512/article/details/56845385
//https://blog.csdn.net/mangosnow/article/details/37054765#0-qzone-1-85099-d020d2d2a4e8d1a374a433f596ad1440

/*
 作用：专门用来绘图（该方法中可以取得与当前view相关联的图形上下文）
 什么时候调用：当view显示的时候调用（viewWillAppear -> drawRect -> viewDidAppear）
 // 注意：如果drawRect方法是手动调用的话则不会创建“与当前view相关联的图形上下文”
 [self setNeedsDisplay]; // 重绘（系统自动帮忙调用drawRect方法：不是立马调用，只有当下一次屏幕刷新的时候才去调用）
 @param rect == 当前view的bounds
 */
- (void)drawRect:(CGRect)rect {
    // 1.基本步骤
    // a>.获取与当前view相关联的图形上下文（系统已经创建完成）
    // b>.绘制路径（一个路径对应多条线）
    // c>.把绘制的内容保存到上下文
    // d>.利用图形上下文将绘制的所有内容渲染到view的layer上

    // 2.基本线条绘制
    // a>.获取与当前view相关联的图形上下文（系统已经创建完成）
    CGContextRef context = UIGraphicsGetCurrentContext(); // Layer Graphics Context/类似于画板
    // b>.绘制路径（一个路径对应多条线）
    UIBezierPath *path = [UIBezierPath bezierPath]; // 类似于🖌
    // 划第一条直线
    [path moveToPoint:CGPointMake(50, 200)]; // 起点
    [path addLineToPoint:CGPointMake(280, 50)]; // 添加一根直线到终点
//    // 添加一根曲线到终点
//    [path addQuadCurveToPoint:CGPointMake(250, 280) controlPoint:CGPointMake(50, 50)];
    // 划第二条线
    [path moveToPoint:CGPointMake(100, 280)]; // 起点（如果不设置这句代码就表示让第一条线的终点作为第一条线的起点）
    [path addLineToPoint:CGPointMake(280, 50)]; // 添加一根直线到终点
    // 设置上下文状态（线的属性）
    CGContextSetLineWidth(context, 10); // 设置线宽
    CGContextSetLineJoin(context, kCGLineJoinRound); // 设置连接处样式
    CGContextSetLineCap(context, kCGLineCapRound); // 设置顶角样式
    [[UIColor redColor] setStroke]; // 设置颜色（必须使用CGContextStrokePath才能生效）
//    [[UIColor redColor] setFill]; // 设置颜色（必须使用CGContextFillPath才能生效）
    // c>.把绘制的内容保存到上下文
    CGContextAddPath(context, path.CGPath); //
    // d>.利用图形上下文将绘制的所有内容渲染到view的layer上
    CGContextStrokePath(context); // 描边stroke
//    CGContextFillPath(context); // 填充fill
    
    // 3.基本形态绘制
    // 1>.画矩形
    UIBezierPath *path_01 = [UIBezierPath bezierPathWithRect:CGRectMake(50, 50, 100, 50)];
//    // 设置圆角
//    UIBezierPath *path_02 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(50, 50, 100, 50) cornerRadius:30];
    [[UIColor redColor] set]; // 设置颜色（无论使用什么都可以生效）
    // c>.把绘制的内容保存到上下文
    CGContextAddPath(context, path_01.CGPath);
    // d>.利用图形上下文将绘制的所有内容渲染到view的layer上
    CGContextStrokePath(context); // 描边stroke
//    CGContextFillPath(context); // 填充fill
    /*
     // 2>.！！！画椭圆（简写：只有2步）！！！
     // a、描述绘制的路径
     UIBezierPath *path_03 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 100, 50)];
     // ！！！必须在此处设置属性！！！
     [[UIColor redColor] set];
     // b、利用UIBezierPath提供的绘图方法进行绘制
     // 封装“获取图形上下文 -> 保存绘制内容 -> 渲染”
     [path_03 stroke];
     [path_03 fill];
     */
    // 3>.画弧（弧度pi == 180度）
    // 第一个参数：圆心
    // 第二个参数：圆的半径
    // 第三个参数：开始角度（传入弧度）(圆心水平方向的最右侧)
    // 第四个参数：截止角度（传入弧度）
    // 第五个参数：YES顺时针绘制/NO逆时针绘制
    UIBezierPath *path_04 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.5 - 10 startAngle:0 endAngle:M_PI_4 clockwise:YES];
    [path_04 stroke];
    // 4>.画扇形
    UIBezierPath *path_05 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5) radius:rect.size.width * 0.5 - 10 startAngle:0 endAngle:M_PI_2 clockwise:YES];
//    // 添加一根线到圆心
//    [path_05 addLineToPoint:CGPointMake(rect.size.width * 0.5, rect.size.height * 0.5)];
//    // 圆心添加一根线到起点
//    [path_05 addLineToPoint:CGPointMake(rect.size.width, rect.size.height * 0.5)];
    // 关闭路径：从路径终点连接一根线到路径起点
    [path_05 closePath];
    // 填充之前会自动关闭路径
    [path_05 fill];
    
    // 4.UIKit绘图
    // 1>.画文字
    NSString *string = @"小码哥";
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor grayColor];
    // 阴影偏移量
    shadow.shadowOffset = CGSizeMake(10, 10);
    // 阴影模糊度
    shadow.shadowBlurRadius = 3;
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                       // 字体大小
                                       NSFontAttributeName, [UIFont systemFontOfSize:40],
                                       // 字体颜色
                                       NSForegroundColorAttributeName, [UIColor redColor],
                                       // 描边颜色
                                       NSStrokeColorAttributeName, [UIColor greenColor],
                                       // 描边宽度
                                       NSStrokeWidthAttributeName, @3,
                                       // 阴影
                                       NSShadowAttributeName, shadow,
                                       nil];
    // 不会自动换行
    [string drawAtPoint:CGPointZero withAttributes:attributes];
    // 会自动换行
    [string drawInRect:rect withAttributes:attributes];
    // 2>.画图片
    UIImage *image = [UIImage imageNamed:@"xxx"];
    // 绘制的是原始图片的大小
    [image drawAtPoint:CGPointZero];
    // 把绘制的图片填充到给定的区域（可能会有拉伸）
    [image drawInRect:rect];
    // 裁剪（超过裁剪区域以外的内容都会被自动裁剪掉）
    UIRectClip(CGRectMake(0, 0, 50, 50));
    // 平铺（会重复铺：类似css中的background-image）
    [image drawAsPatternInRect:rect];
    // 绘制矩形
    UIRectFill(CGRectMake(50, 50, 50, 50));
}
// 5>.练习：自定义进度条

/*
 需求：如何高效的画圆角
 */
-(void)addRoundCorner {
    // 第一种方式（不好）
    // 会产生离屏渲染，特别消耗性能（给性能带来负面影响）
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.clipsToBounds = YES;
    imageView.layer.cornerRadius = 10;
    imageView.layer.masksToBounds = YES;
    // 第二种方式（好）
    // 使用绘图技术 
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 0.0); // NO代表透明
    CGContextRef contextRef = UIGraphicsGetCurrentContext(); // 获取上下文
    CGRect rect = CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height); // 添加一个圆
    CGContextAddEllipseInRect(contextRef, rect);
    CGContextClip(contextRef); // 裁剪
    [imageView drawRect:rect]; // 将图片画上去
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 关闭上下文
    UIGraphicsEndImageContext();
    imageView.image = image;
    // 第三种方式（好）
    // 贝塞尔曲线切割图片
    UIImage *otherImage = [UIImage imageNamed:@"image"];
    UIGraphicsBeginImageContextWithOptions(imageView.bounds.size, NO, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:imageView.bounds cornerRadius:50] addClip];
    [otherImage drawInRect:imageView.bounds];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
}
/*
 利用颜色生成图片
 */
-(UIImage *)imageWithColor:(UIColor *)color {
    // 描述矩形
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    // 开启位图上下文
    UIGraphicsBeginImageContext(rect.size);
    // 获取位图上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 使用color演示填充上下文
    CGContextSetFillColorWithColor(context,[color CGColor]);
    // 渲染上下文
    CGContextFillRect(context,rect);
    // 从上下文中获取图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    // 结束上下文
    UIGraphicsEndImageContext();
    return image;
}
// ！！！Quartz2D部分 - end - 与下面部分内容无关！！！

@end
