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
  @Prop Player: Player;

  // 颜色定义
  private PRIMARY_BLUE: number = hexToRgb('#2169A5');
  private SECONDARY_BLUE: number = hexToRgb('#48B0F8');
  private TEXT_COLOR: number = hexToRgb('#2C3E50');

  private valueSelectedListener: OnChartValueSelectedListener = {
    onValueSelected: (e: EntryOhos, h: Highlight) => {
      Logger.info("雷达图选中值: " + e.getX());
    },
    onNothingSelected: () => {

    }
  }

  // 图表模型
  private model: RadarChartModel = new RadarChartModel();

  // 自定义X轴标签格式化
  @State private valueFormatter: ValueFormatter = new ValueFormatter()

  @Builder
  build() {
    Column() {
        RadarChart({ model: this.model })
          .width('100%')
          .height('100%')  // 铺满高度
          .backgroundColor(Color.White)
    }
    .borderRadius(8)
    .backgroundColor('#F5F5F5')
    .width('100%')
    .height('50%')
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
  }

  private configureLegend(): void {
    let l: Legend | null = this.model.getLegend();
    if (l) {
      l.setEnabled(true);
      l.setVerticalAlignment(LegendVerticalAlignment.TOP);
      l.setHorizontalAlignment(LegendHorizontalAlignment.CENTER);
      l.setOrientation(LegendOrientation.HORIZONTAL);
      l.setDrawInside(false);
      l.setXEntrySpace(10);
      l.setYEntrySpace(8);
      l.setTextColor(this.TEXT_COLOR);
      l.setTextSize(24);  // 增大图例文字大小
    }
  }

  private configureWebLines(): void {
    this.model.setWebLineWidth(0.4);
    this.model.setWebColor(Color.Black);
    this.model.setWebLineWidthInner(0.4);
    this.model.setWebColorInner(Color.Black);
    this.model.setWebAlpha(120);
    this.model.setExtraTopOffset(-80);
  }

  private configureXAxis(): void {
    let xAxis: XAxis | null = this.model.getXAxis();
    if (xAxis) {
      xAxis.setPosition(XAxisPosition.BOTTOM);
      xAxis.setDrawGridLines(false);
      xAxis.setTextSize(8);  // 增大轴标签文字大小
      xAxis.setYOffset(0);
      xAxis.setXOffset(0);
      xAxis.setGranularity(1);
      xAxis.setLabelCount(6);  // 增加到6个标签
      xAxis.setValueFormatter(this.valueFormatter);
      xAxis.setTextColor(this.TEXT_COLOR);
    }
  }

  private configureYAxis(): void {
    let yAxis: YAxis | null = this.model.getYAxis();
    if (yAxis) {
      yAxis.setLabelCount(5, false);
      yAxis.setTextSize(8);
      yAxis.setAxisMinimum(0);
      yAxis.setAxisMaximum(100);
      yAxis.setDrawLabels(false);
    }
  }

  private setData(): void {
    let entries: JArrayList<RadarEntry> = new JArrayList<RadarEntry>();

    const attributes = [
      (Math.random() * 80 + 20),  // 射门
      (Math.random() * 80 + 20),  // 传球
      (Math.random() * 80 + 20),  // 盘带
      (Math.random() * 80 + 20),  // 防守
      (Math.random() * 80 + 20),  // 身体对抗
      (Math.random() * 80 + 20)   // 战术意识(新增)
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
    dataSet.setDrawHighlightIndicators(false);

    let sets: JArrayList<IRadarDataSet> = new JArrayList<IRadarDataSet>();
    sets.add(dataSet);

    let data: RadarData = new RadarData(sets);
    data.setValueTextSize(10);
    data.setDrawValues(true);
    data.setValueTextColor(this.TEXT_COLOR);
    this.model.setData(data);
  }
}

// 更新标签格式化器以支持6个维度
class ValueFormatter implements IAxisValueFormatter {
  getFormattedValue(value: number, axis: AxisBase): string {
    const labels = ["射门", "传球", "盘带", "防守", "身体对抗", "战术意识"];
    return labels[Math.floor(value)];
  }
}