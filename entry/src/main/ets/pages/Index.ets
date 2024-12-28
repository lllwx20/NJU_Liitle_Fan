import { Team } from '../model/Team';
import Logger from '../utils/Logger';
import { TeamItem } from '../view/TeamItem';
import TeamViewModel from '../viewmodel/TeamViewModel';
import FirstPage from './FirstPage';
import PlayerPage from './PlayerPage';
import { ItemInfo } from '@kit.MediaLibraryKit';
import MyPage from './MyPage';
import { router } from '@kit.ArkUI';
import { getUid, Logged } from '../utils/PreferenceUtil';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  @State imageSize : number = 0

  private teams : Team[] = [];
  myScroller : Scroller = new Scroller()
  @State yOffset : number = 0

  async aboutToAppear() {
    this.teams = await TeamViewModel.getTeamList()
    Logger.info('Team List:', JSON.stringify(this.teams));
  }

  @State Loading : boolean = false;

  @State uid : number = 0;

  onPageShow(): void {
    if(Logged()) {
      this.uid = parseInt(getUid())
    }
  }

  // 自定义导航页签的样式
  @Builder TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#28bff1' : '#8a8a8a')
    }
    .width('100%')
    .height(50)
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if(this.currentIndex - targetIndex > 1 || this.currentIndex - targetIndex < -1) {
        this.Loading = true;
        this.currentIndex = targetIndex
        this.controller.changeIndex(this.currentIndex)
        setTimeout(() => {
          this.Loading = false
        }, 75)
      } else {
        this.currentIndex = targetIndex
        this.controller.changeIndex(this.currentIndex)
      }
    })
  }

  build() {
    Tabs({barPosition: BarPosition.End , controller : this.controller}) {
      TabContent() {
        FirstPage()
          .padding({bottom : 78})
      }.tabBar(this.TabBuilder("首页", 0, $r('app.media.FirstPageSelected'), $r('app.media.FirstPageList')))
      TabContent() {
        if(!this.Loading) {
          Stack() {
            Scroll(this.myScroller) {
              List() {
                ForEach(this.teams, (team: Team, index: number) => {
                  ListItem() {
                    TeamItem({
                      team: team,
                      index: index + 1,
                    })
                  }
                })
              }.margin({ top: 50 })
            }
            .width('100%')
            .height('100%')
            .onWillScroll(() => {
              this.yOffset = this.myScroller.currentOffset().yOffset
              console.log('y:' + this.yOffset)
            })

            Row() {
              Text("排名")
                .margin({ left: 8 })
                .fontSize(18)
                .width(44)
              Text("球队")
                .width(70)
                .textAlign(TextAlign.Center)
                .fontSize(18)
              Text("场次")
                .width(60)
                .textAlign(TextAlign.Center)
                .fontSize(18)
              Text("胜/平/负")
                .width(80)
                .textAlign(TextAlign.Center)
                .fontSize(18)
              Text("进/失球")
                .width(70)
                .textAlign(TextAlign.Center)
                .fontSize(18)
              Text("积分")
                .width(50)
                .textAlign(TextAlign.Center)
                .fontSize(18)
            }
            .position({
              x: 0,
              y: 0
            })
            .alignSelf(ItemAlign.Center)
            .backgroundColor('#F1F3F5')
            .width('100%')
            .height(50)
            .hoverEffect(1)

            if (this.yOffset > 100) {
              Image($r("app.media.toTop4"))
                .width(this.imageSize)
                .height(this.imageSize)
                .position({ x: 175, y: 30 })
                .clipShape(new Circle({ width: this.imageSize, height: this.imageSize }))
                .onAppear(()=> {
                  animateTo({
                    duration: 500,
                  }, () => {
                    this.imageSize = 50;
                  });
                })
                .onClick(() => {
                  this.myScroller.scrollEdge(Edge.Top)
                })
            }
          }
        }
      }.tabBar(this.TabBuilder("积分榜", 1, $r('app.media.RatingSelected'), $r('app.media.RatingList')))
      TabContent() {

      }.tabBar(this.TabBuilder("比赛", 2, $r('app.media.GameSelected'), $r('app.media.GameList')))
      TabContent() {
        if(!this.Loading) {
          PlayerPage()
            .padding({ bottom: 78 })
        }
      }.tabBar(this.TabBuilder("球员", 3, $r('app.media.PlayerSelected'), $r('app.media.PlayerList')))
      TabContent() {
        if(!this.Loading) {
          if(this.uid == 0) {
            MyPage({ uid: 0 })
          } else {
            MyPage({ uid: this.uid })
          }
        }
      }.tabBar(this.TabBuilder("我的", 4, $r('app.media.self'), $r('app.media.self_no')))
    }.scrollable(false)

  }
}