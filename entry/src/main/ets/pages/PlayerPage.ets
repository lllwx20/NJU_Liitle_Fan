import { Player } from '../model/Player'
import PlayerViewModel from '../viewmodel/PlayerViewModel';
import Logger from '../utils/Logger';
import CommonConstants from '../constants/CommonConstants';
import PlayerItem from '../view/PlayerItem';
import SearchItem from '../view/SearchItem';

class ClassifyModel {
  classifyId: number;
  classifyName: string | Resource;

  constructor(classifyId: number, classifyName: string | Resource) {
    this.classifyId = classifyId;
    this.classifyName = classifyName;
  }
}
@Component
export default struct PlayerPage {

  @State currentClassify: number = 0;
  @State ClassifyArray: Array<ClassifyModel> = [
    new ClassifyModel(0, '全部'),
    new ClassifyModel(1, '进球'),
    new ClassifyModel(2, '助攻'),
    new ClassifyModel(3, '射门'),
    new ClassifyModel(4, '射正'),
    new ClassifyModel(5, '点球'),
    new ClassifyModel(6, '扑救'),
    new ClassifyModel(7, '丢球'),
    new ClassifyModel(8, '拦截'),
    new ClassifyModel(9, '解围'),
    new ClassifyModel(10, '抢断'),
    new ClassifyModel(11, '红牌'),
    new ClassifyModel(12, '黄牌'),
    new ClassifyModel(13, '犯规'),
    new ClassifyModel(14, '被犯规'),
  ];


  private classifyScroller: Scroller = new Scroller();
  private scroller: Scroller = new Scroller();

  @State playerList : Array<Player> = [
    new Player(1, "梅西", 35, "前锋", "app.media.player1")
  ];
  private count : number = 1;

  classifyChangeAction(index: number, isClassify: boolean): void {
    if (this.currentClassify !== index) {
      this.currentClassify = index;
      if (isClassify) {
        this.scroller.scrollToIndex(index);
      } else {
        this.classifyScroller.scrollToIndex(index);
      }
    }
  }
  async aboutToAppear() {
    this.playerList = await PlayerViewModel.getPlayerList();

    // 打印完整的列表
    Logger.info('Player List:', JSON.stringify(this.playerList));
  }
  build() {
    Column(){
        SearchItem()
        Row() {
          List({ scroller: this.classifyScroller }) {
            ForEach(this.ClassifyArray, (item: ClassifyModel, index?: number) => {
              ListItem() {
                ClassifyItem({
                  classifyName: item.classifyName,
                  isSelected: this.currentClassify === index,
                  onClickAction: () => {
                    if (index !== undefined) {
                      this.classifyChangeAction(index, true);
                    }
                  }
                })
              }
            }, (item: ClassifyModel, index: number) => JSON.stringify(item) + index)
          }
          .height('105%')
          .width('20%')
          .margin({top : 20})
          .backgroundColor('#F1F3F5')
          .scrollBar(BarState.Off)

          Column() {
            Row(){
              Text('球员')
                .textAlign(TextAlign.Start)
                .padding({left: 30 })
              Text('排名')
                .textAlign(TextAlign.End)
                .padding({right: 20 })
            }
            .width(CommonConstants.FULL_WIDTH)
            .justifyContent(FlexAlign.SpaceBetween)

            Divider()
              .width(CommonConstants.FULL_WIDTH)
              .strokeWidth(1.2)
              .color('#D3D3D3')
              .opacity(0.5)
              .margin({top : 4,bottom : 6})

            List({ space: 10 }) {
              ForEach(this.playerList, (item: Player) => {

                ListItem() {
                  PlayerItem({ PlayerItem: item, rank : this.count ++, data : item.playerGoals})
                }
              }, (item: Player) => item.id.toString())
            }
            .scrollBar(BarState.Off)
            .padding({ left: 10, right: 10 })
          }
          .padding({ top: 10 })
          .alignItems(HorizontalAlign.Start)
          .width('80%')
          .height('100%')
        }
        .height(CommonConstants.FULL_HEIGHT)
        .backgroundColor('#FFFFFF')
      }
    }
  }


@Component
struct ClassifyItem {
  @Prop isSelected: boolean = false;
  classifyName?: string | Resource;
  onClickAction = (): void => {
  }

  build() {
    Row(){
      Divider()
      .height(38)
      .vertical(true)
      .strokeWidth(2)
      .color('#0A59F7')
      .width('5%')
      .opacity(this.isSelected ? 1 : 0)
      Text(this.classifyName)
        .fontSize(this.isSelected ? 16 : 14)
        .fontColor(this.isSelected ? '#182431' : '#99182431')
        .fontWeight(this.isSelected ? FontWeight.Medium : FontWeight.Normal)
        .textAlign(TextAlign.Center)
        .width('95%')
        .height(52)
    }
    .backgroundColor(this.isSelected ? '#FFFFFF' : '')
    .onClick(this.onClickAction)

  }
}