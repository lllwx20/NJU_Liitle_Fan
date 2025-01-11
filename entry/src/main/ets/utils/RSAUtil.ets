import { buffer, util } from '@kit.ArkTS';
import { cryptoFramework } from '@kit.CryptoArchitectureKit';
/**
 * 使用RSA非对称密钥（PKCS1模式）加密
 * @param message 要加密的明文数据
 * @returns 加密后的字符串，base64编码
 */
export async function encryptRSA(pubKeyStr : string, message: string) : Promise<string>{
  // 服务器下发RSA公钥字符串（base64编码）

  // 初始化Base64工具实例
  let base64Helper = new util.Base64Helper();
  // 公钥转换为Uint8Array，然后包装为DataBlob类型
  let pubKeyBlob: cryptoFramework.DataBlob = { data: base64Helper.decodeSync(pubKeyStr) };
  // 创建RSA key生成器
  let rsaGenerator = cryptoFramework.createAsyKeyGenerator('RSA1024');
  // 将公钥包装数据pubKeyBlob转换成密钥对类型KeyPair
  let keyPair = await rsaGenerator.convertKey(pubKeyBlob, null);
  // 创建 Cipher对象
  let cipher = cryptoFramework.createCipher('RSA1024|PKCS1');
  // 初始化加密模式，指定密钥keyPair.pubKey
  await cipher.init(cryptoFramework.CryptoMode.ENCRYPT_MODE, keyPair.pubKey, null);
  // 包装要加密的明文
  let plainTextBlob: cryptoFramework.DataBlob = { data: new Uint8Array(buffer.from(message, 'utf-8').buffer) };
  // 传入明文，获取加密后的数据
  let encryptBlob = await cipher.doFinal(plainTextBlob);
  // 返回加密后的字符串
  return base64Helper.encodeToStringSync(encryptBlob.data);
}