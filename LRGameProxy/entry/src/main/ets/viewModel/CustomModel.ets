export default class CustomModel {
  // 5.ArkTS语言
  // 1>.什么是ArkTS
  // a>.ArkTS是HarmonyOS生态应用开发语言
  // 特点：声明式UI范式、状态管理支持
  // 保持ts基本语法的基础上，进一步规范强化静态检查和分析 使程序在开发期就能检测错误，提高代码健壮性 实现更好的运行性能
  // 针对同时并发能力支持有限的问题，ArkTS增强了并发编程api
  /*
  class User {
    name: string = '';
    age: number = 18;
    // ArkTS不支持在运行时更新对象布局，可以使用可选属性替代该功能
    department?: string;
  }
  let user = new User();
  // ts支持在运行时改变对象布局
  (user as any).department = 'xx';
  delete (user as any).department;
  // ArkTS是类型安全的语言、编译器会实时进行类型检查、不支持any类型
  */
  // 2>.变量/常量
  show1() {
    let wukong: string = ''; // 变量声明（支持自动推导）
    const MAX_VALUE: number = 40; // 常量声明
    // 基本类型：number string boolean
    // 引用类型：Object Array
    let first_list: Array<string> = ['', '', ''];
    let second_list: string[] = ['', '', '']
    // 联合类型：Union
    let luckyNum: string | number = 9;
    luckyNum = 'xwj';
    // 类型别名Aliases
    type Matrix = number[][];
    let third_list: Matrix = [
      [],
      [],
      []
    ]
  }
  // 3>.空类型
  show2() {
    let name: string | null = 'a';
    // // 这样就会报错
    // console.log(name.length.toString());
    // 使用if判断
    if (name != null) {}
    // 使用??
    let userName = name ?? '';
    // 使用?
    console.log(name?.length.toString()); // 如果name = null则返回undefined
  }
  // // 4>.函数
  // function test(age: number, name: string): void {
  // }
  // // 箭头函数
  // (参数: 参数类型): 返回值类型 => {
  //   // 函数体只有一行可以省略{}
  //   // 返回值类型可以省略：通过函数体推导
  //   // 一般作为回调函数
  // }
  // // 闭包函数：一个函数把另一个函数作为返回值（保留对内部作用域的访问）
  // function outerFunc(): () => string {
  //   return (): string => {
  //     return ''
  //   }
  // }
  // // 5>.枚举类型：Enum
  // // 默认从0开始
  // enum Color {
  //   Red,
  //   Blue,
  //   Green
  // }
  // let newColor: Color = Color.Red;
  // 7>.支持if-else 三元运算符 while do-while for-of
  // 8>.class
  // // implements可以实现接口
  // class xxx extends HomePage implements xxxx {
  //   // 支持public默认 private protected
  //   public name: string = 'xwj';
  //   private _age: number = 20; // private属性一般考虑加一个_...无法直接访问私有属性（可以通过setter/getter进行访问）
  //   isMale: boolean = true; // public默认
  //
  //   // 必须同时实现属性和方法
  //   width: number = 0;
  //   height: number = 0;
  //   someMethod(): number {
  //   }
  //
  //   constructor() {
  //     // 构造函数
  //     super(); // 通过super关键字访问父类
  //   }
  //
  //   get age(): number {
  //     return this._age;
  //   }
  //
  //   set age(age: number) {
  //     this._age = age;
  //   }
  //
  //   show() {}
  //
  //   // 可以重写父类方法：ArkTS支持封装、继承、多态
  //   // ts也支持面向对象的三大特征|js不行
  //
  //   // 接口可以用来约束和规范类的方法
  //   interface xxxx {
  //     // 属性声明
  //     // // ？？？只有属性的接口可以通过字面量的方式创建对象实例（有方法声明的接口不行）？？？
  //     // let area: xxx = {width: 100, height: 100};
  //     width: number;
  //     height: number;
  //
  //     // 方法声明
  //     someMethod(): number;
  //   }
  // }
  // 9>.export和import
  // export class xxx {
  //   // export导出一个文件的变量、函数、类...
  // }
  // import {} from './Index' // 导入
}