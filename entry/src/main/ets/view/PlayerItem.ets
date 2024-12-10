import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';

@Component
@Preview
export default struct PlayerItem {

  @Prop PlayerItem: Player;
  @Prop data: number;
  @Prop rank: number;
  @LocalStorageProp('backgroundImg') backgroundImg: Resource = $r('app.media.background')
  build() {

    Stack({ alignContent: Alignment.TopEnd }) {
          // 添加排名
          Text(''+this.rank)
          .fontSize(20)
          .fontColor(this.rank == 1 ? Color.Red : this.rank == 2 ? Color.Orange : this.rank == 3 ? Color.Yellow : Color.White)
          .fontWeight(FontWeight.Bold)
          .margin({ top: 4, right: 8 })

          Row() {
            Image($r(this.PlayerItem.playerImageUrl))
              .width(60)
              .height(60)
              .objectFit(ImageFit.Contain)
              .margin({ left: 1 })
            Column(){
              Text(this.PlayerItem.playerName)
                .fontSize(18)
                .fontColor(Color.White)
                .fontWeight(FontWeight.Bold)
                .textAlign(TextAlign.Start)
                .margin({ left: 1 ,top : 1})
                .width(CommonConstants.FULL_WIDTH)
                .height('55%')
              Row(){
                //Text('位置:' + this.PlayerItem.playerPosition)
                //  .fontColor(Color.White)
                //  .textAlign(TextAlign.Start)
                Text('软院')
                  .fontColor(Color.White)
                  .textAlign(TextAlign.Start)
                Text('数据:' + this.data)
                  .fontColor(Color.White)
                  .textAlign(TextAlign.End)
              }
              .width('100%')
              .height('45%')
              .padding({right: 8 })
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('80%')
            .height('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
      }
    .backgroundImage(this.backgroundImg)
    .backgroundImageSize({ width: '100%', height: '100%' })
    .width('100%')
    .height('10%')
    .padding(2)
    .borderRadius(8)
  }
}
