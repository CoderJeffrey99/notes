// 3.文件导入
// 内置库的前缀'dart:xxx/xxx'
// 包管理库的前缀'package:xxx/xxx'
/*
// 全部导入
import 'xxx';
// 库之间出现冲突（调用方法也相应变成'y.xxx();'）
import 'xxx' as y;
// 部分导入（只导入yyy）
import 'xxx' show yyy;
// 部分导入（除yyy导入其他）
import 'xxx' hide yyy;
// 延迟导入y（调用方法也相应变成'y.xxx();'）
import 'xxx' deferred as y;
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // ';'结束

// ignore_for_file:avoid_print
class PositionPage extends StatefulWidget {
  const PositionPage({Key? key}) : super(key: key);

  @override
  State<PositionPage> createState() => _PositionPageState();
}

enum EnumName {
  normalLoginType,
  phoneLoginType,
  codeLoginType
}
class _PositionPageState extends State<PositionPage> {
  @override
  void initState() {
    super.initState();
    // 获取数据
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color.fromARGB(215, 0, 215, 198),
        centerTitle: true,
        title: const Text(
          '职位',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white
          ),
        ),
      ),
      body: const Text(
        '职位'
      ),
    );
  }

  // 1.dart语言概述：dart是一种强类型、跨平台的客户端开发语言。具有专门为客户端优化、高生产力、快速高效、可移植易学的风格
  // 1>.概念：dart语言是一门由Google开发的通用编程语言，后来被ecma批准为标准
  // 2>.作用：dart语言用于构建"web/服务器/pc/移动端"应用
  // 3>.特点：面向对象语句、垃圾回收语言、可以随意转换成js、支持"接口、抽象类、静态类型、泛型、mixins"

  // 2.dart语句的特征
  // 1>.dart语言中一切（无论变量、数字、函数、null）皆对象，所有对象都是Object类的子类
  // 2>.dart语言是强类型语言（一旦确定类型就不可以改变变量类型，编译的时候会进行语法检查）、dart语言允许弱类型语言式的编程
  // 3>.dart语言在运行前解析（指定数据类型和编译时常量）可以提高运行速度
  // 4>.dart语言的统一入口是main函数
  // 5>.dart语言的私有特性是在变量名或者函数名前面加上"_"
  // 6>.dart支持异步处理
  // 7>.dart语言是类型安全的（dart语言使用静态类型检查和动态类型推导以确保变量的值总是与变量的静态类型匹配）

  // 4.标识符
  // 1>.概念：dart语言规定必须以'字母/下划线'开头，只能包含'字母/下划线/数字/$'
  // 2>.严格区分大小写
  var msg = 'msg是一个标识符'; // dart语句结束必须有';'

  // 5.注释
  // 1>.代码注释：不会参加编译
  // 单行注释
  /* 多行注释 */
  // 2>.文档注释：编译以后会保留、使用[]引用相关数据
  /// 文档注释

  // 6.输出语句
  void log() {
    print('hello world');
  }

  // 7.数据类型
  void numType() {
    // 一、数字类型：整数可以转换成双精度浮点数
    int a1 = 1; // int - 表示任意大小的整数
    double a2 = 2.00; // double - 表示小数
    num a3 = 0.01; // num - 表示int/double的父类
    // int a4 = 0.1;  // 不要把小数分配给整数（会抛出异常）

    // 二、字符串：使用''/""表示的字符序列
    // 1>.dart语言中字符串是不可变的
    String b1 = 'hello world'; // 推荐使用
    String b2 = " hello world ";
    // 2>.虽然字符串不可变但是可以操作字符串返回新的字符串
    String b3 = b2.trim(); // 删除字符串前后的空格
    print(b3);
    List list = b1.split(','); // 分割字符串返回List
    print(list);
    String b4 = b1.substring(1, 5); // 分割字符串[1, 5)
    print(b4);
    String b5 = b1.toLowerCase(); // 将字符串全部小写
    print(b5);
    String b6 = b5.toUpperCase(); // 将字符串全部大写
    print(b6);
    // 3>.字符串 -> 数字
    int b7 = int.parse(b1);
    double b8 = double.parse(b1);
    // 4>.数字 -> 字符串
    String b9 = a1.toString();
    String b10 = a2.toString();
    String b11 = a3.toString();
    // 5>.拼接字符串'${xxx}'
    String b12 = '${2 + 2}'; // ${表达式}
    String b13 = '${'wy'}xy'; // 万能拼接
    String b14 = '$a1$b8'; // 如果是拼接标识符可以省略'{}'
    String b15 = b12 + b13; // 如果是两个字符串拼接可以直接使用‘+’
    // 6>.创建多行语句
    String ls = '''
    你好，
    China
    ''';
    print(ls);
    // r前缀让转义字符失效
    String ls1 = r'\n';
    print(ls1);

    // 三、布尔类型：没有非零既真，必须有明确的真假
    assert(b12.isEmpty); // 检查是否是空字符串（只在开发模式下有效，生产模式下无效）
    assert(a1 == 0); // 检查零值，返回false抛出AssertionError
    dynamic hitTest;
    assert(hitTest == null); // 检查是否为null
    bool varName = true;
    // if (varName) {
    //   varName = false;
    // } else {
    //   print('走到这里');
    // }

    // 四、数组List：有序
    // // 1>.创建List
    // var goodList_01 = <String>[];  // 推荐使用
    // List<String> goodList_02; // 推荐使用
    // // 2>.固定长度列表 - 默认已经指定长度/长度不能在运行时更改
    // var listName = new List(3); // 已废弃
    // listName[0] = 1;
    // listName[1] = 2;
    // listName[2] = 3;
    // // 3>.可增长列表 - 默认没有指定长度/长度能在运行时更改
    // // 创建一个空List
    // var listM = new List(); // 已废弃
    // listM.add(1);
    // listM.first;
    // 创建一个有值List
    var firstList = [1, 2, 3];
    firstList.length; // List长度
    if (firstList.length > 1) {
      var _ = firstList[1]; // 获取List第2个元素
      firstList.add(1); // 添加元素
      firstList.first; // 返回第一个元素
      if (firstList.isEmpty) {
        print('firstList是空的');
      }
      firstList.removeLast(); // 删除最后一个元素
      firstList.removeAt(2); // 删除第3个元素
      firstList.reversed; // List逆序
    }
    // 4>.遍历List
    // // Avoid using `forEach` with a function literal
    // firstList.forEach((element) {
    //   print('$element');
    // });
    for (var element in firstList) {
      print('$element');
    }
    // 5>.遍历数组返回新的数组
    firstList.map((element) => element * 2); // [2, 4, 6]
    // 6>.List生成器（返回一个List）
    List<int>.generate(30, (index) => index * 2);

    // 五、集合Set：无序、不能包含重复数据
    var oneSet = {'123', '1234', '1235'}; // 创建非空Set不需要指定类型（集合元素内容不能相同）
    // oneSet = Set.from(firstList); // 根据list创建Set
    var emptySet = <String>{}; // 创建空Set需要指定类型
    oneSet.length; // 获取集合长度
    emptySet.add('12345'); // 添加元素
    oneSet.addAll(emptySet); // 将emptySet中的元素添加到set中（不是把emptySet添加到set中）
    // 遍历集合
    // // Avoid using `forEach` with a function literal.
    // oneSet.forEach((element) {
    //   print('$element');
    // });
    for (var element in oneSet) {
      print('${element}xwj');
    }
    // 补集 - 存在于set1中 & 不存在于set2中
    var difference = oneSet.difference(emptySet);
    print(difference);
    // 交集 - 存在于set1中 & 存在于set2中
    var intersection = oneSet.intersection(emptySet);
    print(intersection);
    // 并集 - 存在于set1中 || 存在于set2中
    var union = oneSet.union(emptySet);
    print(union);

    // 六、映射：Map对象
    // var goodMap = <String, Object>{}; // 推荐使用
    // dart语言规定：映射中的键值对都可以是任何类型
    // 映射可以在运行时增长和缩小
    // 1>.第一种创建方式
    var gifts = {'key1': 'value1', 'key2': 'value2', 'key3': 'value3'};
    // 获取映射中的value
    assert(gifts['key1'] == 'value1');
    // 获取映射中的value，如果获取不到直接返回null
    assert(gifts['key4'] == null);
    // // 2>.第二种创建方式
    // // 创建赋值 - 不推荐使用
    // var giftMaps = Map();
    // giftMaps['key1'] = 'value1';
    // giftMaps['key2'] = 'value2';
    // giftMaps['key3'] = 'value3';
    // // 修改
    // giftMaps['key1'] = 'value11'; // 修改Map
    // giftMaps['key4'] = 'value4'; // 添加map
    // giftMaps.keys; // 返回所有的key
    // giftMaps.values; // 返回所有的value
    // giftMaps.length; // 返回所有的键值对
    // giftMaps.clear(); // 删除map中所有的键值对
    // // 3>.新建常量映射
    // const map = {1: 'value1', 2: 'value2', 3: 'value3'};
    // print(map);
    // // 4>.遍历映射
    // giftMaps.forEach((key, value) {
    //   print('Key = $key, Value = $value');
    // });
  }

  // 8.变量
  // 1>.使用变量之前必须先声明变量：变量存储值的引用/dart语言支持类型检查
  // 2>.dart语言一切皆对象：未初始化的变量默认为null（数字类型、布尔类型没有初始化都默认为null）
  /*
  // var、Object和dynamic都可以声明变量，它们的区别是什么？
  1>.var - 如果没有初始化值可以变成任何类型，如果有初始化值声明的变量类型固定不能改变
  2>.Object - 动态任意类型：声明的变量类型可以改变，编译的时候会检查类型
  3>.dynamic - 动态任意类型：声明的变量类型可以改变，编译的时候不检查类型
  */
  void disVariable() {
    // 如果没有初始化值可以变成任何类型，如果有初始化值声明的变量类型固定不能改变
    // 支持类型推导
    // 推荐使用
    var name = 'wy';

    // 动态任意类型：声明的变量类型可以改变，编译的时候会检查类型
    // 不推荐使用
    Object weight = '125';
    // weight = 123;   // 编译的时候会报错

    // 动态任意类型：声明的变量类型可以改变，编译的时候不检查类型
    // 类似oc的id类型
    dynamic height = '180';
    // height = 170; // 编译不报错（编译的时候不检查类型），运行报错

    // 使用默认类型
    // 类似java
    String age = '18';

    print('$name今年$age岁，体重$weight身高$height');
  }

  // 9.常量：不可以修改/“const/final关键字”用于声明常量/一律使用const
  /*
  const和final都可以修饰常量，他们有什么区别？
  1>.const - 表示编译期常量
  2>.final - 表示运行期常量（应用更广泛）
  */
  void disConstant() {
    // 一、final和const的相同点
    // 1>.常量声明可以省略常量类型
    // final String m1 = 'wy';
    const m1 = 'wy';
    // const int n1 = 1;
    const n1 = 1;
    print('$m1$n1');
    // 2>.常量初始化以后不能再次赋值
    // m1 = 'cfj';
    // n1 = 2;
    // 3>.不能与var一起使用
    // final var m2 = 'wy';
    // const var n2 = 2;
    // 二、final和const的区别
    // 1>.类级别常量使用static/const
    // 2>.const可以使用其他const常量的值来初始化其值
    const width = 100;
    const height = 200;
    const square = width * height;
    print(square);
    // 3>.相同的const常量不会在内存中重复存储
    // // 4>.const修饰的不可变性是可以传递的（子类会继承）
    // var list1 = const [1, 2, 3]; // list1数组可以修改/list1[x]元素不能修改
    // const list2 = const [1, 2, 3]; // list1数组不能修改/list1[x]元素不能修改
    // final list3 = const [1, 2, 3]; // list1数组不能修改/list1[x]元素不能修改
    // print('$list1$list2$list3');
  }

  // 10.运算符
  void disOperator() {
    var m1 = 1;
    var m2 = 2;
    var m3 = true;
    // 1>.算术运算符：+、-、*、/、~/（整除）、%（取余）
    print(m1 + m2); // 3
    print(m1 - m2); // -1
    print(m1 * m2); // 2
    print(m1 / m2); // 0.5
    print(m1 ~/ m2); // 0
    print(m1 % m2); // 1
    // 2>.自增自减运算符：++、--
    print(m1++); // 1
    print(m1--); // 2
    print(++m1); // 2
    print(--m1); // 1
    // 3>.关系运算符：==、!=、>、<、>=、<=
    PositionPage p1 = const PositionPage();
    PositionPage p2 = const PositionPage();
    if (identical(p1, p2) == true) {
      // ==判断值是否相等
      // identical(p1, p2)判断是否为同一对象
    }
    // 4>.赋值运算符：=、??=、+=、-=、*=、/=、>>=、^==、<<=、&=、|=
    m1 = 1;
    m2 *= m1; // b = b * a = 2
    print(m2);
    m2 ??= 2; // 表示如果m2位null则把2赋值给m2
    print(m2); // 2
    // 5>.逻辑运算符：!、||、&&
    print(!m3); // false
    print((m1 == 1) && (m2 == 2)); // true
    // 6>.位运算符（十六进制）：&、|、~（按位取反）、<<、>>
    // 7>.类型运算符：as、is、is!
    String msg = m1 as String; // as表示‘类型转换’
    print(msg);
    // print(msg is String); // true/is代表‘是否是’
    // print(msg is! String); // false/is!代表‘是否不是’
    // 8>.三元表达式
    print(msg.isEmpty ? '' : msg);
    // 9>.空安全运算符
    // a.若msg==null则返回'123'
    var m5 = msg ?? '123';
    // b.若m5==null则把msg赋值给m5
    m5 ??= msg;
    // c.若msg==null则返回null
    var m6 = msg?.isEmpty;
    // 10>.级联运算符：用于连续操作某个对象，而无需每次操作时都调用该对象
    var list1 = [1, 2, 3, 4];
    list1
      ..add(5)
      ..insert(4, 6);
  }

  // 11.条件语句
  void disConditional() {
    var n1 = 1;
    var n2 = 2;
    if (n1 > n2) {

    }
    if (n1 > n2) {

    } else if (n1 == n2) {

    } else {

    }
    if (n1 > n2) {

    } else {

    }
    switch (n1) {
      case 1: {

      }
      break;
      case 2: {

      }
      break;
      default: {

      }
    }
  }

  // 12.循环语句
  void disLoop() {
    for (var i = 0; i < 1000; i++) {
      print('循环语句');
    }
    var list = [1, 2, 3, 4];
    // foreach循环已经废弃
    for (var item in list) {
      print(item);
    }
    var m1 = 1;
    var m2 = 2;
    while (m1 < m2) {

    }
    do {

    } while (m1 < m2);
  }

  // 13.函数
  // 1>.概念：可读、可维护、可重用代码的代码块
  // 2>.特点：函数也是对象
  // 3>.普通函数
  void disNormal(int a, int b, int c) {
    int result = a + b + c;
    print(result);
  }
  // 4>.可选参数函数
  // // a.可选位置参数（必须按照位置，如果需要指定c则不能省略b）
  // int disSum(int a, [int b, int c]) {
  //   disNormal(1, 2, 3);
  //   return a + b + c;
  // }
  // b.带有默认值的可选位置参数
  int disDefault(int a, [int b = 1, int c = 2]) {
    // disSum(1);
    return a + b + c;
  }
  // c.可选命名参数：命名参数就是选填参数（不用考虑b和c的顺序）
  // 命名参数最好给默认值
  int disClick(int a, {int b = 1, int c = 1}) {
    disClick(1, b: 1, c: 2);
    return a + b + c;
  }
  // 5>.递归函数：自己调用自己
  // 6>.Lambda函数/lan'b'da：函数块只有一条语句
  void single() => print('Lambda函数');
  // // 7>.匿名函数：没有方法名/必须用var/final修饰
  // /*
  // 两种形式
  // a.() => xxx;
  // b.() {};
  // */
  // // (name) - 参数
  // // print('$name') - 代码块
  // var mName = (String name) {
  //   return name;
  // }; // 有参匿名函数
  // var sName = () => print(''); // 无参匿名函数
  // 8>.回调函数
  // 一个函数做为另一个函数参数
  // String - 函数返回类型（void可以省略）
  // initComplete - 函数名称（自定义）
  // String msg - 函数入参（自定义）
  void sLogger(String Function(String msg) initComplete) {
    initComplete('12345');
    sLogger((msg) {
      return msg;
    });
    // sLogger(mName);
    // 9>.函数别名/闭包：返回一个函数/函数也是一个对象
    Function makeAdd(int a, int b) {
      return (int y) => a + y;
    }
    // 接收一个函数
    var addFunc = makeAdd(10, 12);
    // 打印结果
    print(addFunc(12));
  }
  // 10>.局部函数：嵌套于其他函数内部的函数

  // 14.枚举
  void loginType() {
    var type = EnumName.codeLoginType;
    switch (type) {
      case EnumName.normalLoginType: {
          print('普通登录');
        }
        break;
      case EnumName.phoneLoginType: {
          print('手机登录');
        }
        break;
      case EnumName.codeLoginType: {
          print('验证码登录');
        }
        break;
    }
  }

  // 15.时间处理
  void handleTime() {
    // 1>.获取当前时间
    DateTime.now();
    // 2>.创建一个指定时间年月日的DateTime对象
    DateTime(2009, 03, 03);
    // 3>.解析日期字符串
    DateTime.parse('2019-03-02');
    // 4>.解析时间戳
    DateTime.fromMillisecondsSinceEpoch(15516161200000);
  }

  // 16.异常：发生异常时如果没有被捕获程序的正常流程中断，程序会终止
  /*
   编译期error - 编译不过
   运行时error - 抛出异常
   */
  // 3>.异常处理（在执行程序期间出现问题）
  void disException() {
    // 第一种写法
    try {
      // 可能会导致异常的代码
      testAge(-2);
    } on CustomException catch (e) {
      // 如果发生异常在这里处理
      e.msgError();
    } catch (e) {
      print("如果异常没有被上方捕获，则会统一被此处捕获");
    } finally {
      // 总是会执行这里
    }

    // 第二种写法
    try {
      // 可能会导致异常的代码
      testAge(-2);
    } on CustomException catch (e, s) {
      // 如果发生异常在这里处理
      CustomException exception = e;
      exception.msgError();
      print(s.toString());
      rethrow; // 异常被重新抛出（这时候调用该函数必须再次捕获异常）
    } finally {
      // 总是会执行这里
    }
  }
  // 2>.抛出异常
  void testAge(int age) {
    if (age < 0) {
      throw CustomException();
    }
  }

  // 29.UI组件
  // 文本组件Text = UILabel
  // 包裹属性
  final _text = const Text(
    // 文字
    '文本组件文本组件文本组件文本组件',
    /*
    对齐方式
    TextAlign.left - 左对齐
    TextAlign.right - 右对齐
    TextAlign.center - 居中对齐
    TextAlign.justify - 两端对齐
    TextAlign.start - 类似"左对齐"
    TextAlign.end - 类似"右对齐"
     */
    textAlign: TextAlign.left,
    /*
    TextDirection.rtl - right to left
    TextDirection.ltr - left to right
    */
    textDirection: TextDirection.ltr,
    // 最大行数（超过部分按照overflow设置处理）
    // 不设置该参数则无限行
    maxLines: 1,
    /*
    字数过多溢出处理方式
    TextOverflow.clip - 直接截断
    TextOverflow.fade - 文字颜色蜕变
    TextOverflow.ellipsis - 显示省略号
    TextOverflow.visible - 文字可见（默认值）
     */
    overflow: TextOverflow.clip,
    style: TextStyle(
        // 字体
        fontFamily: '',
        // 字体大小
        fontSize: 15.0,
        // 字体粗细
        fontWeight: FontWeight.normal,
        // 字体颜色
        // Colors.pink
        /*
        Color.fromARGB(255, 125, 125, 125)
        R - red/G - Green/B - Blue，取值范围是：0 ～ 255
        A - alpha，取值范围是：0 ～ 255（透明 ～ 不透明）
         */
        /*
        Color.fromRGBO(125, 125, 125, 1.0)
        R - red/G - Green/B - Blue，取值范围是：0 ～ 255
        O - opacity，取值范围是：0 ～ 1（透明 ～ 不透明）
         */
        color: Color.fromRGBO(125, 125, 125, 0),
        /*
        线条
        TextDecoration.none - 没有线条
        TextDecoration.underline - 下划线
        TextDecoration.overline - 上划线
        TextDecoration.lineThrough - 删除线
        */
        decoration: TextDecoration.underline,
        // 线条颜色
        decorationColor: Colors.yellow,
        /*
        线条样式
        TextDecorationStyle.solid - 实线
        TextDecorationStyle.double - 双实线
        TextDecorationStyle.dotted - 点线
        TextDecorationStyle.dashed - 虚线
        TextDecorationStyle.wavy - 波浪线
        */
        decorationStyle: TextDecorationStyle.wavy
    ),
  );

  // 按钮组件ElevatedButton = UIButton
  // 一般不使用（用Ink代替）
  final _btn = ElevatedButton(
    onPressed: () {
    },
    onLongPress: () {
    },
    onHover: (isHover) {
    },
    onFocusChange: (isFocusChange) {
    },
    style: const ButtonStyle(
    ),
    child: const Text('按钮组件'),
  );

  // 图片组件Image = UIImageView
  /*
  Image.asset() - 项目图片（常用）
  Image.file() - 本地图片（需要填写绝对路径）
  Image.memory() - 内存图片
  Image.network() - 网络图片（常用）
  */
  final _image = Image.asset(
      '',
      /*
      BoxFit.contain - 按比例填充（一边填满即可，另一边可能会有空隙）/常用
      BoxFit.fill - 拉伸填满（一边填满以后另一边拉伸填满，可能会变形）
      BoxFit.fitWidth - 横向按比例填满（竖向可能会超出）
      BoxFit.fitHeight - 竖向按比例填满（横向可能会超出）
      BoxFit.cover - 按比例填满（两边都要填满（可能会裁剪））
      BoxFit.scaleDown - 不能改变原图大小
      */
      fit: BoxFit.contain,
      width: 500,
      height: 300,
      // 图片混合颜色
      color: Colors.green,
      colorBlendMode: BlendMode.darken,
      // 图片重复
      repeat: ImageRepeat.noRepeat
  );

  // 点击组件InkWell - 这个控件可以更好的代替UIButton
  // 一般与Ink一起使用
  final _loginBtn = Ink(
      width: 500,
      height: 50,
      // color: Colors.pink,
      decoration: BoxDecoration(
          // 背景颜色
          // 1>.不可以与外层color一起使用
          color: Colors.pink,
          // 背景图片
          image: DecorationImage(
            // NetworkImage('')
              image: const AssetImage(''),
              fit: BoxFit.contain,
              // 颜色滤镜
              colorFilter: ColorFilter.mode(
                  Colors.yellow.withOpacity(0.6),
                  BlendMode.screen
              )
          ),
          // 边框
          // 2.不可以只设置一个边框，然后取设置其他的圆角（A borderRadius can only be given for a uniform Border.）
          border: const Border(
              top: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              ),
              left: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              ),
              right: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              ),
              bottom: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              )
          ),
          // 设置圆角
          // borderRadius: BorderRadius.all(Radius.circular(5.0))
          // BorderRadius.vertical(top: Radius.circular(25.0), bottom: Radius.zero)
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0)),
          // 设置阴影
          // 可以设置多个阴影叠加
          boxShadow: const [
            BoxShadow(
              // 阴影颜色
                color: Colors.green,
                // 阴影偏移量：X轴左移20，Y轴上移20
                offset: Offset(-20, -20),
                // 模糊半径
                blurRadius: 10,
                // 延伸半径
                spreadRadius: 10
            )
          ],
          // 设置渐变背景色
          // LinearGradient - 线性渐变
          // RadialGradient - 放射渐变
          // SweepGradient - 扫描渐变
          gradient: const LinearGradient(
              colors: [Colors.red, Colors.yellow, Colors.green],
              // 起点位置
              stops: [0.1, 0.3, 0.5]
          )
      ),
      child: InkWell(
        // 防止InkWell超出
        // 1>.让Ink和InkWell的大小一致
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0)),
        // 单击事件
        onTap: () {},
        // 双击事件
        onDoubleTap: () {},
        // 长按事件
        onLongPress: () {},
        onTapDown: (isTapDown) {},
        // 点击取消
        onTapCancel: () {},
        onFocusChange: (isFocusChange) {},
        onHighlightChanged: (isHighlightChanged) {},
        onHover: (isHover) {},
        focusColor: Colors.pink,
        hoverColor: Colors.pink,
        highlightColor: Colors.pink,
        child: const Center(
            child: Text(
                '登录',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700
                )
            )
        )
      )
  );

  // 输入框组件TextField = UITextField
  final _tf = const TextField(
      // 多行文本
      maxLength: 5,
      // 是否为密码框
      obscureText: true,
      decoration: InputDecoration(
        // 提示
        hintText: '请输入用户名',
        labelText: '用户名',
        // 边框
        border: OutlineInputBorder(),
      )
  );

  // 长宽比AspectRatio
  final _aspectRatio = const AspectRatio(
    aspectRatio: 3.0/1.0,
    child: SizedBox(
      width: 100,
      height: 100,
    ),
  );

  // 静态ListView = UITableView
  final _staticListView = ListView(
    scrollDirection: Axis.vertical,
    children: const [
      Text('第一行'),
      Divider(),
      Text('第二行'),
      Divider(),
      Text('第三行'),
      Divider(),
      Text('第四行'),
      Divider(),
      Text('第五行'),
      Divider(),
      Text('第六行'),
      Divider(),
      Text('第七行'),
      Divider(),
      Text('第八行'),
      Divider()
    ],
  );

  // 动态ListView
  // 动态ListView可以使用该方式，也可以直接使用静态ListView然后不断循环创建
  final _listView = ListView.builder(
    scrollDirection: Axis.vertical,
    // 返回自定义cell
    itemBuilder: (context, index) {
      // 有点击事件就不能加const
      return ListTile(
        leading: const Icon(
            Icons.abc
        ),
        title: Text('这是第$index行'),
        onTap: () {
      
        },
      );
    },
    // 列表数量
    itemCount: 15,
  );

  // 静态GridView = UICollectionView
  final _staticGridView = GridView.count(
    // 滚动方向
    scrollDirection: Axis.vertical,
    // 子控件的内边距
    padding: const EdgeInsets.all(5.0),
    // 副轴Widget数量
    crossAxisCount: 3,
    // 主轴间隙
    mainAxisSpacing: 2,
    // 副轴间隙
    crossAxisSpacing: 4,
    // 子控件的"宽高比例"
    childAspectRatio: 2.0,
    children: const [
      Text('I am JSpang'),
      Text('I am JSpang'),
      Text('I am JSpang'),
      Text('I am JSpang'),
      Text('I am JSpang'),
      Text('I am JSpang'),
      Text('I am JSpang'),
      Text('I am JSpang')
    ],
  );

  // 动态GridView
  final _dynamicGridView = GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Container(
          width: 10,
          height: 10,
          color: Colors.yellow,
        );
      }
  );

  // 容器Container = UIView
  /*
  // 可以点击
  InkWell
    Container
  // 不可以单击
  Container
    InWell
  */
  final _container = Container(
    // 宽度
    width: 500,
    // 高度
    height: 50,
    // Container没有子控件充满整个屏幕，有子控件则与子控件一样大
    // Container只能设置一个子控件
    // 如果Container需要设置多个子控件可以借助Row
    alignment: Alignment.topLeft,
    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    // 内边距
    margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
    // 背景颜色
    // Colors.pink
    // Color.fromARGB(1, 125, 125, 125)、Alpha == 1不透明
    // Color.fromRGBO(125, 125, 125, 0)、opacity == 0不透明
    color: Colors.pink,
    clipBehavior: Clip.none,
    // 水平右边X轴正值，垂直下边Y轴正值
    // 具体操作百度：https://www.jianshu.com/p/ea7bdbfbdff2
    transform: Matrix4.translationValues(10.0, 20.0, 0),
    decoration: const BoxDecoration(
      color: Colors.pink
    ),
    // 此处只有一个子widget
    // 如果需要添加多个widget必须使用'组件布局'
    child: const Text('登录')
  );

  // 内边距Padding
  final _padding = const Padding(
    padding: EdgeInsets.only(right: 20.0),
    child: Text('123'),
  );

  // 装饰类容器SizeBox
  final _sizeBox = const SizedBox(
      width: 100,
      height: 100,
      child: Text('登录')
  );

  // 手势组件GestureDetector
  // 只能有一种手势
  final _gestureDetector = GestureDetector(
    child: const Text('手势'),
    // 点击
    onTap: () {},
    // 双击
    onDoubleTap: () {},
    // 长按
    onLongPress: () {},
    // 垂直拖动
    onVerticalDragStart: (details) {},
    // 水平拖动
    onHorizontalDragStart: (details) {},
    // 平移拖动
    onPanStart: (details) {},
  );

  // 安全区域SafeArea
  /*
  原理：通过MediaQuery来检测屏幕尺寸，使应用程序的大小能与屏幕适配，然后返回了一个Padding Widget来包裹住我们编写的页面，以保证页面不会被异形屏幕遮挡
  */
  final _safeArea = const SafeArea(
    child: Text('登录'),
  );

  // 装饰类容器DecoratedBox
  final _decorateBox = DecoratedBox(
      // BoxDecoration - 改变显示形式（背景颜色、北京图片、边框、圆角、阴影）
      // https://www.jianshu.com/p/ba7eb561ba17
      // https://blog.csdn.net/u014112893/article/details/107819564
      decoration: const BoxDecoration(
        // 背景颜色
        // 1>.不可以与外层color一起使用
          color: Colors.pink,
          // 背景图片
          image: DecorationImage(
            // NetworkImage('')
              image: AssetImage(''),
              fit: BoxFit.contain
          ),
          // 边框
          // 2.不可以只设置一个边框，然后取设置其他的圆角（A borderRadius can only be given for a uniform Border.）
          border: Border(
              top: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              ),
              left: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              ),
              right: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              ),
              bottom: BorderSide(
                  color: Colors.yellow,
                  width: 2.5,
                  style: BorderStyle.solid
              )
          ),
          // 设置圆角
          // borderRadius: BorderRadius.all(Radius.circular(5.0))
          // BorderRadius.vertical(top: Radius.circular(25.0), bottom: Radius.zero)
          borderRadius: BorderRadius.only(topLeft: Radius.circular(25.0)),
          // 设置阴影
          // 可以设置多个阴影叠加
          boxShadow: [
            BoxShadow(
              // 阴影颜色
                color: Colors.green,
                // 阴影偏移量：X轴左移20，Y轴上移20
                offset: Offset(-20, -20),
                // 模糊半径
                blurRadius: 10,
                // 延伸半径
                spreadRadius: 10
            )
          ],
          // 设置渐变背景色
          // LinearGradient - 线性渐变
          // RadialGradient - 放射渐变
          // SweepGradient - 扫描渐变
          gradient: LinearGradient(
              colors: [Colors.red, Colors.yellow, Colors.green],
              // 起点位置
              stops: [0.1, 0.3, 0.5]
          )
      ),
      child: InkWell(
        // 防止InkWell超出
        // 1>.让Ink和InkWell的大小一致
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(25.0)),
        // 单击事件
        onTap: () {},
        // 双击事件
        onDoubleTap: () {},
        // 长按事件
        onLongPress: () {},
        onTapDown: (isTapDown) {},
        // 点击取消
        onTapCancel: () {},
        onFocusChange: (isFocusChange) {},
        onHighlightChanged: (isHighlightChanged) {},
        onHover: (isHover) {},
        focusColor: Colors.pink,
        hoverColor: Colors.pink,
        highlightColor: Colors.pink,
        child: const Center(
            child: Text(
                '登录',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w700
                )
            )
        )
      )
  );

  // 脚手架Scaffold
  // 给界面提供基本的结构：有导航栏的页面需要
  final _scaffold = Scaffold(
      // 导航栏
      // https://blog.csdn.net/qq_40638618/article/details/112466293
      // PreferredSize
      appBar: AppBar(
        // 背景颜色
        backgroundColor: Colors.white,
        // 导航栏底部阴影
        elevation: 0,
        // 左边按钮
        leading: Image.asset(
            'assets/appBarItem/shop_appbar_back.png',
            width: 15,
            height: 15,
            color: Colors.black
        ),
        // 中间文字
        title: const Text(
          '登录',
          // 兼容Android
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0
          ),
        ),
        // 右边按钮
        actions: [
          // Avoid unnecessary containers. - 避免不必要的容器
          Container(
              padding: const EdgeInsets.only(right: 20.0),
              child: const Center(
                  child: Text(
                      '注册账号',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0
                      )
                  )
              )
          ),
          IconButton(
              onPressed: () {
              },
              icon: const Icon(Icons.saved_search)
          )
        ],
        // 底部显示
        // tabLayout+viewpager+fragment
        // TabBar/TabBarView滚动视图：标签栏替代
        bottom: const TabBar(
          tabs: [
            Tab(icon: Icon(Icons.ice_skating))
          ],
        ),
      ),
      // 一般直接放置一个布局
      body: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '账号',
              style: TextStyle(
                  backgroundColor: Colors.pink
              ),
            ),
            Text(
              '密码',
              style: TextStyle(
                  backgroundColor: Colors.pink
              ),
            ),
            Text(
              '登录',
              style: TextStyle(
                  backgroundColor: Colors.pink
              ),
            )
          ]
      ),
      // // 悬浮按钮
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //   },
      //   // 背景色
      //   backgroundColor: Colors.yellow,
      //   child: const Icon(
      //       Icons.add,
      //       color: Colors.black,
      //       size: 40
      //   ),
      // ),
      floatingActionButton: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Colors.white
        ),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.yellow,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // 抽屉（侧滑显示）
      // 关闭抽屉：Navigator.pop(context)
      drawer: const Drawer(
          child: Text('侧边栏')
      ),
      // 右侧侧边栏
      endDrawer: const Drawer(
        child: Text('右侧侧边栏'),
      ),
      // 底部状态栏
      // 参考shop_app_page.dart
      /*
      UITabBar处理方案：
      1>.Scaffold-bottomNavigationBar-items
      2>.DefaultTabController-Scaffold-Container-TabBar-Tab/TabBarView
      */
      bottomNavigationBar: BottomNavigationBar(
        // 当前位于第几个
          currentIndex: 0,
          // xxx
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: Colors.pink,
          unselectedItemColor: Colors.black,
          items: [
            BottomNavigationBarItem(
                label: '首页',
                icon: Image.asset(
                    'assets/bottomNavigationNarItem/home_normal.png',
                    width: 23,
                    height: 23
                ),
                activeIcon: Image.asset(
                    'assets/bottomNavigationNarItem/home_active.png',
                    width: 23,
                    height: 23
                )
            ),
            BottomNavigationBarItem(
                label: '9.9包邮',
                icon: Image.asset(
                    'assets/bottomNavigationNarItem/jiujiu_normal.png',
                    width: 23,
                    height: 23
                ),
                activeIcon: Image.asset(
                    'assets/bottomNavigationNarItem/jiujiu_active.png',
                    width: 23,
                    height: 23
                )
            ),
            BottomNavigationBarItem(
                label: '分类',
                icon: Image.asset(
                    'assets/bottomNavigationNarItem/classify_normal.png',
                    width: 23,
                    height: 23
                ),
                activeIcon: Image.asset(
                    'assets/bottomNavigationNarItem/classify_active.png',
                    width: 23,
                    height: 23
                )
            ),
            BottomNavigationBarItem(
                label: '动态',
                icon: Image.asset(
                    'assets/bottomNavigationNarItem/dynamic_normal.png',
                    width: 23,
                    height: 23
                ),
                activeIcon: Image.asset(
                    'assets/bottomNavigationNarItem/dynamic_active.png',
                    width: 23,
                    height: 23
                )
            ),
            BottomNavigationBarItem(
                label: '我的',
                icon: Image.asset(
                    'assets/bottomNavigationNarItem/my_normal.png',
                    width: 23,
                    height: 23
                ),
                activeIcon: Image.asset(
                    'assets/bottomNavigationNarItem/my_active.png',
                    width: 23,
                    height: 23
                )
            )
          ],
          onTap: (index) {
          }
      )
  );

  // MaterialApp
  // https://www.jianshu.com/p/9af4a89f56dd
  final _materialApp = const MaterialApp(
    // 程序进入以后的第一个界面
    home: Scaffold(),
  );

  // 线性布局Row - Flex子类
  final _row = Row(
    /*
    MainAxisAlignment.start - 将子控件放在主轴的开始位置
    MainAxisAlignment.end - 将子控件放在主轴的结束位置
    MainAxisAlignment.center - 将子控件放在主轴的中间位置
    MainAxisAlignment.spaceBetween - 将主轴空白位置进行均分，排列子元素，首尾没有空隙
    MainAxisAlignment.spaceAround - 将主轴空白区域均分，使中间各个子控件间距相等，首尾子控件间距为中间子控件间距的一半
    MainAxisAlignment.spaceEvenly - 将主轴空白区域均分，使各个子控件间距相等
    */
    // 主轴是水平
    mainAxisAlignment: MainAxisAlignment.start,
    // 当容器比较大（比子widget大的多）的时候此属性有作用
    crossAxisAlignment: CrossAxisAlignment.start,
    // left to right - 从左到右
    // right to left - 从右到左
    textDirection: TextDirection.ltr,
    mainAxisSize: MainAxisSize.min,
    // 不能换行，不能滚动（如果超出屏幕就报错）
    children: [
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.yellow,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.blue,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.green,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.orange,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      Container(
        width: 100,
        height: 100,
        color: Colors.yellow,
      )
    ],
  );

  // 垂直布局Column - Flex子类
  final _column = Column(
    /*
    MainAxisAlignment.start - 将子控件放在主轴的开始位置
    MainAxisAlignment.end - 将子控件放在主轴的结束位置
    MainAxisAlignment.center - 将子控件放在主轴的中间位置
    MainAxisAlignment.spaceBetween - 将主轴空白位置进行均分，排列子元素，首尾没有空隙
    MainAxisAlignment.spaceAround - 将主轴空白区域均分，使中间各个子控件间距相等，首尾子控件间距为中间子控件间距的一半
    MainAxisAlignment.spaceEvenly - 将主轴空白区域均分，使各个子控件间距相等
    */
    // 主轴是垂直
    mainAxisAlignment: MainAxisAlignment.start,
    // 当容器比较大（比子widget大的多）的时候此属性有作用
    crossAxisAlignment: CrossAxisAlignment.start,
    // left to right - 从左到右
    // right to left - 从右到左
    textDirection: TextDirection.ltr,
    mainAxisSize: MainAxisSize.min,
    // 不能换行，不能滚动（如果超出屏幕就报错）
    children: [
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      // 扩充组件Expanded
      // 剩下的区域都是该控件
      Expanded(
        flex: 1,
        child: Container(
          width: 100,
          color: Colors.yellow,
        ),
      ),
      Expanded(
        flex: 2,
        child: Container(
          width: 100,
          color: Colors.blue,
        ),
      )
    ],
  );

  // 弹性布局Flex
  // 允许子控件按照一定比例来分配父控件空间
  // 可以使用Flex的地方基本都可以使用Row、Column
  final _flex = const Flex(
    // Axis.horizontal - Row
    // Axis.vertical - Column
      direction: Axis.vertical
  );

  // 层叠布局Stack/IndexedStack
  // https://www.jianshu.com/p/387d730cbe92
  final _stack = Stack(
    // Stack与"子控件中最大的控件"大小保持一致，所以"子控件中最大的控件"一直位于topLeft，"其他子控件"按照该属性布局
    // topStart topCenter topEnd
    // CenterStart center centerEnd
    // bottomStart bottomCenter bottomEnd
    alignment: AlignmentDirectional.topCenter,
    children: [
      Container(
        width: 100,
        height: 100,
        color: Colors.red,
      ),
      Container(
        width: 90,
        height: 90,
        color: Colors.yellow,
      ),
      Container(
        width: 180,
        height: 180,
        color: const Color.fromARGB(0, 125, 125, 125),
      )
    ],
  );

  final _positionedStack = Stack(
    // expand表示子控件和Stack一样大（即使子控件已经定义宽高也无效）
      fit: StackFit.loose,
      // bottomEnd - bottom表示子控件和Stack底部对齐、End表示子控件和Stack右边对齐
      // topStart topCenter topEnd
      // CenterStart center centerEnd
      // bottomStart bottomCenter bottomEnd
      alignment: AlignmentDirectional.topCenter,
      // 从左到右
      // 从下到上
      children: [
        // 绝对布局Positioned
        // Stack一般配合Positioned
        Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            )
        ),
        Positioned(
            top: 200,
            left: 100,
            child: Container(
              width: 90,
              height: 90,
              color: Colors.yellow,
            )
        )
      ]
  );

  final _card = Card(
    child: Column(
      children: [
        ListTile(
          leading: const Icon(
              Icons.abc
          ),
          title: const Text('这是第一行'),
          onTap: () {
          },
        ),
        ListTile(
          leading: const Icon(
              Icons.abc
          ),
          title: const Text('这是第二行'),
          onTap: () {
          },
        ),
        ListTile(
          leading: const Icon(
              Icons.abc
          ),
          title: const Text('这是第三行'),
          onTap: () {
          },
        )
      ],
    ),
  );

  // 流式布局Wrap
  // 自动换行
  final _wrap = const Wrap(
    // 子控件水平之间的距离
    spacing: 10,
    // 子控件竖直之间的距离
    runSpacing: 10,
    // 纵轴显示
    direction: Axis.vertical,
    /*
    WrapAlignment.start - 将子控件放在主轴的开始位置
    WrapAlignment.end - 将子控件放在主轴的结束位置
    WrapAlignment.center - 将子控件放在主轴的中间位置
    WrapAlignment.spaceBetween - 将主轴空白位置进行均分，排列子元素，首尾没有空隙
    WrapAlignment.spaceAround - 将主轴空白区域均分，使中间各个子控件间距相等，首尾子控件间距为中间子控件间距的一半
    WrapAlignment.spaceEvenly - 将主轴空白区域均分，使各个子控件间距相等
    */
    alignment: WrapAlignment.spaceEvenly,
    runAlignment: WrapAlignment.center,
    children: [
      Text('第一行'),
      Divider(),
      Text('第二行'),
      Divider(),
      Text('第三行'),
      Divider(),
      Text('第四行'),
      Divider(),
      Text('第五行'),
      Divider(),
      Text('第六行'),
      Divider(),
      Text('第七行'),
      Divider(),
      Text('第八行'),
      Divider()
    ],
  );
}
// 1>.自定义异常
class CustomException implements Exception {
  String msgError() => 'Amount should be greater than zero';
}

// 17.类
// 1>.概述：dart语言是一门面向对象的语言（支持面向对象编程）
// 2>.特点：封装、继承（dart不支持多继承，只支持多重继承/子类可以继承父类除构造函数以外的所有属性和函数）、多态
class WidgetPositionPage extends FutureDonew {
  // 3>.成员变量：dart自动给成员变量提供隐式的`getter`和`setter`方法
  dynamic firstName; // 未init的实例变量的值null
  String lastName = 'xy';
  
  // 静态成员变量
  static int age = 12;
  // 私有成员变量（'_'表示私有）
  // dart语言没有public、protected、private
  final String _method = 'hello world';

  // 私有方法
  void _show() {
    print(_method);
  }

  // setter方法
  set testName(String firstName) {
    this.firstName = firstName;
  }

  // getter方法
  String get testName {
    // 此处可以省略this
    return firstName;
  }

  // 构造函数：不能继承于父类
  // 1>.普通构造函数
  WidgetPositionPage() {
    firstName = 'xwj';
  }

  // 2>.命名构造函数
  WidgetPositionPage.nameConst() {
    // 因为此处没有同名的属性，所以可以省略this
    // this表示引用类的当前实例
    firstName = 'xwj';
  }

  // 3>.调用父类
  WidgetPositionPage.alone() : super();

  // 4>.对象方法：需要对象调用
  void disTest() {
    // 状态 - 描述对象
    // 行为 - 描述对象可以执行的操作
    // 标识 - 将对象与一组类似对象区分开来的唯一值
    // 0>.super：直接调用父类方法
    super.getData();
    // 1>.实例化WidgetPositionPage
    WidgetPositionPage w1 = new WidgetPositionPage();
    // new可以省略
    WidgetPositionPage w2 = WidgetPositionPage();
    WidgetPositionPage w3 = WidgetPositionPage.nameConst();
    // 2>.调用成员变量
    w1.firstName = 'xwj';
    // 3>.调用对象函数
    w1._show();
    // 4>.调用静态函数
    WidgetPositionPage.disTestPage();
  }

  // 5>.静态方法：需要类名调用
  static void disTestPage() {
    print('TestPage');
  }
}

// 18.抽象类和接口
// dart语言中没有专门声明接口的语法（和抽象类共用一套代码）
// https://www.cnblogs.com/johu/p/15704153.html
abstract class Massage {
  // 抽象方法不能用abstract声明
  // 没有方法体的方法就是抽象方法
  void doMassage();

  void show() {
    print('我是普通方法');
  }
}
// 抽象类：使用extends实现抽象类
// 必须实现抽象方法
class SexMassage extends Massage {
  @override
  void doMassage() {
    print('脚底按摩');
  }
}
// 接口：使用implements实现接口
class FootMassage implements Massage {
  @override
  void doMassage() {
    print('脚底按摩');
  }

  @override
  void show() {
    // 如果抽象类中有普通方法可以使用extends
    // 如果抽象类中没有普通方法可以使用implements
  }
}

// 19.mixins：重复使用类中代码的方式
class A {
  void funA() {}
}
class B {
  void funB() {}
}
class C = A with B;

// 20.异步操作：https://blog.csdn.net/yuzhiqiang_1993/article/details/89155870
class FutureDonew {
  // 1>.因为flutter基于dart语言（在一个线程中运行）开发，因此flutter也是单线程模型（flutter没有多线程的概念）
  // 2>.flutter对异步的操作不能像'原生iOS开发'一样利用多线程处理（flutter怎么处理异步操作？）
  /*
  Future对象：表示异步操作的结果/通常使用then()来处理返回结果
  async：表明函数是一个异步函数/返回类型是Future类型
  await：等待耗时操作的返回结果，这个操作会阻塞
  */
  /*
  a.首先判断‘getData()’函数是不是一个异步函数？如果是需要加上‘async’
  b.因为加上‘async’，所以返回值为‘Future<T>’
  c.‘await’表示需要等待耗时操作返回（阻塞）
  */
  Future<String> getData() async {
    // 第一种写法
    getData().then((value) {
      // 接口返回数据
      // value == Future<String>
    }).whenComplete(() {
      // 异步任务处理完成
    }).catchError((obj) {
      // 出现异常
    });
    // 第二种写法
    String msg = await getData();
    return msg;
  }
}

// 21.跨平台解决方案
// 1>.Web/Hybrid - 基于web相关技术来实现界面和功能/UI性能差，功能性api缺失 - cordova
// 2>.jsCore - 通过虚拟Dom树来构建UI，映射成原生UI组件，通过jsCore桥接调用原生服务/UI性能一般，开发体验差 - React Native/Weex
// 3>.Native - 将某个语言编译成二进制文件，生成动态库，打包成apk和iap/UI性能好，开发体验较好 - flutter

// 22.flutter概述
// 1>.概念：flutter是google开发的移动UI框架，可以快速的在iOS/Android上构建高质量的原生用户界面
// 2>.特点：flutter可以与现有的代码一起工作｜flutter是完全免费、开源的 | dart语言无法直接调用Android系统提供的Java接口，需要使用flutter插件来实现中转
// 3>.兼容：android/iOS/linux/macos/web/windows
// 4>.开发电脑选择：mac(windows不能开发iOS)
// 5>.IDE选择：Android Studio > VsCode

// 23.flutter环境搭建
/*
一.flutter环境准备
1>.打开官网https://flutter.io
2>.点击Docs -> 点击Get Started -> 选择macOS
3>.下载flutterSDK（以后flutter升级直接可以用命令行）
4>.将下载完成的flutterSDK放在某个位置（例如：/Applications/flutter）
二、开始配置环境变量
1>.vim ~/.bash_profile（.zshrc）
2>.写入以下语句
'''
// 配置环境变量
export PATH=/Applications/flutter/bin:$PATH
// 针对国内用户 - 设置Flutter临时镜像（随时可以会换）
export FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
export PUB_HOSTED_URL=https://pub.flutter-io.cn
'''
3>.source ~/.bash_profile
4>.flutter doctor #检测flutter环境
5>.在iOS上配置环境 - 下载Xcode/安装git/安装CocoaPods
6>.Android Studio - Preferences - Plugins(下载Dart插件/Flutter插件)
 */
// 注意点
// 1>.shift + command + p - 打开控制器面板
// 2>.运行flutter项目之前可以使用“flutter doctor”命令行检测一下
// 3>.？？？怎么升级flutterSDK？？？1.终端输入flutter upgrade/2.直接下载flutterSDK覆盖
// 4>.Using Flutter in China - https://flutter.dev/community/china
// 5>.VSCode新建项目命令 - xxx是项目名称，必须小写
// flutter create -i swift -a kotlin xxx
// 6>.将项目导入到AS
// 将flutter项目导入AS中会自动引导AS安装Dart插件/Flutter插件
// 7>.flutter run - 运行项目
// 8>.flutter run -d 'iphone X' - 利用iphone X运行项目

// 24.flutter连接安卓模拟器
// touch .bash_profile
// open -e .bash_profile
// export PATH=/Users/xiewujun/Library/Android/sdk/platform-tools/:$PATH
// cd /Users/xiewujun/Library/Android/sdk/platform-tools
// adb connect 127.0.0.1:7555

// 25.flutter项目文件
/*
flutter_donew - projectName（必须小写）
  .dart_tool - 工具包
  .idea - 环境配置
  android - 安卓包工程文件：原生代码
  ios - iOS包工程文件：原生代码
  lib - 主要工程目录（dart源文件）/可以包含其他资源文件（很重要）
  test - 测试相关文件
  .gitignore - 忽略文件
  .metadata - 元信息
  .packages - 包信息
  pubspec.lock - xxx
  pubspec.yaml - 项目依赖配置文件（很重要）
  README.md - 相关介绍文档
 */

// 26.归档资源
// 1>.Android中将resources和assets区别对待，iOS中将images和assets区别对待
// 2>.flutter中认为所有的资源都会被作为assets对待
// 3>.flutter中的assets文件夹可以是任意文件夹（只要在pubspec.yaml中声明）
/*
// pubspec.yaml中怎么声明图片
assets:
# 这里只需要声明一个就行
- images/dm_main_logo.png
// 项目中怎么使用该图片
Image.asset(images/dm_main_logo.png);
*/
// flutter中如何处理不同分辨率：与iOS一致遵循一个简单的基于像素密度的格式

// 27.flutter中如何添加项目所需依赖（封装一组编程单元的机制）
// 1>.任何语言都会提供一种方式来引入第三方软件库
// 2>.在Android中可以使用Gradle文件来添加依赖项，在iOS中通常把依赖项添加到Podfile中
// 3>.flutter使用dart构建系统和pub包管理器来处理依赖
/*
// pubspec.yaml中怎么声明依赖
dependencies:
  flutter:
    sdk: flutter
  google_sign_in: ^3.0.3
  Dio: ">=2.1.0 <3.1.0"
  */
/*
1.虽然flutter项目中的Android文件夹下有一个Gradle文件，但是只有在添加平台相关所需要的依赖关系时才使用这些文件。否则应该使用pubspec.yaml来声明用于flutter的外部依赖项
2.如果flutter项目中的iOS文件夹下有Podfile文件，但是只有在添加平台相关所需要的依赖关系时才使用这些文件。否则应该使用pubspec.yaml来声明用于flutter的外部依赖项
3.在pubspec.yaml中写上需要下载的第三方库 -> 然后选中pubspec.yaml -> 最后Get Packages
 */
/*
1>.pub get - 获取App所依赖的所有包
2>.pub upgrade - 将所有依赖项升级到较新版本
3>.pub build - 用于构建您的Web应用程序
4>.pub help - 将提供所有pub命名帮助
 */

// 28.flutter打包
// https://www.jianshu.com/p/77a0342ea94c
// 安卓打包：flutter build apk
// iOS打包：通过Xcode配置证书直接打包