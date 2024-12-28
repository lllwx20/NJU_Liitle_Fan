import { Team } from '../model/Team';
import Logger from '../utils/Logger';
import { TeamItem } from '../view/TeamItem';
import TeamViewModel from '../viewmodel/TeamViewModel';
import FirstPage from './FirstPage';
import PlayerPage from './PlayerPage';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  private teams : Team[] = [];
  myScroller : Scroller = new Scroller()
  @State yOffset : number = 0
  async aboutToAppear() {
     this.teams = await TeamViewModel.getTeamList()
      Logger.info('Team List:', JSON.stringify(this.teams));
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
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
  }

  build() {
    Tabs({barPosition: BarPosition.End , controller : this.controller}) {
      TabContent() {
        FirstPage()
          .padding({bottom : 78})
      }.tabBar(this.TabBuilder("首页", 0, $r('app.media.FirstPageSelected'), $r('app.media.FirstPageList')))
      TabContent() {
        //
      }.tabBar(this.TabBuilder("比赛", 1, $r('app.media.GameSelected'), $r('app.media.GameList')))
      TabContent() {
        Stack() {
          Scroll(this.myScroller) {
            List() {
              ForEach(this.teams, (team: Team, index: number) => {
                ListItem() {
                  TeamItem({
                    team : team,
                    index: index + 1,
                  })
                }
              })
            }.margin({ top: 50 })
          }
          .width('100%')
          .height('100%')
          .onWillScroll(()=> {
              this.yOffset = this.myScroller.currentOffset().yOffset
            console.log('y:'+this.yOffset)
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
          if(this.yOffset > 100) {
            Image($r("app.media.toTop4"))
              .width(50)
              .height(50)
              .position({ x: 175, y: 30 })
              .clipShape(new Circle({ width: 50, height: 50 }))
              .onClick(() => {
                this.myScroller.scrollEdge(Edge.Top)
              })
          }
        }
      }.tabBar(this.TabBuilder("积分榜", 2, $r('app.media.RatingSelected'), $r('app.media.RatingList')))
      TabContent() {
        PlayerPage()
          .padding({bottom : 78})
      }.tabBar(this.TabBuilder("球员榜", 3, $r('app.media.PlayerSelected'), $r('app.media.PlayerList')))
    }.scrollable(false)
  }
}