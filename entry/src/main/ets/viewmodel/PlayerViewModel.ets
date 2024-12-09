import CommonConstants from '../constants/CommonConstants';
import { Player } from '../model/Player';
import ResponseResult from '../model/ResponseResult';
import { httpRequestGet } from '../utils/HttpUtil';
import Logger from '../utils/Logger';

class PlayerViewModel {

  getPlayerList(): Promise<Player[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_PLAYER_LIST}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getList', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getList failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getList failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }
}

let playerViewModel = new PlayerViewModel();

export default playerViewModel as PlayerViewModel;