import { ClassifyModel, Player } from '../model/Player'
import PlayerViewModel from '../viewmodel/PlayerViewModel';
import Logger from '../utils/Logger';
import CommonConstants from '../constants/CommonConstants';
import PlayerItem from '../view/PlayerItem';
import { promptAction } from '@kit.ArkUI';


@Component
export default struct PlayerPage {


  private ClassifyArray: Array<ClassifyModel> = [
    new ClassifyModel(0, '全部'),
    new ClassifyModel(1, '进球'),
    new ClassifyModel(2, '助攻'),
    new ClassifyModel(3, '射门'),
    new ClassifyModel(4, '射正'),
    new ClassifyModel(5, '点球'),
    new ClassifyModel(6, '扑救'),
    new ClassifyModel(7, '抢断'),
    new ClassifyModel(8, '红牌'),
    new ClassifyModel(9, '黄牌'),
    new ClassifyModel(10,'犯规'),
    new ClassifyModel(11,'被犯规'),
  ];

  @State currentClassify: number = 0;
  @State changeValue: string = ''
  @State submitValue: string = ''
  @State playerList : Array<Player> = [];
  private originPlayerList : Array<Player> = [];
  private classifyScroller: Scroller = new Scroller();
  private scroller: Scroller = new Scroller();
  private controller: SearchController = new SearchController()

  async aboutToAppear() {
    this.originPlayerList = await PlayerViewModel.getPlayerList();
    this.playerList = this.originPlayerList;
    // 打印完整的列表
    Logger.info('Player List:', JSON.stringify(this.playerList));
  }

  sortPlayerList(): void {
    this.playerList.sort((a: Player, b: Player) => {
      switch (this.currentClassify) {
        case 1: // 按进球数排序
          return (b.playerGoals || 0) - (a.playerGoals || 0);
        case 2: // 按助攻数排序
          return (b.assist || 0) - (a.assist || 0);
        case 3: // 按射门数排序
          return (b.shot || 0) - (a.shot || 0);
        case 4: // 按射正数排序
          return (b.shotRight || 0) - (a.shotRight || 0);
        case 5: // 按点球数排序
          return (b.shotPenalty || 0) - (a.shotPenalty || 0);
        case 6: // 按扑救数排序
          return (b.save || 0) - (a.save || 0);
        case 7: // 按抢断数排序
          return (b.steal || 0) - (a.steal || 0);
        case 8: // 按红牌数排序
          return (b.redCard || 0) - (a.redCard || 0);
        case 9: // 按黄牌数排序
          return (b.yellowCard || 0) - (a.yellowCard || 0);
        case 10: // 按犯规数排序
          return (b.foul || 0) - (a.foul || 0);
        case 11: // 按被犯规数排序
          return (b.foulAgainst || 0) - (a.foulAgainst || 0);
        default: // 默认按 ID 排序
          return (a.id || 0) - (b.id || 0);
      }
    });
  }

  classifyChangeAction(index: number, isClassify: boolean): void {
    if (this.currentClassify !== index) {
      this.currentClassify = index;
      if (isClassify) {
        this.scroller.scrollToIndex(index);
      } else {
        this.classifyScroller.scrollToIndex(index);
      }
      this.sortPlayerList(); // 调用排序方法
    }
  }
  getPlayerData(player: Player): number {
    switch (this.currentClassify) {
      case 1: return player.playerGoals || 0;       // 进球
      case 2: return player.assist || 0;           // 助攻
      case 3: return player.shot || 0;             // 射门
      case 4: return player.shotRight || 0;        // 射正
      case 5: return player.shotPenalty || 0;      // 点球
      case 6: return player.save || 0;             // 扑救
      case 7: return player.steal || 0;            // 抢断
      case 8: return player.redCard || 0;          // 红牌
      case 9: return player.yellowCard || 0;       // 黄牌
      case 10: return player.foul || 0;            // 犯规
      case 11: return player.foulAgainst || 0;     // 被犯规
      default: return -1;                          // 默认值
    }
  }

  filterPlayerList(keyword: string){
    // 过滤球员列表
    this.playerList = this.playerList.filter((player: Player): boolean => {
      const lowerKeyword = keyword.toLowerCase();
      return player.team.toLowerCase() === lowerKeyword || // 按球队过滤
      player.playerName.toLowerCase().includes(lowerKeyword) || // 按名称过滤
      player.number.toString() === lowerKeyword   // 按号码过滤
    });

    // 打印筛选结果
    Logger.info('Filtered Player List:', JSON.stringify(this.playerList));
  }


  build() {
    Column(){
        Column() {
          Search({ value: this.changeValue, placeholder: '输入球员名字、号码或所属球队', controller: this.controller })
            .height(30)
            .backgroundColor('#F5F5F5')
            .placeholderColor(Color.Grey)
            .placeholderFont({ size: 14, weight: 400 })
            .enableKeyboardOnFocus(false)
            .textFont({ size: 14, weight: 400 })
            .onSubmit((value: string) => {
              this.submitValue = value
              this.filterPlayerList(value);
              if(this.playerList.length === 0){
                promptAction.showToast({
                  message: '未找到该球员',
                  bottom: 400
                });
              }
            })
            .onChange((value: string) => {
              if (!value) {
                // 如果关键词为空，恢复完整的列表
                this.playerList = this.originPlayerList;;
                this.sortPlayerList(); // 调用排序方法
              }
              this.changeValue = value
            })
        }.width('95%')

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
              Row(){
                Image($r('app.media.PlayerIcon'))
                  .width(20)
                  .height(20)
                  .autoResize(true)
                Text('球员')
                  .textAlign(TextAlign.Start)
              }.margin({ left: 10 })
              Row(){
                if(this.currentClassify !== 0 ){
                  Image($r('app.media.dataIcon'))
                    .width(19)
                    .height(19)
                    .autoResize(true)
                  Text('数据')
                    .textAlign(TextAlign.Center)
                    .fontSize(16)
                }
              }.padding({left: 64 })

              Row(){
                Image(this.currentClassify === 0 ? $r('app.media.TeamIcon') : $r('app.media.RankIcon'))
                  .width(20)
                  .height(20)
                  .autoResize(true)
                Text(this.currentClassify === 0 ? '球队' : '排名')
                .textAlign(TextAlign.End)
              }.padding({right: 20 })



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
              ForEach(this.playerList, (item: Player, index: number) => {
                ListItem() {
                  PlayerItem({
                    PlayerItem: item,
                    rank: index + 1,
                    data: this.getPlayerData(item)
                  })
                }
              }, (item: Player) => `${item.id}-${this.currentClassify}-${this.changeValue}`) // 添加当前分类作为标识的一部分
            }
            .scrollBar(BarState.Off)
            .padding({ left: 10, right: 10 })
            .animation({
              duration: 300,
              curve: Curve.Smooth
            })

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


