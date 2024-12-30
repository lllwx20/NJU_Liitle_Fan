import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';

@Component
export default struct PlayerInfo {
  @Prop Player: Player;
  build() {
    Scroll(){
      Column(){
        Column(){
          Text('基本信息').fontSize(15).textAlign(TextAlign.Start).width(CommonConstants.FULL_WIDTH).padding({top: 8,left : 10,bottom : 10})
          Row(){
            Column(){
              Text('出生年月').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
              Text(this.Player.bornYearMonth).fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
              Text(' ')
              Text('参赛年份').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.playYear+'年').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            .height('50%')
            .width('50%')
            .justifyContent(FlexAlign.SpaceBetween)
            Column(){
              Text('身高').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
              Text(this.Player.height+'m').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.Start)
              Text(' ')
              Text('体重').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.weight + 'kg').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            .height('50%')
            .width('50%')
            .justifyContent(FlexAlign.SpaceBetween)

          }
          .width(CommonConstants.FULL_WIDTH)
          .padding({left : 5,right :5})
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_WIDTH)
        .borderRadius(8)
        .height('23%')

        Divider().height(10).opacity(0)

        Column(){
          Text('基本数据').fontSize(15).textAlign(TextAlign.Start).width(CommonConstants.FULL_WIDTH).padding({top: 5,left : 10,bottom : 10})
          Row(){
            Column(){
              Text('首发/场次').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.starterGame+ '/' + this.Player.playedGame).fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            .height('50%')
            Column(){
              Text('上场时间').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.starterGame * 80 + (this.Player.playedGame - this.Player.starterGame) * 20 + '').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            .height('50%')
            Column(){
              Text('进球').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.playerGoals+'').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            .height('50%')
            Column(){
              Text('助攻').fontSize(20).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.assist+'').fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            .height('50%')
          }
          .padding({left : 5,right :5})
          .width(CommonConstants.FULL_WIDTH)
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_WIDTH)
        .borderRadius(8)
        .height('15%')
        .padding({top : 10})

        Divider().height(10).opacity(0)

        Column(){
          Text('获奖情况').fontSize(15).textAlign(TextAlign.Start).width(CommonConstants.FULL_WIDTH).padding({top: 5,left : 10})
          Row(){
            Column(){
              Image($r('app.media.guanjun'))
                .width(60)
                .height(60)
                .autoResize(true)
              Text('冠军').fontSize(17).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.id % 2 === 1 ? "1" : "0").fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            Column(){
              Image($r('app.media.yajun'))
                .width(60)
                .height(60)
                .autoResize(true)
              Text('亚军').fontSize(17).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.id % 3 === 0 ? "1" : "0").fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
            Column(){
              Image($r('app.media.jijun'))
                .width(60)
                .height(60)
                .autoResize(true)
              Text('季军').fontSize(17).fontColor(Color.Grey).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
              Text(this.Player.id % 2 === 0 ? "1" : "0").fontSize(20).fontWeight(FontWeight.Bold).textAlign(TextAlign.End)
            }
          }
          .padding({left : 25,right :25})
          .width(CommonConstants.FULL_WIDTH)
          .height('28%')
          .justifyContent(FlexAlign.SpaceBetween)
        }
        .backgroundColor(Color.White)
        .width(CommonConstants.FULL_WIDTH)
        .borderRadius(8)
        .padding({top : 10})
      }
      .width(CommonConstants.FULL_WIDTH)
      .height(CommonConstants.FULL_HEIGHT)
    }
    .width(CommonConstants.FULL_WIDTH)
    .height(CommonConstants.FULL_HEIGHT)
    .scrollBar(BarState.Off)
    .padding({ left: 15, right: 15, top : 15, bottom :15})
    .backgroundColor('#F5F5F5')
  }
}