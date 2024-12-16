import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';
import { router } from '@kit.ArkUI';
import Logger from '../utils/Logger';

@Component
export default struct PlayerItem {

  @Prop PlayerItem: Player;
  @Prop data: number;
  @Prop rank: number;
  @LocalStorageProp('backgroundImg') backgroundImg: Resource = $r('app.media.background')
  build() {
    Row(){
      Stack({ alignContent: Alignment.TopEnd }) {
        Text(''+this.data)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .fontSize(this.data === -1 ? 0 : 26)
          .fontWeight(FontWeight.Medium)
          .margin({ top: 16, right: 76 })
          .width(70)

        if(this.data === -1){
          Image($r('app.media.t1'))
            .width(40)
            .height(40)
            .autoResize(true)
            .margin({ top: 10, right: 9 })
        }else{
          Text(''+this.rank)
            .fontSize(20)
            .fontColor(this.rank == 1 ? Color.Red : this.rank == 2 ? Color.Orange : this.rank == 3 ? Color.Yellow : '#D3D3D3')
            .fontWeight(FontWeight.Bold)
            .textAlign(TextAlign.End)
            .margin({ top: 20, right: 16 })
        }



        Row() {
          Image($r(this.PlayerItem.playerImageUrl))
            .width(60)
            .height(60)
            .objectFit(ImageFit.Contain)
            .margin({ left: 1 })
          Column(){
            Text(this.PlayerItem.playerName)
              .fontSize(16)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Normal)
              .textAlign(TextAlign.Start)
              .margin({ left: 1, top: 1 })
              .height('55%')
              .width(CommonConstants.FULL_WIDTH)
            Text(this.PlayerItem.team +' '+ this.PlayerItem.number + '号')
              .fontSize(13)
              .fontColor(Color.White)
              .fontWeight(FontWeight.Normal)
              .textAlign(TextAlign.Start)
              .width(CommonConstants.FULL_WIDTH)
              .height('45%')
              .padding({right: 8 })
          }
          .width('80%')
          .height(CommonConstants.FULL_HEIGHT)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .width(CommonConstants.FULL_WIDTH)
        .justifyContent(FlexAlign.SpaceBetween)
      }
      .backgroundImage(this.backgroundImg)
      .backgroundImageSize({ width: '100%', height: '100%' })
      .width('100%')
      .height('10%')
      .padding(2)
      .borderRadius(8)
    }.onClick(() => {
      try {
        router.pushUrl({
          url: 'pages/PlayerDetail',
          params: { Player: this.PlayerItem }
        })
      } catch (error) {
        Logger.error(`ErrorCode: ${error.code},  Message: ${error.message}`);
      }
    })

  }
}
