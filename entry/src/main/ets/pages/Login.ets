import router from '@ohos.router';
import http from '@ohos.net.http';
import ResponseResult from '../model/ResponseResult';
import CommonConstants from '../constants/CommonConstants';
import UserViewModel from '../viewmodel/UserViewModel';
import Logger from '../utils/Logger';
import { Login } from '../utils/PreferenceUtil';
import { promptAction } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  @State phone: string = ''
  @State password: string = '' //密码
  @State loginError: string = ''
  @State token: string = ''
  @StorageLink("topRectHeight") topHeight: number = 0
  @StorageLink("bottomRectHeight") bottomHeight: number = 0

  async onLoginRequest() {
    /*const httpRequest = http.createHttp();

    // 通过 URL 查询参数发送请求
    const url = `${CommonConstants.SERVER}${CommonConstants.LOGIN}${encodeURIComponent(this.phone)}&password=${encodeURIComponent(this.password)}`;

    console.log(url);
    const promise = httpRequest.request(url, {
      method: http.RequestMethod.POST,
      header: { 'Content-Type': 'application/json; charset=utf-8' },
    });

    promise.then((data) => {
      console.info('返回结果: ' + data.result);
      let result: ResponseResult;

      // 类型检查并解析 JSON 字符串
      if (typeof data.result === 'string') {
        result = JSON.parse(data.result) as ResponseResult;
      } else {
        result = data.result as ResponseResult;
      }

      if (result.code === "000") {
        if (typeof result.data === 'string') {
          this.token = result.data
          console.log("get token, token = ",this.token)
          router.pushUrl({ url: 'pages/Index' }); // 跳转到 Index界面
        } else {
          this.loginError = "result.result not string "
          console.log("result.result not string "+ result.data);
        }
      } else {
        this.loginError = result.msg as string;

      }
    }).catch((err: Error) => {
      console.error('错误信息：' + JSON.stringify(err));
      this.loginError = '网络错误，请稍后再试';
    });*/
    let uid : number = await UserViewModel.Login({phone : this.phone, password : this.password})
    Logger.info("uid" + uid)
    Login(uid)

    router.back({url : 'pages/Index', params : {
      uid : uid
    }})

  }

  build() {

    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
      // 在界面顶部放置一个Row组件，用于占位
      Row() {
      }
      .width("100%")
      // 设置Row组件的高度为状态栏的高度，可避免界面内容与状态栏内容重叠
      .height(this.topHeight)
      Text('登录')
        .fontSize(24)
        .fontColor(Color.Blue)
        .fontWeight(FontWeight.Bold)
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