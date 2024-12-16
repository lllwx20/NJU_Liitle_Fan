import { router } from '@kit.ArkUI'


@Entry
@Component
struct TeamDetail {
  params: object = router.getParams();
  @State tid: number = this.params['tid'];
  @State name : string = "软院"
  @State score : number = 0
  @State index : number = 0
  build() {
    Column() {
      Column() {
        Text(this.name)
          .fontSize(40)
          .fontColor('white')
        Text(this.index.toString())
          .fontSize(35)
          .fontWeight(FontWeight.Bold)
          .fontStyle(FontStyle.Italic)
          .fontColor('white')
        Text("联赛排名")
          .fontSize(15)
          .fontColor('#E2EAF4')
      }
      .backgroundImage($r('app.media.TeamBackground2'))
      .backgroundImagePosition(Alignment.Center)
      .backgroundImageSize(ImageSize.FILL)
      .width('100%')
      .height('25%')
      Tabs() {
        TabContent() {

        }.tabBar("数据")
        TabContent() {

        }.tabBar("阵容")
        TabContent() {

        }.tabBar("赛程")
      }

    }
  }
}