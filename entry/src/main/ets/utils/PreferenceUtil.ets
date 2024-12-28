
import { preferences } from '@kit.ArkData';
import { BusinessError } from '@kit.BasicServicesKit';

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
  return dataPreferences.getSync('uid', 'default').toString()
}

export function Login(uid : number) {
  let dataPreferences =  getPreference();
  dataPreferences.putSync('uid', uid)
}


export function exit() {
  let dataPreferences =  getPreference();
  dataPreferences.deleteSync('uid');
}
