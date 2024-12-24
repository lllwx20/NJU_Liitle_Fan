export class Player {
  id: number;
  number :number;
  playerName: string;
  playerGoals: number;
  playerPosition: string;
  playerImageUrl: string;
  teamImageUrl: string;
  team: string;
  playerAge: number;
  assist: number;
  shot: number;
  shotRight: number;
  shotPenalty: number;
  save: number;
  steal: number;
  redCard: number;
  yellowCard: number;
  foul: number;
  foulAgainst: number;
  bornYearMonth: string;
  playYear: number;
  weight: number;
  height: number;
  playedGame: number;
  playedTime: number;
  starterGame: number;
  shooting:number;
  passing:number;
  defense:number;
  physical:number;
  tacticalAwareness:number;
  dribbling:number;
  rateNum:number;
  constructor(
    id: number = 0,
    number : number = 0,
    playerName: string = "",
    playerGoals: number = 0,
    playerPosition: string = "",
    playerImageUrl: string = "",
    team: string = "",
    teamImageUrl: string = "",
    playerAge: number = 0,
    assist: number = 0,
    shot: number = 0,
    shotRight: number = 0,
    shotPenalty: number = 0,
    save: number = 0,
    steal: number = 0,
    redCard: number = 0,
    yellowCard: number = 0,
    foul: number = 0,
    foulAgainst: number = 0,
    bornYearMonth: string= "",
    playYear: number= 0,
    weight: number= 0,
    height: number= 0,
    playedGame: number= 0,
    playedTime: number= 0,
    starterGame: number= 0,
  dribbling: number= 0,
  shooting:number= 0,
  passing:number= 0,
  defense:number= 0,
  physical:number= 0,
  tacticalAwareness:number= 0,
  rateNum:number= 0,
  ) {
    this.id = id;
    this.number = number;
    this.playerName = playerName;
    this.playerGoals = playerGoals;
    this.playerPosition = playerPosition;
    this.playerImageUrl = playerImageUrl;
    this.team = team;
    this.teamImageUrl = teamImageUrl;
    this.playerAge = playerAge;
    this.assist = assist;
    this.shot = shot;
    this.shotRight = shotRight;
    this.shotPenalty = shotPenalty;
    this.save = save;
    this.steal = steal;
    this.redCard = redCard;
    this.yellowCard = yellowCard;
    this.foul = foul;
    this.foulAgainst = foulAgainst;
    this.bornYearMonth  = bornYearMonth
    this.playYear = playYear
    this.weight = weight
    this.height = height
    this.playedGame = playedGame
    this.playedTime = playedTime
    this.starterGame = starterGame
    this.shooting = shooting
    this.passing = passing
    this.defense = defense
    this.physical = physical
    this.tacticalAwareness = tacticalAwareness
    this.dribbling = dribbling
    this.rateNum = rateNum
  }
}


export class ClassifyModel {
  classifyId: number;
  classifyName: string | Resource;

  constructor(classifyId: number, classifyName: string | Resource) {
    this.classifyId = classifyId;
    this.classifyName = classifyName;
  }
}

export class RatePlayerParams {
  id?: number;
  shooting?: number;
  passing?: number;
  defense?: number;
  physical?: number;
  tacticalAwareness?: number;
  dribbling?:number;
}