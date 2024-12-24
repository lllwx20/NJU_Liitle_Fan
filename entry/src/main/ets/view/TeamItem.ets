import { router } from "@kit.ArkUI";
import { Team } from "../model/Team";


@Component
export struct TeamItem {
  @Prop team : Team
  @Prop index: number;
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
        .fontSize(18)
      Image($r(this.team.teamImageUrl))
        .width(18)
        .height(18)
        .autoResize(true)
        .margin({ left: 10 })
      Text(this.team.teamName)
        .margin({ left: 5 })
        .fontSize(18)
        .width(50)
      Text(this.team.teamPlayed.toString())
        .fontSize(18)
        .width(60)
        .textAlign(TextAlign.Center)
      Text(this.team.teamWin.toString() + "/" + this.team.teamDraw.toString() + "/" + this.team.teamLose.toString())
        .width(75)
        .textAlign(TextAlign.Center)
        .fontSize(18)
      Text(this.team.teamGoals.toString() + "/" + this.team.teamLoss.toString())
        .width(75)
        .textAlign(TextAlign.Center)
        .fontSize(18)

      if (this.index === 0) {
        Column() {
          Text("晋级区")
            .fontSize(10)
            .width(40)
            .height(10)
            .backgroundColor('#98F5F9')
            .textAlign(TextAlign.Center)
            .margin({ top: 0})
          Text(this.team.teamPoints.toString())
            .fontSize(18)
            .width(50)
            .textAlign(TextAlign.Center)
            .height(30)
        }.height(50)
      } else {
        Text(this.team.teamPoints.toString())
          .fontSize(18)
          .width(50)
          .textAlign(TextAlign.Center)
          .fontSize(18)
      }

    }
    .alignSelf(ItemAlign.Center)
    .backgroundColor(this.color)
    .width('100%')
    .height(50)
    .onClick(() => {
      router.pushUrl({
        url: 'pages/TeamDetail',
        params: {tid : this.team.id, index : this.index}
      })
    })
  }
}