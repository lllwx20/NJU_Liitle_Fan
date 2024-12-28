import router from '@ohos.router';
import http from '@ohos.net.http';
import ResponseResult from '../model/ResponseResult';
import CommonConstants from '../constants/CommonConstants';
import { User } from '../model/User';
import { promptAction } from '@kit.ArkUI';

@Entry
@Component
struct RegisterPage {
  @State registerError: string = '';
  @State phone: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  @State name: string = '';
  //加一个变量记录角色身份

  async onRequest() {
    if (this.password !== this.confirmPassword) {
      this.registerError = '密码与确认密码不一致';
      return;
    }

    const httpRequest = http.createHttp();

    const url = `${CommonConstants.SERVER}${CommonConstants.REGISTER}`;
    let user : User = new User()
    user.name = this.name;
    user.phone = this.phone;
    user.password = this.password;
    user.role = "user";
    user.tid = 0;
    user.avatar = "app.media.BaseAvatar"

    const promise = httpRequest.request(url, {
      method: http.RequestMethod.POST,
      header: { 'Content-Type': 'application/json; charset=utf-8' },
      extraData: user
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
        promptAction.showToast({message : "注册成功!"})
        router.pushUrl({ url: 'pages/Login' });
      } else {
        promptAction.showToast({message : "该手机号已被注册!"})
        this.registerError = result.msg as string || '注册失败，请稍后再试';
      }
    }).catch((err :Error) => {
      console.error('错误信息：' + JSON.stringify(err));
      this.registerError = '网络错误，请稍后再试';
    });
  }

  build() {
    Flex({ direction: FlexDirection.Column, alignItems: ItemAlign.Center, justifyContent: FlexAlign.SpaceAround }) {
      Text('注册')
        .fontSize(24)
        .fontColor(Color.Blue)
        .fontWeight(FontWeight.Bold);

      Column({ space: 8 }) {
        TextInput({ placeholder: '用户名：' })
          .onChange((value) => {
            this.name = value;
          });

        TextInput({ placeholder: '手机号：' })
          .onChange((value) => {
            this.phone = value;
          });

        TextInput({ placeholder: '密码：' })
          .type(InputType.Password)
          .onChange((value) => {
            this.password = value;
          });

        TextInput({ placeholder: '确认密码：' })
          .type(InputType.Password)
          .onChange((value) => {
            this.confirmPassword = value;
          });

        //选择角色身份的逻辑是什么样的？

        Button('注册')
          .width('95%')
          .margin({ top: 10 })
          .onClick(() => {
            this.onRequest()
            console.log("开始注册")
          });

        Button('返回登录')
          .width('95%')
          .backgroundColor(Color.Gray)
          .margin({ top: 10 })
          .onClick(() => {
            router.pushUrl({ url: 'pages/Login' });
          });

        if (this.registerError) {
          Text(this.registerError)
            .fontColor(Color.Red)
            .fontSize(16)
            .margin({ top: 10 });
        }
      }
      .width('90%');
    }
    .width('100%')
    .height('100%')
  }
}