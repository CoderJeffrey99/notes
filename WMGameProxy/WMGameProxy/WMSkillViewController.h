//
//  WMSkillViewController.h
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/8/5.
//  Copyright © 2019 zali. All rights reserved.
//

#import <UIKit/UIKit.h>
// 由于import是一个预编译指令，他会将""中的文件内容copy到import所在的位置
// 只要""中的文件内容发生变化，那么import就会重新copy一次（更新操作）
#import "WMStudyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

// @class
// 作用：可以简单的引用一个类（仅仅告诉编译器：WMSkillViewController是一个类，并不会包含这个类的所有内容，也不会做任何copy操作）
// 使用：在.h文件中使用“@ class”引用一个类；在.m文件中使用#import包含这个类的.h文件（可以避免循环copy）
// 注意：由于“@ class”仅仅是告诉编译器后面的名称使用一个类，所以编译器并不知道这个类中有哪些属性和方法，如果在.m中使用这个类需要#import导入这个类才可以使用
/*
 总结：
 1、如果都在.h文件中import，假如A拷贝了B，B拷贝了C，如果C被修改了，那么B和A都需要重新拷贝，因为C修改了那么B就会重新拷贝，而B重新拷贝之后相当于B也被修改了，那么A
 也需要重写拷贝，也就是说如果都在.h中拷贝，只要有间接关系的文件都会重新拷贝
 2、如果在.h文件中使用“@ class”，在.m文件中用import，那么如果一个文件发生了变化，只有和这个文件有直接关系的那个文件才会重新拷贝
 3、所以在.h中用“@ class”可以提升编译效率
 */
/*
 总结：
 如果两个类相互copy（A拷贝B，B拷贝A）就会报错
 如何解决：在.h中使用“@ class”，在.m中使用#import
 因为如果.h文件中都使用#import就会形成死循环
 如果在.h文件使用“@ class”那么就不会做任何copy操作，而在.m中#import只会copy对象文件，并不会形成死循环
 */
@class WMSkillViewController; // 有分号;

// 定义协议protocol
// 1>.概述：协议本身不是类（类似java中的接口）、可以给类增加方法（外部可以用类的对象调用该协议方法）、可以实现多继承（相同类型可以使用“继承”，不同类型可以使用“协议”）和对象间通信
// 2>.注意点：只声明方法（不实现方法/也不能声明属性）、遵从协议的所有类（拥有协议中所有的方法声明）必须导入协议头文件、父类遵循某个协议子类也自动遵循该协议、一个类可以遵循一个或者多个协议
// ！！！"协议protocol"可以直接使用“模版”创建（类似"类别Category"）！！！
// 3>.协议的作用
// 1.类型限定 - Student<WMStudyProtocol> *s = [[Student alloc]init];（注意格式）
// 1>.遵循某个协议的不同对象可以放在同一个数组中
// 2>.遵循某个协议但不实现该协议中的方法的对象调用协议中的方法会报错（需要做判断）
//if (self.wife respondsToSelector:@selector(study:)) {
//    [self.wife study:one];
//}
// 4>.声明协议
// NSObject类遵循了NSObject协议
@protocol WMSkillViewControllerProtocol <NSObject, WMStudyProtocol> // 协议也可以再遵循协议
// 必须实现协议（缺省）
// Objective-C不实现会报警告⚠️
// swift中不实现会直接报错
// 遵循该协议的类必须实现该方法（不实现会报警告/默认）
@required
-(void)jumpPage:(NSString *)text;
// 遵循该协议的类可选实现该方法（不实现不会报警告）
@optional
-(void)finishTask:(WMSkillViewController *)controller;

@end

@interface WMSkillViewController : UIViewController
// 委托方：持有协议，该类就是委托方
// 代理方：遵从协议，实现方法
// 持有协议的id指针：如果有*在<>外面
// 使用weak防止内存泄漏？？？说明原因？？？
// 为什么使用id？？？（任何遵循WMSkillViewControllerProtocol的类都可以做为我的代理）
@property (weak, nonatomic) id <WMSkillViewControllerProtocol> delegate;

// 定义block：怎么“声明block”就怎么“定义block”/以后使用直接使用“myBlock”
// block和delegate的区别 - block紧凑一些
@property (strong, nonatomic) void (^myBlock)(BOOL isBlue);
// 企业级开发一般不修改原有方法
// 一般会新写一个方法扩充
-(void)shouGIF;

@end

NS_ASSUME_NONNULL_END
