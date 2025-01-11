import CommonConstants from '../constants/CommonConstants';
import { Player, RatePlayerParams } from '../model/Player';
import ResponseResult from '../model/ResponseResult';
import { httpRequestGet, httpRequestPost } from '../utils/HttpUtil';
import Logger from '../utils/Logger';

class PlayerViewModel {

  getPlayerList(): Promise<Player[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_PLAYER_LIST}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getPlayerList', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getPlayerList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getPlayerList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  getPlayerByTeam(name : string): Promise<Player[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_PLAYER_BY_TEAM}` + name;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getPlayerByTeam', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getPlayerByTeam failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getPlayerByTeam failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  getPlayerById(id : number): Promise<Player> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_PLAYER_BY_ID}` + id;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getPlayer', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getPlayer failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getPlayer failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }


  ratePlayer(params: RatePlayerParams): Promise<boolean> {
  return new Promise(async (resolve: Function, reject: Function) => {
    let url = `${CommonConstants.SERVER}${CommonConstants.RATE_PLAYER}`;

    httpRequestPost(url, params).then((data: ResponseResult) => {
      if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
        Logger.info(url + ' ratePlayer', JSON.stringify(data));
        resolve(data.data);
      } else {
        Logger.error(url + ' ratePlayer failed', JSON.stringify(data));
      }
    }).catch((err: Error) => {
      Logger.error('ratePlayer failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}

}

let playerViewModel = new PlayerViewModel();

export default playerViewModel as PlayerViewModel;