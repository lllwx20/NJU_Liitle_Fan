export class Player {
  id: number;
  number :number;
  playerName: string;
  playerGoals: number;
  playerPosition: string;
  playerImageUrl: string;
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

  constructor(
    id: number = 0,
    number : number = 0,
    playerName: string = "",
    playerGoals: number = 0,
    playerPosition: string = "",
    playerImageUrl: string = "",
    team: string = "",
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
    foulAgainst: number = 0
  ) {
    this.id = id;
    this.number = number;
    this.playerName = playerName;
    this.playerGoals = playerGoals;
    this.playerPosition = playerPosition;
    this.playerImageUrl = playerImageUrl;
    this.team = team;
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
