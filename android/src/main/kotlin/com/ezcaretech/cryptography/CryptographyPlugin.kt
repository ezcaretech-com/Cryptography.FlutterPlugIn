package com.ezcaretech.cryptography

import android.util.Base64;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import java.io.UnsupportedEncodingException
import java.security.InvalidAlgorithmParameterException
import java.security.InvalidKeyException
import java.security.NoSuchAlgorithmException
import java.security.spec.AlgorithmParameterSpec
import javax.crypto.BadPaddingException
import javax.crypto.Cipher
import javax.crypto.IllegalBlockSizeException
import javax.crypto.NoSuchPaddingException
import javax.crypto.spec.IvParameterSpec
import javax.crypto.spec.SecretKeySpec

/** CryptographyPlugin */
class CryptographyPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "cryptography")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else if (call.method == "aesEncrypt") {
      val text = call.argument<String>("text")
      val key = call.argument<String>("key")
      if (text != null && key != null) {
        result.success(aesEncrypt(text, key))
      } else {
        result.error("bad args", null, null)
      }
    } else if (call.method == "aesDecrypt") {
      val text = call.argument<String>("text")
      val key = call.argument<String>("key")
      if (text != null && key != null) {
        result.success(aesDecrypt(text, key))
      } else {
        result.error("bad args", null, null)
      }
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }


  var ivBytes = byteArrayOf(
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00,
    0x00
  )

  @Throws(
    UnsupportedEncodingException::class,
    NoSuchAlgorithmException::class,
    NoSuchPaddingException::class,
    InvalidKeyException::class,
    InvalidAlgorithmParameterException::class,
    IllegalBlockSizeException::class,
    BadPaddingException::class
  )
  fun aesEncrypt(str: String, key: String): String? {
    val textBytes = str.toByteArray(charset("UTF-8"))
    val ivSpec: AlgorithmParameterSpec = IvParameterSpec(ivBytes)
    val newKey = SecretKeySpec(key.toByteArray(charset("UTF-8")), "AES")
    var cipher: Cipher? = null
    cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
    cipher.init(Cipher.ENCRYPT_MODE, newKey, ivSpec)
    return Base64.encodeToString(cipher.doFinal(textBytes), 0)
  }

  @Throws(
    UnsupportedEncodingException::class,
    NoSuchAlgorithmException::class,
    NoSuchPaddingException::class,
    InvalidKeyException::class,
    InvalidAlgorithmParameterException::class,
    IllegalBlockSizeException::class,
    BadPaddingException::class
  )
  fun aesDecrypt(str: String, key: String): String? {
    val textBytes: ByteArray = Base64.decode(str, 0)
    //byte[] textBytes = str.getBytes("UTF-8");
    val ivSpec: AlgorithmParameterSpec = IvParameterSpec(ivBytes)
    val newKey = SecretKeySpec(key.toByteArray(charset("UTF-8")), "AES")
    val cipher = Cipher.getInstance("AES/CBC/PKCS5Padding")
    cipher.init(Cipher.DECRYPT_MODE, newKey, ivSpec)
    return cipher.doFinal(textBytes).toString(Charsets.UTF_8)
  }
}
