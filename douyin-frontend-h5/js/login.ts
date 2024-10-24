// Cocos2d-x使用c++和Lua
// Cocos Creator是对Cocos2d-x的封装：Cocos2d-x只支持纯代码编辑，Cocos Creator支持可视化，脚本化
// Cocos Creator3.x = Cocos2d-x + h5游戏引擎 + Cocos Creator3D
// Cocos Creator面向组件编程

// 1.概述
// 1>.TypeScript是JavaScript的超集，支持ECMAScript6.x标准
// 2>.TypeScript是Microsoft开发的开源的编程语言
// 3>.TypeScript设计目标是开发大型项目：可以编译成纯JavaScript（运行在任何浏览器上）
// 4>.通常我们使用.ts作为TypeScript代码文件的后缀名
// 5>.$tsc CMGameProxy.ts # 转换为JavaScript代码
// 6>.$node CMGameProxy.js # 执行CMGameProxy.js
var msg: string = 'hello world' // 可以不以;结尾
console.log(msg) // 严格区分大小

// 2.注释
// 1>.支持单行注释
/*
2>.支持多行注释
*/

// 3.数据类型
// 1>.any类型
// >>可以赋值任意类型的value
// >>编译期：typeScript编译器不会对该变量进行检查
// >>运行期：javascript引擎（如果尝试执行无效操作：调用未定义的函数、访问不存在的对象...）会抛出运行时错误
let name1: any
name1 = 'xwj'
name1 = 18
// 2>.number数字类型
// >>表示整数和分数
let age: number = 100
let height: number = 180.56
let money_count = -1000.59
// 3>.string字符串
let name2 = 'xwj' // 可以使用‘’表示字符串类型：同下
let name3 = "wy" // 可以使用“”表示字符串类型：同上
let words = `${name2} love ${name3}` // 使用``模版字符串定义内嵌表达式
let details = `
可以使用‘’表示字符串类型：同下
可以使用‘’表示字符串类型：同下
可以使用‘’表示字符串类型：同下
`
// 4>.boolean布尔类型
let isFlag: boolean = false
// 5>.数组
let array: string[] = ['xwj', 'wy', 'xst'] // 推荐使用
let array1: Array<string> = ['xwj', 'wy', 'xst']
let array2 = new Array('xwj', 'wy', 'xst')
let array3; // array2是any类型
array3[0] = 'xwj' // init根据第一个元素类型来推断数组的类型...string
// 遍历数组
for (let index = 0; index < array.length; index++) {
    const element = array[index];
}
for (const key in array) {
}
// 多维数组
var array4: string[][] = [
    ['xwj', 'wy', 'xst'],
    ['xwj', 'wy', 'xst']
]
// 数组作为函数参数
function test9(sites: string[]) {
    
}
// 数组作为函数返回值
function test10(): string[] {
    return new Array('xwj', 'wy')
}
array1.concat(array1) // 连接两个或更多数组：返回新数组
array1.indexOf('xwj') // 返回指定元素的索引：不存在返回-1
array1.lastIndexOf('xwj') // 返回指定元素的索引（从后向前）：不存在返回-1
array1.join("&") // array -> string
array1.push('cfj') // 向数组的末尾添加元素：返回新数组长度
array1.pop() // 删除数组的最后一个元素：返回删除的元素
array1.reverse() // 反转数组
array.unshift() // 向数组的开头添加元素：返回新数组长度
array1.shift() // 删除数组的第一个元素：返回删除的元素
// 6>.元组：表示已知元素类型和数量的数组
// 数组中一般存储的都是数据类型相同的元素，数据类型不同的元素使用元组
let tuple1: [string, number]
// tuple1 = [1, 'xwj'] // 报错
tuple1 = ['xwj', 18]
// let tuple2 = []
// tuple2[0] = '123'
// tuple2[1] = 123
// // 访问元组
// console.log(tuple1[1])
// // 操作元组
// tuple2.push('x1') // 向元组最后添加元素
// console.log(tuple2.pop()) // 向元组最后移除元素：返回被移除的元素
// tuple2.length // 元组中元素个数
// 更新元组
tuple1[1] = 2
// 解构元组
var [b, c] = tuple1
console.log(b) // 1
console.log(c) // xwj
// 7>.Map
let dict: {[key: string]: string} = {
    'key1': "value1",
    'key2': "value2"
}
// Map是ES6引入的一种数据结构
// 创建Map
let map = new Map([
    ['key1', 'value1'],
    ['key2', 'value2']
])
// 设置map对象
map.set('key3', 'value3')
map.get('key3') // 返回value...kye3不存在返回undefined
if (map.has('key3')) {
    // 判断map中是否包含key3对应的value
}
map.size // 返回key/value的数量
map.delete('key3') // 删除元素
// map.clear() // 移除所有元素
map.keys()
// 遍历map
Array.from(map.keys()).forEach((key) => {

})
map.forEach((value, key, map) => {

})
// 8>.enum枚举：实质还是number
enum Colors {
    // 如果不指定数字则从0开始
    red,
    // 如果指定数字则从指定数字开始
    yellow = 10,
    blue
}
let color: Colors = Colors.red
// 9>.void
function test(): void {
    console.log('hello world')
}
// 10>.null
let obj = null // 空对象引用
typeof obj // 类型验证：返回object
// 类型别名
type newObj = object
let obj1: newObj
// 11>.undefined
let obj2; // 未init的变量
// 12>.never其它类型
let x1: never
let x2: number
// x1 = 123 // 报错：数字类型不能赋值给never类型
x1 = (
    () => {
        throw new Error('exception')
    }
)()
x2 = x1 // never类型可以赋值给数字类型
// 抛出异常的函数返回值可以是never
function test1(): never {
    throw new Error('exception')
}
// 无法执行完毕的函数返回值是never
function test2(): never {
    while (true) {
        
    }
}
// 13>.联合类型：给变量设置多种类型
var name6: number | string
name6 = 12
name6 = 'xwj'
// name6 = true // 报错：只能赋值指定类型，赋值其它类型报错
// 联合类型作为函数参数
function test11(param: string | string[]) {
    
}
// 联合类型作为数组类型
let array5: number[] | string[]
// 14>.unknown：可以用来标记在编程阶段还不清楚类型的变量
let m1: unknown = 4
m1 = '123'

// 4.变量
// 1.变量声明
// 1>.先声明再赋值
var wukong1: string;
wukong1 = 'wukong'
// wukong1 = 123 // 报错：ts是强类型语言
// 2>.声明并赋值
var wukong2: string = 'wukong'
// 3>.类型推断
var wukong3 = 'wukong'
// 4>.任意类型any
var wukong4;
// 2.作用域
var y1 = '123' // 全局变量
class Test3 {
    y2 = '123' // 类的实例变量
    static y3 = '123' // 类的静态变量

    test4(): void {
        var y4 = '123' // 局部变量
    }
}
console.log(Test3.y3)

// 5.运算符
// 1>.算术运算符
var num1: number = 9
var num2: number = 2
console.log(num1 + num2) // 11...也是字符串连接符
console.log(num1 - num2) // 7
console.log(num1 * num2) // 18
console.log(num1 / num2) // 4.5
console.log(num1 % num2) // 1
console.log(++num1) // 10
console.log(num1++) // 10
console.log(--num1) // 10
console.log(num1--) // 10
// 2>.关系运算符
// 结果为true/false
console.log(num1 == num2) // false
console.log(num1 != num2) // true
console.log(num1 > num2) // true
console.log(num1 < num2) // false
console.log(num1 >= num2) // true
console.log(num1 <= num2) // false
// 3>.逻辑运算符
// 结果为true/false
console.log((num1 == num2) && (num1 != num2)) // false
console.log((num1 == num2) || (num1 != num2)) // true
console.log(!(num1 == num2)) // true
// 4>.位运算符
// XXX
// 5>.赋值运算符
num1 = num2;
num1 += num2; // num1 = num1 + num2
num1 -= num2; // num1 = num1 - mun2
num1 *= num2; // num1 = num1 * num2
num1 /= num2; // num1 = num1 / num2
// 6>.三元运算符
var msg1 = (num1 > num2) ? '123' : '456'
// 7>.typeof
console.log(typeof num1) // number
console.log(typeof(num2)) // number
// instanceof运算符
// >>用于判断对象是否为指定的类型
// XXX

// 6.条件语句
// 1>.if语句
if (num1 > num2) {
    
}
// 2>.if...else语句
if (num1 > num2) {
    
} else {

}
// 3>.if...else if...else语句
if (num1 > num2) {
    
} else if (num1 === num2) {

} else {

}
// 4>.switch语句
// num1可以是任意类型：number string boolean object（Array Map） class interface enum
// 底层是===
switch (num1) {
    case 1: {

    }
        break;
    case 2:
    case 3:
    case 4: {

    }
        break;
    default:
        break;
}

// 7.循环语句
// 1>.for循环
for (let index = 0; index < array1.length; index++) {
    const element = array1[index];
}
// 2>.for...in
for (let element in array1) {
    // element表示数组index
    // 1, 2, 3, 4...
}
// 3>for...of
for (let element of array1) {
    // element表示数组value
}
// 4>.while循环
while (num1 > 10) {
    // 条件为true的时候开始循环
}
// 5>.do...while
do {
    // 先执行一次，条件为true的时候开始循环
} while (num1 > 10);
// 6>.关于循环的三个关键字
// continue; // 跳出本次循环，开始下次循环
// break; // 跳出循环：循环结束
// return; // 直接返回
// 7>.无限循环：死循环
// for(;;) {}
// while (true) {}
// do {
// } while (true);

// 8.函数
// 1>.定义函数
function test4(a1: number, s1: string): string {
    return a1 + s1
}
/*
js代码
function test4(a1, s1) {
    return a1 + s1
}
*/
let s2 = test4(1, 'xwj')
// 2>.可选参数
// a.默认情况下，形参和实参必须相等（可选参数除外）
function test5(a1: number, a2?: number) {
    // 可选参数必须跟在必需参数后面
}
test5(1)
test5(1, 2)
// 3>.默认参数
function test6(s1: string, s2: string = 'xwj') {
    
}
test6('wy')
test6('wy', 'cfj')
// 4>.剩余参数
// ...s2表示剩余参数组成的array
// 0 ~ (s2.length - 1)
function test7(s1: string, ...s2: string[]) {
    
}
test7('xwj', 'x1', 'x2', 'x3')
// 5>.匿名函数
var msg2 = function () {
    
}
msg2()
var msg3 = function (a1: number, a2: number): number {
    // 直接调用
    (function () {
    
    })()    
    return a1 * a2
}
msg3(1, 2)
// 6>.使用构造函数
var msg4 = new Function('a', 'b', 'return a * b')
msg4(1, 2)
// 7>.递归函数：自己调用自己
// function test8() {
    // 必须有结束条件
    // test8()
// }
// 8>.箭头函数
// 1>.支持函数体有多行
// 2>.不能用作构造函数：主要用来替代匿名函数
var msg5 = (s1: string) => console.log(s1)
msg5('xwj')
// 我们可以不指定参数类型
// 单个参数()可以省略
var msg6 = (s1) => {
    if (typeof(s1) == 'number') {
        
    } else if (typeof(s1) == 'string') {

    }
}
msg6(1)
msg6('xwj')
// 9>.无参可以直接使用()
var msg7 = () => {
}
// 10>.函数作为参数：回调函数（传入函数名 === 整个函数）
function lrTest(func: Function) {
    // 执行传入的函数：函数作为参数可以传递代码块（！！！这点是变量无法做到的！！！）
    // 代码块可以定义规则
    func();
 }
 lrTest(function () {
    
 });
 function lrShow() {
    
 }
 lrTest(lrShow);
// 重载：函数名称相同，参数不同（类型不同、数量不同、顺序不同），与返回值无关...js不支持重载？？？

// 9.Number包装类
var num1 = Number(123)
var num2 = Number('xwj') // 返回NaN
Number.MAX_VALUE // 最大值
Number.MIN_VALUE // 最小值
Number.NEGATIVE_INFINITY // 负无穷大-Infinity
Number.POSITIVE_INFINITY // 正无穷大Infinity
Number.NaN // NaN
// 数字 -> 字符串
var num3 = Number(177.2345)
num3.toFixed() // 177
num3.toFixed(2) // 177.23
num3.toFixed(5) // 177.23450
num3.toLocaleString() // 177.2345
num3.toString() // 十进制
num3.toString(2) // 二进制
num3.toString(8) // 八进制
// 数字格式化指定长度
num3.toPrecision() // 177.2345
num3.toPrecision(1) // 1
num3.toPrecision(2) // 17
// Number -> number
num3.valueOf()
// 2>.String包装类
// string和String有什么不同？？？
let name4 = new String('xwj')
name4 = 'xwj'
name4.length // 字符串的长度
name4.charAt(1) // 返回指定位置的字符
name4.charCodeAt(1) // 返回指定位置的字符的unicode编码
let name5 = name4.concat(name1) // 连接两个或更多字符串：返回新字符串
name5.indexOf('w') // 返回某个指定的字符串值在字符串中首次出现的位置
name5.lastIndexOf('w') // 从后向前搜索字符串：从起始位置（0）开始计算返回字符串最后出现的位置
name5.match('正则表达式') // 查找一个或多个正则表达式的匹配
name5.toLocaleLowerCase() // 转换成小写
name5.toLocaleUpperCase() // 转换成大写
name5.toString() // 返回字符串
name5.valueOf() // String -> string
// 切割字符串：自行百度slice()和substring(1, 2)的区别
name5.slice()
name5.split("&", 4) // 按照&分割字符串组成字符数组（保留字符数组元素个数4）
name5.substring(1, 2)

// 12.接口：无法转换成js
interface PersonCallback {
    name: string;
    age: number;
    sayHi(): string
}
// 变量可以实现接口
var customer: PersonCallback = {
    name: 'xwj',
    age: 18,
    sayHi() {
        return 'xwj'
    }
}
// 继承：ts允许接口多继承
interface StudentCallback extends PersonCallback {
    studentNo: number
}

// 13.类
// 1>.抽象类：本身不能被实例化为对象，可以被继承
abstract class Person1 {
    _name: string = '' // 如果不想外部直接调用该属性需要这样写（这属于一个约定俗称的方式，因为这样写外部依旧可以直接调用）
    // 成员方法和函数的区别：不需要加function关键字
    run() {

    }
    // 抽象方法
    abstract say(): void
}
class Person2 extends Person1 {
    
    get name() {
        return this._name
    }

    set name(value) {
        this._name = value
    }

    constructor(name: string) {
        // 先调用父类方法
        super()
        // this表示当前类实例对象
        this._name = name
    }

    say() {
        console.log('我的名字是' + this._name)
    }
}
/*
js代码
var Person = (function () {
    function Person(name) {
        this.name = name
    }
    Person.prototype.show = function () {
        console.log('我的名字是' + this.name)
    }
    return Person
}())
*/
// 创建对象
var p1 = new Person2('')
p1.name = 'xwj' // 在外部实际调用的是getter/setter
p1.say
if (p1 instanceof Person2) {
    // 判断p1是否是Person类的对象
}
// 继承：只支持单继承不支持多继承
// 不能继承父类的私有成员和构造方法
// 类可以实现接口
class Student extends Person2 implements StudentCallback {
    // static修饰属性和方法表示静态属性和静态方法：直接通过类名调用
    static No: number
    age: number
    studentNo: number
    /*
    public默认 任何地方都可以访问
    protected 自身/子类可以访问
    private 当前类中可以访问
    */
    public score: string

    // 重写父类方法
    say(): void {
        // super可以引用父类属性和方法
        super.say()
        console.log('我的名字是' + this.name)
    }

    sayHi(): string {
        return ''
    } 
}

// 14.对象
var obj3 = {
    key1: 'xwj',
    key2: function () {
        
    },
    key3: ['xwj', 'wy']
}
obj3.key2 = function () {
    console.log('xwj')
}

// 15.泛型
// 1>.泛型函数
// T - type
// U - 第二个参数
// V - 第三个参数
// E - Array
// R - 返回值
function test14<T, U, V, R, E>(arg1: T, arg2: U, arg3: V, arg4: R, arg5: E[]): R {
    return arg4
}
// 2>.泛型接口
// K - key
// V - value
interface Pair<K, V> {
    first: K,
    second: V
}
let pair1: Pair<string, number> = {
    first: 'xwj',
    second: 10
}
// 3>.泛型类
class Box<T> {
    private value: T

    constructor(value: T) {
        this.value = value
    }
}
// 4>.约束泛型
interface LengthWise {
    length: number
}
function test19<T extends LengthWise>(args: T): void {
    console.log(args.length)
}
test19('xwj')
// 5>.给泛型设置一个默认值
function test20<T = string>(args: T): void {
    console.log(args)
}

// 16.命名空间
/*
我们一般把一个文件中新建一个namespace，其它文件引用如下：
/// <reference path = "文件名.ts" />
*/
namespace Doyin {
    // 想要外部调用必须使用export
    export interface test {

    }
    export class test1 {

    }

    // 嵌套命名空间
    export namespace Doyin1 {
        export class Doyin2 {
            public show() {

            }
        }
    }
}
// 访问
var d1 = new Doyin.Doyin1.Doyin2()
d1.show()

// 17.模块
// 使用export导出
// export class Douyin {

// }
// 使用import导入
// import { Douyin } from '../相对路径'

// 18.声明文件
/*
ts文件怎么调用js文件：
1.直接引用：可以调用类和方法，无法使用ts特性（类型检查...）
2.引用声明文件（描述js库和模块信息）
Douyin.d.ts
declare module xxx {
    export class Douyin {
        sum(): number
    }
}
*/

// 19.单例模式
// 第一种方式
// class ModuleManager {
//     static instance = new ModuleManager()

//     private constructor() {

//     }
// }
// ModuleManager.instance
// 第二种方式：推荐
class ModuleManager {
    private static instance: ModuleManager

    private constructor() {

    }

    static getInstance(): ModuleManager {
        // lazy加载
        if (!ModuleManager.instance) {
            ModuleManager.instance = new ModuleManager()
        }
        return ModuleManager.instance
    }
}
ModuleManager.getInstance()

// 20.代理模式
interface IPerson1 {
    calculation(num1: number, num2: number): number
}
class Person3 {

    personCallback: IPerson1

    getNum(num1: number, num2: number) {
        this.personCallback.calculation(num1, num2)
    }
}
class Npc1 implements IPerson1 {
    calculation(num1: number, num2: number): number {
        return num1 - num2
    }

    
}
class Npc2 implements IPerson1 {
    calculation(num1: number, num2: number): number {
        return num1 + num2
    }
}
let p3 = new Person3()
p3.personCallback = new Npc2()
p3.getNum(3, 4)

// 21.观察者模式
interface IObserver {
    nameChanged(newValue: string)
}
class Person4 {
    private _name: string

    observers: Array<IObserver> = new Array()

    set name(value) {
        this._name = value

        for (let observer of this.observers) {
            observer.nameChanged(this._name)
        }
    }

    get name() {
        return this._name
    }
}
class Npc3 implements IObserver {
    nameChanged(newValue: string) {
        
    }
}
let p4 = new Person4()
p4.observers.push(new Npc3)
p4.name = 'xwj'

// 21.工厂模式
enum CarType {
    benz,
    bmw,
    audi
}
class Car {
    static create(type: CarType): Car {
        let car: Car
        switch (type) {
            case CarType.benz: {
                car = new Benz()
            }
                break;
            case CarType.benz: {
                car = new Bmw()
            }
                break;
            case CarType.benz: {
                car = new Audi()
            }
                break;
            default: {
                throw new Error(`Invalid car type: ${type}`)
            }    
        }
        return car
    }
}
class Benz extends Car {}
class Bmw extends Car {}
class Audi extends Car {}
let bmw = Car.create(CarType.bmw)



let list: string[] = [];
list.every(() => {
    
})
