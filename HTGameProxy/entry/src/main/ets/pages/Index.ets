@Entry
@Component
struct Index {
  // ArkTS是HarmonyOS开发语言
  // ArkTS = TypeScript + ArkUI

  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}