import { Team } from '../model/Team';
import Logger from '../utils/Logger';
import { TeamItem } from '../view/TeamItem';
import { GameItem } from '../view/GameItem';
import TeamViewModel from '../viewmodel/TeamViewModel';
import FirstPage from './FirstPage';
import PlayerPage from './PlayerPage';
import MyPage from './MyPage';
import { getUid, Logged } from '../utils/PreferenceUtil';
import { Game, GameStatus } from '../model/Game'
import { Player} from '../model/Player'
import GameViewModel from '../viewmodel/GameViewModel'
type GroupedMap = Map<string, Game[]>;

@Entry
@Component
struct Index {
  @State message: string = 'Hello World';
  @State currentIndex: number = 0
  private controller: TabsController = new TabsController()
  @State imageSize : number = 0
  @State imageX : number = 200
  @State imageY : number = 55
  private teams: Team[] = [];
  private games: Game[] = [];
  //用于集成game类
  private groupedMap: GroupedMap = new Map();


  myScroller: Scroller = new Scroller()
  @State yOffset: number = 0


  getFormattedTime(date: Date): string {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
  }

  getGameStatus(game : Game) {
    const currentTime = new Date(); // 获取当前时间
    const gameStartTime = game.gameTime;
    const gameEndTime = new Date(gameStartTime.getTime() + 75 * 60 * 1000); // 比赛结束时间：开始时间 + 75分钟
    if (currentTime < gameStartTime) {
      game.status = GameStatus.NotStarted  // 比赛未开始
    } else if (currentTime >= gameStartTime && currentTime <= gameEndTime) {
      game.status = GameStatus.Ongoing // 比赛进行中
    } else {
      game.status = GameStatus.Ended  // 比赛已结束
    }
  }


  async aboutToAppear() {
    this.games = await GameViewModel.getAllGames()
    this.teams = await TeamViewModel.getTeamList()



    Logger.info('Team List:', JSON.stringify(this.teams));
    // 排序比赛

    this.games.sort((a, b) => {
      const aTime = new Date(a.gameTime).getTime();
      const bTime = new Date(b.gameTime).getTime();
      return aTime - bTime;
    });

    for (let i = 0; i < this.games.length; i++){
      this.games[i].gameTime = new Date(this.games[i].gameTime);
      this.getGameStatus(this.games[i]);
    }


    this.games.forEach((game) => {
      const dateKey = this.getFormattedTime(game.gameTime).split(" ")[0]; // 格式化后的日期部分
      if (!this.groupedMap.has(dateKey)) {
        this.groupedMap.set(dateKey, []);
      }
      this.groupedMap.get(dateKey)?.push(game);
    })





  }

  @State uid: number = 0;

  @State change : boolean = false;

  private getDayOfWeek(dateStr: string): string {
    const days = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    const date = new Date(dateStr); // 将日期字符串转换为 Date 对象
    return days[date.getDay()]; // 返回对应的星期字符串
  }

  onPageShow(): void {
    if (Logged()) {
      this.change = !this.change
      this.uid = parseInt(getUid())
    } else {
      this.uid = 0
    }
    Logger.info('new uid = ' + this.uid);
  }



  // 自定义导航页签的样式
  @Builder
  TabBuilder(title: string, targetIndex: number, selectedImg: Resource, normalImg: Resource) {
    Column() {
      Image(this.currentIndex === targetIndex ? selectedImg : normalImg)
        .size({ width: 25, height: 25 })
      Text(title)
        .fontColor(this.currentIndex === targetIndex ? '#28bff1' : '#8a8a8a')
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .onClick(() => {
      if (this.currentIndex - targetIndex > 1 || this.currentIndex - targetIndex < -1) {

        this.currentIndex = targetIndex
        this.controller.changeIndex(this.currentIndex)

      } else {
        this.currentIndex = targetIndex
        this.controller.changeIndex(this.currentIndex)
      }
    })
  }

  build() {
    Tabs({ barPosition: BarPosition.End, controller: this.controller }) {
      TabContent() {
        FirstPage()
      }.tabBar(this.TabBuilder("首页", 0, $r('app.media.FirstPageSelected'), $r('app.media.FirstPageList')))

      TabContent() {

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
            Image($r("app.media.ToTop"))
              .width(this.imageSize)
              .height(this.imageSize)
              .position({ x: this.imageX, y: this.imageY })
              .clipShape(new Circle({ width: this.imageSize, height: this.imageSize }))
              .onAppear(() => {
                animateTo({
                  duration: 500,
                }, () => {
                  this.imageX = 175
                  this.imageY = 30
                  this.imageSize = 50;
                });

              })
              .onClick(() => {
                this.myScroller.scrollEdge(Edge.Top)
                this.imageSize = 0;
                this.imageX = 200
                this.imageY = 55
              })
          }
        }

      }.tabBar(this.TabBuilder("积分榜", 1, $r('app.media.RatingSelected'), $r('app.media.RatingList')))

      TabContent() {
        List() {
          ForEach(Array.from(this.groupedMap.entries()), (entry: [string, Game[]], index: number) => {
            ListItem() {
              Column() {
                Text(`${entry[0]} ${this.getDayOfWeek(entry[0])}`)
                  .fontSize(14)
                  .fontWeight(FontWeight.Normal)
                  .textAlign(TextAlign.Center);
              }
              .justifyContent(FlexAlign.Center)
              .backgroundColor('#ffe7e7e7')
              .width('100%')
              .borderRadius(4)
              .height(24);
            }
            ForEach(entry[1], (singleGame: Game) => {
              ListItem() {
                GameItem({ game : singleGame })
              }
            })
          })
        }
      }.tabBar(this.TabBuilder("比赛", 2, $r('app.media.GameSelected'), $r('app.media.GameList')))

      TabContent() {

        PlayerPage()
          .padding({ bottom: 78 })

      }.tabBar(this.TabBuilder("球员", 3, $r('app.media.PlayerSelected'), $r('app.media.PlayerList')))

      TabContent() {

        if (this.uid == 0) {
          MyPage({ uid: 0 })
        } else if(this.uid != 0 && this.change){
          MyPage({ uid: this.uid })
        } else {
          MyPage({ uid: this.uid })
        }

      }.tabBar(this.TabBuilder("我的", 4, $r('app.media.self'), $r('app.media.self_no')))
    }.scrollable(false)

  }
}