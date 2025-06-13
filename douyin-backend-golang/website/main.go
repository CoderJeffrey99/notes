package main

import (
	"errors"
	"fmt"
	"math"
	"reflect"
	"sort"
	"strings"
	"unicode/utf8"
)

func main() {
	/*
	1.概述
	a>.go语言全称golang、是google在2017年推出的开发语言（静态类型语言）
	b>.源代码以.go结尾、严格区分大小写
	c>.执行入口是main方法、每条语句后面不需要;、一行只能写一句代码
	d>.定义的变量和import包如果没有被使用会报错
	*/

	// 2.代码风格
	// a>.支持单行注释//、也支持多行注释/**/
	// b>.第一个中括号{只能写在第一行、不能换行
	// c>.标识符：命名规则与其他语言一致
	fmt.Println("Hello, World")
	
	// 3.数据类型
	// a>.整数
	var a int = 10;
	var a1 uint = 10;
	fmt.Printf("有符号的整数：%d......无符号的整数：%d", a, a1)
	// b>.浮点数
	// c>.复数
	// d>.布尔类型
	// e>.字符串类型
	
	// // 4.变量
	// // a>.声明变量（两种方式）
	// // go语言中没有undefined的概念：整数未init就是0、布尔类型未init就是false、字符串未init就是""、接口引用未init就是nil
	// var a2 int // 没有初始化值就必须加上type
	// var a3 = 10 // 有初始化值就类型推导
	// // 可以在同一行上声明多个变量
	// var a4, a5, a6 int = 10, 11, 12
	// var a7, a8, a9 = 10, "xwj", true
	// // b>.短变量声明
	// a10 := "cfj" // 用于声明局部变量
	// a11, a12, a13 := 12, "none", false

	// // 5.常量
	// // a>.数值常量
	// const PI = 3.14
	// // b>.字符串字面量
	// const name = "cainiao"
	// // c>.布尔常量
	// const isShow = true
	
	// 6.运算符
	// a>.算术运算符：+-*/%
	// b>.比较运算符：== != > < >= <=
	// c>.逻辑运算符：&& || !
	// d>.按位运算符：& ｜ ^ << >> &^
	// e>.赋值运算符：= += &= ^= |=
	// f>.杂项运算符P：&变量名（返回变量名的地址）*变量名（提供指向变量的指针）<-（接收：从通道接收值）

	// 7.条件语句：与其他语言一致

	// 8.循环语句
	// a>.第一种
	for index := 0; index < 10; index++ {
		fmt.Println(index)
	}
	// // b>.第二种
	// for {
	// 	// 死循环
	// }
	// c>.第三种
	index := 10;
	for index < 100 {
		index += 10;
	}
	// // d>.遍历字符串的Unicode代码点
	// LrLoop: for index, char := range "abcde" {
	// 	fmt.Printf("%U......%d\n", char, index)
	// 	break // 终止循环
	// 	continue // 终止本次循环，开始下次循环
	// 	goto LrLoop // 跳转到该处
	// }
	// e>.遍历map的键值对
	sMap := map[string]string {
		"key1": "value1",
		"key2": "value2",
		"key3": "value3",
	}
	for key, value := range sMap {
		fmt.Println(key, value)
	}
	// f>.遍历通道上发送的顺序值（直到关闭为止）
	chnl := make(chan int)
	go func() {
		chnl <- 100
		chnl <- 1000
		chnl <- 10000
		chnl <- 100000
	}()
	for index := range chnl {
		fmt.Println(index)
	}

	// 9.类型转换：不支持"自动类型转换"
	// 格式：T(value)
	var avg int
	var salary float32
	avg = int(salary)
	fmt.Println(avg)

	// 10.switch语句
	// a>.变量声明/自增/赋值/函数调用（可选）; 变量（可选）
	switch day := 4; day {
		case 1: {
			fmt.Println("Monday1")
		}
		case 2: {
			fmt.Println("Monday2")
		}
		case 3: {
			fmt.Println("Monday3")
		}
		case 4: {
			fmt.Println("Monday4")
		}
		case 5, 6, 7: {
			fmt.Println("Monday567")
		}
	}
	// 不带可选语句和表达式
	var value int = 2
	switch {
		case value == 1: {

		}
		case value == 2: {
			
		}
		case value == 3: {
			
		}
	}

	// 11.Select语句、deadlock死锁

	// 12.函数
	length := 100
	width := 100
	fmt.Println(area(length, width))
	swap(&length, &width)
	show("1234")
	show("123", "456")
	// 匿名函数
	// a>.直接调用
	func () {
		fmt.Println("123")
	}()
	func (element string) {
		fmt.Println(element)
	}("xwj")
	// b>.赋值给变量
	newFunc := func (age int32) {
		fmt.Println(age)
	}
	newFunc(18)
	// 匿名函数当作参数传递
	newNameFunc("123", "456", oldNameFunc)
	newNameFunc("", "", func (firstName, lastName string) string {
		return firstName + lastName
	});
	// a>.支持返回多个值
	var value1, value2 = newShow(10, 10)
	fmt.Printf("...%d...%d", value1, value2)
	// b>.给返回值命名
	var value3, value4 = oldShow(10, 10)
	fmt.Printf("...%d...%d", value3, value4)
	// 未使用的变量可以用_标识
	var value5, _ = oldShow(10, 10)
	fmt.Printf("...%d", value5)
	// Defer关键字

	// 13.方法Method
	author := Author{
		name: "xwj",
		branch: "Audi",
		salary: 19000,
	}
	author.newShowMethod()
	author.newShowMethodPin("BMW", 50000)

	// 14.结构体：不支持继承、支持组合的轻量类
	var a2 Address
	// 按顺序传递字段
	a3 := Address{"xwj", "sh", 100}
	a4 := Address{name: "xwj", city: "sh", pinCode: 100}
	// 指向结构的指针
	a5 := &Address{"xwj", "sh", 100}
	fmt.Println((*a5).name)
	fmt.Println((*a5).city)
	fmt.Println((*a5).pinCode)
	// 这样也可以
	fmt.Println(a5.pinCode)
	// ==运算符、DeeplyEqual()方法完全一样
	// 类型相同 + 字段值相同 = 返回true
	if a2 == a3 {
		
	} else if reflect.DeepEqual(a4, a5) {
		
	}
	a6 := NewAddress{
		name: "",
		city: "",
		pinCode: 100,
		address: *a5,
		details: func(s string, i int) string {
			return s
		},
	}
	a6.details(a6.city, a6.pinCode)
	if reflect.DeepEqual(a5, a6) {
	}
	// 匿名结构体
	a7 := struct {
		name string
		city string
		pinCode int
	}{
		name: "xwj",
		city: "sh",
		pinCode: 100,
	}
	if reflect.DeepEqual(a5, a7) {
	}
	a8 := OldAddress{"xwj", 100}
	if reflect.DeepEqual(a5, a8) {
	}

	// 15.数组：值类型
	var array1 [3]string
	array1[0] = "xwj"
	array1[1] = "xwj"
	array1[2] = "xwj"
	array2 := [3]string{"xwj", "xwj", "xwj"}
	fmt.Println(array2[0])
	// array3 := [3][3]string{
	// 	{"xwj", "xwj", "xwj"},
	// 	{"xwj", "xwj", "xwj"},
	// 	{"xwj", "xwj", "xwj"},
	// }
	// // 数组长度
	// fmt.Println(len(array3))
	// 数组的长度由初始化的元素确定
	// array4 := [...]string{"xwj", "xwj", "xwj"}
	// fmt.Println(len(array4))
	// // 遍历数组
	// for index := 0; index < len(array4); index++ {
	// 	fmt.Printf("%d", array4[index])
	// }
	// 值传递：修改a8但是a9不变
	a9 := a8;
	// 引用传递：修改a8则a10变化
	a10 := &a8;
	if reflect.DeepEqual(a9, a10) {
	}

	// 16.切片
	var my_slice_1 = []string{"xwj", "xwj", "xwj"}
	// [low:high)
	var my_slice_2 = array1[1:2]
	// 类型 长度 容量
	var my_slice_3 = make([]string, 4, 7)
	// 遍历切片
	for index := 0; index < len(my_slice_1); index++ {
	}
	for index, ele := range my_slice_2 {
		fmt.Printf("...%d...%s", index, ele)
	}
	for _, ele := range my_slice_3 {
		fmt.Printf("...%s", ele)
	}
	// 创建零值切片
	var my_slice_4 []string
	fmt.Println(len(my_slice_4))
	fmt.Println(cap(my_slice_4))
	// 返回true
	if my_slice_4 == nil {
	}
	// my_slice_5 := [][]string{
	// 	{"xwj", "xwj", "xwj"},
	// 	{"xwj", "xwj", "xwj"},
	// 	{"xwj", "xwj", "xwj"},
	// }
	// if my_slice_5 == nil {
	// }
	// 排序
	sort.Strings(my_slice_1)
	// 复制：返回复制的元素总数
	my_slice_6 := copy(my_slice_1, my_slice_2)
	fmt.Println(my_slice_6)

	// 17.字符串：变宽字符序列（使用""）
	// // 字符串可以位空、不能位nil
	// // 不可变
	// var s1 string
	// s1 = "xwj"
	// 可以包含转意义字符
	s2 := "xwj"
	// 不能包含转字符、可以包含除反引号之外的任何字符
	s3 := `xwj`
	// 遍历字符串
	for _, char := range s2 {
		fmt.Println(char)
	}
	for i := 0; i < len(s2); i++ {
		
	}
	// 字符串长度
	if len(s3) == utf8.RuneCountInString(s3) {
		// 比较字符串是否相等
	}
	// s1 == s2 -> 0
	// s1 > s2 -> 1
	// s1 < s2 -> -1
	strings.Compare(s2, s3)
	// 字符串拼接
	// a>.直接使用+
	fmt.Println(s2 + s3)
	s4 := fmt.Sprintf("%s...%s", s2, s3)
	fmt.Println(s4)
	// 在s2末尾拼接s3
	s2 += s3
	// // 拼接
	// s5 := strings.Join(my_slice_1, "-")
	// my_slice_7 := strings.Split(s5, "-")
	// 删除s2指定的前缀和后缀
	s6 := strings.Trim(s2, "$@")
	// 只删除左边
	s7 := strings.TrimLeft(s2, "$@")
	// 只删除右边
	s8 := strings.TrimRight(s2, "$@")
	// 删除前后空格
	s9 := strings.TrimSpace(s2)
	// 删除指定后缀（没有指定后缀原样返回）
	s10 := strings.TrimSuffix(s2, "@^")
	// 删除指定前缀（没有指定前缀原样返回）
	s11 := strings.TrimPrefix(s2, "@^")
	fmt.Printf("%s...%s...%s...%s...%s...%s", s6, s7, s8, s9, s10, s11)
	// 判断字符串是否包含指定字符（串）
	if strings.Contains(s11, "@") {
		if strings.ContainsAny(s11, "") {
			
		}
	}
	// 找不到返回-1...判断第二个参数的首字符在第一个参数的index（包括标点符号和空格）
	// 字符使用''、字符串使用""
	strings.Index(s11, "sk")
	strings.IndexAny(s11, "sk")
	strings.IndexByte(s11, 's')

	// 18.指针
	// a>.概述：指针是一个变量，用于存储另一个变量的内存地址
	// 未init的指针变量为nil
	var s12 *string
	s12 = &s11;
	fmt.Println(s12)
	// 指针作为函数参数
	ptf(&s11)
	// 数组指针和指针数组
	// 指向结构体的指针
	s13 := &a2
	// 结果是一样的
	fmt.Printf("%s...%s", s13.name, (*s13).name)
	// 修改
	s13.name = "xwjxj"
	// // 比较指针大小
	// // 两个指针值只有在它们指向内存中的相同值或都是nil时才相等
	// if s12 == s13 {
		
	// }
	// // 指针容量：返回指向数组的指针的容量
	// cap(s12)
	// // 指针长度：返回指向数组的指针存在的元素总数
	// len(a12)

	// 19.接口：方法的集合
	value6 := Address{
		name: "xwj",
		city: "苏州",
		pinCode: 168,
	}
	var myInterface MyInterface = value6
	myInterface.getCode()
	myInterface.getName()

	// 20.语言通道Channel
	// a>.概述：通道是一种技术（允许一个goroutine将数据发送到另一个goroutine、默认情况下通道是双向的）
	// b>.创建通道
	var my_channel_01 chan string
	my_channel_01 = make(chan string)
	fmt.Println(my_channel_01)

	// 21.并发
	// a>.Goroutine：一种函数或方法
	// 允许在一个程序中创建多个goroutine（同时执行）
	go myInterface.getCode()
	go myInterface.getName()

	// 22.异常处理
	value7, err := Sqrt(10.5)
	if err != nil {
		fmt.Println(value7)
	} else {
		fmt.Println(err)
	}
}

// 函数默认使用值传递
func area(length, width int) int {
	return length * width
}
func ptf(value *string)  {
	*value = "xwj"
}
// 指针作为函数返回值
func rpf() *string {
	s := "xwj"
	return &s
}
// 应用传递
func swap(length, width *int) {
}
// 数组可以做为函数参数
// 数组长度可以指定也可以不指定
func details(array []string, array1 [5]string) {

}
// 切片作为函数参数
func getCode(ele []string)  {
	
}
// 可变参数
func show(element ...string) {
}
// // 匿名函数无法直接定义
// func () {
// }
func newNameFunc(firstName string, lastName string, bigFunc func(string, string) string) {
	bigFunc(firstName, lastName)
}
func oldNameFunc(firstName, lastName string) string {
	return firstName + lastName
}
// 返回值
// a>.支持返回多个值
func newShow(p, q int) (int, int) {
	return p * q, p + q
}
// b>.给返回值命名
// oldShow(p int, q int) (k int, v int)也可以
func oldShow(p, q int) (k, v int) {
	k = p * q
	v = p + q
	return
}

// 13.方法：可以访问接收者的属性（接收者类型不能在另一个包中定义）
// 允许在同一个包中创建多个具有相同名称的方法（接收者必须具有不同的类型）
// a>.结构类型接收器的方法
type Author struct {
	name, branch string
	salary int
}
func (a Author)newShowMethod() string {
	s := a.name + a.branch
	fmt.Println(a.salary)
	return s
}
// b>.非结构类型接收器的方法
// 指针接收器：方法中所做的更改将反映在调用方
func (a *Author)newShowMethodPin(branch string, salary int) {
	(*a).branch = branch
	(*a).salary = salary
}

// 14.结构体struct：类似不支持继承、支持组合的轻量级类
type Address struct {
	name string
	city string
	pinCode int
}
type FuncName func (string, int) string
type NewAddress struct {
	// 可以写在一起
	name, city string
	pinCode int
	// 结构体嵌套
	address Address
	// 函数做为字段
	details FuncName
}
// 匿名字段：不允许创建两个或多个相同类型的字段
type OldAddress struct {
	string
	int
}

// 接口
// 定义接口
type MyInterface interface {
	getCode() int
	getName() string
}
// 实现接口
func (a Address) getCode() int {
	return a.pinCode
}
func (a Address) getName() string {
	return fmt.Sprintf("%s%s", a.city, a.name)
}

// 异常处理
func Sqrt(value float64) (float64, error) {
	if value < 0 {
		return 0, errors.New("math: 负数的平方根") 
	}
	return math.Sqrt(value), nil
}
// Recover（恢复）：用于从紧急情况或错误情况中重新获得对程序的控制
// 它停止终止序列并恢复正常执行。从延迟函数中调用
// 返回nil
// Panic（一种我们用来处理错误情况的机制）
func SaveDivide(num1, num2 int) int {
	defer func() {
		fmt.Println(recover())
	}()
	quotient := num1 / num2
	return quotient
}