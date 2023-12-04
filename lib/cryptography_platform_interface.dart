import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'cryptography_method_channel.dart';

abstract class CryptographyPlatform extends PlatformInterface {
  /// Constructs a CryptographyPlatform.
  CryptographyPlatform() : super(token: _token);

  static final Object _token = Object();

  static CryptographyPlatform _instance = MethodChannelCryptography();

  /// The default instance of [CryptographyPlatform] to use.
  ///
  /// Defaults to [MethodChannelCryptography].
  static CryptographyPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CryptographyPlatform] when
  /// they register themselves.
  static set instance(CryptographyPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
