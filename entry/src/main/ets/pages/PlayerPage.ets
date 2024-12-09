import { Player } from '../model/Player'
import PlayerViewModel from '../viewmodel/PlayerViewModel';
import Logger from '../utils/Logger';
import CommonConstants from '../constants/CommonConstants';

@Component
export default struct PlayerPage {
  @State playerList : Array<Player> = [];
  async aboutToAppear() {
    this.playerList = await PlayerViewModel.getPlayerList();

    // 打印完整的列表（可选）
    Logger.info('Player List:', JSON.stringify(this.playerList));
  }

  build() {
    Column() {
      List({ space: 12 }) {
        ForEach(this.playerList, (item: Player) => {
          ListItem() {
            PlayerItem({ Player: item })
          }
        }, (item: Player) => item.id.toString())
      }
      .scrollBar(BarState.Off)
      .padding({ left: 10, right: 10 })
    }
    .margin({ top: 10 })
    .alignItems(HorizontalAlign.Start)
  }
}

@Component
struct PlayerItem {

  @Prop Player: Player;
  aboutToAppear() {
    Logger.info('Player', JSON.stringify(this.Player));
  }
  build() {
    Row() {
      Image($r('app.media.player1'))
        .width(40)
        .height(40)
        .objectFit(ImageFit.Contain)
        .margin({ right: 16 })
      Column() {
        Text(this.Player.playerName)
          .fontSize(16)
          .textAlign(TextAlign.Center)
          .fontWeight(FontWeight.Medium)
        Text('位置:'+ this.Player.playerPosition)
          .fontSize(14)

          .textAlign(TextAlign.Center)
        Text('进球数:'+ this.Player.playerGoals)
          .fontSize(14)
          .textAlign(TextAlign.Center)
      }
      .width('75%')
      .margin({ right: 8 })
    }
    .width('100%')
    .padding(2)
    .backgroundColor(Color.White)
    .borderRadius(8)
  }
}
