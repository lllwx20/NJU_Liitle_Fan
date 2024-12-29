import { promptAction, router} from "@kit.ArkUI"
import { Team } from "../model/Team"
import { User } from "../model/User"
import { exit, getUid, Logged, Login } from "../utils/PreferenceUtil"
import TeamViewModel from "../viewmodel/TeamViewModel"
import UserViewModel from "../viewmodel/UserViewModel"
import { ResizeDirection } from "@kit.TestKit"


@Component
export default struct MyPage {


  @State login : boolean = false
  @Prop uid : number
  @State tid : number = 0
  @State index : number = 1
  @State userName: string = "aaa"
  @State avatar :string = 'app.media.BaseAvatar'
  @State mainTeam : string = ""
  @State TeamImageUrl : string  = ""
  @State imageSize : number = 50
  @State teams : Team[] = []
  @State teamItems : Array<SelectOption> = []
  @State tidArray : number[] = []

  async aboutToAppear(): Promise<void> {

    if(this.uid != 0) {
      this.login = true
      let user : User = await UserViewModel.getUser(this.uid)
      this.userName = user.name;
      this.avatar = user.avatar
      this.tid = user.tid;
    }
    if(this.tid != 0) {
      let team : Team = await TeamViewModel.getTeam(this.tid)
      this.mainTeam = team.teamName
      this.TeamImageUrl = team.teamImageUrl
    } else {
      this.teams = await TeamViewModel.getTeamList()
      for(let i : number = 0; i < this.teams.length; i++) {
        this.teamItems.push({value : this.teams[i].teamName, icon : this.teams[i].teamImageUrl})
        this.tidArray.push(this.teams[i].id)
      }
    }
  }

  build() {
    Column() {
      Flex({ justifyContent: FlexAlign.Center, alignItems: ItemAlign.Center }) {
        Column({ space: 10 }) {
          Row(){
            Column(){

            }.width('85%')
            if(this.login) {
              Image($r('app.media.exit'))
                .width(30)
                .height(30)
                .onClick(()=> {
                  AlertDialog.show({
                    title: '退出账号',
                    message: `是否退出当前账号？`,
                    alignment: DialogAlignment.Center,
                    primaryButton:{
                      value: '确认',
                      fontColor: Color.White,
                      backgroundColor: Color.Blue,
                      action: ()=> {
                        this.login = false
                        this.uid = 0
                        this.avatar = 'app.media.BaseAvatar'
                        exit()
                        promptAction.showToast({ message: '退出成功' });

                      }
                    },
                    secondaryButton:{
                      value: '取消',
                      fontColor: Color.Gray,
                      backgroundColor: Color.White,
                      action: ()=> {

                      }
                    }
                  })

                })

            }
          }
          .width('100%')
          .height(40)
          Image($r(this.avatar))
            .width(80)
            .height(80)
            .clipShape(new Circle({ width: 80, height: 80 }))
            .backgroundColor(Color.White)
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
      .height(200)



      Row() {
        Text("我的主队")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .width('50%')
        if(this.login) {
          if(this.tid == 0) {
            Row() {
              Select(this.teamItems)
                .value("请选择主队")
                .selectedOptionFont({ size: 16, weight: 400 })
                .onSelect((index : number) => {
                  AlertDialog.show({

                    title: '确认您选择的主队',
                    message: `是否选择${this.teamItems[index].value}为您的主队？`,
                    alignment: DialogAlignment.Center,
                    primaryButton:{
                      value: '确认',
                      fontColor: Color.White,
                      backgroundColor: Color.Blue,
                      action: async ()=> {
                        let ret = await UserViewModel.setMainTeam(this.uid, this.tidArray[index])
                        if(ret) {
                          this.tid = this.tidArray[index]
                          let team : Team = await TeamViewModel.getTeam(this.tid)
                          this.mainTeam = team.teamName
                          this.TeamImageUrl = team.teamImageUrl
                          promptAction.showToast({ message: '选择成功' });
                        } else {
                          promptAction.showToast({ message: '选择失败' });
                        }
                      }
                    },
                    secondaryButton:{
                      value: '取消',
                      fontColor: Color.Gray,
                      backgroundColor: Color.White,
                      action: ()=> {

                      }
                    },
                    cancel: ()=> {
                      promptAction.showToast({ message: `已取消` });
                    }
                  })
                })
            }
          } else {
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
                  router.pushUrl({
                    url: 'pages/TeamDetail',
                    params: { tid: this.tid, index: this.index }
                  })
                })
            }
            .width('50%')
          }
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
        Text("我的订阅")
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