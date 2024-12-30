import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';

@Component
export default struct PlayerData {
  @Prop Player: Player;

  build() {
    Scroll() {
        Column() {
          Column() {
            Text('基本数据')
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .width(CommonConstants.FULL_WIDTH)
              .padding({ top: 5, left: 10, bottom: 10 })
            Row() {
              Column() {
                Text('首发/场次')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.starterGame + '/' + this.Player.playedGame)
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('上场时间').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.starterGame * 80 + (this.Player.playedGame - this.Player.starterGame) * 20 + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('进球').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.playerGoals + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('助攻').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.assist + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')
            }
            .padding({ left: 5, right: 5 })
            .width(CommonConstants.FULL_WIDTH)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .backgroundColor(Color.White)
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius(8)
          .height('15%')
          .padding({ top: 10 })

          Divider().height(10).opacity(0)

          Column() {
            Text('进攻')
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .width(CommonConstants.FULL_WIDTH)
              .padding({ top: 5, left: 10, bottom: 10 })
            Row() {
              Column() {
                Text('射门')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.shot+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('射正').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.shotRight+'').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('点球').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.shotPenalty + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('射正率').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text((this.Player.shotRight/this.Player.shot * 100).toFixed(1) + '%').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')
            }
            .padding({ left: 5, right: 5 })
            .width(CommonConstants.FULL_WIDTH)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .backgroundColor(Color.White)
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius(8)
          .height('15%')
          .padding({ top: 10 })

          Divider().height(10).opacity(0)

          Column() {
            Text('防守')
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .width(CommonConstants.FULL_WIDTH)
              .padding({ top: 5, left: 10, bottom: 10 })
            Row() {
              Column() {
                Text('扑救')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.save+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')
              Column() {
                Text('解围')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.steal+8+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')
              Column() {
                Text('封堵')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.steal+5+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('抢断').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.steal + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')

            }
            .padding({ left: 5, right: 5 })
            .width(CommonConstants.FULL_WIDTH)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .backgroundColor(Color.White)
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius(8)
          .height('15%')
          .padding({ top: 10 })

          Divider().height(10).opacity(0)

          Column() {
            Text('纪律')
              .fontSize(15)
              .textAlign(TextAlign.Start)
              .width(CommonConstants.FULL_WIDTH)
              .padding({ top: 5, left: 10, bottom: 10 })
            Row() {
              Column() {
                Text('红牌')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.redCard+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')
              Column() {
                Text('黄牌')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.yellowCard+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')
              Column() {
                Text('犯规')
                  .fontSize(20)
                  .fontColor(Color.Grey)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
                Text(this.Player.foul+'')
                  .fontSize(20)
                  .fontWeight(FontWeight.Bold)
                  .textAlign(TextAlign.End)
              }
              .height('50%')

              Column() {
                Text('被犯规').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
                Text(this.Player.foulAgainst + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              }
              .height('50%')

            }
            .padding({ left: 5, right: 5 })
            .width(CommonConstants.FULL_WIDTH)
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .backgroundColor(Color.White)
          .width(CommonConstants.FULL_WIDTH)
          .borderRadius(8)
          .height('15%')
          .padding({ top: 10 })
        }
        .width(CommonConstants.FULL_WIDTH)
        .height(CommonConstants.FULL_HEIGHT)
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
      .scrollBar(BarState.Off)
      .padding({
        left: 15,
        right: 15,
        top: 15,
        bottom: 15
      })
      .backgroundColor('#F5F5F5')
    }
}