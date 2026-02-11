//
//  WMController.swift
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

import UIKit
// 可以在此处遵循协议
//class WMController: UIViewController, UITableViewDataSource, UITableViewDelegate {
//
//}
class WMController: UIViewController {
    // 1.swift修饰符
    /*
     低级别权限修饰的类中不可以含有高级别的变量（比如private修饰的class中不能含有public的成员变量）
     高级别权限修饰的类中可以含有低级别的变量（比如public修饰的class中可以含有private的成员变量）
     */
    //
    // 最高权限：一般sdk提供外部使用、可重写
    open var p1: String?
    // 比open小一点、不可重写（Swift3.0中新添加的权限）
    public var p2: String?
    // 当前包内可以使用（默认）
    internal var p3: String?
    // 当前文件内可以使用（Swift3.0中新添加的权限）
    fileprivate var p4: String?
    // 当前作用域内可以使用
    private var p5: String?
    
    // 2.懒加载
    // 1>.swift中也有懒加载只能放在结构体或类中
    // 2>.swift直接用lazy关键字定义某一个属性懒加载
    // 3>.格式
//    // 第一种方式
//    lazy var tableView: UITableView = UITableView()
    // 第二种方式
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    // 3.UITableView
    override func viewDidLoad() {
        super.viewDidLoad()
        // 4.swift中注释
        // "// MARK:- xxx"类似“#pragma mark -xxx”（可以分类）
        // “/// xxx”类似"/** xxx */"（书写会有提示）
        self.setupUI()
    }
}

// 5.类似“Category”
// 只能扩充方法/不能扩充属性
// MARK:- 设置界面相关
extension WMController {
    func setupUI() {
        view.addSubview(tableView)
    }
}

// MARK: - 设置代理
extension WMController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 20
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cellID = "cellID"
            // 1.创建cell
    //        // 1>.该方法返回UITableViewCell/必须先注册/推荐使用这个
    //        var cell = tableView.dequeueReusableCell(withIdentifier:"", for:indexPath)
            // 2>.该方法返回UITableViewCell?/无需注册
            var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
            if cell == nil {
                // 在swift中怎么使用枚举
                // 1>.枚举类型.具体类型
                // 2>.直接就是”.具体类型“
                // 如果需要使用‘|’连接枚举需要先把枚举转换成type.rawValue
                cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
            }
            // 2.给cell赋值
            cell?.textLabel?.text = "测试数据\(indexPath.row)"
            // 返回cell
            return cell!
        }
}

// MARK: - 设置代理
extension WMController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("点击了\(indexPath.row)")
    }
}

// 6.枚举
extension WMController {
    /*
     1).命名规范
     1>.在swift中enum名称大写、元素小写
     2>.在oc中enum名称大写、元素大写
     */
    // oc中的枚举本质就是int，有原始值，默认从0开始
    // swift中的枚举默认没有原始值，可以在定义的时候指定类型
    // a.如果指定为Int则默认递增
    enum CalendarTimeType: Int {
        case none = 1
        case new
        case old
    }
    // 如果指定为其它类型则需要全部赋值（无法递增）
    enum MethodType: String {
        case add = "加法"
        case sub = "减法"
    }
    func type() {
        // 可以使用枚举类型变量或常量接收枚举值
        let m1: CalendarTimeType = .new
        let m2 = CalendarTimeType.new
        // 数字 -> 枚举
        let _: CalendarTimeType? = CalendarTimeType.init(rawValue: 1)
        // 枚举 -> 数字
        print("\(CalendarTimeType.new.rawValue)")
        // 输出可选类型（区分大小写）
        print("\(MethodType.add.rawValue)")
    }
    // enum枚举配合switch一起使用如果case中包含所有的枚举值则不需要加default
}

// 7.Swift和Objective-C混合编程
/*
 //Objective-C工程调用Swift代码
 https://blog.csdn.net/u010407865/article/details/62886943
 https://www.jianshu.com/p/9f757a09eacd
 //Swift工程调用Objective-C代码
 https://blog.csdn.net/pjk1129/article/details/39644477
 */

// 8.常见第三方库
/*
 // 自动布局
 https://github.com/SnapKit/Snapkit
 // 字典转模型
 https://github.com/dacaizhao/MJExtensionSwift
 // 常见第三方库
 https://www.jianshu.com/p/f4282df18537
 https://www.jianshu.com/p/c74f6abc2eb7
 https://www.jianshu.com/p/68e12b966d86
 */
/*
 AFNetworking
 MJRefresh
 SDWebImage
 Alamofire
 HandyJSON
 SwiftyJSON
 */
