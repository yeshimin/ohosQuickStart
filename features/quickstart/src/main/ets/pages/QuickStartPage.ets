import { Banner } from '../view/Banner';
import { EnablementView } from '../view/EnablementView';
import { TutorialView } from '../view/TutorialView';

@Component
export struct QuickStartPage {
  @State message: string = '快速入门';

  build() {
    Column() {
      // ‘快速入门’文本
      Text(this.message)
        .fontSize(24)
        .fontWeight('700')
        .fontFamily('HarmonyHeiTi-Bold')
        .lineHeight(33)
        .width('100%')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })

      // banner
      // Banner()

      // 赋能套件
      // EnablementItem()

      // 入门教程
      // TutorialItem()

      Scroll() {
        Column() {
          Banner()
          EnablementView()
          TutorialView()
        }
      }
      .layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}
