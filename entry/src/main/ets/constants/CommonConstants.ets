
/**
 * Common constants for all features.
 */
export default class CommonConstants {

  static readonly SERVER: string = 'http://172.19.184.2:8080';

  static readonly LOGIN: string = '/api/users/login';

  static readonly REGISTER: string = '/api/users/register';

  static readonly GET_PLAYER_LIST: string = '/api/players/getPlayerList';

  static readonly GET_PLAYER_BY_TEAM: string = '/api/players/getPlayerByTeam/';

  static readonly GET_TEAM_LIST: string = '/api/teams/getAll';

  static readonly GET_TEAM_RANK: string = '/api/teams/getTeamRank/'

  static readonly GET_TEAM: string = '/api/teams/getTeam/';

  static readonly RATE_PLAYER: string = '/api/players/ratePlayer';

  static readonly GET_PLAYER_BY_ID: string = '/api/players/getPlayerById/';

  static readonly GET_USER: string = '/api/users/';

  static readonly CLEAR_OLD: string = '/api/users/clear/'

  static readonly SET_MAIN_TEAM: string = '/api/users/setMainTeam/';

  static readonly SUBSCRIBE: string = '/api/users/subscribe/';

  static readonly CANCEL: string = '/api/users/cancel/';

  static readonly GET_GAME: string = '/api/games/getGameById/'

  static readonly GET_ALL_GAME: string = '/api/games/getGameList'

  static readonly IS_SUBSCRIBED: string = '/api/games/IsSubscribed/'

  static readonly GET_GAMES_BY_TEAM: string = '/api/games/getGamesByTeam/'

  static readonly SERVER_CODE_SUCCESS: string = '000';

  static readonly FULL_WIDTH: string = '100%';

  static readonly FULL_HEIGHT: string = '100%';
}


export const enum ContentType {
  JSON = 'application/json'
}