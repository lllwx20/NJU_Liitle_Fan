import { Team } from '../model/Team';
import { TeamItem } from '../view/TeamItem';
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
  aboutToAppear(): void {

      for(let i = 0; i < 20; i++) {
        this.teams.push({
          id: 0,
          name: "软院",
          point: 0,
          games : 0,
          win : 0,
          draw : 0,
          lose : 0,
          score : 0,
          loss : 0
        })
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
      this.currentIndex = targetIndex
      this.controller.changeIndex(this.currentIndex)
    })
  }

  build() {
    Tabs({barPosition: BarPosition.End , controller : this.controller}) {
      TabContent() {

      }.tabBar(this.TabBuilder("首页", 0, $r('app.media.FirstPageSelected'), $r('app.media.FirstPageList')))
      TabContent() {
        Stack() {
          Scroll(this.myScroller) {
            List() {
              ForEach(this.teams, (team: Team, index: number) => {
                ListItem() {
                  TeamItem({
                    tid: team.id,
                    name: team.name,
                    point: team.point,
                    index: index,
                    games: team.games,
                    win: team.win,
                    draw: team.draw,
                    lose: team.lose,
                    score: team.score,
                    loss: team.loss
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
              .margin({ left: 12 })
              .fontSize(15)
            Text("球队")
              .margin({ left: 30 })
              .fontSize(15)
            Text("场次")
              .margin({ left: 39 })
              .fontSize(15)
            Text("胜/平/负")
              .margin({ left: 23 })
              .fontSize(15)
            Text("进/失球")
              .margin({ left: 23 })
              .fontSize(15)
            Text("积分")
              .margin({ left: 26 })
              .fontSize(15)
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
      }.tabBar(this.TabBuilder("积分榜", 1, $r('app.media.RatingSelected'), $r('app.media.RatingList')))
      TabContent() {

      }.tabBar(this.TabBuilder("比赛", 2, $r('app.media.GameSelected'), $r('app.media.GameList')))
      TabContent() {
        PlayerPage()
          .padding({bottom : 75})
      }.tabBar(this.TabBuilder("球员", 3, $r('app.media.PlayerSelected'), $r('app.media.PlayerList')))
    }
  }
}