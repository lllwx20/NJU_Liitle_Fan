export class Player {
  id: number;
  playerName: string;
  playerGoals: number;
  playerPosition: string;
  playerImageUrl: string;

  constructor(
    id: number = 0,
    playerName: string = "",
    playerGoals: number = 0,
    playerPosition: string = "",
    playerImageUrl: string = ""
  ) {
    this.id = id;
    this.playerName = playerName;
    this.playerGoals = playerGoals;
    this.playerPosition = playerPosition;
    this.playerImageUrl = playerImageUrl;
  }
}
