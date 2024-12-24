import { Player, RatePlayerParams } from '../model/Player';
import PlayerViewModel from '../viewmodel/PlayerViewModel';
import { promptAction } from '@kit.ArkUI';

@Component
export default struct PlayerRate {
  @Prop Player: Player;
  @State ratePlayer: RatePlayerParams = {
    id: -1,
    shooting: -1,
    passing: -1,
    defense: -1,
    physical: -1,
    tacticalAwareness: -1,
    dribbling:-1
  };
  onRated?: () => void;  // 添加评分成功的回调

  dialogController: CustomDialogController = new CustomDialogController({
    builder: RatingDialog({
      ratePlayer: $ratePlayer,
      confirm: (): void => this.submitRating(),
      controller: undefined
    }),
    alignment: DialogAlignment.Bottom,
    offset: { dx: 0, dy: -20 }
  });

  submitRating(): void {
    if (!this.validateRating()) {
      promptAction.showToast({ message: '请输入有效的评价(0-100)',bottom: 400 });
      return;
    }
    PlayerViewModel.ratePlayer(this.ratePlayer)
      .then(() => {
        promptAction.showToast({ message: '评价成功' ,bottom: 400});
        this.onRated?.();// 评分成功后调用刷新回调
      })
      .catch(() => {
        promptAction.showToast({ message: '评价失败' ,bottom: 400});
      });
  }

  validateRating(): boolean {
    return this.ratePlayer.shooting !== undefined && this.ratePlayer.shooting >= 0 && this.ratePlayer.shooting <= 100 &&
      this.ratePlayer.passing !== undefined && this.ratePlayer.passing >= 0 && this.ratePlayer.passing <= 100 &&
      this.ratePlayer.defense !== undefined && this.ratePlayer.defense >= 0 && this.ratePlayer.defense <= 100 &&
      this.ratePlayer.physical !== undefined && this.ratePlayer.physical >= 0 && this.ratePlayer.physical <= 100 &&
      this.ratePlayer.tacticalAwareness !== undefined && this.ratePlayer.tacticalAwareness >= 0 && this.ratePlayer.tacticalAwareness <= 100;
  }

  build() {
    Button({ type: ButtonType.Circle, stateEffect: true }) {
      Image($r('app.media.add')).width(25).height(25)
    }
    .width(50)
    .height(50)
    .onClick(() => {
      this.ratePlayer.id = this.Player.id;
      this.dialogController.open();
    })
  }
}

@CustomDialog
struct RatingDialog {
  @Link ratePlayer: RatePlayerParams;
  controller: CustomDialogController;
  confirm: () => void = () => {}; // 提供默认实现

  build() {
    Column() {
      Text('球员能力评价').fontSize(20)

      this.createRatingInputRow('射门', (value: string) => {
        this.ratePlayer.shooting = parseInt(value);
      })
      this.createRatingInputRow('传球', (value: string) => {
        this.ratePlayer.passing = parseInt(value);
      })
      this.createRatingInputRow('防守', (value: string) => {
        this.ratePlayer.defense = parseInt(value);
      })
      this.createRatingInputRow('盘带', (value: string) => {
        this.ratePlayer.dribbling = parseInt(value);
      })
      this.createRatingInputRow('身体对抗', (value: string) => {
        this.ratePlayer.physical = parseInt(value);
      })
      this.createRatingInputRow('战术意识', (value: string) => {
        this.ratePlayer.tacticalAwareness = parseInt(value);
      })

      Row() {
        Button('取消')
          .margin(10)
          .onClick(() => {
            this.controller.close();
          })
        Button('确定')
          .margin(10)
          .onClick(() => {
            this.confirm();
            this.controller.close();
          })
      }.margin({ top: 20, bottom: 20 })
    }
    .width('100%')
    .padding(20)
    .backgroundColor(Color.White)
    .borderRadius({ topLeft: 24, topRight: 24 })
  }

  @Builder
  createRatingInputRow(label: string, onChange: (value: string) => void) {
    Row() {
      Text(label)
        .width('30%')
        .fontSize(16)
      TextInput({ placeholder: '0-100' })
        .width('70%')
        .type(InputType.Number)
        .onChange(onChange)
    }
    .width('100%')
    .margin({ top: 10, bottom: 10 })
  }
}