

@Component
export default struct FirstPage {
  @State currentIndex: number = 0;

  build() {
    Column() {
      Scroll() {
        Column() {
          Row() {
            Text('热门资讯')
              .padding(5)
              .fontSize(20)
              .fontWeight('bold');
          }

          infoBanner()

          Row() {
            Text('比赛预告')
              .padding(10)
              .fontSize(20)
              .fontWeight('bold');
          }

          mostRecentMatches()

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
}

class Match {
  id: string;
  homeTeam: string;
  awayTeam: string;
  matchTime: string;

  constructor(id: string, homeTeam: string, awayTeam: string, matchTime: string) {
    this.id = id;
    this.homeTeam = homeTeam;
    this.awayTeam = awayTeam;
    this.matchTime = matchTime;
  }
}

@Component
struct mostRecentMatches {
  @State matchList: Array<Match> = [
    new Match('match1', '球队A', '球队B', '2024-01-01 18:00'),
    new Match('match2', '球队C', '球队D', '2024-01-02 20:00'),
  ];

  build() {
    Row() {
      ForEach(this.matchList, (match: Match) => {
        this.renderMatchCard(match);
      }, (match: Match) => match.id);
    }
    .width('100%');
  }

  @Builder
  renderMatchCard(match: Match) {
    Column() {
      Text(`${match.homeTeam} vs ${match.awayTeam}`)
        .fontSize(16)
        .fontWeight('bold')
        .padding(5);

      Text(match.matchTime)
        .fontSize(14)
        .fontColor('#888888')
        .padding(5);
    }
    .width('45%') // 每个卡片占一行的45%
    .padding(10)
    .margin({ left: 10, right: 10 }) // 增加左右间距
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
  }
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
    new BannerClass('pic0', $r('app.media.1')),
    new BannerClass('pic1', $r('app.media.2')),
    new BannerClass('pic2', $r('app.media.3')),
  ];

  build() {
    Swiper() {
      ForEach(this.bannerList, (item: BannerClass, index: number) => {
        Image(item.imageSrc)
          .objectFit(ImageFit.Contain)
          .width('100%')
          .padding({ top: 11, left: 16, right: 16 })
          .borderRadius(12);
      }, (item: BannerClass, index: number) => item.id);
    }
    .autoPlay(true)
    .loop(true)
    .indicator(
      new DotIndicator()
        .color('#1a000000')
        .selectedColor('#0A59F7'));
  }
}