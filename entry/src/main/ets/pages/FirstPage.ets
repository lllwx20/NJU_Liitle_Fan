import { router, Router } from "@kit.ArkUI";

@Component
export default struct FirstPage {
  @State currentIndex: number = 0;

  build() {
    Column() {
      Scroll() {
        Column() {
          Row() {
            Text('足坛快报')
              .padding(5)
              .fontSize(18)
              .fontWeight('bold');
          }

          infoBanner()

          Row() {
            Text('比赛预告')
              .padding(10)
              .fontSize(18)
              .fontWeight('bold');
          }

          mostRecentMatches()

          Row() {
            Text('热门资讯')
              .padding(10)
              .fontSize(18)
              .fontWeight('bold');
          }

          NewsList()
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
  @State pictureList: Array<BannerClass> = [
    new BannerClass('pic1', $r('app.media.1')),
    new BannerClass('pic2', $r('app.media.2')),
    new BannerClass('pic3', $r('app.media.3')),
  ];

  @State titleList: Array<string> = [
    '多点开花！软院4-1轻取地科',
    '研超焦点大战，蓝色监狱天气联2-2握手言和',
    '南大高水平校队夺得“南京城市杯”冠军',
  ];

  build() {
    Swiper() {
      ForEach(this.pictureList, (item: BannerClass, index: number) => {
        Stack() {
          Image(item.imageSrc)
            .objectFit(ImageFit.Contain)
            .width('100%')
            .padding({ top: 11, left: 16, right: 16 })
            .borderRadius(12);

          Text(this.titleList[index])
            .fontSize(16)
            .fontColor(Color.White)
            .padding(5)
            .position({ bottom: 5, left: 20 })
            .borderRadius(5)
        }
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

class NewsItem {
  id: string;
  imageSrc: ResourceStr;
  title: string;

  constructor(id: string, imageSrc: ResourceStr, title: string) {
    this.id = id;
    this.imageSrc = imageSrc;
    this.title = title;
  }
}

@Component
struct NewsList {
  @State newsItems: Array<NewsItem> = [
    new NewsItem('news1', $r('app.media.4'), '南大足协赛事月度五佳球出炉，快来看看有无你的主队吧！'),
    new NewsItem('news2', $r('app.media.1'), '软院青春风暴席卷南冠，4-1大胜地科'),
    new NewsItem('news3', $r('app.media.2'), '跌宕起伏，互相送礼，研超蓝色监狱天气联2-2平局收场'),
  ];

  build() {
    Column() {
      ForEach(this.newsItems, (item: NewsItem) => {
        this.renderNewsCard(item);
      }, (item: NewsItem) => item.id);
    }
    .width('100%');
  }

  @Builder
  renderNewsCard(item: NewsItem) {
    Row() { // 使用 Row 来并排显示图片和标题
      Image(item.imageSrc)
        .objectFit(ImageFit.Cover)
        .width(150) // 小图宽度
        .height(120) // 小图高度
        .borderRadius(5)
        .padding(5); // 图片内边距

      Column() { // 标题的列
        Text(item.title)
          .fontSize(16)
          .fontWeight('bold')
          .padding(5)
          .width('55%')
          .position({ top : 20 , left : 160 })
      }
    }
    .padding(10)
    .width('100%')
    .backgroundColor('#FFFFFF')
    .borderRadius(10)
    .onClick(() => {
      router.pushUrl({
        url: `pages/${item.id}`,
      })
    })
    .margin({ bottom: 10 }); // 每个新闻卡片之间的间距
  }
}