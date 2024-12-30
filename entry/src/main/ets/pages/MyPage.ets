import { promptAction, router} from "@kit.ArkUI"
import { Team } from "../model/Team"
import { User } from "../model/User"
import { exit } from "../utils/PreferenceUtil"
import TeamViewModel from "../viewmodel/TeamViewModel"
import UserViewModel from "../viewmodel/UserViewModel"


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

  @State handlePopup: boolean = false

  @State cancel: boolean = false

  @Builder popupBuilder() {
    Column({ space: 25 }) {
      Text('是否更换主队').fontSize(20)
      Row() {
        Toggle({type: ToggleType.Checkbox})
          .onChange(()=> {
            this.cancel = !this.cancel
          })
        Text("取消订阅该队的比赛")
          .fontSize(15)
      }
      Row({space: 25}) {
        Button('确认')
          .height(30)
          .width(70)
          .fontSize(15)
          .fontColor(Color.White)
          .backgroundColor(Color.Blue)
          .onClick(async () => {
            this.handlePopup = !this.handlePopup
            this.tid = 0;
            let ret = await UserViewModel.setMainTeam(this.uid, 0)
            if(ret) {
              promptAction.showToast({
                message: this.mainTeam + "已不再是您的主队！",
                bottom: 400
              })
            }
            this.teams = await TeamViewModel.getTeamList()
            for(let i : number = 0; i < this.teams.length; i++) {
              this.teamItems.push({value : this.teams[i].teamName, icon : this.teams[i].teamImageUrl})
              this.tidArray.push(this.teams[i].id)
            }
          })
        Button('取消')
          .height(30)
          .width(70)
          .fontSize(15)
          .fontColor(Color.White)
          .backgroundColor(Color.Gray)
          .onClick(() => {
            this.handlePopup = !this.handlePopup
          })
      }
    }.width(250).height(150).padding(5).backgroundColor('#F1F3F5')
  }

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
      this.index = await TeamViewModel.getTeamRank(this.tid) + 1
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
                        promptAction.showToast({ message: '退出成功' ,bottom: 400});

                      }
                    },
                    secondaryButton:{
                      value: '取消',
                      fontColor: Color.White,
                      backgroundColor: Color.Gray,
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
            .onClick(()=> {
              if(!this.login) {
                router.pushUrl({
                  url: 'pages/Login',
                })
              }
            })
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
      .backgroundImage($r('app.media.BlueBG'))
      .backgroundImagePosition(Alignment.Center)
      .backgroundImageSize(ImageSize.FILL)



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
                          this.index = await TeamViewModel.getTeamRank(this.tid) + 1
                          this.mainTeam = team.teamName
                          this.TeamImageUrl = team.teamImageUrl
                          promptAction.showToast({ message: '选择成功' ,bottom: 400});
                        } else {
                          promptAction.showToast({ message: '选择失败' ,bottom: 400});
                        }
                      }
                    },
                    secondaryButton:{
                      value: '取消',
                      fontColor: Color.White,
                      backgroundColor: Color.Gray,
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
                .margin({left : 20})
              Image($r(this.TeamImageUrl))
                .margin({left : 5})
                .width(this.imageSize)
                .height(this.imageSize)

            }
            .width('45%')
            .onClick(() => {
              router.pushUrl({
                url: 'pages/TeamDetail',
                params: { tid: this.tid, index: this.index }
              })
            })
            Row(){
              Image($r('app.media.Change'))
                .width(20)
                .height(20)
                .onClick(() => {
                  if(this.login) {
                    this.handlePopup = !this.handlePopup
                  }
                })
                .bindPopup(this.handlePopup, {
                  builder: this.popupBuilder,
                })
            }

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