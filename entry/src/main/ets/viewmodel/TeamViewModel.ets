import CommonConstants from '../constants/CommonConstants';
import ResponseResult from '../model/ResponseResult';
import { Team } from '../model/Team';
import { httpRequestGet } from '../utils/HttpUtil';
import Logger from '../utils/Logger';

class TeamViewModel {
  getTeamList() : Promise<Team[]> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_TEAM_LIST}`;
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
  getTeam(id : number) : Promise<Team> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_TEAM}${id}`;
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
  getTeamRank(id : number) : Promise<number> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_TEAM_RANK}${id}`;
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

let teamViewModel = new TeamViewModel();

export default teamViewModel as TeamViewModel;