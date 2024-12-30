import { Game } from "../model/Game";
import { Team } from "../model/Team";
import { promptAction, router } from '@kit.ArkUI';
import Logger from '../utils/Logger';
import  GameViewModel  from '../viewmodel/GameViewModel'
import TeamViewModel from '../viewmodel/TeamViewModel'
import { getUid, Logged, setChanged } from "../utils/PreferenceUtil";
import UserViewModel from "../viewmodel/UserViewModel";


@Component
export struct GameItem {
  @Prop year : boolean
  @Prop game : Game ;
  @State teamA : Team = new Team();
  @State teamB : Team = new Team();
  @State isSubscribed : boolean = false



  async aboutToAppear() {
    if(Logged()) {
      this.isSubscribed = await GameViewModel.IsSubscribed(parseInt(getUid()), this.game.id)
    }
    this.teamA = await TeamViewModel.getTeam(this.game.team1);
    this.teamB = await TeamViewModel.getTeam(this.game.team2);
  }
  build() {

    Column()
    {

      // 添加时间与顶部分割线的间距
      Column() {
        Text(this.year===true ?
        this.game.gameTime.toLocaleDateString()+'  '+ this.game.gameTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false }):
        this.game.gameTime.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', hour12: false })) // 24小时制显示时分
          .fontSize(14)
          .textAlign(TextAlign.Center)
          .fontColor('#ff858585')
          .margin({ top: 15 });
      }
      // 队伍对阵与比分
      Row() {
        Row() {
          // 队伍A的名称
          Text(this.teamA.teamName)
            .fontSize(15)
            .textAlign(TextAlign.Center)
            .margin({ right: 8 })
            .fontColor('#ff262626');

          // 队伍A的logo
          Image($r(this.teamA.teamImageUrl))
            .width(38)
            .height(38)
            .borderRadius(50)
            .margin({ right: 12 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/TeamDetail',
              params: { tid: this.teamA.id }
            })
          })
        }
        if (this.game.status==='已结束'){
          Text(`${this.game.team1Score} : ${this.game.team2Score}`)
            .fontSize(25)
            .fontStyle(FontStyle.Italic)
            .fontWeight('bold')
            .textAlign(TextAlign.Center); // 文本居中
        }
        else if (this.game.status==='未开始') {
          if(this.isSubscribed) {
            Image($r('app.media.subscribe'))
              .width(24)
              .height(24)
              .borderRadius(50)
              .margin({ left: 14, right: 14 })
              .onClick(async ()=>{
                  let ret = await UserViewModel.cancel(parseInt(getUid()), this.game.id)
                  if(ret) {
                    this.isSubscribed = false
                    setChanged()
                    promptAction.showToast({message : "已取消订阅！",bottom: 400})

                  } else {
                    promptAction.showToast({message : "取消失败！",bottom: 400})
                  }

              })
          } else {
            Image($r('app.media.ring'))
              .width(24)
              .height(24)
              .borderRadius(50)
              .margin({ left: 14, right: 14 })
              .onClick(async ()=>{
                if(Logged()) {
                  let ret = await UserViewModel.subscribe(parseInt(getUid()), this.game.id)
                  if(ret) {
                      setChanged()
                      this.isSubscribed = true
                      promptAction.showToast({message : "订阅成功！",bottom: 400})
                  } else {
                    promptAction.showToast({message : "订阅失败！",bottom: 400})
                  }
                } else{
                  promptAction.showToast({message : "请先登录！",bottom: 400})
                }
              })
          }
        }else {
          Image($r('app.media.onfire'))
            .width(22)
            .height(22)
            .borderRadius(50)
            .margin({left:14,right:14})
        }

        Row() {
          // 队伍B的logo
          Image($r(this.teamB.teamImageUrl))
            .width(38)
            .height(38)
            .borderRadius(50)
            .margin({ left: 12 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/TeamDetail',
              params: { tid: this.teamB.id }
            })
          })

          // 队伍B的名称
          Text(this.teamB.teamName)
            .fontSize(15)
            .textAlign(TextAlign.Center)
            .margin({ left: 8 })
            .fontColor('#ff262626');
        }
      }
      .alignItems(VerticalAlign.Center) // 垂直居中所有内容
      .justifyContent(FlexAlign.Center) // 水平居中对齐
      .height('100%') // 占满父容器高度
      .backgroundColor('#ffffffff')
      .padding({
        top: 10,
        bottom: 10,
      })
      .borderRadius(0)
      .width('100%')
      .height(65);


      Column() {
        if (this.game.status==='已结束'){
          Text("已结束")
            .fontSize(11)
            .textAlign(TextAlign.Center)
            .fontColor('#ff000000')
            .margin({ top: 0, bottom: 10 });
        }
        else if (this.game.status==='未开始') {
          Text("未开始")
            .fontSize(11)
            .textAlign(TextAlign.Center)
            .fontColor('#ff797979')
            .margin({ top: 0, bottom: 10 });
        }else {
          Text("进行中")
            .fontSize(11)
            .textAlign(TextAlign.Center)
            .fontColor('#ff23ba16')
            .margin({ top: 0, bottom: 10 });
        }
      }
      Divider()
        .color('#ffd0d0d0') // 深灰色分隔线
        .height(1) // 分隔线高度
        .width('100%'); // 分隔线宽度占满容器
    }.onClick(() => {
      try {
        router.pushUrl({
          url: 'pages/GameDetail',
          params: { game : this.game }
        })
      } catch (error) {
        Logger.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
      }
    })
  }
}
