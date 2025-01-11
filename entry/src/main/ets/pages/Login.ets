import router from '@ohos.router';
import UserViewModel from '../viewmodel/UserViewModel';
import Logger from '../utils/Logger';
import { LoginPreferences } from '../utils/PreferenceUtil';
import { encryptRSA } from '../utils/RSAUtil';

@Entry
@Component
struct Login {
  @State phone: string = ''
  @State password: string = '' //密码
  @State loginError: string = ''
  @State token: string = ''
  @StorageLink("topRectHeight") topHeight: number = 0
  @StorageLink("bottomRectHeight") bottomHeight: number = 0
  private publicStr : string = ''


  async onLoginRequest() {
    this.publicStr = await UserViewModel.getPublicKeyStr()
    let encryptPassword: string = await  encryptRSA(this.publicStr,this.password)
    let uid : number = await UserViewModel.Login({phone : this.phone, password : encryptPassword})
    Logger.info("uid" + uid)
    LoginPreferences(uid)

    router.back({url : 'pages/Index', params : {
      uid : uid
    }})

  }

  build() {

    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
    Row() {
      Image($r('app.media.BackBlack'))
        .width(40)
        .height(40)
        .onClick(() => {
          router.back()
        })
        .alignSelf(ItemAlign.Start)
        .margin({ left: 20, top: 50 })
    }.width('100%')
      // 在界面顶部放置一个Row组件，用于占位
      Column() {
        Image($r('app.media.NJUFA'))
          .width(200)
          .height(200)

        // 设置Row组件的高度为状态栏的高度，可避免界面内容与状态栏内容重叠
        Text('登录')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
      }
      Column({ space: 8 }) {
        TextInput({ placeholder: '手机号：' })
          .onChange((value) => {
            this.phone = value
          })
        TextInput({ placeholder: '密码：' })
          .type(InputType.Password)
          .onChange((value) => {
            this.password = value
          })
        Button('登录')
          .width('95%')
          .margin({ top: 10 })
          .onClick(() => {
            this.onLoginRequest();
          })
        Button('注册')
          .width('95%')
          .backgroundColor(Color.Gray)
          .margin({ top: 10 })
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Register'
            })
          })
        if (this.loginError) {
          Text(this.loginError)
            .fontColor(Color.Red)
            .fontSize(16)
            .margin({ top: 10 });
        }
      }
      .width('90%')
      // 在界面底部放置一个Row组件，用于占位
      Row() {
      }
      .width("100%")
      // 设置Row组件的高度为导航栏的高度，可避免界面内容与导航栏内容重叠
      .height(this.bottomHeight)
    }
    .width('100%')
    .height('100%')
  }
}