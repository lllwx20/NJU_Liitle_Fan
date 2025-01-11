import CommonConstants from '../constants/CommonConstants';
import { Game } from '../model/Game';
import ResponseResult from '../model/ResponseResult';
import { httpRequestGet } from '../utils/HttpUtil';
import Logger from '../utils/Logger';

class GameViewModel {



  getGameById(id : number) : Promise<Game> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_GAME}${id}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getGameById', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getGameById failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getGameById failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  IsSubscribed(uid : number, gid : number) : Promise<boolean> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.IS_SUBSCRIBED}${uid}/${gid}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' IsSubscribed', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' IsSubscribed failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('IsSubscribed failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  getAllGames() : Promise<Game[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_ALL_GAME}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getAllGames', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getAllGames failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getAllGames failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

  getGamesByTeam(tid : number) : Promise<Game[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_GAMES_BY_TEAM}${tid}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getGamesByTeam', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getGamesByTeam failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getGamesByTeam failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

}

let userViewModel = new GameViewModel();

export default userViewModel as GameViewModel;