import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';
import {
  ChartColor,
  JArrayList,
  XAxis,
  XAxisPosition,
  Description,
  Legend,
  RadarEntry,
  RadarChart,
  RadarDataSet,
  RadarChartModel,
  IRadarDataSet,
  RadarData,
  YAxis,
  IAxisValueFormatter,
  AxisBase,
  LegendVerticalAlignment,
  LegendHorizontalAlignment,
  LegendOrientation,
  OnChartValueSelectedListener,
  EntryOhos,
  Highlight,
} from '@ohos/mpchart';
import Logger from '../utils/Logger';
function hexToRgb(hex: string): number {
  hex = hex.replace(/^#/, '');
  const bigint = parseInt(hex, 16);
  const r = (bigint >> 16) & 255;
  const g = (bigint >> 8) & 255;
  const b = bigint & 255;
  return ChartColor.rgb(r, g, b);
}

@Component
export default struct PlayerRadarChart {
  @Prop @Watch("onPlayerChanged")Player: Player;
  @State private isValueSelected: boolean = false;
  @State private selectedValue: number = 0;
  @State private selectedIndex: number = -1;

  onPlayerChanged() {
    this.setData();
    this.model.animateXY(1500, 1500);
  }

  // 颜色定义
  private PRIMARY_BLUE: number = hexToRgb('#2169A5');
  private SECONDARY_BLUE: number = hexToRgb('#48B0F8');
  private TEXT_COLOR: number = hexToRgb('#2C3E50');

  private valueSelectedListener: OnChartValueSelectedListener = {
    onValueSelected: (e: EntryOhos, h: Highlight) => {
      this.isValueSelected = true;
      this.selectedValue = e.getY();
      this.selectedIndex = h.getX();
      Logger.info("雷达图选中值: " + this.selectedValue + " at index: " + this.selectedIndex);
    },
    onNothingSelected: () => {
      this.isValueSelected = false;
      this.selectedValue = 0;
      this.selectedIndex = -1;
    }
  }

  // 图表模型
  private model: RadarChartModel = new RadarChartModel();


  @Builder
  build() {
    Stack() {
      Text('评价数: ' + this.Player.rateNum)
        .fontSize(15)
        .fontColor(Color.Grey)
        .width('40%')
        .height('5%')
        .position({ x: '8%', y: '3%' })
        .zIndex(99)
      RadarChart({ model: this.model })
        .width('120%')
        .height('100%')
        .backgroundColor(Color.White)
        .padding({bottom : 200, left : 23, right : 10})


      if (this.isValueSelected) {
        Text(`${this.getAttributeLabel(this.selectedIndex)}: ${this.selectedValue.toFixed(1)}`)
          .fontSize(16)
          .fontColor(Color.White)
          .fontWeight(FontWeight.Bold)
          .textAlign(TextAlign.Center)
          .backgroundColor(this.SECONDARY_BLUE)  // 使用更浅的蓝色
          .width('40%')
          .height('5%')
          .borderRadius(20)
          .padding(8)
          .position({ x: '32%', y: '65%' })  // 移动到雷达图下方
          .shadow({
            radius: 3,
            color: '#20000000',
            offsetX: 1,
            offsetY: 1
          })
      }
    }
    .borderRadius(8)
    .backgroundColor('#F5F5F5')
    .width('100%')
    .height('100%')
  }

  // 辅助方法：获取属性标签
  private getAttributeLabel(index: number): string {
    const labels = ["射门", "传球", "盘带", "防守", "身体对抗", "战术意识"];
    return index >= 0 && index < labels.length ? labels[index] : "";
  }

  aboutToAppear() {
    this.model.setOnChartValueSelectedListener(this.valueSelectedListener);

    let description: Description | null = this.model.getDescription();
    if (description) {
      description.setEnabled(false);
    }
    this.configureLegend();
    this.configureWebLines();
    this.configureXAxis();
    this.configureYAxis();
    this.setData();
    this.model.animateXY(1500, 1500);
  }

  private configureLegend(): void {
    let l: Legend | null = this.model.getLegend();
    if (l) {
      l.setEnabled(false); // 不展示图例
      l.setVerticalAlignment(LegendVerticalAlignment.BOTTOM);
      l.setHorizontalAlignment(LegendHorizontalAlignment.CENTER);
      l.setOrientation(LegendOrientation.HORIZONTAL);
      l.setDrawInside(false);
      l.setXEntrySpace(10);
      l.setYEntrySpace(8);
      l.setTextColor(this.TEXT_COLOR);
      l.setTextSize(14);  // 增大图例文字大小
    }
  }

  private configureWebLines(): void {
    this.model.setWebLineWidth(0.5);
    this.model.setWebColor(Color.Black);
    this.model.setWebLineWidthInner(0.4);
    this.model.setDragDecelerationEnabled(true);
    this.model.setWebColorInner(Color.Black);
    this.model.setWebAlpha(120);
  }

  private configureXAxis(): void {
    let xAxis: XAxis | null = this.model.getXAxis();
    if (xAxis) {
      xAxis.setPosition(XAxisPosition.TOP);
      xAxis.setDrawGridLines(false);
      xAxis.setTextSize(15);  // 增大轴标签文字大小
      xAxis.setYOffset(0);
      xAxis.setXOffset(0);
      xAxis.setGranularity(1);
      xAxis.setLabelCount(6);  // 增加到6个标签
      xAxis.setValueFormatter(new valueFormatter());
      xAxis.setTextColor(Color.Black);
    }
  }

  private configureYAxis(): void {
    let yAxis: YAxis | null = this.model.getYAxis();
    if (yAxis) {
      yAxis.setLabelCount(6, true);
      yAxis.setTextSize(10);
      yAxis.setAxisMinimum(0);
      yAxis.setAxisMaximum(100);
      yAxis.setDrawLabels(false);
    }
  }

  private setData(): void {
    let entries: JArrayList<RadarEntry> = new JArrayList<RadarEntry>();

    const attributes = [
      (this.Player.shooting),  // 射门
      (this.Player.passing),  // 传球
      (this.Player.dribbling),  // 盘带
      (this.Player.defense),  // 防守
      (this.Player.physical),  // 身体对抗
      (this.Player.tacticalAwareness)   // 战术意识(新增)
    ];

    attributes.forEach(val => {
      entries.add(new RadarEntry(val));
    });

    let dataSet: RadarDataSet = new RadarDataSet(entries, this.Player.playerName);
    dataSet.setColorByColor(this.PRIMARY_BLUE);
    dataSet.setFillColor(this.SECONDARY_BLUE);
    dataSet.setDrawFilled(true);
    dataSet.setFillAlpha(180);
    dataSet.setLineWidth(2);
    dataSet.setDrawHighlightCircleEnabled(true);
    dataSet.setDrawHighlightIndicators(true);

    let sets: JArrayList<IRadarDataSet> = new JArrayList<IRadarDataSet>();
    sets.add(dataSet);

    let data: RadarData = new RadarData(sets);
    data.setValueTextSize(13);
    data.setDrawValues(false);  // 默认不显示数值
    data.setValueTextColor(Color.Red);
    this.model.setData(data);
  }
}

class valueFormatter implements IAxisValueFormatter {
  private mActivities: string[] = ["射门", "传球", "盘带", "防守", "身体对抗", "战术意识"];

  getFormattedValue(value: number, axis: AxisBase): string {
    return this.mActivities[Math.floor(value % this.mActivities.length)];
  }
}