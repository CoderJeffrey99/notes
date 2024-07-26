@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('HelloWorld')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
    }
    .height('100%')
    .width('100%')
  }
}
/*
HarmonyOS简介
1.应用开发的机遇、挑战和趋势
a>.随着万物互联时代的来临，设备底座将从手机扩展到所有的IoT设备（物联网设备：通过传感设备，任何物体的数据（速度、温度、湿度...）都可以按照约定的协议传输到网络，然后进行智能决策）
b>.更多IoT设备导致设备之间的连接步骤复杂，数据难以互通，生态无法共享、能力难以协同的问题
2.概念：HarmonyOS是新一代的智能终端操作系统，为不同设备的智能化、互联与协同提供了统一的语言，为用户带来简捷，流畅，连续，安全可靠的全场景交互体验
3.技术理念：一次开发，多端部署（地代码可视化开发，多端UI适配，事件交互归一） ｜ 可分可合，自由流转（独立开发元服务，按需组成应用，应用和元服务都可以上架AppGallery）｜ 统一开发，原生智能（多端融合，统一接入标准）
*/


// ArkUI框架 -- 方舟UI框架
// DevEco Studio -- 集成开发环境
// 基础功能：工程管理 代码编辑 界面预览 编译构建 代码调试 ｜ 集成工具：性能调优 设备模拟 命令行工具
// 快速上架 -> 上架审核 -> 应用分发

// huawei appGallery Connect -- 开发者提交应用和元服务的统一入口，集成证书管理，项目管理，版本管理

// DevEco Studio5.0是一体化版本：包含hmSDK、构建版本、ohpm（开源鸿蒙性能管理器）
// 登录https://developer.huawei.com/consumer/cn/deveco-studio下载相应版本，开箱即用
// 创建应用：Create Project -> Choose Your Ability Template(Application/Atomic Service) -> Empty Ability -> Configure Your Project

// ArkTS语言
// 1>.概念：ArkTS语言是HarmonyOS生态的应用开发语言（ArkTS语言是在TypeScript语言基础上扩展的、TypeScript又是JavaScript的超集）
// 2>.组成：声明式UI范式 + 状态管理 + 强化静态检查和分析 + 增强并发编程api + js/ts
/*
// ts
class User {
  name: string = ''
}
let user = new User()
// 运行时动态新增属性
(user as any).age = 18
// 运行时动态删除属性
delete (user as any).age
// ArkTS
class User {
  name: string = ''
  age? : number
}
let user = new User()
user.age = 18
user.age = undefined
*/

