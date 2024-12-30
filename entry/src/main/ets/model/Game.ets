import { Team } from "./Team";

// 定义比赛状态的枚举
export enum GameStatus {
  NotStarted = '未开始',
  Ongoing = '进行中',
  Ended = '已结束'
}

export interface StatComparison {
  label: string; // 数据的名称，例如 "比赛场次"
  teamAData: number; // 球队A的数据
  teamBData: number; // 球队B的数据
}

export class Game {
  id : number = 0;
  team1: number = 0;
  team2: number = 0;
  team1Score: number = 0;
  team2Score: number = 0;
  gameTime: Date = new Date();
  isOver:boolean = false;


  status: GameStatus = GameStatus.Ended;
  stats : StatComparison[] = [];

  // 获取比赛状态


  // 获取队伍A与队伍B的比分

  getScore(): string {
    return `${this.team1Score} : ${this.team2Score}`;
  }


  // 获取格式化的比赛时间
  getFormattedTime(): string {
    const year = this.gameTime.getFullYear();
    const month = String(this.gameTime.getMonth() + 1).padStart(2, '0');
    const day = String(this.gameTime.getDate()).padStart(2, '0');
    const hours = String(this.gameTime.getHours()).padStart(2, '0');
    const minutes = String(this.gameTime.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
  }
}
