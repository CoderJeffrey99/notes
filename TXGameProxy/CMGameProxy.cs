// https://github.com/Y-Dian/LearnXinYminutes/blob/master/learncsharp-cn.cs
// 任何c#语言的第一句都是这个：using关键字表示导入System这个namespace
// 可以包含多个using语句
using System;

/*
C#/C-Sharp概述
1>.C#是一门简单的、现代的、面向对象的、类型安全的、面向组件的、结构化编程语言
2>.C#是由“Microsoft微软”开发的、使用“Visual Studio”编写的语言
3>.C#以.cs后缀：类名和文件名可以不同（如果文件名和类名不同则需要给类创建一个namespace）、严格区分大小写
*/

// 命名空间：类似于java中的包（类的集合）
// >>一个文件中可以有多个命名空间：每个命名空间中声明的类的名称不能相同、不同命名空间中声明的类的名称可以相同
// >>C#命名规则：命名空间、类、方法、接口首字母必须大写
// >>我们一般考虑在namespace内部创建类
namespace CMGameproxy
{
    /**
     * 定义一个类
     * @param class 定义类的关键字
     * @param CMGameProxy 类的名称
     */
    public class CMGameProxy
    {
        /**
         * 程序入口：程序执行从Main方法开始
         * @param static 静态方法：可以直接调用
         * @param void 没有返回值
         * @param Main 方法名（必须大写）
         */
        static void Main(string[] args)
        {
            // 单行注释
            /* 多行注释 */
            /**
             * 文档注释
             */

            // System是命名空间：导入System就可以省略前缀
            //System.Console.WriteLine("Hello World");
            Console.WriteLine("Hello World"); // C#的每条语句必须有";"结尾

            // 标识符
            // 由“数字、字母、_、@”表示，数字不能开头（严格区分大小写）
            // 约定：方法、接口首字母大写

            // 关键字：不能使用关键字做为标识符、“@关键字”可以做为标识符

            // 变量
            // 1>.概念：程序运行过程中其值可以改变的量，用于存储数据
            // 2>.特点：变量必须先声明 -> 初始化 -> 使用
            // 3>.数据类型：与java基本一致、支持指针
            // a.基本数据类型
            byte a1 = 10;
            short a2 = 10;
            int a3 = 10;
            long a4 = 10L;
            float a5 = 10.3F;
            double a6 = 10.3;
            char a7 = 'a';
            // b.对象类型
            Object obj1 = new Object();
            // c.动态类型：类型检查发生在运行时
            dynamic a8 = 20;
            // d.字符串类型
            // string和String完全一样
            string a9 = "xwj";
            String a10 = "xwj";
            // 逐字字符串：把转义字符当作普通字符看待
            string a11 = @"xwj\ncfj";
            // e.布尔类型
            // bool和Boolean完全一样
            bool s1 = true;
            Boolean s2 = false;

            // 类型转换
            // 1>.隐式转换：较小范围的数据类型转换为较大范围的数据类型：编译器自动完成、安全、不会导致数据丢失
            byte a12 = 10;
            int a13 = a12;
            // 2>.显式转换（强制类型转换）：较大范围的数据类型转换为较小范围的数据类型：会造成数据丢失
            byte a14 = (byte)a13;

            // 常量
            // 1>.概念：程序运行过程中其值不会改变的量，用于存储数据
            // C#使用const修饰常量
            const string a15 = "taobao";
            const int a16 = 10;
            const double PI = 3.14;

            // 运算符
            // 1.算术运算符
            int b1 = 10;
            int b2 = 20;
            int b3;
            b3 = b1 + b2;
            b3 = b1 - b2;
            b3 = b1 * b2;
            b3 = b1 / b2;
            b3 = b1 % b2;
            b3 = b1++;
            b3 = b2--;
            // 2.关系运算符
            bool b4;
            b4 = b1 == b2;
            b4 = b1 != b2;
            b4 = b1 > b2;
            b4 = b1 < b2;
            b4 = b1 >= b2;
            b4 = b1 <= b2;
            // 3.逻辑运算符
            b4 = (b1 == b2) && (b1 < b2);
            b4 = (b1 == b2) || (b1 < b2);
            b4 = !(b1 <= b2);
            // 4.位运算符：操作二进制
            b3 = b1 & b2;
            b3 = b1 | b2;
            b3 = b1 ^ b2;
            b3 = ~b1;
            b3 = b1 << 2;
            b3 = b1 >> 2;
            // 5.赋值运算符
            b3 = b1;
            b3 += b1; // b3 = b3 + b1
            b3 -= b1; // b3 = b3 - b1
            b3 *= b1; // b3 = b3 * b1
            b3 /= b1; // b3 = b3 / b1
            b3 %= b1; // b3 = b3 % b1
            b3 <<= b1; // b3 = b3 << b1
            b3 >>= b2; // b3 = b3 >> b1
            b3 &= b2; // b3 = b3 & b1
            b3 ^= b2; // b3 = b3 ^ b1
            b3 |= b2; // b3 = b3 | b1
            // 6.sizeof()返回数据类型的大小
            int b5 = sizeof(int); // 4
            // 7.typeof()返回class的类型
            Console.WriteLine(typeof(Object));
            // 8.is判断对象是否为某一类型
            Object obj = new Object();
            if (obj is Car)
            {
                // 9.as强制转换：转换失败也不会抛出异常
                Car c1 = obj as Car;
            }

            // 条件语句
            // if语句
            if (s1)
            {

            }
            // if...else语句
            if (s1)
            {

            }
            else
            {

            }
            // if嵌套
            if (s1)
            {
                if (s2)
                {

                }
            }
            // switch语句
            // a1支持“整型、枚举”
            switch (a1)
            {
                case 1:
                    {

                    }
                    break;
                case 2:
                    {

                    }
                    break;
                case 3:
                case 4:
                    {

                    }
                    break;
                default: break;
            }
            // 三元运算符
            int b6 = s1 ? 60 : 100;


            // 循环语句
            // while循环
            while (s1)
            {

            }
            // do...while
            do
            {

            } while (s1);
            // for循环
            for (int index = 0; index < 100; index++)
            {
                //continue; // 结束本次循环，开始再次循环
                //break; // 跳出循环：开始执行后续语句
                //return; // 直接结束：后续语句也不再执行
            }
            // foreach循环
            int[] marks = new int[] { 10, 20, 23, 25, 28 };
            foreach (int sum in marks)
            {

            }
            // 循环嵌套
            for (int i = 0; i < 100; i++)
            {
                for (int j = 0; j < 100; j++)
                {
                }
            }
            // 死循环
            /*
            while (true)
            {
            }
            do
            {
            } while (true);
            for (; ; )
            {
            }*/

            // 可空类型：类似swift中的可选类型
            // 1>.概念：可以为其分配正常范围的值以及null
            int? b7 = null;
            int? b8 = 45;
            //int b9 = b8; // 类型不一致
            int b10 = b8 ?? 45;

            // 数组
            // 1>.概念：一种存储相同类型元素的固定大小顺序集合
            // 2.定义数组
            // >>第一种方式
            int[] array1 = new int[10];
            array1[0] = 10;
            array1[1] = 20;
            // >>第二种方式
            int[] array2 = { 10, 20, 23, 25, 28 };
            // >>第三种方式
            int[] array3 = new int[5] { 10, 20, 23, 25, 28 };
            // >>第四种方式
            int[] array4 = new int[] { 10, 20, 23, 25, 28 };
            int[] score = array4;
            // 3.访问数组元素
            int b11 = array4[2];
            // 4.遍历数组 
            for (int index = 0; index < array4.Length; index++)
            {

            }
            foreach (int index in array4)
            {

            }

            // 字符串
            string fname, lname;
            fname = "Rowan";
            lname = "Atkinson";
            string name = fname + lname;
            // 字符数
            int b12 = name.Length;
            // 判断字符串是否相等
            fname.Equals(lname);
            if (String.Compare(fname, lname) == 0)
            {
                // 比较两个指定字符串对象
                String.Concat(fname, lname);
            }
            if (fname.Contains("test"))
            {
                // fname是否包含test字符串
            }
            // 连接字符串
            String[] strings = new string[] { "xie", "wu", "jun" };
            String.Join(",", strings);
            // 去掉字符串
            fname.Trim();
            fname.IndexOf('t');

            // C#中的Map（Dictionary）
            Dictionary<string, int> dict = new Dictionary<string, int>();
            // 添加键值对
            dict["key1"] = 123;
            dict.Add("key2", 456);
            // 获取值
            Console.WriteLine(dict["key1"]);
            if (dict.ContainsKey("key1"))
            {
                // key1是否存在
            }
            // 修改值
            dict["key1"] = 789;
            // 删除键值对
            dict.Remove("key1");
            // 获取Dictionary的大小
            int count = dict.Count;
            // 遍历
            foreach (var key in dict.Keys)
            {
                
            }
            foreach (var value in dict.Values)
            {
                
            }
            foreach (KeyValuePair<string, int> item in dict)
            {
                
            }


            // 结构体
            Person p = new Person("xwj", 18);
            p.GetDetails();

            int today = (int)Days.Mon;
            foreach (Days day in Enum.GetValues(typeof(Days)))
            {
                // 遍历枚举
                today = (int)day;
            }
            int b13 = (int)Days.Mon;

            Car car = new Car();
            car.name = "xwj";
            car.age = 18;
            car.GetPerson();

            // 运算符重载
            // 第26章

            // 异常（程序执行期间出现的问题）处理
            try
            {
                // 引起异常的语句
            }
            catch (Exception e)
            {
                // 异常处理
                throw e; // 抛出异常
            }
            finally
            {
                // 必须执行的语句
            }

            // 抽象类和接口

            // C#文件操作

            // C#集合
            // 1>.动态数组ArrayList
            // 2>.哈希表Hashtable
            // 3>.排序列表SortedList
            // 4>.堆栈Stack
            // 5>.队列Queue
            // 6>.点阵列BitArray

            // C#泛型

            // 多线程Thread
        }

        // 方法
        /*
        访问修饰符 returnType methodName(参数1, 参数2, 参数3) {

        }
        */
        // 值传递：形参的值发生改变时，不会影响实参的值（默认都是值传递）
        // 引用传递：当形参的值发生改变时，同时会改变实参的值（使用ref关键字可以让值传递->引用传递）
        // 输出参数：可以返回多个值
        public string GetDetails(ref int s1, int s2)
        {
            return "";
        }
    }

    // 结构体
    // >>类和结构体的区别
    // 1>.类是引用类型，结构体是值类型
    // 2>.结构体不支持继承
    // 3>.结构体不能声明默认的构造函数
    struct Person
    {
        public string name;
        public int age;

        // 可以定义方法
        public void GetDetails()
        {
        }

        // 可以定义构造函数
        public Person(string name, int age)
        {
            this.name = name;
            this.age = age;
        }

        // 不可以定义析构函数
    }

    // 枚举：值类型
    // 默认情况下：第一个枚举符号的值是0
    enum Days { Sun, Mon, Tue, Wed, Thu, Fri, Sat };

    // C#不支持多继承：可以实现interface实现多继承
    // >>继承使用":"
    class Car : CMGameProxy
    {
        // 访问权限修饰符
        // public - 所有对象都可以访问
        // internal - 同一个程序集的对象可以访问：类的默认访问权限
        // protected - 该类及其子类可以访问
        // private - 该类内部可以访问：成员的默认访问权限
        public string name; // 成员变量
        public int age;
        public static readonly int height = 180; // 静态变量

        // 支持setting和getting方法
        // 不支持setting和getting方法的语言我们可以手动创建setting和getting方法
        public void SetName(string name)
        {
            this.name = name;
        }

        public string GetName()
        {
            return this.name;
        }


        // 构造方法：与java完全一致
        public Car()
        {
        }

        public Car(string name, int age)
        {
            this.name = name;
            this.age = age;
        }

        // 成员方法
        public void GetPerson()
        {

        }
        // 静态方法
        public static void ShowDetails()
        {

        }

        ~Car()
        {
            // 析构函数：结束程序之前释放资源（比如关闭文件、释放内存）
            // 析构函数不能继承或重载
        }
    }
}