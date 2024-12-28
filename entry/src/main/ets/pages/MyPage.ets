import { router, screenshot, window } from "@kit.ArkUI"
import { Team } from "../model/Team"
import { User } from "../model/User"
import { getUid, Logged, Login } from "../utils/PreferenceUtil"
import TeamViewModel from "../viewmodel/TeamViewModel"
import UserViewModel from "../viewmodel/UserViewModel"


@Component
export default struct MyPage {


  @State login : boolean = false
  @Prop uid : number
  @State tid : number = 0
  @State index : number = 1
  @State userName: string = "aaa"
  @State mainTeam : string = ""
  @State TeamImageUrl : string  = ""
  @State imageSize : number = 50

  async aboutToAppear(): Promise<void> {

    if(this.uid != 0) {
      this.login = true
      let user : User = await UserViewModel.getUser(this.uid)
      this.userName = user.name;
      this.tid = user.tid;
    }
    if(this.tid != 0) {
      let team : Team = await TeamViewModel.getTeam(this.tid)
      this.mainTeam = team.teamName
      this.TeamImageUrl = team.teamImageUrl
    }
  }

  async aboutToDisappear(): Promise<void> {

    this.login = Logged()
    if(this.login) {
      let user : User = await UserViewModel.getUser(parseInt(getUid()))
      this.uid = user.id
      this.userName = user.name;
      this.tid = user.tid;
    }
    if(this.tid != 0) {
      let team : Team = await TeamViewModel.getTeam(this.tid)
      this.mainTeam = team.teamName
      this.TeamImageUrl = team.teamImageUrl
    }
  }

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Column({ space: 10 }) {
          Image($r('app.media.BaseAvatar'))
            .width(80)
            .height(80)
          if(!this.login) {
            Text('登录 / 注册')
              .fontSize(20)
              .height(30)
              .textAlign(TextAlign.Center)
              .onClick(()=> {
                router.pushUrl({
                  url: 'pages/Login',
                })
              })
          } else {
            Text(this.userName)
              .fontSize(20)
              .height(30)
              .textAlign(TextAlign.Center)
          }
        }.onClick(() => {

        })
      }
      .width('100%')
      .height(150)

      Row() {
        Text("我的主队")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('50%')
        if(this.login) {
          Row() {
            Text(this.mainTeam)
              .textAlign(TextAlign.Center)
              .fontSize(20)
              .width('25%')
            Image($r(this.TeamImageUrl))
              .margin({ left: 20 })
              .width(this.imageSize)
              .height(this.imageSize)
              .onClick(() => {
                animateTo({
                  duration: 500,
                }, () => {
                  this.imageSize = 65;
                });
                animateTo({
                  duration: 100,
                  delay : 200
                }, () => {
                  this.imageSize = 50;
                });
                router.pushUrl({
                  url: 'pages/TeamDetail',
                  params: { tid: this.tid, index: this.index }
                })
              })


          }
          .width('50%')
        } else {
          Text("请登录查看")
            .fontSize(20)
            .textAlign(TextAlign.Center)
        }
      }.width('95%')
      .height(100)
      .padding(20)
      .backgroundColor(Color.White)
      .margin({
        left: 9
      })
      .borderRadius(15)

      Column() {
        Text("我订阅的比赛")
          .fontSize(20)
          .height(50)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)

      }
      .height('100%')
      .width('100%')
      .backgroundColor(Color.White)
      .margin({top : 20})


    }.height('100%')
    .width('100%')
    .backgroundColor('#F1F3F5')
  }
}