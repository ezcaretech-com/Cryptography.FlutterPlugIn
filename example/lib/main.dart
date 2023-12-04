import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:cryptography/cryptography.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _cryptographyPlugin = Cryptography();
  final _key = 'EzForm_Generator1111111111111111';
  final _plainId = 'CCC0EMR';
  final _plainPw = '11111';
  String? _encryptedId;
  String? _encryptedPw;
  String? _decryptedId;
  String? _decryptedPw;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _cryptographyPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      _encryptedId = await _cryptographyPlugin.aesEncrypt(_plainId, _key);
      _encryptedPw = await _cryptographyPlugin.aesEncrypt(_plainPw, _key);

      debugPrint(_encryptedId);
      debugPrint(_encryptedPw);

      _decryptedId = _encryptedId == null
          ? null
          : await _cryptographyPlugin.aesDecrypt(_encryptedId!, _key);
      _decryptedPw = _encryptedPw == null
          ? null
          : await _cryptographyPlugin.aesDecrypt(_encryptedPw!, _key);
    } catch (e) {
      null;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Running on: $_platformVersion\n'),
              Text('_plainId: $_plainId\n'),
              Text('_encryptedId: $_encryptedId\n'),
              Text('_decryptedId: $_decryptedId\n'),
              Text('_plainPw: $_plainPw\n'),
              Text('_encryptedPw: $_encryptedPw\n'),
              Text('_decryptedPw: $_decryptedPw\n'),
            ],
          ),
        ),
      ),
    );
  }
}
