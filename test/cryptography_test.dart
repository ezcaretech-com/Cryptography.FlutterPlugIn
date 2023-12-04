import 'package:flutter_test/flutter_test.dart';
import 'package:cryptography/cryptography.dart';
import 'package:cryptography/cryptography_platform_interface.dart';
import 'package:cryptography/cryptography_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCryptographyPlatform
    with MockPlatformInterfaceMixin
    implements CryptographyPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CryptographyPlatform initialPlatform = CryptographyPlatform.instance;

  test('$MethodChannelCryptography is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCryptography>());
  });

  test('getPlatformVersion', () async {
    Cryptography cryptographyPlugin = Cryptography();
    MockCryptographyPlatform fakePlatform = MockCryptographyPlatform();
    CryptographyPlatform.instance = fakePlatform;

    expect(await cryptographyPlugin.getPlatformVersion(), '42');
  });
}
