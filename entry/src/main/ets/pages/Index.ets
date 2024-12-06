import { Team } from '../model/Team';
import { TeamItem } from '../view/TeamItem';

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  private teams : Team[] = [];

  aboutToAppear(): void {
    this.teams.push( {
      id: 0,
      name: "排头",
      point: 0,
      games : 0,
      win : 0,
      draw : 0,
      lose : 0,
      score : 0,
      loss : 0
    })
      for(let i = 0; i < 10; i++) {
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
        List() {
          ForEach(this.teams, (team : Team, index :number)=> {
            ListItem() {
                TeamItem({name : team.name,
                  point : team.point,
                  index : index,
                  games : team.games,
                  win : team.win,
                  draw : team.draw,
                  lose : team.lose,
                  score : team.score,
                  loss : team.loss})
            }
          })
        }
      }.tabBar(this.TabBuilder("积分榜", 1, $r('app.media.RatingSelected'), $r('app.media.RatingList')))
      TabContent() {

      }.tabBar(this.TabBuilder("比赛", 2, $r('app.media.GameSelected'), $r('app.media.GameList')))
      TabContent() {

      }.tabBar(this.TabBuilder("球员", 3, $r('app.media.PlayerSelected'), $r('app.media.PlayerList')))
    }
  }
}