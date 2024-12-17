import { router } from '@kit.ArkUI';
import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';
import PlayerData from '../view/PlayerData';
import PlayerInfo from '../view/PlayerInfo';
import PlayerRadarChart from '../view/PlayerRadarChart';

@Entry
@Component
struct  PlayerDetail {
  @State params: object = router.getParams();
  @State Player: Player = this.params['Player'];
  build() {
    Column() {

      Column() {
        Column(){
          Button({ type: ButtonType.Circle, stateEffect: true }) {
            Image($r('app.media.back')).width(20).height(20)
          }
          .backgroundImage($r('app.media.background'))
          .width(30)
          .height(30)
          .onClick(() => {
            router.back();
          })
          .margin({ top: 5, left: 5 }) // 增加边距
        }
        .width(CommonConstants.FULL_WIDTH)
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Start)

        Column(){
          Row(){
            Image($r(this.Player.playerImageUrl))
              .width(100)
              .height(100)
              .objectFit(ImageFit.Contain)
              .margin({ left: 1 })
              .backgroundBlurStyle(BlurStyle.Thin, { colorMode: ThemeColorMode.DARK, adaptiveColor: AdaptiveColor.DEFAULT, scale: 0.5 })
            Column(){
              Text(this.Player.playerName)
                .fontSize(30)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Normal)
                .textAlign(TextAlign.Start)
                .margin({ left: 1, top: 1 })
                .height('40%')
                .width(CommonConstants.FULL_WIDTH)
              Row(){
                Image($r('app.media.t1'))
                  .width(30)
                  .height(30)
                  .autoResize(true)
                Text(this.Player.team)
                  .fontSize(20)
                  .fontColor(Color.White)
                  .fontWeight(FontWeight.Normal)
                  .textAlign(TextAlign.Start)

              }
              .padding({top : 25})
              .width(CommonConstants.FULL_WIDTH)
              .height('60%')
            }
            .padding({left : 5})
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .height('55%')
          Row(){
            Text(this.Player.number+'号')
              .fontSize(20)
              .fontColor(Color.White)
            Text(this.Player.id % 8 === 0 ? '左脚' :'右脚')
              .fontSize(20)
              .fontColor(Color.White)
            Text(this.Player.playerPosition)
              .fontSize(20)
              .fontColor(Color.White)
            Text(this.Player.playerAge+'岁')
              .fontSize(20)
              .fontColor(Color.White)
          }
          .padding({left : 30,right : 30,bottom : 10})
          .width(CommonConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.SpaceBetween)
          .height('35%')
        }.width(CommonConstants.FULL_WIDTH)
      }
      .backgroundImage($r('app.media.background'))
      .backgroundImagePosition(Alignment.Center)
      .backgroundImageSize(ImageSize.FILL)
      .width('100%')
      .height('25%')
      Tabs() {
        TabContent() {
          PlayerInfo({Player : this.Player})
        }.tabBar("资料")
        TabContent() {
          PlayerData({Player : this.Player})
        }.tabBar("数据")
        TabContent() {
          PlayerRadarChart({Player : this.Player})
        }.tabBar("能力图")
      }.scrollable(false)

    }
  }
}