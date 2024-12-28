import { http } from '@kit.NetworkKit';
import CommonConstants, { ContentType } from '../constants/CommonConstants';
import ResponseResult from '../model/ResponseResult';


/**
 * Initiates an HTTP request to a given URL.
 *
 * @param url URL for initiating an HTTP request.
 * @param params Params for initiating an HTTP request.
 */
export function httpRequestGet(url: string): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.GET,
    readTimeout: 10000,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: 1500,
    extraData: {}
  });
  let serverData: ResponseResult = new ResponseResult();
  // Processes the data and returns.
  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === 200) {
      // Obtains the returned data.
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);
      if (resultJson.code === CommonConstants.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = $r('app.string.http_error_message');
    return serverData;
  })
}
export function httpRequestPost(url: string, data: object): Promise<ResponseResult> {
  let httpRequest = http.createHttp();
  let responseResult = httpRequest.request(url, {
    method: http.RequestMethod.POST,
    readTimeout: 10000,
    header: {
      'Content-Type': ContentType.JSON
    },
    connectTimeout: 1500,
    extraData: data  // 在extraData中传递请求数据
  });

  let serverData: ResponseResult = new ResponseResult();

  return responseResult.then((value: http.HttpResponse) => {
    if (value.responseCode === 200) {
      let result = `${value.result}`;
      let resultJson: ResponseResult = JSON.parse(result);

      if (resultJson.code === CommonConstants.SERVER_CODE_SUCCESS) {
        serverData.data = resultJson.data;
      }
      serverData.code = resultJson.code;
      serverData.msg = resultJson.msg;
    } else {
      serverData.msg = `${$r('app.string.http_error_message')}&${value.responseCode}`;
    }
    return serverData;
  }).catch(() => {
    serverData.msg = $r('app.string.http_error_message');
    return serverData;
  })
}
