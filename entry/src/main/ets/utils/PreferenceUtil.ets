
import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';
import Logger from './Logger';

let context  = getContext(this)
const PREFERENCES_NAME = 'login';


export function getPreference() : preferences.Preferences{
  let options: preferences.Options = { name: PREFERENCES_NAME };
  let dataPreferences: preferences.Preferences | null = null;
  dataPreferences = preferences.getPreferencesSync(context, options);
  return dataPreferences;
}

export function Logged() : boolean {
  let dataPreferences =  getPreference();
  return dataPreferences.hasSync('uid')
}

export function getUid() : string {
  let dataPreferences =  getPreference();
  if(dataPreferences.hasSync('uid'))
    return dataPreferences.getSync('uid', 'default').toString()
  else
    return "0";
}

export function setChanged(){
  let dataPreferences =  getPreference();
  Logger.info("setchange")
  dataPreferences.putSync('change', true)
}

export function haveChanged(){
  let dataPreferences =  getPreference();
  return dataPreferences.hasSync('change')
}

export function clearChange() {
  let dataPreferences =  getPreference();
  dataPreferences.deleteSync('change');
}


export function LoginPreferences(uid : number) {
  let dataPreferences =  getPreference();
  dataPreferences.putSync('uid', uid)
}


export function exit() {
  let dataPreferences =  getPreference();
  dataPreferences.deleteSync('uid');
}
