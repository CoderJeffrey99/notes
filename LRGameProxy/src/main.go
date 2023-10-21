package main

// 通过import来导入其他的包
// 第一种方式
import "fmt" // 导入的包未使用会报错：IDE会自动处理

// 第二种方式
//import (
//	"fmt"
//)
// package别名：防止不同第三方包的报名非常接近或相同

// Go程序是通过package来组织的
// 只有package名称为main的包才可以包含main函数
// 一个可执行程序：有且仅有一个main包

// 全局变量可以使用var()
var (
	// 支持类型推导
	s1 = "123"
	a1 = 18
)

const (
	text = "12"
	num  = 18
)

// func可以声明函数
func main() {
	// 函数名首字母小写 - private
	// 函数名首字母大写 - public
	fmt.Println("hello world")

	// 常量：其值在编译期就确定
	const count int = 1
	const s2 = ""

	// 变量
	// bool布尔类型 1个字节 true/false 没有非0既真 默认值false
	// int整型 默认值为0
	// int8/uint8八位整型 1个字节 uint8 = byte
	// int16/uint16十六位整型 2个字节
	// int32/uint32三十二位整型 4个字节
	// int64/uint64六十四位整型 8个字节
	// float32/float64浮点型 4/8个字节
	// complex64/complex128复数 8/16个字节
	// array
	// struct
	// string
	// slice
	// map
	// chan
	// interface
	// func

	// 局部变量不支持var()
	var a2 int = 8

	// 类型转换
	// Go语言不存在隐式转换
	var a3 = 8
	var s3 = string(a3)
	fmt.Println(s3)

	// 条件语句
	if a3 > 10 {
		fmt.Println("abc")
	} else {
		fmt.Println("123")
	}

	switch a2 {
	case 1:
		{
			// 不需要break
		}
	case 2:
		{

		}
		// 表示case穿透
		fallthrough
	default:
		{

		}
	}

	// 循环语句：只有for一个循环关键字
inner: // 支持标签：不使用会报错
	for i := 0; i < 10; i++ {
		break inner
		//continue
		//goto
	}

	// 数组Array：值类型

	// 切片Slice：引用类型

	// map
}

// 函数：不支持嵌套、重载和默认参数

// 结构体struct：Go语言没有class

// 1.什么是Go语言
// 支持并发、高效的垃圾回收机制、内存安全、类型安全、快速编译、支持UTF-8编码

// 2.安装Go语言
// 登录https://golang.org下载适用于你操作系统的Go安装程序，按照提示进行安装 ｜ 也可以使用homebrew安装Go
// 设置GOPATH环境变量：针对旧版
// 配置PATH：可以在终端直接使用go命令
// Go项目下新建三个目录：bin存放编译后生成的可执行文件、pkg存放编译后生成的包文件、src存放项目源码

// Go命令
// 在终端输入go就可以查看所有支持的命令
// go get 获取远程包：需要提前安装git
// go run 直接运行程序
// go build 测试编译：检查代码是否有编译错误
// go fmt 格式化源码
// go install 编译包文件并编译整个程序
// go test 运行测试文件
// go doc 查看文档

// 关键字：小写

// 单行注释
/*
多行注释
*/
