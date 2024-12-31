import { App, router } from '@kit.ArkUI';
import PlayerViewModel from '../viewmodel/PlayerViewModel';
import TeamViewModel from '../viewmodel/TeamViewModel'
import CommonConstants from '../constants/CommonConstants';
import { Game, StatComparison } from '../model/Game';
import { Player } from '../model/Player';
import Logger from '../utils/Logger';
import { Container } from '@kit.ArkGraphics3D';
import { Team } from '../model/Team';




@Entry
@Component
export struct GameDetail {
  @State params: object = router.getParams();
  @State game: Game = this.params['game'];
  private controller: TabsController = new TabsController()
  @State currentIndex: number = 0
  @State teamA : Team = new Team;
  @State teamB : Team = new Team;
  @State players_A : Player[] = [];
  @State players_B : Player[] = [];

  generateStats(): StatComparison[] {
    return [
      { label: '场次', teamAData: this.teamA.teamPlayed, teamBData: this.teamB.teamPlayed },
      { label: '进球', teamAData: this.teamA.teamGoals, teamBData: this.teamB.teamGoals },
      { label: '失球', teamAData: this.teamA.teamLoss, teamBData: this.teamB.teamLoss },
      { label: '胜场', teamAData: this.teamA.teamWin, teamBData: this.teamB.teamWin },
      { label: '负场', teamAData: this.teamA.teamLose, teamBData: this.teamB.teamLose },
      { label: '平局', teamAData: this.teamA.teamDraw, teamBData: this.teamB.teamDraw},
      { label: '助攻', teamAData: this.teamA.teamSupport, teamBData: this.teamB.teamSupport },
      { label: '黄牌', teamAData: this.teamA.teamYellow, teamBData: this.teamB.teamYellow },
    ];
  }

  async aboutToAppear() {
    this.teamA = await TeamViewModel.getTeam(this.game.team1);
    this.teamB = await TeamViewModel.getTeam(this.game.team2);
    this.players_A = await PlayerViewModel.getPlayerByTeam(this.teamA.teamName);
    this.players_B = await PlayerViewModel.getPlayerByTeam(this.teamB.teamName);
    this.game.stats = this.generateStats();
  }
  build() {
    if (this.game.status === '已结束') {
      Column() {
        // 背景图片部分
        Column(){
          Row() {
            Row() {
              // 返回按钮 Image 在最左端
              Image($r('app.media.GoBack'))
                .width(20)
                .height(20)
                .margin({ left : 6 ,top : 5 })
                .onClick(() => {
                  router.back();
                })
            }
            .justifyContent(FlexAlign.Start) // 左对齐
            .alignItems(VerticalAlign.Center) // 垂直居中

            Row() {
              // 比赛时间 Text 在最中间
              Text(new Date(this.game.gameTime).toLocaleDateString() + '  '+new Date(this.game.gameTime).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }) )
                .margin({ top: 15,right :45})
                .fontSize(15)
                .fontColor('#ff000000')
            }
            .justifyContent(FlexAlign.Center) // 水平居中
            .alignItems(VerticalAlign.Center) // 垂直居中
            .width('99%') // 确保 Row 容器占满宽度
          }

          Row(){
            Image($r(this.teamA.teamImageUrl))
              .width(70)
              .height(70)
              .borderRadius(50)
              .margin({ right: 20 ,top:30})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/TeamDetail',
                  params: { tid: this.teamA.id }
                })
              })

            // 比分
            Text(`${this.game.team1Score} : ${this.game.team2Score}`)
              .fontSize(40)
              .fontWeight('bold')
              .fontColor('#ffffff')
              .textAlign(TextAlign.Center)
              .margin({ top:35 })
              .fontWeight('bold');

            // 队伍B队徽
            Image($r(this.teamB.teamImageUrl))
              .width(70)
              .height(70)
              .borderRadius(50)
              .margin({ left: 20 ,top:30})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/TeamDetail',
                  params: { tid: this.teamB.id }
                })
              })
          }
          Row(){
            Text(this.teamA.teamName)
              .fontSize(18)
              .margin({top:15,right:80})
              .fontColor('#ffffffff')

            Text(this.teamB.teamName)
              .fontSize(18)
              .margin({top:15,left:80})
              .fontColor('#ffffffff')

          }
          Row(){
            Text("已结束")
              .fontSize(14)
              .fontColor('#ff737373')
          }
        }
        .backgroundImage($r('app.media.game_detail_background'))
        .backgroundImagePosition(Alignment.Center)
        .backgroundImageSize(ImageSize.FILL)
        .width('100%')
        .height(200)

        Row() {
          // 第一个 Tab "阵容"
          Column() {
            Image(this.currentIndex === 0 ? $r('app.media.teamlistSelected') : $r('app.media.teamlist'))
              .size({ width: 25, height: 25 })
            Text('阵容')
              .fontColor(this.currentIndex === 0 ? '#ff000000' : '#8a8a8a')
          }
          .width('50%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = 0;
            this.controller.changeIndex(this.currentIndex);
          })


          Column() {
            Image(this.currentIndex === 1 ? $r("app.media.goalsSelected") : $r("app.media.goals"))
              .size({ width: 25, height: 25 })
            Text('数据')
              .fontColor(this.currentIndex === 1 ? '#ff000000' : '#8a8a8a')
          }
          .width('50%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = 1;
            this.controller.changeIndex(this.currentIndex);
          })
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fffffefe')
        .borderRadius({bottomLeft:20,bottomRight:20})  // 设置圆角，数值越大，圆角越圆

        if (this.currentIndex === 0){
          Column(){
            Row() {
              Text('主队')
                .fontSize(16)
                .fontWeight('bold')
                .margin({ left: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
              Text('客队')
                .fontSize(16)
                .fontWeight('bold')
                .margin({ right: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            Row(){
              Column(){
                ForEach(this.players_A, (player:Player)=>{
                  Row() {
                    // 球员号码
                    Text(player.number.toString())
                      .width(20)
                      .fontSize(14)
                      .fontColor('#000000')
                      .margin({ right: 10 })
                      .fontStyle(FontStyle.Italic);

                    // 球员头像
                    Image($r(player.playerImageUrl))
                      .width(30)
                      .height(30)
                      .borderRadius(20)

                    // 球员名字
                    Text(player.playerName)
                      .fontSize(14)
                      .fontColor('#000000');
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/PlayerDetail',
                      params: { Player: player }
                    })
                  })
                  .margin({ bottom: 10 }); // 每行之间的间距
                });
              }
              .width('43%') // 左边占一半宽度
              .margin({ right: 10 }) // 和右边的队伍之间加点间距
              .justifyContent(FlexAlign.Start) // 确保从顶部开始对齐

              Column(){
                ForEach(this.players_B, (player:Player)=>{
                  Row() {
                    // 球员号码
                    Text(player.number.toString())
                      .width(20)
                      .fontSize(14)
                      .fontColor('#000000')
                      .margin({ right: 10 })
                      .fontStyle(FontStyle.Italic);

                    // 球员头像
                    Image($r(player.playerImageUrl))
                      .width(30)
                      .height(30)
                      .borderRadius(20)

                    // 球员名字
                    Text(player.playerName)
                      .fontSize(14)
                      .fontColor('#000000');
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/PlayerDetail',
                      params: { Player: player }
                    })
                  })
                  .margin({ bottom: 10 }); // 每行之间的间距
                });
              }
              .width('50%') // 左边占一半宽度
              .margin({ left: 10 }) // 和右边的队伍之间加点间距
              .justifyContent(FlexAlign.Start) // 确保从顶部开始对齐
            }
            .backgroundColor('#ffffffff')
            .borderRadius(20)
            .width('90%')
          }

        }else {
          Column(){
            Row() {
              Text(this.teamA.teamName)
                .fontSize(16)
                .fontWeight('bold')
                .margin({ left: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
              Text(this.teamB.teamName)
                .fontSize(16)
                .fontWeight('bold')
                .margin({ right: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            Column(){
              ForEach(this.game.stats , (stat: StatComparison)=>{
                Row(){

                  Text(stat.teamAData.toString())
                    .fontSize(15)
                    .fontColor('#ff000000')
                    .margin({right:10})

                  Rect()
                    .height(12)
                    .width(stat.teamAData/(stat.teamAData+stat.teamBData)*100)
                    .fill(stat.teamAData > stat.teamBData
                      ? '#00FF00' // 绿色
                      : stat.teamAData < stat.teamBData
                        ? '#CCCCCC' // 灰色
                        : '#ff65afde' )

                  Text(stat.label)
                    .fontSize(16)
                    .margin({ left: 10, right: 10 })
                    .fontColor('#ff000000')
                    .fontStyle(FontStyle.Italic)


                  Rect()
                    .height(12)
                    .width(stat.teamBData/(stat.teamAData+stat.teamBData)*100)
                    .fill(stat.teamBData > stat.teamAData
                      ? '#00FF00' // 绿色
                      : stat.teamBData < stat.teamAData
                        ? '#CCCCCC' // 灰色
                        : '#ff65afde')

                  Text(stat.teamBData.toString())
                    .fontSize(15)
                    .fontColor('#ff000000')
                    .margin({left:10})

                }.margin({top:15,bottom:15})

              })
            }
            .backgroundColor('#ffffffff')
            .borderRadius(20)
            .width('90%')
          }
        }

      }
      .backgroundColor('#ffececec')
      .height('100%')
    }
    else if (this.game.status === '进行中') {

      Column() {
        // 背景图片部分
        Column(){
          Row() {
            Row() {
              // 返回按钮 Image 在最左端
              Image($r('app.media.GoBack'))
                .width(20)
                .height(20)
                .margin({ top: 15 })
                .onClick(() => {
                  router.back();
                })
            }
            .justifyContent(FlexAlign.Start) // 左对齐
            .alignItems(VerticalAlign.Center) // 垂直居中

            Row() {
              // 比赛时间 Text 在最中间
              Text(this.game.gameTime.toString())
                .margin({ top: 15 ,right:18})
                .fontSize(14)
                .fontColor('#ff4f4f4f')
            }
            .justifyContent(FlexAlign.Center) // 水平居中
            .alignItems(VerticalAlign.Center) // 垂直居中
            .width('100%') // 确保 Row 容器占满宽度
          }
          Row(){
            Image($r(this.teamA.teamImageUrl))
              .width(70)
              .height(70)
              .borderRadius(50)
              .margin({ right: 20 ,top:30})
              .onClick(() => {
              router.pushUrl({
                url: 'pages/TeamDetail',
                params: { tid: this.teamA.id }
              })
            })

            // 比分
            Text(`? : ?`)
              .fontSize(40)
              .fontWeight('bold')
              .fontColor('#ffffffff')
              .textAlign(TextAlign.Center)
              .margin({ top:35 })
              .fontWeight('bold');

            // 队伍B队徽
            Image($r(this.teamB.teamImageUrl))
              .width(70)
              .height(70)
              .borderRadius(50)
              .margin({ left: 20 ,top:30})
            .onClick(() => {
              router.pushUrl({
                url: 'pages/TeamDetail',
                params: { tid: this.teamB.id }
              })
            })
          }
          Row(){
            Text(this.teamA.teamName)
              .fontSize(18)
              .margin({top:15,right:80})
              .fontColor('#ffffffff')

            Text(this.teamB.teamName)
              .fontSize(18)
              .margin({top: 15,left:80})
              .fontColor('#ffffffff')

          }
          Row(){
            Text("进行中")
              .fontSize(14)
              .fontColor('#ffffffff')
          }
        }
        .backgroundImage($r('app.media.game_detail_background'))
        .backgroundImagePosition(Alignment.Center)
        .backgroundImageSize(ImageSize.FILL)
        .width('100%')
        .height(200)

        Row() {
          // 第一个 Tab "阵容"
          Column() {
            Image(this.currentIndex === 0 ? $r('app.media.teamlistSelected') : $r('app.media.teamlist'))
              .size({ width: 25, height: 25 })
            Text('阵容')
              .fontColor(this.currentIndex === 0 ? '#ff000000' : '#8a8a8a')
          }
          .width('50%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = 0;
            this.controller.changeIndex(this.currentIndex);
          })


          Column() {
            Image(this.currentIndex === 1 ? $r("app.media.goalsSelected") : $r("app.media.goals"))
              .size({ width: 25, height: 25 })
            Text('数据')
              .fontColor(this.currentIndex === 1 ? '#ff000000' : '#8a8a8a')
          }
          .width('50%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = 1;
            this.controller.changeIndex(this.currentIndex);
          })
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fffffefe')
        .borderRadius({bottomLeft:20,bottomRight:20})  // 设置圆角，数值越大，圆角越圆

        if (this.currentIndex === 0){
          Column(){
            Row() {
              Text('主队')
                .fontSize(16)
                .fontWeight('bold')
                .margin({ left: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
              Text('客队')
                .fontSize(16)
                .fontWeight('bold')
                .margin({ right: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            Row(){
              Column(){
                ForEach(this.players_A, (player:Player)=>{
                  Row() {
                    // 球员号码
                    Text(player.number.toString())
                      .width(20)
                      .fontSize(14)
                      .fontColor('#000000')
                      .margin({ right: 10 })
                      .fontStyle(FontStyle.Italic);

                    // 球员头像
                    Image($r(player.playerImageUrl))
                      .width(30)
                      .height(30)
                      .borderRadius(20)

                    // 球员名字
                    Text(player.playerName)
                      .fontSize(14)
                      .fontColor('#000000');
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/PlayerDetail',
                      params: { Player: player }
                    })
                  })
                  .margin({ bottom: 10 }); // 每行之间的间距
                });
              }
              .width('43%') // 左边占一半宽度
              .margin({ right: 10 }) // 和右边的队伍之间加点间距
              .justifyContent(FlexAlign.Start) // 确保从顶部开始对齐

              Column(){
                ForEach(this.players_B, (player:Player)=>{
                  Row() {
                    // 球员号码
                    Text(player.number.toString())
                      .width(20)
                      .fontSize(14)
                      .fontColor('#000000')
                      .margin({ right: 10 })
                      .fontStyle(FontStyle.Italic);

                    // 球员头像
                    Image($r(player.playerImageUrl))
                      .width(30)
                      .height(30)
                      .borderRadius(20)

                    // 球员名字
                    Text(player.playerName)
                      .fontSize(14)
                      .fontColor('#000000');
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/PlayerDetail',
                      params: { Player: player }
                    })
                  })
                  .margin({ bottom: 10 }); // 每行之间的间距
                });
              }
              .width('50%') // 左边占一半宽度
              .margin({ left: 10 }) // 和右边的队伍之间加点间距
              .justifyContent(FlexAlign.Start) // 确保从顶部开始对齐
            }
            .backgroundColor('#ffffffff')
            .borderRadius(20)
            .width('90%')
          }

        }else {
          Column(){
            Row() {
              Text(this.teamA.teamName)
                .fontSize(16)
                .fontWeight('bold')
                .margin({ left: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
              Text(this.teamB.teamName)
                .fontSize(16)
                .fontWeight('bold')
                .margin({ right: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            Column(){
              ForEach(this.game.stats , (stat: StatComparison)=>{
                Row(){

                  Text(stat.teamAData.toString())
                    .fontSize(15)
                    .fontColor('#ff000000')
                    .margin({right:10})

                  Rect()
                    .height(12)
                    .width(stat.teamAData/(stat.teamAData+stat.teamBData)*100)
                    .fill(stat.teamAData > stat.teamBData
                      ? '#00FF00' // 绿色
                      : stat.teamAData < stat.teamBData
                        ? '#CCCCCC' // 灰色
                        : '#ff65afde' )

                  Text(stat.label)
                    .fontSize(16)
                    .margin({ left: 10, right: 10 })
                    .fontColor('#ff000000')
                    .fontStyle(FontStyle.Italic)


                  Rect()
                    .height(12)
                    .width(stat.teamBData/(stat.teamAData+stat.teamBData)*100)
                    .fill(stat.teamBData > stat.teamAData
                      ? '#00FF00' // 绿色
                      : stat.teamBData < stat.teamAData
                        ? '#CCCCCC' // 灰色
                        : '#ff65afde')

                  Text(stat.teamBData.toString())
                    .fontSize(15)
                    .fontColor('#ff000000')
                    .margin({left:10})

                }.margin({top:15,bottom:15})

              })
            }
            .backgroundColor('#ffffffff')
            .borderRadius(20)
            .width('90%')
          }
        }

      }
      .backgroundColor('#ffececec')
      .height('100%')
    }
    else  {
      Column(){
        // 背景图片部分
        Column(){
          Row() {
            Row() {
              // 返回按钮 Image 在最左端
              Image($r('app.media.GoBack'))
                .width(20)
                .height(20)
                .margin({ top: 15 })
                .onClick(() => {
                  router.back();
                })
            }
            .justifyContent(FlexAlign.Start) // 左对齐
            .alignItems(VerticalAlign.Center) // 垂直居中

            Row() {
              // 比赛时间 Text 在最中间
              Text(this.game.gameTime.toString())
                .margin({ top: 15 ,right:18})
                .fontSize(14)
                .fontColor('#ff4f4f4f')
            }
            .justifyContent(FlexAlign.Center) // 水平居中
            .alignItems(VerticalAlign.Center) // 垂直居中
            .width('100%') // 确保 Row 容器占满宽度
          }
          Row(){
            Image($r(this.teamA.teamImageUrl))
              .width(70)
              .height(70)
              .borderRadius(50)
              .margin({ right: 20 ,top:30})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/TeamDetail',
                  params: { tid: this.teamA.id }
                })
              })

            // 比分
            Text(`? : ?`)
              .fontSize(40)
              .fontWeight('bold')
              .fontColor('#ffffffff')
              .textAlign(TextAlign.Center)
              .margin({ top:35 })
              .fontWeight('bold');

            // 队伍B队徽
            Image($r(this.teamB.teamImageUrl))
              .width(70)
              .height(70)
              .borderRadius(50)
              .margin({ left: 20 ,top:30})
              .onClick(() => {
                router.pushUrl({
                  url: 'pages/TeamDetail',
                  params: { tid: this.teamB.id }
                })
              })
          }
          Row(){
            Text(this.teamA.teamName)
              .fontSize(18)
              .margin({top:15,right:80})
              .fontColor('#ffffffff')

            Text(this.teamB.teamName)
              .fontSize(18)
              .margin({top: 15,left:80})
              .fontColor('#ffffffff')

          }
          Row(){
            Text("未开始")
              .fontSize(14)
              .fontColor('#ffffffff')
          }
        }
        .backgroundImage($r('app.media.game_detail_background'))
        .backgroundImagePosition(Alignment.Center)
        .backgroundImageSize(ImageSize.FILL)
        .width('100%')
        .height(200)



        Row() {
          // 第一个 Tab "阵容"
          Column() {
            Image(this.currentIndex === 0 ? $r('app.media.teamlistSelected') : $r('app.media.teamlist'))
              .size({ width: 25, height: 25 })
            Text('阵容')
              .fontColor(this.currentIndex === 0 ? '#ff000000' : '#8a8a8a')
          }
          .width('50%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = 0;
            this.controller.changeIndex(this.currentIndex);
          })


          Column() {
            Image(this.currentIndex === 1 ? $r("app.media.goalsSelected") : $r("app.media.goals"))
              .size({ width: 25, height: 25 })
            Text('数据')
              .fontColor(this.currentIndex === 1 ? '#ff000000' : '#8a8a8a')
          }
          .width('50%')
          .height(50)
          .justifyContent(FlexAlign.Center)
          .onClick(() => {
            this.currentIndex = 1;
            this.controller.changeIndex(this.currentIndex);
          })
        }
        .width('100%')
        .height(50)
        .backgroundColor('#fffffefe')
        .borderRadius({bottomLeft:20,bottomRight:20})  // 设置圆角，数值越大，圆角越圆


        if (this.currentIndex === 0){
          Column(){
            Row() {
              Text('主队')
                .fontSize(16)
                .fontWeight('bold')
                .margin({ left: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
              Text('客队')
                .fontSize(16)
                .fontWeight('bold')
                .margin({ right: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            Row(){
              Column(){
                ForEach(this.players_A, (player:Player)=>{
                  Row() {
                    // 球员号码
                    Text(player.number.toString())
                      .width(20)
                      .fontSize(14)
                      .fontColor('#000000')
                      .margin({ right: 10 })
                      .fontStyle(FontStyle.Italic);

                    // 球员头像
                    Image($r(player.playerImageUrl))
                      .width(30)
                      .height(30)
                      .borderRadius(20)

                    // 球员名字
                    Text(player.playerName)
                      .fontSize(14)
                      .fontColor('#000000');
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/PlayerDetail',
                      params: { Player: player }
                    })
                  })
                  .margin({ bottom: 10 }); // 每行之间的间距
                });
              }
              .width('43%') // 左边占一半宽度
              .margin({ right: 10 }) // 和右边的队伍之间加点间距
              .justifyContent(FlexAlign.Start) // 确保从顶部开始对齐

              Column(){
                ForEach(this.players_B, (player:Player)=>{
                  Row() {
                    // 球员号码
                    Text(player.number.toString())
                      .width(20)
                      .fontSize(14)
                      .fontColor('#000000')
                      .margin({ right: 10 })
                      .fontStyle(FontStyle.Italic);

                    // 球员头像
                    Image($r(player.playerImageUrl))
                      .width(30)
                      .height(30)
                      .borderRadius(20)

                    // 球员名字
                    Text(player.playerName)
                      .fontSize(14)
                      .fontColor('#000000');
                  }
                  .onClick(()=>{
                    router.pushUrl({
                      url: 'pages/PlayerDetail',
                      params: { Player: player }
                    })
                  })
                  .margin({ bottom: 10 }); // 每行之间的间距
                });
              }
              .width('50%') // 左边占一半宽度
              .margin({ left: 10 }) // 和右边的队伍之间加点间距
              .justifyContent(FlexAlign.Start) // 确保从顶部开始对齐
            }
            .backgroundColor('#ffffffff')
            .borderRadius(20)
            .width('90%')
          }

        }else {
          Column(){
            Row() {
              Text(this.teamA.teamName)
                .fontSize(16)
                .fontWeight('bold')
                .margin({ left: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
              Text(this.teamB.teamName)
                .fontSize(16)
                .fontWeight('bold')
                .margin({ right: 70, top: 15, bottom: 10 })
                .fontColor('#000000');
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween);

            Column(){
              ForEach(this.game.stats , (stat: StatComparison)=>{
                Row(){

                  Text(stat.teamAData.toString())
                    .fontSize(15)
                    .fontColor('#ff000000')
                    .margin({right:10})

                  Rect()
                    .height(12)
                    .width(stat.teamAData/(stat.teamAData+stat.teamBData)*100)
                    .fill(stat.teamAData > stat.teamBData
                      ? '#00FF00' // 绿色
                      : stat.teamAData < stat.teamBData
                        ? '#CCCCCC' // 灰色
                        : '#ff65afde' )

                  Text(stat.label)
                    .fontSize(16)
                    .margin({ left: 10, right: 10 })
                    .fontColor('#ff000000')
                    .fontStyle(FontStyle.Italic)


                  Rect()
                    .height(12)
                    .width(stat.teamBData/(stat.teamAData+stat.teamBData)*100)
                    .fill(stat.teamBData > stat.teamAData
                      ? '#00FF00' // 绿色
                      : stat.teamBData < stat.teamAData
                        ? '#CCCCCC' // 灰色
                        : '#ff65afde')

                  Text(stat.teamBData.toString())
                    .fontSize(15)
                    .fontColor('#ff000000')
                    .margin({left:10})

                }.margin({top:15,bottom:15})

              })
            }
            .backgroundColor('#ffffffff')
            .borderRadius(20)
            .width('90%')
          }
        }
      }
      .backgroundColor('#ffececec')
      .height('100%')
    }
  }

}
