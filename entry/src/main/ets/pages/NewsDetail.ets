import { router } from "@kit.ArkUI";
import CommonConstants from '../constants/CommonConstants';

class BannerClass {
    id: string = '';
    imageSrc: ResourceStr = '';

    constructor(id: string, imageSrc: ResourceStr) {
        this.id = id;
        this.imageSrc = imageSrc;
    }
}

@Entry
struct NewsDetail {
    @State newsTitle: string = '软院青春风暴席卷南冠，4-1大胜地科';

    @State pictureList: Array<BannerClass> = [
        new BannerClass('pic1', $r('app.media.1')),
        new BannerClass('pic2', $r('app.media.1a')),
        new BannerClass('pic3', $r('app.media.1b')),
    ];

    @State newsContent: string =
        '   在昨晚的南冠联赛中，软院足球队以4-1的压倒性优势战胜地科队，展现了他们的强大实力和出色的团队配合。这场比赛在热烈的氛围中进行，软院队从一开始就掌控了比赛节奏，展现出青春活力和斗志。\n' +
            '\n' +
            '   比赛的第15分钟，软院队的前锋张伟在禁区内接到队友的传球，冷静施射，帮助球队首开纪录。随后，地科队虽然试图反击，但软院队的防线表现稳健，未给对手太多机会。\n' +
            '\n' +
            '   第30分钟，软院队的中场核心李明在一次快速反击中，巧妙地将球送至边路，边锋王磊快速插上，精准传中，前锋刘强在门前把握住机会，轻松将球送入网窝，比分扩大为2-0。\n' +
            '\n' +
            '   下半场开始不久，地科队通过一次任意球机会扳回一城，球员李华的精准射门让他们看到了希望。然而，软院队并没有因此受到影响，反而在第70分钟再次发力。通过一系列流畅的配合，张伟再次破门，将比分改写为3-1。\n' +
            '\n' +
            '   比赛的最后时刻，软院队的替补球员小李也在登场后表现出色，他在第85分钟接到长传球后，带球突破防线，冷静推射，锁定了比赛的最终比分4-1。\n' +
            '\n' +
            '   这场胜利不仅为软院队积累了宝贵的积分，也让他们在本赛季的竞争中信心倍增。教练在赛后表示：“球队的表现非常出色，年轻球员们展现了他们的潜力和拼搏精神，希望能在接下来的比赛中继续保持这样的状态。”';

    build() {
        Column() {
            Scroll() {
                Column() {
                    // 返回按钮
                    Row() {
                        Image($r('app.media.BackBlack'))
                            .width(45)
                            .height(45)
                            .onClick(() => {
                                router.back();
                            })
                            .padding(10);
                    }
                    .align(Alignment.TopStart)
                    .width('100%');

                    // 新闻标题
                    Text(this.newsTitle)
                        .fontSize(24)
                        .fontWeight('bold')
                        .padding(10)
                        .align(Alignment.TopStart);

                    //新闻图片
                    Swiper() {
                        ForEach(this.pictureList, (item: BannerClass, index: number) => {
                            Image(item.imageSrc)
                                .objectFit(ImageFit.Contain)
                                .width('100%')
                                .padding({ top: 6, left: 5, right: 5, bottom: 6 })
                                .borderRadius(12)
                        }, (item: BannerClass, index: number) => item.id);
                    }
                    .padding(19)
                    .autoPlay(true)
                    .loop(true)
                    .indicator(
                        new DotIndicator()
                            .color('#1a000000')
                            .selectedColor('#0A59F7'));

                    Text(this.newsContent)
                        .fontSize(17)
                        .padding(10)
                        .align(Alignment.TopStart)
                        .padding(19)
                    Row(){
                        Divider()
                        .width('30%')
                        .strokeWidth(1.2)
                        .color(Color.Gray)
                        .opacity(0.5)
                        Text('我是有底线的')
                            .fontColor(Color.Gray)
                            .fontSize(13)
                            .padding(10)
                            .align(Alignment.TopStart)
                        Divider()
                        .width('30%')
                        .strokeWidth(1.2)
                        .color(Color.Gray)
                        .opacity(0.5)

                    }
                    .margin({top : 15,bottom : 15})
                }.layoutWeight(1)
                .align(Alignment.TopStart)
            }
            .scrollBar(BarState.Off)
            .width('100%')
            .height('100%')
            .backgroundColor('#F5F5F5')
        }
    }
}