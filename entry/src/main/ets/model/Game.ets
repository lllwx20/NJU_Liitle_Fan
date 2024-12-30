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
  teamA: Team;
  teamB: Team;
  teamAGoals: number = 0;
  teamBGoals: number = 0;
  time: Date = new Date();
  status: GameStatus;

  stats : StatComparison[];




  constructor(teamA: Team, teamB: Team, teamAGoals: number, teamBGoals: number, time: Date) {
    this.teamA = teamA;
    this.teamB = teamB;
    this.teamAGoals = teamAGoals;
    this.teamBGoals = teamBGoals;
    this.time = time;  // 允许传入手动设置的时间

    // 在构造函数中确定比赛状态
    this.status = this.getGameStatus();
    this.stats = this.generateStats();

  }

  // 获取比赛状态
  getGameStatus(): GameStatus {
    const currentTime = new Date(); // 获取当前时间
    const gameStartTime = this.time;
    const gameEndTime = new Date(gameStartTime.getTime() + 75 * 60 * 1000); // 比赛结束时间：开始时间 + 75分钟

    if (currentTime < gameStartTime) {
      return GameStatus.NotStarted;  // 比赛未开始
    } else if (currentTime >= gameStartTime && currentTime <= gameEndTime) {
      return GameStatus.Ongoing;  // 比赛进行中
    } else {
      return GameStatus.Ended;  // 比赛已结束
    }
  }

  // 获取队伍A与队伍B的比分
  getScore(): string {
    return `${this.teamAGoals} : ${this.teamBGoals}`;
  }
   generateStats(): StatComparison[] {
    return [
      { label: '场次', teamAData: this.teamA.teamPlayed, teamBData: this.teamB.teamPlayed },
      { label: '进球', teamAData: this.teamA.teamGoals, teamBData: this.teamB.teamGoals },
      { label: '失球', teamAData: this.teamA.teamLoss, teamBData: this.teamB.teamLoss },
      { label: '胜场', teamAData: this.teamA.teamWin, teamBData: this.teamB.teamWin },
      { label: '负场', teamAData: this.teamA.teamLose, teamBData: this.teamB.teamLose },
      { label: '平局', teamAData: this.teamA.teamDraw, teamBData: this.teamB.teamDraw},
      { label: '助攻', teamAData: this.teamA.teamSupport, teamBData: this.teamB.teamSupport },
      { label: '黄牌', teamAData: this.teamA.teamYellow, teamBData: this.teamB.teamYellow },
    ];
  }

  // 获取格式化的比赛时间
  getFormattedTime(): string {
    const year = this.time.getFullYear();
    const month = String(this.time.getMonth() + 1).padStart(2, '0');
    const day = String(this.time.getDate()).padStart(2, '0');
    const hours = String(this.time.getHours()).padStart(2, '0');
    const minutes = String(this.time.getMinutes()).padStart(2, '0');
    return `${year}-${month}-${day} ${hours}:${minutes}`;
  }
}
