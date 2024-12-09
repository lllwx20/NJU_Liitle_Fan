import { Player } from '../model/Player';

@Component
@Preview
export default struct PlayerItem {

  @Prop PlayerItem: Player;
  build() {
    Row() {
      Column() {
        //Image(this.PlayerItem.playerImageUrl)
        //  .width(40)
        //  .height(40)
        //  .objectFit(ImageFit.Contain)
        //  .margin({ right: 16 })
        Text(this.PlayerItem.playerName)
          .fontSize(16)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Medium)
        Text('位置:'+ this.PlayerItem.playerPosition)
          .fontSize(14)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
        Text('进球数:'+ this.PlayerItem.playerGoals)
          .fontSize(14)
          .fontColor(Color.White)
          .textAlign(TextAlign.Center)
      }
      .width('75%')
      .margin({ right: 8 })
    }
    .width('100%')
    .padding(2)
    .backgroundColor(Color.White)
    .borderRadius(8)
    .justifyContent(FlexAlign.SpaceBetween)

  }
}
