import { BreakpointType, BreakpointTypeEnum } from '@ohos/utils/src/main/ets/utils/BreakpointSystem';
import { ArticleClass } from '../model/ArticleClass';
import { bufferToString } from '../util/BufferUtil';

@Preview
@Component
export struct TutorialView {
  @State tutorialList: Array<ArticleClass> = [];
  @Consume('articlePathStack') articlePathStack: NavPathStack;
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;

  aboutToAppear(): void {
    this.getDataFromJson();
  }

  getDataFromJson() {
    getContext(this).resourceManager.getRawFileContent('TutorialData.json').then(value => {
      let res: string = bufferToString(value);
      this.tutorialList = JSON.parse(res) as ArticleClass[];
    })
  }

  build() {
    Column() {
      Text('入门教程')
        .fontSize('#182431')
        .fontSize(16)
        .fontWeight(500)
        .fontFamily('HarmonyHeiTi-medium')
        .textAlign(TextAlign.Start)
        .padding({ left: 16 })
        .margin({ bottom: 8.5 })

      List({ space: 12 }) {
        ForEach(this.tutorialList, (item: ArticleClass) => {
          ListItem() {
            TutorialItem({ tutorialItem: item })
              .onClick(() => {
                this.articlePathStack.pushPathByName('articleDetail', item)
              })
          }
        }, (item: ArticleClass) => item.id)
      }
      .scrollBar(BarState.Off)
      .padding({ left: 16, right: 16 })
      .lanes(
        new BreakpointType<number>({ sm: 1, md: 2, lg: 3 }).getValue(this.currentBreakpoint),
        new BreakpointType<number>({ sm: 0, md: 12, lg: 16 }).getValue(this.currentBreakpoint)
      )
    }
    .margin({ top: 18 })
    .alignItems(HorizontalAlign.Start)
  }
}

/**
 * 入门教程
 */
// @Preview
@Component
struct TutorialItem {
  @Prop tutorialItem: ArticleClass;

  build() {
    Row() {
      Column() {
        // 标题
        Text(this.tutorialItem.title)
          .height(19)
          .width('100%')
          .fontSize(14)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(1)
          .fontWeight(400)
          .margin({ top: 4 })

        // 简介
        Text(this.tutorialItem.brief)
          .height(32)
          .width('100%')
          .fontSize(12)
          .textAlign(TextAlign.Start)
          .textOverflow({ overflow: TextOverflow.Ellipsis })
          .maxLines(2)
          .fontWeight(400)
          .fontColor('rgba(0, 0, 0, 0.6)')
          .margin({ top: 5 })
      }
      .height('100%')
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      .margin({ right: 12 })

      // 图片
      Image($r(this.tutorialItem.imageSrc))
        .objectFit(ImageFit.Cover)
        .height(64)
        .width(108)
        .borderRadius(16)
    }
    .width('100%')
    .height(88)
    .borderRadius(16)
    .backgroundColor(Color.White)
    .padding(12)
    .alignItems(VerticalAlign.Top)
  }
}