import { router } from '@kit.ArkUI'

import TeamConstants from '../constants/TeamConstants';
import { Team } from '../model/Team';
import TeamViewModel from '../viewmodel/TeamViewModel';
import { hfp } from '@kit.ConnectivityKit';
import { Player } from '../model/Player';
import PlayerViewModel from '../viewmodel/PlayerViewModel';
import PlayerItem from '../view/PlayerItem';


@Entry
@Component
struct TeamDetail {
  params: object = router.getParams();
  @State tid: number = this.params['tid'];
  @State name: string = "软院"
  @State totalPoints: number = 0
  @State totalGoals : number = 0
  @State score: number = 0
  @State loss: number = 0;
  @State games: number = 0;
  @State index: number = this.params['index']
  @State points: number = 0;
  @State win: number = 10;
  @State draw: number = 2;
  @State lose: number = 3;
  @State support: number = 0;
  @State steal: number = 0;
  @State foul: number = 0;
  @State yellow: number = 0;
  @State winRate: string = "";
  @State drawRate: string = "";
  @State loseRate: string = "";
  @State flag: boolean = true
  chooseColor: string = '#33A1F5'
  team: Team = new Team();
  players : Player[] = [];
  @State total_font: string = 'white'
  @State total_bg: string = this.chooseColor
  @State home_font: string = 'gray'
  @State home_bg: string = 'white'
  @State visit_font: string = 'gray'
  @State visit_bg: string = 'white'

  async aboutToAppear() {
    this.team = await TeamViewModel.getTeam(this.tid);
    this.name = this.team.teamName
    this.players = await PlayerViewModel.getPlayerByTeam(this.name)
    this.totalPoints = this.team.teamPoints
    this.totalGoals = this.team.teamGoals
    this.points = this.team.teamPoints
    this.score = this.team.teamGoals
    this.loss = this.team.teamLoss
    this.games = this.team.teamPlayed
    this.win = this.team.teamWin
    this.lose = this.team.teamLose
    this.draw = this.team.teamDraw
    this.support = this.team.teamSupport
    this.steal = this.team.teamSteal
    this.foul = this.team.teamFoul
    this.yellow = this.team.teamYellow
    this.winRate = parseFloat((this.win / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
    this.drawRate = parseFloat((this.draw / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
    this.loseRate = parseFloat((this.lose / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
    this.flag = false
  }

  @Builder
  data(num: number, dataName: string) {
    Column() {
      Text(num.toString())
        .fontSize(25)
        .fontWeight(FontWeight.Bold)
      Text(dataName)
        .fontSize(15)
        .fontColor(Color.Gray)

    }
  }

  @Styles
  card(){
    .width('95%')
    .padding(20)
    .backgroundColor(Color.White)
    .margin({
      left: 9
    })
    .borderRadius(15)
    .shadow({
      radius: 6,
      color: 'e6e6e6',
      offsetX: 2,
      offsetY: 4
    })
  }

  build() {
    if (this.flag) {
      Text("Loading...")
        .align(Alignment.Center)
        .fontSize(60)
        .margin({
          top: 100
        })
    } else {
      Column() {

        Row() {
          Column() {
            Image($r('app.media.GoBack'))
              .width(20)
              .height(20)
              .onClick(() => {
                router.back()
              })
              .alignSelf(ItemAlign.Start)
              .margin({ top: 0 })
            Text(this.name)
              .fontSize(30)
              .fontColor('white')
              .margin({ top: 10, left: 20 })
              .alignSelf(ItemAlign.Start)
            Row() {
              Column() {
                Text(this.index.toString())
                  .fontSize(35)
                  .fontWeight(FontWeight.Bold)
                  .fontStyle(FontStyle.Italic)
                  .fontColor('white')
                  .margin({ left: 15, top: 15 })
                Text("联赛排名")
                  .fontSize(15)
                  .fontColor('#E2EAF4')
                  .margin({ left: 15 })
              }

              Column() {
                Text(this.totalPoints.toString())
                  .fontSize(35)
                  .fontWeight(FontWeight.Bold)
                  .fontStyle(FontStyle.Italic)
                  .fontColor('white')
                  .margin({ left: 15, top: 15 })
                Text("积分")
                  .fontSize(15)
                  .fontColor('#E2EAF4')
                  .margin({ left: 15 })
              }.margin({ left: 50 })
            }
          }

          Image($r(this.team.teamImageUrl))
            .width(100)
            .height(100)
            .margin({ left: 75 })

        }
        .backgroundImage($r('app.media.TeamBackground2'))
        .backgroundImagePosition(Alignment.Center)
        .backgroundImageSize(ImageSize.FILL)
        .width('100%')
        .height(200)

        Tabs() {
          TabContent() {
            Column() {
              Row() {
                Column() {
                  Text(this.totalGoals.toString())
                    .fontSize(35)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                  Text("进球")
                    .fontSize(15)
                    .fontColor(Color.Gray)
                    .textAlign(TextAlign.Center)
                }.width(65)


                Column() {
                  Text(this.support.toString())
                    .fontSize(35)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                  Text("助攻")
                    .fontSize(15)
                    .fontColor(Color.Gray)
                    .textAlign(TextAlign.Center)
                }.width(65)

                Column() {
                  Text(this.steal.toString())
                    .fontSize(35)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                  Text("抢断")
                    .fontSize(15)
                    .fontColor(Color.Gray)
                    .textAlign(TextAlign.Center)
                }.width(65)

                Column() {
                  Text(this.foul.toString())
                    .fontSize(35)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                  Text("犯规")
                    .fontSize(15)
                    .fontColor(Color.Gray)
                    .textAlign(TextAlign.Center)
                }.width(65)

                Column() {
                  Text(this.yellow.toString())
                    .fontSize(35)
                    .fontWeight(FontWeight.Bold)
                    .textAlign(TextAlign.Center)
                  Text("黄牌")
                    .fontSize(15)
                    .fontColor(Color.Gray)
                    .textAlign(TextAlign.Center)
                }.width(65)
              }.card()
              .margin({ top: 15 })

              Column() {

                Text("联赛积分")
                  .fontSize(20)
                  .margin({ left: 20, top: 25 })
                  .alignSelf(ItemAlign.Start)
                  .fontWeight(FontWeight.Bold)
                Row({ space: 15 }) {
                  Button("总榜单")
                    .fontSize(15)
                    .fontColor(this.total_font)
                    .height(25)
                    .width(80)
                    .backgroundColor(this.total_bg)
                    .shadow({
                      radius: 3
                    })
                    .onClick(() => {
                      this.points = this.team.teamPoints
                      this.score = this.team.teamGoals
                      this.loss = this.team.teamLoss
                      this.games = this.team.teamPlayed
                      this.win = this.team.teamWin
                      this.lose = this.team.teamLose
                      this.draw = this.team.teamDraw
                      this.total_font = 'white'
                      this.total_bg = this.chooseColor
                      this.home_font = 'gray'
                      this.home_bg = 'white'
                      this.visit_font = 'gray'
                      this.visit_bg = 'white'
                      this.winRate = parseFloat((this.win / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                      this.drawRate =
                        parseFloat((this.draw / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                      this.loseRate =
                        parseFloat((this.lose / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                    })
                  Button("主场")
                    .fontSize(15)
                    .fontColor(this.home_font)
                    .height(25)
                    .width(80)
                    .backgroundColor(this.home_bg)
                    .shadow({
                      radius: 3
                    })
                    .onClick(() => {
                      this.points = this.team.homePoints
                      this.games = this.team.homePlayed
                      this.win = this.team.homeWin
                      this.lose = this.team.homeLose
                      this.draw = this.team.homeDraw
                      this.score = this.team.homeGoals
                      this.loss = this.team.homeLoss
                      this.home_font = 'white'
                      this.home_bg = this.chooseColor
                      this.total_font = 'gray'
                      this.total_bg = 'white'
                      this.visit_font = 'gray'
                      this.visit_bg = 'white'
                      this.winRate = parseFloat((this.win / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                      this.drawRate =
                        parseFloat((this.draw / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                      this.loseRate =
                        parseFloat((this.lose / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                    })
                  Button("客场")
                    .fontSize(15)
                    .fontColor(this.visit_font)
                    .height(25)
                    .width(80)
                    .backgroundColor(this.visit_bg)
                    .shadow({
                      radius: 3
                    })
                    .onClick(() => {
                      this.points = this.team.visitPoints
                      this.games = this.team.visitPlayed
                      this.win = this.team.visitWin
                      this.lose = this.team.visitLose
                      this.draw = this.team.visitDraw
                      this.score = this.team.visitGoals
                      this.loss = this.team.visitLoss
                      this.visit_font = 'white'
                      this.visit_bg = this.chooseColor
                      this.total_font = 'gray'
                      this.total_bg = 'white'
                      this.home_font = 'gray'
                      this.home_bg = 'white'
                      this.winRate = parseFloat((this.win / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                      this.drawRate =
                        parseFloat((this.draw / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                      this.loseRate =
                        parseFloat((this.lose / (this.win + this.draw + this.lose) * 100).toFixed(2)) + "%";
                    })
                }.margin({ top: 20 })

                Row() {
                  Stack() {
                    Column() {
                      Text(this.index.toString())
                        .fontSize(35)
                        .fontWeight(FontWeight.Bold)
                        .fontStyle(FontStyle.Italic)

                      Text("排名")
                        .fontSize(15)
                        .fontColor(Color.Gray)
                    }

                    Progress({
                      value: 100,
                      total: 100,
                      type: ProgressType.Ring
                    })
                      .style({ strokeWidth: 10 })
                      .color('#FE5555')
                      .size({ width: 100, height: 100 })
                    Progress({
                      value: (this.lose + this.draw) / (this.win + this.draw + this.lose) * 100,
                      total: 100,
                      type: ProgressType.Ring
                    })
                      .style({ strokeWidth: 10 })
                      .color('#22AAF4')
                      .size({ width: 100, height: 100 })
                    Progress({
                      value: this.lose / (this.win + this.draw + this.lose) * 100,
                      total: 100,
                      type: ProgressType.Ring
                    })
                      .style({ strokeWidth: 10 })
                      .color('#069D18')
                      .size({ width: 100, height: 100 })

                  }

                  Column() {
                    Text(this.win + "胜" + this.draw + "平" + this.lose + "负")
                      .fontSize(25)
                      .fontWeight(FontWeight.Bold)
                      .margin({ left: 5 })

                    Text("积分：" + this.points)
                      .fontSize(15)
                      .margin({ top: 5 })

                  }.margin({ left: 15 })
                }.margin({ top: 25 });

                Row() {
                  Column() {
                    Text(this.score.toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("进球")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }
                  .width(100)

                  Column() {
                    Text(this.loss.toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("失球")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(90)

                  Column() {
                    Text((this.score - this.loss).toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("净胜球")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(90)

                  Column() {
                    Text(parseFloat((this.score / this.games).toFixed(2)).toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("均进")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(100)
                }.margin({ top: 20 })

                Row() {
                  Column() {
                    Text(this.winRate.toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("胜率")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(100)

                  Column() {
                    Text(this.drawRate.toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("平率")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(90)

                  Column() {
                    Text(this.loseRate.toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("负率")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(90)

                  Column() {
                    Text(parseFloat((this.loss / this.games).toFixed(2)).toString())
                      .fontSize(TeamConstants.DATA_SIZE)
                      .fontWeight(FontWeight.Bold)
                    Text("均失")
                      .fontSize(TeamConstants.DATA_NAME_SIZE)
                      .fontColor(Color.Gray)

                  }.width(100)
                }.margin({ top: 30 })
              }.width('100%')
              .margin({ top: 15 })
              .height("100%")
              .backgroundColor(Color.White)

            }
            .width('100%')
            .height('100%')
            .backgroundColor('#F1F3F5')

          }.tabBar("数据")

          TabContent() {
            List({ space: 10 }) {
              ForEach(this.players, (item: Player, index: number) => {
                ListItem() {
                  PlayerItem({
                    PlayerItem: item,
                    rank: index + 1,
                    data: -1
                  })
                }
                .width('95%')
                .margin({
                  left: 11
                })
                .borderRadius(15)
              })
            }
            .width('100%')
            .height('100%')
            .backgroundColor('#F1F3F5')
          }.tabBar("阵容")

          TabContent() {

          }.tabBar("赛程")
        }

      }
    }
  }
}