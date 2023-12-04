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

  @override
  Future<String?> aesEncrypt(String text, String key) => Future.value('42');

  @override
  Future<String?> aesDecrypt(String text, String key) => Future.value('42');
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

  test('aesEncrypt', () async {
    Cryptography cryptographyPlugin = Cryptography();
    MockCryptographyPlatform fakePlatform = MockCryptographyPlatform();
    CryptographyPlatform.instance = fakePlatform;
    const key = 'EzForm_Generator1111111111111111';
    const plainText = 'CCC0EMR';

    expect(await cryptographyPlugin.aesEncrypt(plainText, key), '42');
  });

  test('aesDecrypt', () async {
    Cryptography cryptographyPlugin = Cryptography();
    MockCryptographyPlatform fakePlatform = MockCryptographyPlatform();
    CryptographyPlatform.instance = fakePlatform;
    const key = 'EzForm_Generator1111111111111111';
    const plainText = 'CCC0EMR';

    expect(await cryptographyPlugin.aesDecrypt(plainText, key), '42');
  });
}
