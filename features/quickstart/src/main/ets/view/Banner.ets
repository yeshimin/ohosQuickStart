import { BannerClass } from '../model/BannerClass';
import { bufferToString } from '../util/BufferUtil';

@Preview
@Component
export struct Banner {
  @State bannerList: Array<BannerClass> = [];
  @Consume('articlePathStack') articlePathStack: NavPathStack;

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
  }
}