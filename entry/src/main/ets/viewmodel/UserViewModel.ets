import CommonConstants from '../constants/CommonConstants';
import ResponseResult from '../model/ResponseResult';
import { User } from '../model/User';
import { httpRequestGet, httpRequestPost } from '../utils/HttpUtil';
import Logger from '../utils/Logger';
import { promptAction } from '@kit.ArkUI';

export class LogInfo {
  phone : string = ""
  password : string = ""
}

class UserViewModel {

  Login(info :LogInfo) : Promise<number> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.LOGIN}`;
      httpRequestPost(url, info).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          promptAction.showToast({message : "登录成功！"})
          Logger.info(url + ' Login', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' Login failed', JSON.stringify(data));
          promptAction.showToast({message : "手机号或密码错误！"})
          reject($r('app.string.page_none_msg'));
        }
      })
    });
  }

  setMainTeam(uid : number, tid : number) : Promise<boolean> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.SET_MAIN_TEAM}${uid}/${tid}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          promptAction.showToast({message : "选择成功！"})
          Logger.info(url + ' setMainTeam', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' setMainTeam failed', JSON.stringify(data));
          promptAction.showToast({message : "选择失败！"})
          reject($r('app.string.page_none_msg'));
        }
      })
    });
  }

  subscribe(uid : number, gid : number) : Promise<boolean> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.SUBSCRIBE}${uid}/${gid}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' subscribe', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' subscribe failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    });
  }

  cancel(uid : number, gid : number) : Promise<boolean> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.CANCEL}${uid}/${gid}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' cancel', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' cancel failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    });
  }

  clear(uid : number, tid : number) : Promise<boolean> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.CLEAR_OLD}${uid}/${tid}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' clear', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' clear failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      })
    });
  }



  getUser(id : number) : Promise<User> {
  return new Promise(async (resolve: Function, reject: Function) => {
    let url = `${CommonConstants.SERVER}${CommonConstants.GET_USER}${id}`;
    httpRequestGet(url).then((data: ResponseResult) => {
      if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
        Logger.info(url + ' getUser', JSON.stringify(data));
        resolve(data.data);
      } else {
        Logger.error(url + ' getUser failed', JSON.stringify(data));
        reject($r('app.string.page_none_msg'));
      }
    }).catch((err: Error) => {
      Logger.error('getUser failed', JSON.stringify(err));
      reject($r('app.string.http_error_message'));
    });
  });
}

  getPublicKeyStr() : Promise<string> {
    return new Promise(async (resolve: Function, reject: Function) => {
      let url = `${CommonConstants.SERVER}${CommonConstants.GET_PUBLIC_KEY_STR}`;
      httpRequestGet(url).then((data: ResponseResult) => {
        if (data.code === CommonConstants.SERVER_CODE_SUCCESS) {
          Logger.info(url + ' getPublicKeyStr', JSON.stringify(data));
          resolve(data.data);
        } else {
          Logger.error(url + ' getPublicKeyStr failed', JSON.stringify(data));
          reject($r('app.string.page_none_msg'));
        }
      }).catch((err: Error) => {
        Logger.error('getPublicKeyStr failed', JSON.stringify(err));
        reject($r('app.string.http_error_message'));
      });
    });
  }

}

let userViewModel = new UserViewModel();

export default userViewModel as UserViewModel;