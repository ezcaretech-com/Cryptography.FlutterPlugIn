
import 'cryptography_platform_interface.dart';

class Cryptography {
  Future<String?> getPlatformVersion() {
    return CryptographyPlatform.instance.getPlatformVersion();
  }

  Future<String?> aesEncrypt(String text, String key) {
    return CryptographyPlatform.instance.aesEncrypt(text, key);
  }

  Future<String?> aesDecrypt(String text, String key) {
    return CryptographyPlatform.instance.aesDecrypt(text, key);
  }
}
