import { BreakpointType, BreakpointTypeEnum } from '@ohos/utils/src/main/ets/utils/BreakpointSystem';
import { BannerClass } from '../model/BannerClass';
import { bufferToString } from '../util/BufferUtil';

@Preview
@Component
export struct Banner {
  @State bannerList: Array<BannerClass> = [];
  @Consume('articlePathStack') articlePathStack: NavPathStack;
  @StorageProp('currentBreakpoint') currentBreakpoint: string = BreakpointTypeEnum.MD;

  aboutToAppear(): void {
    this.getDataFromJson();
  }

  getDataFromJson() {
    getContext(this).resourceManager.getRawFileContent('BannerData.json').then(value => {
      let res: string = bufferToString(value);
      this.bannerList = JSON.parse(res) as BannerClass[];
    })
  }

  build() {
    Swiper() {
      ForEach(this.bannerList, (item: BannerClass) => {
        Image($r(item.imageSrc))
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ top: 11, left: 16, right: 16 })
          .borderRadius(16)
          .onClick(() => {
            this.articlePathStack.pushPathByName('bannerDetailPage', item);
          })
      }, (item: BannerClass) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7')
    )
    .displayCount(new BreakpointType({ sm: 1, md: 2, lg: 2 }).getValue(this.currentBreakpoint))
    .displayMode(SwiperDisplayMode.STRETCH)
    .indicator(this.currentBreakpoint === BreakpointTypeEnum.SM ?
    Indicator.dot().color('#1a000000').selectedColor('#0A59F7') : false)
    .nextMargin(new BreakpointType<Length>({ sm: 0, md: 12, lg: 266 }).getValue(this.currentBreakpoint))
  }
}