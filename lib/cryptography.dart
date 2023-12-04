
import 'cryptography_platform_interface.dart';

class Cryptography {
  Future<String?> getPlatformVersion() {
    return CryptographyPlatform.instance.getPlatformVersion();
  }
}
