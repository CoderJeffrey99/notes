### 所有语言
1.标识符：由“字母、数字、_”组合而成，并且不能以数字开头 ｜ 不能把关键字和保留字作为标识符 ｜ 严格区分大小写
2.变量：必须先声明、再init、再使用 ｜ 成员变量默认已经init

### C语言
1.printf("hello world");  // 第一行代码：必须以";"结尾
2.支持“自动类型转换（大类型 -> 小类型）”：可能会损失精度（Java语言不支持这种情况）
3.支持自增++、自减--
4.布尔类型bool：非0既真
5.switch语句：支持、value支持int/枚举、支持break
































### Objective.C语言
1.
2.支持“自动类型转换（大类型 -> 小类型）”：可能会损失精度
3.自增++自减--：支持
5.布尔类型BOOL：非0既真
9.switch语句：支持、value支持int/枚举、支持break

### Swift语言

### Java语言
1.System.out.println("hello world"); // 第一行代码：必须以";"结尾
2.注释：支持单行注释、多行注释、文档注释
3.字符串：""表示String、''表示char...有区别
4.Java是强类型语言：类名和文件名必须一致
5.布尔类型boolean：没有非0既真、没有明确的大小
6.自增++自减--：支持
7.全等于===：不支持
8.if语句：支持
9.switch语句：支持、value支持int/枚举/String、支持break
10.变量定义：int/double/String name = xxx;
11.常量定义：final int/double/String name = xxx;
12.类型转换：支持自动类型换转、强制类型转换int a = (int)b;

### Groovy语言

### Kotlin语言

### Dart语言

### C#语言
1.Console.WriteLine("hello world"); // 第一行代码：必须以";"结尾
2.注释：支持单行注释、多行注释、文档注释
3.字符串：""表示String、''表示char...有区别、string和String完全一样（推荐使用string）
4.C#是强类型语言：类名和文件名可以不一致（给类创建一个namespace即可）
5.布尔类型：bool和Boolean完全一样（推荐使用bool）
6.自增++自减--：支持
7.全等于===：不支持
8.if语句：支持
9.switch语句：支持、value支持int/枚举、支持break
10.变量定义：int/double/String name = xxx;
11.常量定义：const int/double/String name = xxx;
12.类型转换：支持自动类型换转、强制类型转换int a = (int)b;
13.可选类型：支持可空类型（可选类型）

### js语言

### ts语言

### ArKTS语言

### python语言

### Go语言

### rust语言

### Groovy
1.println("hello world") // 第一行代码：可以不以";"结尾
2.注释：支持单行注释、多行注释、文档注释
3.字符串：""表示String、''表示String...没有区别
10.变量定义：int/double/String name = xxx|def name = "xwj" // 支持类型推导
13.println("你的姓名：$name") // 万能拼接符号
14.def array = [1, 3, 3] // 数组定义
15.xxx
16.def map = [red: "#FF0000", green: "#00FF00"] // 映射定义

### JavaScript
1.console.log("hello world"); // 第一行代码：可以不以";"结尾
2.注释：支持单行注释、多行注释、文档注释
3.字符串：""表示String、''表示String...没有区别
4.JavaScript是弱类型语言
5.布尔类型bool：任何数据类型都可以转换成布尔类型bool
10.变量定义：var name = xxx;
11.常量定义：var name = xxx;
12.类型转换：xxx


4>.数据类型关键字
 - 基本数据类型关键字
 void - 无返回值类型
 char - 字符串数据（整型的一种）
 int - 整型
 float - 单精度浮点型
 double - 双精度浮点型
 - 类型修饰
 short - 短整型数据
 long - 长整型数据
 signed - 有符号整型数据
 unsigned - 无符号整型数据
 - 复杂类型
 struct - 结构体
 union - 共用体
 enum - 枚举
 typedef - 声明类型的别名
 sizeof - 特定类型/特定类型变量的大小
 - 存储级别
 auto - xxx
 static - 静态变量
 register - xxx
 extern - 指定对应变量为外部变量
 const - 定义常量
 5>.流程控制关键字
 - 跳转结构
 return - 返回（当前方法）
 continue - 结束当前循环，开始下次循环
 break - 跳出当前循环
 goto - 无条件跳转语句
 - 分支结构
 if - xxx
 else - xxx
 switch - xxx
 case - xxx
 default - xxx
 - 循环结构
 for - xxx
 do - xxx
 while - xxx