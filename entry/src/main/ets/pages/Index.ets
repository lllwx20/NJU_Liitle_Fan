import { Team } from '../model/Team';
import Logger from '../utils/Logger';
import { TeamItem } from '../view/TeamItem';
import { GameItem } from '../view/GameItem';
import TeamViewModel from '../viewmodel/TeamViewModel';
import FirstPage from './FirstPage';
import PlayerPage from './PlayerPage';
import MyPage from './MyPage';
import { getUid, Logged } from '../utils/PreferenceUtil';
import { Game } from '../model/Game'
import { Player} from '../model/Player'
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
  //用于集成game类
  private team1 : Team[] = [];
  private games : Game[] = [];
  private players : Player[] = [];
  private groupedMap: GroupedMap = new Map();


  myScroller: Scroller = new Scroller()
  @State yOffset: number = 0

  async aboutToAppear() {
    this.teams = await TeamViewModel.getTeamList()
    Logger.info('Team List:', JSON.stringify(this.teams));

    this.team1.push({
      id: 0,
      teamName: "排头",
      teamPoints: 0,
      teamPlayed: 0,
      teamWin: 0,
      teamDraw: 0,
      teamLose: 0,
      teamGoals: 0,
      teamLoss: 0,
      teamImageUrl: '',
      players: [],
      teamType: '',
      homePlayed: 0,
      visitPlayed: 0,
      homeGoals: 0,
      visitGoals: 0,
      homeLoss: 0,
      visitLoss: 0,
      homePoints: 0,
      visitPoints: 0,
      homeWin: 0,
      visitWin: 0,
      homeLose: 0,
      visitLose: 0,
      homeDraw: 0,
      visitDraw: 0,
      teamSupport: 0,
      teamSteal: 0,
      teamFoul: 0,
      teamYellow: 0,

    })
    const teamNames = ["软院", "数学", "历史", "文学", "医学", "地海", "匡院", "地科", "商院", "生科"];
    const teamLogos = [
      'app.media.team1logo',
      'app.media.team2logo',
      'app.media.team3logo',
      'app.media.team4logo',
      'app.media.team5logo',
      'app.media.team6logo',
      'app.media.team7logo',
      'app.media.team8logo',
      'app.media.team9logo',
      'app.media.team10logo',
    ];


    const player1 = new Player();
    player1.playerName = "谷雨泽"
    player1.number = 10;
    player1.playerImageUrl = 'app.media.people';

    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);
    this.players.push(player1);






    for (let i = 0; i < teamNames.length; i++) {
      this.team1.push({
        id: i,
        teamName: teamNames[i],
        teamImageUrl: teamLogos[i],
        players: this.players,
        teamType: '',
        teamPlayed: Math.floor(Math.random() * (40 - 20) + 20),
        homePlayed: 0,
        visitPlayed: 0,
        teamGoals: Math.floor(Math.random() * (40 - 20) + 20),
        homeGoals: 0,
        visitGoals: 0,
        teamLoss: Math.floor(Math.random() * (40 - 20) + 20),
        homeLoss: 0,
        visitLoss: 0,
        teamPoints: Math.floor(Math.random() * (40 - 20) + 20),
        homePoints: 0,
        visitPoints: 0,
        teamWin: Math.floor(Math.random() * (40 - 20) + 20),
        homeWin: 0,
        visitWin: 0,
        teamLose: Math.floor(Math.random() * (40 - 20) + 20),
        homeLose: 0,
        visitLose: 0,
        teamDraw: Math.floor(Math.random() * (40 - 20) + 20),
        homeDraw: 0,
        visitDraw: 0,
        teamSupport: Math.floor(Math.random() * (40 - 20) + 20),
        teamSteal: 0,
        teamFoul: 0,
        teamYellow: Math.floor(Math.random() * (40 - 20) + 20),

      })
    }


    const getTeamByName = (name: string): Team | undefined => {
      return this.team1.find(t => t.teamName === name);
    };

    // 初始化比赛数组，使用已存在的队伍对象
    const teamSoftYuan = getTeamByName("软院");
    const teamShuXue = getTeamByName("数学");
    const teamLiShi = getTeamByName("历史");
    const teamWenXue = getTeamByName("文学");
    const teamYiXue = getTeamByName("医学");
    const teamDiHai = getTeamByName("地海");
    const teamKuangYuan = getTeamByName("匡院");
    const teamDiKe = getTeamByName("地科");
    const teamShangYuan = getTeamByName("商院");
    const teamShengKe = getTeamByName("生科");



    if (teamSoftYuan && teamShuXue && teamLiShi && teamWenXue  && teamYiXue && teamDiHai && teamKuangYuan && teamDiKe && teamShangYuan && teamShengKe) {

      const currentTime = new Date();

      this.games.push(new Game(teamSoftYuan, teamShuXue, 2, 1, new Date(currentTime.getTime() + 3 * 60 * 60 * 1000)));
      this.games.push(new Game(teamLiShi, teamWenXue, 1, 3, new Date(currentTime.getTime() + 5 * 60 * 60 * 1000)));
      this.games.push(new Game(teamYiXue, teamDiHai, 3, 1, new Date(currentTime.getTime() + 7 * 60 * 60 * 1000)));
      this.games.push(new Game(teamKuangYuan, teamDiKe, 5, 0, new Date(currentTime.getTime() + 9 * 60 * 60 * 1000)));
      this.games.push(new Game(teamSoftYuan, teamShuXue, 2, 1, new Date(currentTime.getTime() - 40 * 60 * 1000)));
      this.games.push(new Game(teamLiShi, teamWenXue, 1, 3, new Date(currentTime.getTime() - 60 * 60 * 1000)));
      this.games.push(new Game(teamYiXue, teamDiHai, 1, 3, new Date(currentTime.getTime() - 50 * 60 * 1000)));
      this.games.push(new Game(teamKuangYuan, teamDiKe, 4, 2, new Date(currentTime.getTime() - 30 * 60 * 1000)));
      this.games.push(new Game(teamShangYuan, teamDiHai, 0, 0, new Date(currentTime.getTime() - 100 * 60 * 1000)));
      this.games.push(new Game(teamShengKe, teamDiKe, 0, 0, new Date(currentTime.getTime() - 120 * 60 * 1000)));
      this.games.push(new Game(teamSoftYuan, teamShuXue, 2, 1, new Date(currentTime.getTime() - 80 * 60 * 1000)));
      this.games.push(new Game(teamLiShi, teamWenXue, 1, 3, new Date(currentTime.getTime() - 90 * 60 * 1000)));
      this.games.push(new Game(teamYiXue, teamDiHai, 8, 2, new Date(currentTime.getTime() - 110 * 60 * 1000)));
      this.games.push(new Game(teamKuangYuan, teamDiKe, 4, 1, new Date(currentTime.getTime() - 130 * 60 * 1000)));
      this.games.push(new Game(teamSoftYuan, teamShuXue, 2, 1, new Date(currentTime.getTime() + 2 * 60 * 60 * 1000)));
      this.games.push(new Game(teamLiShi, teamWenXue, 1, 3, new Date(currentTime.getTime() + 4 * 60 * 60 * 1000)));
      this.games.push(new Game(teamYiXue, teamDiHai, 1, 3, new Date(currentTime.getTime() + 6 * 60 * 60 * 1000)));
      this.games.push(new Game(teamShangYuan, teamShengKe, 4, 2, new Date(currentTime.getTime() - 10 * 60 * 1000)));
    }
    // 排序比赛
    this.games.sort((a, b) => a.time.getTime() - b.time.getTime());
    this.games.forEach((game) => {
      const dateKey = game.getFormattedTime().split(" ")[0]; // 格式化后的日期部分
      if (!this.groupedMap.has(dateKey)) {
        this.groupedMap.set(dateKey, []);
      }
      this.groupedMap.get(dateKey)?.push(game);
    })





  }

  @State uid: number = 0;

  @State change : boolean = false;

  onPageShow(): void {
    if (Logged()) {
      this.change = !this.change
      this.uid = parseInt(getUid())
    } else {
      this.uid = 0
    }
    Logger.info('new uid = ' + this.uid);
  }

  private getDayOfWeek(dateStr: string): string {
    const days = ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"];
    const date = new Date(dateStr); // 将日期字符串转换为 Date 对象
    return days[date.getDay()]; // 返回对应的星期字符串
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
            ForEach(entry[1], (singleGame: Game, gameIndex: number) => {
              ListItem() {
                GameItem({ game: singleGame })
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