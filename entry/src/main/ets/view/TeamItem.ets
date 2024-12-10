import { router } from "@kit.ArkUI";

class routerParams {
  src: number

  constructor(i: number) {
    this.src = i
  }
}

@Component
export struct TeamItem {
  @Prop tid: number;
  @Prop name: string;
  @Prop point: number;
  @Prop index: number;
  @Prop games: number;
  @Prop win: number;
  @Prop draw: number;
  @Prop lose: number;
  @Prop score: number;
  @Prop loss: number;
  private color: string = this.getColor()

  getColor(): string {
    if (this.index < 3 && this.index >= 0) {
      return '#E2EAF4'
    }
    return '#F1F3F5'
  }

  build() {
    Row() {

      Text(this.index.toString())
        .margin({ left: 10 })
        .width(30)
        .textAlign(TextAlign.Center)
        .fontSize(20)
      Image($r('app.media.t1'))
        .width(20)
        .height(20)
        .autoResize(true)
        .margin({ left: 10 })
      Text(this.name)
        .margin({ left: 5 })
        .fontSize(20)
      Text(this.games.toString())
        .margin({ left: 35 })
        .fontSize(20)
      Text(this.win.toString() + "/" + this.draw.toString() + "/" + this.lose.toString())
        .margin({ left: 35 })
        .fontSize(20)
      Text(this.score.toString() + "/" + this.loss.toString())
        .margin({ left: 35 })
        .fontSize(20)

      if (this.index === 0) {
        Column() {
          Text("晋级区")
            .fontSize(10)
            .width(40)
            .height(10)
            .backgroundColor('#98F5F9')
            .textAlign(TextAlign.Center)
            .margin({ top: 0, left: 35 })
          Text(this.point.toString())
            .margin({ left: 35 })
            .fontSize(20)
            .width(30)
            .textAlign(TextAlign.Center)
            .height(30)
        }.height(50)
      } else {
        Text(this.point.toString())
          .margin({ left: 40 })
          .fontSize(20)
          .width(30)
          .textAlign(TextAlign.Center)
          .fontSize(20)
      }

    }
    .alignSelf(ItemAlign.Center)
    .backgroundColor(this.color)
    .width('100%')
    .height(50)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/TeamDetail',
        params: new routerParams(this.tid)
      })
    })
  }
}