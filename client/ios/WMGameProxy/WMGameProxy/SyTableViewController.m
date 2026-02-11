//
//  SyTableViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/7/9.
//  Copyright © 2019 zali. All rights reserved.
//

#import "SyTableViewController.h"

@interface SyTableViewController () <
UITableViewDelegate,
UITableViewDataSource
>

@end

@implementation SyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
}

// 表格视图
// 数据源NSArray可以使用lazy
-(void)setupTableView {
    /// 两种类型
    // UITableViewStylePlain普通样式（顶部有滞留效果）/tableView.tableHeaderView = [[UIView alloc]init];
    // UITableViewStyleGrouped分组样式（数据少的时候下面不会有分割线）
    UITableView *tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    // 真实高度
    // 也可以通过delegate设置：以delegate设置为主
    // 设置行高：如果不设置使用默认值
    // 默认行高44
    tableView.rowHeight = 40;
    // 设置区头高度
    // 可以设置0.001让区头隐藏
    tableView.sectionHeaderHeight = 25;
    // 设置区尾高度
    tableView.sectionFooterHeight = 25;
    // 预估高度
    // self-sizing/iOS8.x以后
    // 告诉UITableView所有cell的真实高度是根据“约束”自动计算的
    tableView.rowHeight = UITableViewAutomaticDimension;
    // 预估行高
    // 作用：提高性能，设置预估行高会减少“- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;”方法的调用次数
    /*
     计算调用“- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;”方法的次数count
     int count = MAX(屏幕长度 / tableView.estimatedRowHeight, 所有的cell)
     */
    tableView.estimatedRowHeight = 40;
    // 预估区头高度
    tableView.estimatedSectionHeaderHeight = 0;
    // 预估区尾高度
    tableView.estimatedSectionFooterHeight = 0;
    // 设置背景视图
    UIView *bgView = [[UIView alloc]initWithFrame:self.view.bounds];
    bgView.backgroundColor = UIColor.whiteColor;
    tableView.backgroundView = bgView;
    // 设置表头/表尾
    // 如果需要动态修改表头高度：可以再次设置表头
    // 尝试用表尾做"加载更多loading"？？？
    // ！！！宽度默认为[[UIScreen mainScreen] bounds].size.width，无论设置为多少！！！
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 100)];
    tableView.tableHeaderView = view;
    tableView.tableFooterView = view;
    // 设置分割线
    // 分割线可以用UIView代替
    // 颜色
    tableView.separatorColor = UIColor.redColor;
    // 样式
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    // 位置
    tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    // 滚动条
    // 样式
    tableView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    // 是否展示滚动条
    tableView.showsVerticalScrollIndicator = false;
    // 设置delegate
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 10;
    // 设置索引字体颜色
    tableView.sectionIndexColor = UIColor.redColor;
    // 设置索引背景颜色
    tableView.sectionIndexBackgroundColor = UIColor.grayColor;
    // 强制更新
    // 根据“约束”立即自动计算控件的宽度和高度
    [tableView layoutIfNeeded];
//    /// 两种模式
//    // 普通模式
//    tableView.editing = false;
//    // 编辑模式
//    tableView.editing = true;
    [self.view addSubview:tableView];
    // 通过ID标识注册对应的cell类型
    // 只需要注册一次
    [tableView registerClass:[UITableView class] forCellReuseIdentifier:@"cell"];
    [tableView registerNib:[UINib nibWithNibName:@"xib名称" bundle:nil] forCellReuseIdentifier:@"cell"];
    // 刷新
    // 1.全局刷新
    // 1).刚进入页面会默认调一次UITableViewDelegate, UITableViewDataSource
    // 2).调用该方法会调用该一次UITableViewDelegate, UITableViewDataSource
    // 3).新cell进入屏幕会调用一次UITableViewDelegate, UITableViewDataSource
    // 刷新所有屏幕上可见的cell
    [tableView reloadData];
    // 2.局部刷新（动画刷新）
    // 修改数据
    // 必须保证数据源的count保持不变（不包括“添加数据”/“删除数据”，因为“添加数据”/“删除数据”会改变数据源的count）
    [tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0], [NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationFade];
    // 添加数据
    [tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    // 删除数据
    [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    // 批量删除
    // 1.告诉UITableView在编辑模式下可以多选
    tableView.allowsMultipleSelectionDuringEditing = YES;
    // 局部刷新
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    // 2.点击按钮进入编辑模式
    // 3.获取到选中的cell/不可以一边遍历一边删除（遍历数组的时候一定要保证数组count不变）
    for (NSIndexPath *indexPath in tableView.indexPathsForSelectedRows) {
//        // 需要拿到“所有需要删除的row”保存起来统一删除
//        NSMutableArray *array = [NSMutableArray array];
//        [array removeObjectsInArray:@[]];
    }
    // 4.统一UI设置（也可以分开设置https://www.jianshu.com/p/f28a4379c126）
    if (@available(iOS 15.0, *)) {
        UITableView.appearance.sectionHeaderTopPadding = 0;
    }
}


/*
 执行流程：
 numberOfSectionsInTableView -> heightForHeaderInSection -> heightForFooterInSection ->
 numberOfRowsInSection -> heightForRowAtIndexPath -> cellForRowAtIndexPath -> willDisplayCell
 */
#pragma mark - UITableViewDelegate, UITableViewDataSource
// UITableViewDataSource
// 调用顺序
// 1.UITableView有多少组
// 默认就是1组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark - 必须实现的方法
// 自动调用下列方法
// 2.组中有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
//    // 仿QQ折叠：https://javaforall.cn/107830.html
//    // 默认一个折叠部分表示section
//    // 返回0表示折叠
//    return 0;
}
// 3.赋值
// 只要一个cell出现在视野范围内就会调用一次该方法
// 缓存池中cell的值还是老的（去缓存池中拿到cell必须要改数据）
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 第一种方式：无需注册
    // 静态局部变量
    // 不改变作用域/改变生命周期
    // 全局一直存在
    // 1.定义重用标识
    static NSString *ID = @"cell"; // 为什么需要加static
    // UITableViewCell默认提供四种样式
    // 详情见UITableViewCell样式.png
    // cell最好自定义
    // 2.去缓存池中取到可循环利用的cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    // 3.如果缓存池没有可以循环利用的cell需要自己创建
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    // 4.设置数据
    // cell的属性
    // 控件属性
    cell.textLabel.text = @"好男人";
    cell.detailTextLabel.text = @"绿帽子";
    // 设置cell的背景backgroundColor
    cell.backgroundColor = UIColor.lightGrayColor;
    // 设置cell的背景UIView（优先级高于cell.backgroundColor）
    cell.backgroundView = [[UIView alloc] init];
    // 设置cell的选中背景UIView/可以设置颜色
    cell.selectedBackgroundView = [[UIView alloc] init];
    cell.imageView.image = [UIImage imageNamed:@"image_demo"];
    NSLog(@"%@", cell.contentView.subviews);
    // 真正属性
    // 这些都可以自定义完成
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // 样式
    cell.accessoryView = [[UISwitch alloc] init]; // 控件（优先显示）
    cell.selectionStyle = UITableViewCellSelectionStyleNone; // 选中样式
    /*
     ！！！为防止“复用”导致cell的数据发生混乱：有if的地方必须有else衔接！！！
     保证cell每次进入屏幕都会得到改变
     */
//    /// 第二种方式：（常用）
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    return cell;
}
// 不强制实现的方法
// 4.很少使用
// 一般通过自定义控件实现
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    /// 设置区头title
//    return @"好男人";
//}
//
//- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
//    “- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section”的优先级更高
//    /// 设置区尾title
//    return @"好男人";
//}


// UITableViewDelegate
// 1.选中的事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 某一行被选中
    // 通过NSIndexPath可以拿到UITableViewCell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 通过UITableViewCell可以拿到NSIndexPath
    NSIndexPath *index = [tableView indexPathForCell:cell];
    if (index.row == indexPath.row) {
//        // 手动设置文字的最大宽度（cell没有出现则需要手动设置）
//        cell.textLabel.preferredMaxLayoutWidth = 100;
//        // 强制刷新（就算cell还没有显示都可以根据约束自动计算宽高）
//        [cell layoutIfNeeded];
    }
}
// 2.取消选中某一行
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 某一行取消选中
    // 先选中第0行 -> 再选中第1行（取消选中第0行）
}
// 3.返回某一行头部UIView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // 设置区头
    // 默认设置44
    return 44;
}
// 4.返回某一行尾部UIView
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}
// 为了防止UITableView底部空白处出现默认的线条，需要将此处设置为0.01
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // 设置区尾（默认44）
    return 44;
}
// 5.返回某一行行高
// 一种思路：cell的size可以放在model中统一管理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置行高（默认44）
//    // ！！！会发生“死循环”！！！
//    [tableView cellForRowAtIndexPath:indexPath];
    // cell自适应
    // 1.使用预估高度（然后保存）
    // 2.获取数据源然后计算高度
    return 44;
}


/*
 默认状态tableView.editing = false;
 左滑以后tableView.editing = true;
 */
// 1.左滑删除/单个UITableViewRowAction
// 修改系统默认的UITableViewRowAction
// 监听“Delete按钮”的点击
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    // 点击删除或插入调用该方法
    // 一般用来更新数据源
    switch (editingStyle) {
        case UITableViewCellEditingStyleNone:
            // 未知
            break;
        case UITableViewCellEditingStyleDelete:
            // 删除
            break;
        case UITableViewCellEditingStyleInsert:
            // 插入
            break;
    }
}
// 修改“Delete按钮”的默认文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
// 返回编辑类型
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleInsert;
    }
}

// 2.左滑删除/多个UITableViewRowAction
// 点击按钮不会调用“- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath”
// 自定义UITableViewRowAction则上述方法不再起作用
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"关注" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击关注");
        // 第一种方式：直接刷新（动画太快）
        [tableView reloadData];
        // 第一种方式：退出编辑模式
        // 在此处需要将"tableView.editing = false;"
    }];
    action1.backgroundColor = UIColor.redColor;
    UITableViewRowAction *action2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"点击删除");
    }];
    action2.backgroundColor = UIColor.grayColor;
    // 从“右边 -> 左边"排序
    return @[action1, action2];
}

// 3.编辑模式
// 将“tableView.editing = true;”左边会出现一排“红色按钮”
// 可以加上动画[tableView setEditing:!tableView.editing animated:YES];

// 4.自定义“批量删除”（上面Line120）
// “批量删除”和“左滑删除”可以同时存在

// 5.设置右边索引
/*
 可以通过属性设置索引“字体颜色”/“背景颜色”
 // 设置索引字体颜色
 tableView.sectionIndexColor = UIColor.redColor;
 // 设置索引背景颜色
 tableView.sectionIndexBackgroundColor = UIColor.grayColor;
 */
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    // 按照index匹配（不是按照字符串匹配）
    // 需要手动匹配
    return @[@"A", @"B", @"C"];
}

// 6.行的移动
// 支持行的移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 行的移动完成
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
}

//怎么实现瀑布流？
//使用多个UITableView联动（调用UIScrollView的代理方法让“多个UITableView的偏移量”等于“UIScrollView的偏移量”实现联动）

@end
