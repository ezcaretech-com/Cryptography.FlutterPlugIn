import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cryptography/cryptography_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCryptography platform = MethodChannelCryptography();
  const MethodChannel channel = MethodChannel('cryptography');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('aesEncrypt', () async {
    const key = 'EzForm_Generator1111111111111111';
    const plainText = 'CCC0EMR';
    expect(await platform.aesEncrypt(plainText, key), '42');
  });

  test('aesDecrypt', () async {
    const key = 'EzForm_Generator1111111111111111';
    const plainText = 'CCC0EMR';
    expect(await platform.aesDecrypt(plainText, key), '42');
  });
}
