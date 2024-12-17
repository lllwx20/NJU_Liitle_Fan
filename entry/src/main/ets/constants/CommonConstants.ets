
/**
 * Common constants for all features.
 */
export default class CommonConstants {

  static readonly SERVER: string = 'http://10.4.49.54:8080';

  static readonly GET_PLAYER_LIST: string = '/api/players/getPlayerList';

  static readonly SERVER_CODE_SUCCESS: string = '000';

  static readonly FULL_WIDTH: string = '100%';

  static readonly FULL_HEIGHT: string = '100%';
}


export const enum ContentType {
  JSON = 'application/json'
}