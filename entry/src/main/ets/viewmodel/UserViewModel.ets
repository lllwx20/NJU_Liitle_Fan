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
          Logger.error(url + ' getList failed', JSON.stringify(data));
          promptAction.showToast({message : "手机号或密码错误！"})
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

let userViewModel = new UserViewModel();

export default userViewModel as UserViewModel;