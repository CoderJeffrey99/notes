//
//  WMGame.swift
//  WMGameProxy
//
//  Created by 谢吴军 on 2019/6/10.
//  Copyright © 2019 zali. All rights reserved.
//

// 1.2014年Apple发布swift
// https://www.cnswift.org/the-basics

// 2.swift中怎么导入框架
// 一般在swift中不需要导入框架
import UIKit
// 3.swift简介
// 编译语言的高性能 + 脚本语言的交互性
class WMGame: NSObject {
    var name: String = ""

    func log() {
        // 4.定义标识符
        // swift中定义标识符必须告诉编译器是一个常量还是一个变量
        // let - 修饰的对象（内存地址）不可以修改/可以获取对象以后修改内部属性
        // var - 修饰的对象（内存地址）可以修改
        let myName: String = ""  // 常量：必须在定义的时候初始化（oc不需要）
        var myAge: Int = 0       // 变量：先定义一个变量以后再初始化必须在定义的时候告诉编译器变量的类型
        myAge = 10
        let myHeight = 180       // 定义的同时初始化可以不用写数据类型（自动类型推导）
        print("\(myName) is \(myAge) is \(myHeight)")
        
        // 5.swift语句结束
        // 1>.单行语句无需加";"（加上也可以）
        // 2>.多个语句在一行：必须加";"（一般不建议这样写）
        // 输出函数
        print("Hello World")
        
        // 6.常量和变量
        // 1>.swift中必须告诉编译器这是一个常量还是变量
        // 2>.使用过程中建议先定义常量，如果需要修改再修改成变量（更安全）
    //        // ！！！3>.常量是指向的对象不可以进行修改，但是可以改变对象内部属性！！！
    //        let myView: UIView = UIView()
    //        myView = UIView() // 错误
    //        myView.backgroundColor = UIColor.red; // 正确
        // 4>.swift不会自动给变量赋初始值
        // 常量：值不能够被修改的量/优先使用常量
        let myConstant: Int = 12
    //        myConstant = 13 // 错误
        let uMyConstant: UInt = 13
        // 变量：值可以根据需要不断修改
        var myVariable = 42
        // 定义以后可以改变
        myVariable = 12
        print("\(myConstant) + \(myVariable) + \(uMyConstant)")
        
        // 7.类型推导
        // 1>.swift数据类型：整型Int/浮点型Double/对象类型/结构体类型
        let intValue: Int = 10; // 整型
        let intValue1: Double = 10.20; // 表示64位浮点数
        let intValue2: Float = 10.2; // 表示32位浮点数
        print("\(intValue) + \(intValue1) + \(intValue2)")
        let uintValue4: UInt = 10; // 无符号数（默认是有符号数）：无符号数比有符号数的取值范围更大
        // 2>.Int == NSInteger
        // 3>.swift是强类型语言（属性有明确的类型，不存在id类型）
        // 4>.根据后面值的类型推导出前面标识符的类型
        // 5>.option + 左键：查看标识符类型
        // typealias类型别名
        typealias NSInteger = Int
        let value: NSInteger = 45
        print(value)
        
        // 8.swift中基本运算
        // 1>.相同类型才可以进行运算
        // 2>.因为swift中没有“隐式转换”（不会自动将一种类型转换成另一种类型）
        // 3>.强制类型转换
        let m1: Double = 3.14
        let tempM: Int = Int(m1) // 不会修改m1的值
        print("\(tempM)")
        // 4>.默认情况下swift的运算符不允许值溢出
        
        // 9.逻辑分支
        // 1>.if语句
        // 1).if后面的()可以省略
        // 2).判断语句不再有“非0即真”：必须有明确的真假
        let score = 10
        if score > 10 {

        } else if score == 9 {
            
        } else {
            
        }
        // 2>.三目运算符
        let m2 = 10
        let n2 = 15
        var result = 0
        result = m2 > n2 ? m2 : n2
        // 3>.guard语句
        // 1).提高程序的可读性
        // 2).guard必须与else同时使用
        // 3).“guard”表示“守卫”的意思
        guard m2 >= 10 else {
            // 语句块1
            // 如果条件语句（m2 >= 10）为false？则执行“语句块1”
            // “不成立”执行这里
            // ！！！这里一般情况下会使用以下一种语句！！！
            // 必须加一个 “关键字”
            // return
            // break
            // continue
            // throw
            return
        }
        // 语句块2
        // 如果条件语句（m2 >= 10）为true？则执行“语句块2”
        // 4)."guard语句"必须在“函数”中使用
        // 4>.switch语句
        // 1).switch的基本使用
         let sex = 0
        // switch后面的“()”可以省略
        // case语句结束后“break”可以省略
        switch sex {
        case 0:
            print("男")
//            // 2).如果系统想要产生"case穿透"
//            fallthrough
        case 1:
            print("女")
        default:
            print("未知")
        }
        // 3).case后面可以判断多个条件，多个条件以“,”隔开/类似于“或”
        switch sex {
        case 0, 1:
            print("正常人")
        default:
            print("未知")
        }
        // 4).swift中switch可以判断浮点型
        let pi = 3.14
        switch pi {
        case 3.14:
            print("这是一个pi")
        default:
            print("这不是一个pi")
        }
        // 5).switch可以判断字符串
        let m3 = 10
        let n3 = 20
        let opration = "+"
        switch opration {
        case "+":
            result = m3 + n3
        case "-":
            result = m3 - n3
        case "*":
            result = m3 * n3
        case "/":
            result = m3 / n3
        default:
            print("非法操作符")
        }
        // 6).switch可以判断区间（重点知识）
        // swift中有两种常见的区间
        // 1.开区间：0..<10 - 0到9不包含10
        // 2.闭区间：0...10 - 0到10包含10
        // “0..<10”|“0...10”是一个整体
        switch score {
        case 0..<60:
            print("不及格")
        case 60..<85:
            print("及格")
        case 85...100:
            print("优秀")
        default:
            print("不合理的分数")
        }
        
        // 10.循环
        // 1>.for循环
//        // ！！！swift3.x移除该写法！！！
//        for var index = 0; index < 10; index++ {
//            print(index)
//        }
        // 打印1-9
        for index in 0..<10 {
            print(index)
        }
        // 打印10次“hello world”
        // 在swift中如果一个标识符不需要使用可以使用”_“来代替
        // 可以加快运行速度
        for _ in 0..<10 {
            print("hello world")
        }
        // 2>.while循环
        // 0).条件不成立 -> 终止循环
        // 1).while后面的()可以省略
        // 2).while后面的判断条件没有“非0即真”
        var m4 = 10
        while m4 > 0 {
            print(m4)
//            // swift中没有“自增自减”
//            m4--
            m4 = m4 - 1
        }
        // 3>.do...while循环
        // 0).条件不成立 -> 终止循环
        // 1).swift中没有“do...while循环”
        // 2).swift中有“repeat...while循环”
        repeat {
            print(m4)
            m4 = m4 - 1
        } while m4 > 0
    }
    
    // 11.字符串
    // swift中字符串不是指针而是实际的值
    // String是一个结构体，性能更高，可以转换成NSString
    /*
     常见的特殊字符串常量
     1.空字符 \0
     2.反斜杠 \
     3.制表符 \t
     4.换行符 \n
     5.回车符 \r
     6.双引号 \"
     7.单引号 \'
     */
    func string() {
        // 1>.定义字符串
        // 1).定义不可变字符串
        let opration: String = "+"
        // 2).定义可变字符串
        var str0 = "xwj"
        str0 = "wy"
        // 3).定义空字符串
        var emptyString = ""
        
        // 2>.遍历字符串
        for char in opration {
            print("\(char) + \(str0)")
        }
        
        // 3>.字符串拼接
        // 1).两个字符串之间的拼接
        let str1 = "小码哥"
        let str2 = "IT教育"
        let plusStr = str1 + str2
        // 2).字符串和其它标识符之间的拼接
        let count: Int = 10000
        print("\(plusStr)有\(count)名学生")
        // 3).拼接字符串时，字符串的格式化
        let min = 2
        let second = 18
        let _ = String(format: "%02d:%02d", [min, second])
        
        // 4>.字符串的截取
        let urlString = "www.520it.com"
        // 将string转换成NSString
        let headerString = (urlString as NSString).substring(to: 3)
        let middleString = (urlString as NSString).substring(with: NSMakeRange(4, 5))
        let footerString = (urlString as NSString).substring(from: 10)
        print(headerString + middleString + footerString)
        
        // 5>.字符串其它方法
        // 1).前面是大写/后面是小写
        print("\(headerString.uppercased())\(footerString)\(footerString.lowercased())")
        // 2).判断字符串是否有特定前缀
        if urlString.hasPrefix("www") {
            
        }
        // 3).判断字符串是否有特定后缀
        if urlString.hasSuffix("width") {
            
        }
        // 4).判断字符串是否相等
        // 因为swift中字符串不是指针
        // 如果是指针==表明指针地址相等
        if urlString == "www.520it.com" {
            
        }
        // 5).判断字符串是否为空
        // 第一种方式
        if urlString.isEmpty {
            // urlString.count/NSString的length不一定相同
            // urlString.count基于Unicode编码
            // NSString的length基于UTF-16编码
        }
        // 第二种方式
        if urlString.count == 0 {
            
        }
    }
    
    // 12.数组
    // 1>.数组Array是一串有序的由相同类型元素（也可以是不同类型元素但是没有意义）构成的集合
    // 2>.数组中的元素是有序的、可以重复出现
    func array() {
        // 3>.定义数组
        // 1).定义不可变数组
        /*
         option + 鼠标右键 - 查看属性类型
         command + 鼠标右键 - 查看源码
         */
        let array = ["why", "yz", "lmj"]
        // 2).定义可变数组
//        var arrayM = Array<String>() // 不常用
        var arrayM = [String]()
        // 定义空数组必须指定数组类型
        var _: [String] = []
        // 3).定义空数组
        var emptyArray: [String] = []
        // 4).存放不同类型的数据
        var anyArray: Array<Any> = [1, "lnj", 1.75];
        
        // 4>.对可变数组的基本操作
        // 1).追加元素
        arrayM.append("lnj")  // 追加在尾部
        arrayM.append("why")  // 数组中可以有相同元素
        // 与“[mArray5 addObjectsFromArray:mArray1];”一致
        arrayM.append(contentsOf: array) // 追加一个数组
        // 2).删除元素
//        arrayM.removeFirst()
//        arrayM.removeLast()
//        arrayM.remove(at: 2)
//        arrayM.removeAll()
        // 3).修改元素
        arrayM[0] = "xwj"
        arrayM[1] = "xwj"
        // 4).获取元素
        let _ = arrayM[1]
        // 5).插入元素
        arrayM.insert("xwj", at: 2)
        
        // 5>.数组的遍历
        // 1).根据下标
        for index in 0..<arrayM.count {
            print(arrayM[index])
        }
        // 2).直接遍历元素
        for name in arrayM {
            print(name)
        }
        // 3).遍历数组中前两个元素（部分遍历）
        for name in arrayM[0..<2] {
            print(name)
        }
        // 4).遍历
        arrayM.forEach { (name) in
            print(name)
        }
        
        // 6>.数组的合并
        // 相同类型的数组才可以进行合并，不同类型数组不能相加合并
        let _ = arrayM + array
    }
    
    // 13.字典
    // 1>.swift中字典类型是Dictionary、泛型集合
    // 2>.字典的元素是无序的
    func dictionary() {
        // 1>.定义字典
        // 1).定义不可变字典
        let dict: [String : Any] = ["name":"xwj", "age":18, "height": 1.88]
        // 2).定义可变字典
//        var dictM = Dictionary<String, Any>() // 不常用
        /*
         NSObject一般用于创建对象
         AnyObject一般用于指定类型
         */
        var dictM = [String : Any]()
        // 3).定义空字典
        var emptyDictionary1: [String: Any] = [:]
        var emptyDictionary2: Dictionary<String, Any> = [:]
        
        // 2>.对可变字典的基本操作
        // 1).添加元素
        dictM["name"] = "why"
        dictM["age"] = 18
        dictM["height"] = 1.88
        // 2).删除元素
        dictM.removeValue(forKey: "age")
        // value设置为空也可以删除字典元素
        dictM["name"] = nil
        // 3).修改元素
        // 如果字典中已经有对应的key -> 修改原key中保存的value
        // 如果字典中没有对应的key -> 添加key/value
        dictM.updateValue("xwj", forKey: "name")
        dictM["name"] = "yz"
        // 4).获取元素
        let _ = dictM["name"]
        
        // 3>.遍历字典
        // 1).遍历字典中所有的key
        for key in dict.keys {
            print(key)
        }
        // 2).遍历字典中所有的value
        for value in dict.values {
            print(value)
        }
        // 3).遍历所有的键值对
        for (key, value) in dict {
            print(key)
            print(value)
        }
        
        // 4>.合并字典
        // 即使字典类型一致也不能相加合并
    }
    
    // 14.元组
    // 1>.一种数据结构，组成”元组的数据“称为”元素“
    // 2>.一般元组作为方法的返回值
    func tuple() {
        // 3>.元组的写法
        // 1).元组的基本用法
        let info_0 = ("yz", 18, 1.88)
        print("\(info_0.0)\(info_0.1)\(info_0.2)")
        // 2).元组取别名（常用写法）
        let info_1 = (name: "yz", age: 18, height: 1.88)
        print("\(info_1.name)\(info_1.age)\(info_1.height)")
        // 3).元素的别名就是元组的名称
        let (name, age, height) = ("yz", 18, 1.88)
        print("\(name)\(age)\(height)")
    }
    
    // 15.可选类型
    // 1>.在Objective-C中，如果一个变量暂时不使用可以直接赋值为0或者设置为nil（Objective-C中nil是一个指针指向不存在的对象）
    // 2>.swift中nil不是指针，是一种特定的类型，不能直接给变量赋值（不是可选类型无法赋值为nil）
    // 3>.swift中规定：对象中所有的属性都必须有明确的初始化值
    func optional() {
        // 4>.定义可选类型
        // 1).方式一（不常用）
        // 可选类型也是泛型
        var name: Optional<String> = nil
        // 2).方式二（常用：语法糖）
        var age: Int? = nil
        
        // 5>.给可选类型赋值
        name = "xwj"
        age = 0
        
        // 6>.取出可选类型的值
        // 强制解包：非常危险，如果可选类型为nil，则系统会崩溃
        if name != nil {
            print(name!)
        }

        // 7>.可选绑定
        // 1).判断age是否有值，如果没有值，直接不执行{}
        // 2).如果age有值系统会自动将age进行解包，并将解包的结果赋值给tempAge
        // 写法一：不常用
        if let tempAge = age {
            print(tempAge)
        }
        // 写法二：常用
        if let age = age {
            print(age)
        }
        
        // 8>.可选类型有两种状态：有值、没有值（没有值就是nil）
        // 有值
        var height: Int? = 180
        // 没有值
        var height1: Int?
        var height2: Int? = nil
    }
    
    // 16.函数
    // 1>.基本用法
    // 1).无参无返回值
    func about() -> Void {
        print("‘-> Void’可以省略")
    }
    func about1() {
        
    }
    // 2).无参有返回值
    func readMsg() -> String {
        // 调用函数
        about()
        return "吃饭了吗"
    }
    // 3).有参无返回值
    // ‘-> Void’可以省略
    func callPhone(phoneNum: String) {
        let _ = sum(value1: 1, value2: 2)
        print("打电话\(phoneNum)")
    }
    // 4).有参有返回值
    func sum(value1: Int, value2: Int) -> Int {
        callPhone(phoneNum: "15601749931")
        let _ = plus(1, value2: 2)
        return value1 + value2
    }
    // 2>.使用注意
    // 1).内部参数和外部参数
    // 内部参数：在函数内部可以看到的参数就是内部参数，默认情况下所有的参数都是内部参数
    // 外部参数：在函数外部可以看到的参数就是外部参数，默认情况下从第二个参数开始既是内部参数也是外部参数
    // 如果希望第一个参数也是外部参数可以在标识符前给该参数添加一个别名/一般别名直接用‘_’
    func plus(_ value1: Int, value2: Int) -> Int {
        let _ = makeCoffee(coffeeName: "拿铁")
        let _ = makeCoffee()
        // 作用：使用defer代码块来表示在函数返回前，函数中最后执行的代码：无论函数是否会抛出错误，该代码都会执行
        // 什么时候调用：当前作用域结束之前调用（每当一个作用域结束就进行该作用域defer执行）
        defer {
            
        }
        return value1 + value2
    }
    // 2).swift函数的默认参数
    func makeCoffee(coffeeName: String = "雀巢") -> String {
        let _ = sum(string: "可变参数", value1: 10, 13, 15)
        return "制作了一杯\(coffeeName)咖啡"
    }
    // 3).可变参数
    // value1是“数组”类型
    func sum(string: String, value1: Int...) -> Int {
        var count = 0
        for num in value1 {
            count = count + num
        }
        return count
    }
    // 4).指针类型
//    // 值传递（swift默认是值传递）
//    // 默认情况下函数参数是let：试图从函数体内部更改函数参数的值会导致编译时错误
//    func swapNum( m: Int, n: Int) {
//        let tempNum = m
//        m = n
//        n = tempNum
//    }
    // 地址传递
    // 如果您希望函数修改参数的值，并且这些更改在函数调用结束后仍然存在：可以修改“函数参数”
    func swapNum( m: inout Int, n: inout Int) {
        let tempNum = m
        m = n
        n = tempNum
    }
    // 5).函数支持嵌套使用
    func test() {
        func demo() {
            print("demo")
        }
        // 这里必须调用
        demo()
        var m = 10
        var n = 9
        // 此处不能传递常量
        swapNum(m: &m, n: &n)
    }
    
    // 重写父方法必须加上override
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        // 这里不能重写父类
//        super.setValue(value, forUndefinedKey: key)
    }
}

// 17.类
// 1>.swift是一门面向对象的语言（类是面向对象的基础）
// 2>.类的定义：具有相同属性和方法的抽象/可以没有父类
// swift中只要继承NSObject就可以使用KVC
class WMGameProxy: NSObject {
    // 3>.定义属性
    // 重写属性：无论是存储属性还是计算属性都只能重写为计算属性
    // 1).存储属性
    var id: String? = nil
    var name: String?
    var age: Int = 0
    // 2).计算属性：通过计算得到结果的属性
    var mathScore: Double = 0.0
    var chineseScore: Double = 0.0
    // 也可以通过一个“方法”完成（swift不推荐使用）
    var averageScore: Double {
//        // swift开发中如果需要使用当前对象的某一个属性或者调用当前对象某一个方法的时候不需要加"self"，可以直接使用
//        return (self.mathScore + self.chineseScore) * 0.5
        return (mathScore + chineseScore) * 0.5
    }
    
    // 4>.类属性相关关键字
    // 1>.与整个类相关的属性
    // 2>.通过类名进行访问
    static var courseCount: Int = 0
    // 既可以修饰属性，也可以修饰方法，还可以修饰类
    // 1>.被final关键字修饰的属性和方法不能被重写
    // 2>.被final关键字修饰的类不能被继承
    final var height = 180.0
    // 弱引用：默认情况下所有的引用都是强引用
    // 1>.如果利用weak修饰变量：当对象释放后会自动将变量设置为nil（安全：继续访问该对象程序不会crash）
    // 2>.利用weak修饰的变量必定是一个可选类型，因为只有可选类型才能设置为nil
    weak var w1: WMGameProxy?
    // unowned相当于oc的unsafe_unretained
    // 1>.利用unowned修饰的变量，对象释放后不会设置为nil（不安全：继续访问该对象程序会crash）
    // 2>.利用unowned修饰的变量，不一定是可选类型
    unowned var w2: WMGameProxy?
    
    // 5>.属性监听器
    // 1.不能在子类中重写父类只读的存储属性
    // 2.不能给lazy的属性设置属性观察器
    var tempName: String = "" {
        // 属性即将改变时进行监听
        willSet {
            // 老值
            print(tempName)
            print(newValue)
        }
        // 属性已经改变进行监听
        didSet {
            // 新值
            print(tempName)
            print(oldValue)
        }
    }
    
    // 6>.单例
//    // 必须将构造函数私有化
//    private init() {}
    // 第一种方式
    static let instance: WMGameProxy = WMGameProxy()
    class func shareInstance() -> WMGameProxy {
        return instance
    }
    // 第二种方式
    static let sharedInstance = WMGameProxy()
    
    // 7>.构造函数：类似oc中的初始化方法、没有编写构造函数编译器会提供一个默认的构造函数
    // 1).如果继承自NSObject类可以重写父类构造函数
    override init() {
        // 在“构造函数”中如果没有明确调用“super.init()”系统会帮助我们调用（系统帮我们调用是在最后面）
        super.init()
    }
    // 2).自定义构造函数
    init(id: String, age: Int) {
        self.id = id
        self.age = age
    }
    // 3).自定义构造函数
    init(dict: [String : Any]) {
//        /*
//         AnyObject转成确定的类型
//         1."as?"最终转成的类型是一个“可选类型”
//         2."as!"最终转成的类型是一个“确定类型”
//         */
//        let _ = dict["name"] as? String
        super.init() // 必须调用（系统帮我们调用是在最后面）
        setValuesForKeys(dict)
    }
    
    // 8>.方法：类方法和实例方法
    // 实例方法：一定是通过对象来调用的
    // 实例方法会自动将除第一个参数以外的其它参数即当做外部参数又当做内部参数
    func getName() -> String? {
        // 1).给类的属性赋值
        let game: WMGame = WMGame()
        // 2).直接赋值
        game.name = "xwj"
        // 3).通过KVC赋值
        game.setValue("xwj", forKeyPath: "name")
        // 调用类的方法
        game.log()
        return self.name
    }
    // 类方法：通过static关键字定义，通过类名来调用（也可以使用class定义）
    // 类方法中不存在self：不能访问非静态属性
    static func show() {
        
    }
    
    // 9>.重写父类方法：必须加上override关键字
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
//        // 5>.防止循环引用
//        // 第一种方法
//        weak var weakSelf = self
//        self.loadData { (jsonData) -> (Void) in
//            /**
//             1.如果可选类型没有值：后面的代码不会执行
//             2.如果可选类型有值：系统会自动给weakSelf进行解包
//             */
//            weakSelf?.name = ""
//        }
//
//        // 第二种方法：不推荐使用
//        // 当self为nil的时候会崩溃：很危险
//        // 类似oc中的__unsafe_unretained
//        self.loadData { [unowned self] (jsonData) -> (Void) in
//            /**
//             1.如果可选类型没有值->后面的代码不会执行
//             2.如果可选类型有值->系统会自动给self进行解包
//             */
//            self.name = ""
//        }

        // 第三种方法：推荐使用
        self.loadData { [weak self] (jsonData) -> (Void) in
            /*
             1.如果可选类型没有值 -> 后面的代码不会执行
             2.如果可选类型有值 -> 系统会自动给self进行解包
             */
            self?.name = ""
        }
        
        // 6>.尾随闭包：如果闭包做为函数的最后一个参数那么闭包可以将()省略
        self.loadData (callback: { [weak self] (jsonData) -> (Void) in
            /*
             1.如果可选类型没有值 -> 后面的代码不会执行
             2.如果可选类型有值 -> 系统会自动给self进行解包
             */
            self?.name = ""
        })
        
        // 7>.逃逸闭包：当一个闭包作为参数传到一个函数中，但是这个闭包在函数返回之后才被执行，我们称该闭包从函数中逃逸
        func request (result:@escaping((String)->())) {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
                result("数据结果")
            }
        }
        
        // 8>.非逃逸闭包：永远不会离开一个函数的局部作用域的闭包就是非逃逸闭包
    }
    
    // 18.闭包：特殊的函数、经常用于回调
    // 1>.闭包的格式：(参数, 参数) -> (返回值类型)
    // 2>.闭包做为函数参数
    /*
     callback - 函数参数
     (_ jsonData: String) -> (Void) - 函数参数类型/闭包类型
     */
    func loadData(callback: (_ jsonData: String) -> (Void)) {
        callback("jsonData数据")
    }
    
    // 析构函数：相当于“dealloc方法”
    // 作用：释放持有资源、关闭文件、断开网络
    deinit {
        // 当对象销毁的时候调用该方法
        // 借用位置（与该函数无关）
        var _ = block("",18)
    }
    
    // 3>.闭包基本写法
    var block: (_ name: String, _ age: Int) -> (Int) = {
        (name: String, age: Int) in
        return 100
    }
    
    // 4>.typealias修饰闭包
    typealias callBackBlock = (_ jsonData: String) -> (Void)
    var callBack: callBackBlock?
}

// 19.结构体：用于封装不同或相同类型的数据，swift中的结构体是一类类型, 可以定义属性和方法(甚至构造方法和析构方法)
struct Rect {
    // 结构体的属性可以没有默认值
    var width: Double = 0.0
    var height: Double = 0.0
}
// 如果结构体的属性有默认值，可以直接使用()构造一个结构体
var r1 = Rect()
//r1.width = 10.0
//r1.height = 10.0
// swift要求实例化一个结构体或类的时候，所有的成员变量都必须有初始值：构造函数用于初始化所有成员变量，而不是分配内存（分配内存是系统完成的）
struct Rect1 {
    var width: Double = 10.0;
    var height: Double
    
    // swift中的结构体可以定义方法
    // 1>.结构体中定义的方法属于结构体
    // 2>.结构体中的成员变量必须使用某个实例调用
    // 3>.成员方法可以访问成员属性
    func getWidth() -> Double {
        return width
    }
    
    // 20.subscripts下标：访问对象中数据的快捷方式
    // 要想实现下标访问，必须实现subscript方法
    // 如果想要通过下标访问，必须实现get方法
    // 如果想要通过下表赋值，必须实现set方法
    subscript(s: String) -> Double? {
        get {
            switch s {
            case "width":
                return width
            case "height":
                return height
            default:
                return nil
            }
        }
        set {
            switch s {
            case "width":
                if let newValue = newValue {
                    width = newValue
                }
            case "height":
                if let newValue = newValue {
                    height = newValue
                }
            default:
                print("Not Value")
            }
        }
    }
}
// 如果结构体的属性没有默认值，必须使用逐一构造器实例化结构体
// 必须包含所有未初始化的属性；顺序必须与结构体中属性的顺序一致
var r2 = Rect1(width: 10.0, height: 10.0)
// 结构体中的成员方法是和某个实例对象绑定在一起的，所以谁调用，方法中访问的属性就属于谁
//r2.getWidth()
//r2["width"] = 100.0
// 结构体是值类型：结构体之间的赋值其实是将r2中的值完全拷贝一份到r3中，所以他们是两个不同的实例
var r3 = r2;

/*
 1.在swift中，类和结构体有什么区别？swift为什么推荐使用结构体？
 // 在swift中，类和结构体有什么区别？
 类是引用类型：存放在堆内存，需要手动管理内存
 结构体是值类型：存放在栈内存，不需要进行内存管理
 类可以被继承
 结构体无法被继承
 类在给属性赋值的时候不会开辟新的内存地址
 结构体在给属性赋值的时候会开辟新的内存地址
 // swift为什么推荐使用结构体？
 值类型不需要手动进行内存管理，没有引用计数，不会因为循环引用导致内存泄漏
 值类型通常来说是以栈的形式分配的，速度很快
 值类型是安全的（但是因为结构体无法继承，所以Objective-C中无法调用swift中的struct）
 */
/*
 2.swift和Objective-C有什么不同？
 1>.swift是强类型（静态）语言，Objective-C弱类型（动态）语言
 2>.swift注重值类型，Objective-C注重引用类型
 3>.swift有元组类型、支持运算符重载
 4>.swift比Objective-C代码更简洁、更安全
 5>.swift编译速度慢，API更新快
 */
/*
 3.oc和swift怎么定义变量？
 ```
 // oc
 const int price = 0;
 // swift
 let price = 0
 ```
 */
/*
 4.为什么说可选类型在swift语言中特别重要？
 可选类型的本质是枚举：使用可选类型可以把一些错误暴露在编译阶段
 */
/*
 5.oc/swift混合编程的痛点？（oc/swift混合编程的编译速度慢，原因是什么？怎么优化？）
 1>.oc的类不能继承swift类
 2>.oc想要调用swift代码需要swift中的类继承NSObject（oc无法调用swift中的struct）
 3>.swift中特有概念（元组、inout关键字）在oc中不存在（如果方法中参数或返回值有oc不支持的类型则oc无法调用该方法）
 4>.oc/swift混合编程的编译速度慢（FIXME）
 */
