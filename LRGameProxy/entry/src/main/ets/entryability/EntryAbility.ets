import { AbilityConstant, UIAbility, Want } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { window } from '@kit.ArkUI';

export default class EntryAbility extends UIAbility {
  onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onCreate');
  }

  onDestroy(): void {
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onDestroy');
  }

  onWindowStageCreate(windowStage: window.WindowStage): void {
    // Main window is created, set main page for this ability
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageCreate');

    windowStage.loadContent('pages/Index', (err) => {
      if (err.code) {
        hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.');
    });
  }

  onWindowStageDestroy(): void {
    // Main window is destroyed, release UI related resources
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onWindowStageDestroy');
  }

  onForeground(): void {
    // Ability has brought to foreground
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onForeground');
  }

  onBackground(): void {
    // Ability has back to background
    hilog.info(0x0000, 'testTag', '%{public}s', 'Ability onBackground');
  }
}

// 1.认识harmony
// 1>.万物互联时代的机遇、挑战和趋势
// a.随着万物互联时代的开启，设备底座从几十亿手机扩展到数百亿的loT设备，更多的智能设备并没有带来更好的全场景体验
// b.新的场景存在的问题：连接步骤复杂、数据难以互通、生态无法共享、能力难以协同
// c.移动应用开发中遇到的挑战：针对不同操作系统，重复开发，维护多套版本
// d.新的应用生态具备的特征：单一设备延伸到多设备、厚重应用模式到轻量化服务模式、集中化分发到AI加持下的智慧分发、纯软件到软硬芯协同的AI能力
// 2>.核心技术理念
// a.一次开发，多端部署（多设备工程管理、多目标构建、一体化打包）
// b.可分可合，自由流转（元服务是支持可分可合，自由流转的轻量化程序实体、自由流转（跨端迁移和多端协同））
// c.统一生态，原生智能（支持业界主流跨平台开发框架；react native、flutter、weex、Taro、uni-app）
// 3.高效开发与测试
// a.开发框架：ArkUI框架
// b.集成开发环境：DevEco Studio
// c.测试工具：专项测试套件、测试工具平台
// 4.上架分发
// a.huawei AppGallery Connect为开发者提供全球化、全场景、一站式应用与服务分发能力
// b.huawei AppGallery Connect作为开发者统一提交HarmonyOS生态应用和元服务的入口：证书管理、项目管理、版本管理



// 2.快速开始
// 1>.安装DevEco Studio：登录https://developer.huawei.com/consumer/cn/deveco-studio（一体化：无需再安装HarmonyOS SDK、Node.js、Hvigor、OHPM、模拟器平台）
// 2>.Application应用、Atomic Service元服务
// 3>.Compatible SDK:5.0.0(12) => HarmonyOS Next
// 4>.诊断开发环境：Help > Diagnostic Tools > Diagnose Development Environment
// 5>.特别说明：HarmonyOS SDK已嵌入DevEco Studio中，无需额外下载配置（DevEco Studio\sdk目录中查看）、进行OpenHarmony应用开发：通过Settings > OpenHarmony SDK下载OpenHarmony SDK

// 3.工程目录结构
/*
LRGameProxy
  .hvigor -- 自动生成
  .idea -- 自动生成
  AppScope
    resources --
    app.json5 -- 应用全局配置信息
  // apk aab ipa hap
  entry -- HarmonyOS工程模块（编译构建生成一个hap包）
    src
      main
        ets
          entryability -- 应用/服务的入口
          entrybackupability -- 应用提供扩展的备份恢复能力
          pages -- 应用/服务页面
        resources -- 存放资源文件（图形、多媒体、字符串、布局文件）
        module.json5 -- 模块配置文件
      mock
      ohosTest
      test
    build-profile.json5 -- 当前的模块信息、编译信息配置项
    hvigorfile.ts -- 模块级编译构建任务脚本
    obfuscation-rules.txt -- 混淆规则文件：在release模式下开启代码混淆进行编译会对代码进行编译、混淆和压缩处理
    oh-package.json5 -- 描述包名、版本、入口文件（类型声明文件）和依赖项
  oh_modules -- 用于存放三方库依赖信息
  build-profile.json5 -- 工程级配置项：signingConfigs
  hvigorfile.ts -- 工程级编译构建任务脚本
  oh-package.json5 -- 描述全局配置
 */

// 4.构建页面
// 1>.点击pages -> New -> ArkTS File...这样方式必须手动配置route（entry -> resources -> base -> profile -> main_pages.json）
// 2>.点击pages -> New -> Page -> Empty Page...自动配置route

