// 装饰器
@Entry
@Component
// 自定义组件
struct Index {
  // 装饰器
  @State message: string = 'Hello';

  build() {
    RelativeContainer() {
      // 内置组件
      Text(this.message)
        .id('Hello')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
      Button() {
        Text('Next')
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
      }
      // 事件方法
      .onClick(() => {

      })
      // 属性方法
      .type(ButtonType.Capsule)
      .margin({
        top: 20
      })
      .backgroundColor('#0D9FFB')
      .width('40%')
      .height('5%')
    }
    .height('100%')
    .width('100%')
  }
}