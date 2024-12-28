

@Component
export default struct FirstPage {
  @State currentIndex: number = 0;

  build() {
    Column() {
      Scroll() {
        Column() {
          Row() {
            Text('热门资讯')
              .padding(3)
              .fontSize(20)
              .fontWeight('bold');
          }

          infoBanner()

          // // 分类导航
          // this.renderCategoryNav()

          //NewsList()
        }
      }.layoutWeight(1)
      .scrollBar(BarState.Off)
      .align(Alignment.TopStart)
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F5F5')
  }

  // @Builder
  // renderCategoryNav() {
  //   // 分类导航图标及标签
  //   Row() {
  //     this.renderCategoryItem('赛程', $r('app.media.enablement_pic1'))
  //     this.renderCategoryItem('数据', $r('app.media.enablement_pic2'))
  //     this.renderCategoryItem('球队', $r('app.media.enablement_pic3'))
  //     this.renderCategoryItem('CBA专区', $r('app.media.enablement_pic4'))
  //     this.renderCategoryItem('玩中职篮', $r('app.media.enablement_pic5'))
  //   }
  //   .width('100%')
  //   .padding({ top: 20})
  //   .backgroundColor(Color.White)
  // }
  //
  // @Builder
  // renderCategoryItem(label: string, iconUrl: ResourceStr) {
  //   Column() {
  //     Image(iconUrl)
  //       .width(40)
  //       .height(40)
  //       .borderRadius(20)
  //     Text(label)
  //       .fontSize(14)
  //       .fontColor('#000000')
  //   }
  //   .width('20%')
  //   .alignItems(HorizontalAlign.Center)
  // }
}

class BannerClass {
  id: string = '';
  imageSrc: ResourceStr = '';

  constructor(id: string, imageSrc: ResourceStr) {
    this.id = id;
    this.imageSrc = imageSrc;
  }
}

@Component
struct infoBanner {
  @State bannerList: Array<BannerClass> = [
    new BannerClass('pic0', $r('app.media.logo')),
    new BannerClass('pic1', $r('app.media.match')),
    new BannerClass('pic2', $r('app.media.goal')),
    new BannerClass('pic3', $r('app.media.preview')),
  ];

  build() {
    Swiper() {
      ForEach(this.bannerList,(item: BannerClass,index: number)=>{
        Image(item.imageSrc)
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ top: 11, left: 16, right: 16 })
          .borderRadius(12)
      },(item: BannerClass,index: number) => item.id)
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'))
  }
}