
@Component
export struct TeamItem {
  @Prop name : string;
  @Prop point : number;
  @Prop index : number;
  @Prop games : number;
  @Prop win : number;
  @Prop draw : number;
  @Prop lose : number;
  @Prop score : number;
  @Prop loss : number;
  private color : string = this.getColor()

  getColor() :string {
    if(this.index < 3 &&  this.index > 0) {
      return '#E2EAF4'
    }
    return '#F1F3F5'
  }
  build() {
      Row() {
        if (this.index > 0) {
          Text(this.index.toString())
            .margin({ left: 10 })
            .width(30)
            .textAlign(TextAlign.Center)
            .fontSize(20)
          Text(this.name)
            .margin({ left: 25 })
            .fontSize(20)
          Text(this.games.toString())
            .margin({ left: 35 })
            .fontSize(20)
          Text(this.win.toString() + "/" + this.draw.toString() + "/" + this.lose.toString())
            .margin({ left: 40 })
            .fontSize(20)
          Text(this.score.toString() + "/" + this.loss.toString())
            .margin({ left: 40 })
            .fontSize(20)

            if(this.index === 1) {
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
        } else {
          Text("排名")
            .margin({ left: 5 })
            .fontSize(20)
          Text("球队")
            .margin({ left: 20 })
            .fontSize(20)
          Text("场次")
            .margin({ left: 20 })
            .fontSize(20)
          Text("胜/平/负")
            .margin({ left: 15 })
            .fontSize(20)
          Text("进/失球")
            .margin({ left: 15 })
            .fontSize(20)
          Text("积分")
            .margin({ left: 10 })
            .fontSize(20)
        }
      }
      .alignSelf(ItemAlign.Center)
      .backgroundColor(this.color)
      .width('100%')
      .height(50)
  }
}