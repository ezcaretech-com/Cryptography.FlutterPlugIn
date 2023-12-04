import CryptoSwift
import Flutter
import UIKit

public class CryptographyPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "cryptography", binaryMessenger: registrar.messenger())
    let instance = CryptographyPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "aesEncrypt":
      if let args = call.arguments as? Dictionary<String, Any>,
        let text = args["text"] as? String,
        let key = args["key"] as? String {
        result(try? CryptographyPlugin.aesEncrypt(with: text, key: key))
      } else {
        result(FlutterError.init(code: "bad args", message: nil, details: nil))
      }
    case "aesDecrypt":
      if let args = call.arguments as? Dictionary<String, Any>,
        let text = args["text"] as? String,
        let key = args["key"] as? String {
        result(try? CryptographyPlugin.aesDecrypt(with: text, key: key))
      } else {
        result(FlutterError.init(code: "bad args", message: nil, details: nil))
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
  
  public static func aesEncrypt(with text: String, key: String) throws -> String {
    let key = Array(key.utf8)
    let iv: [UInt8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
    let data = try aes.encrypt(Array(text.bytes))
    return Data(data).base64EncodedString()
  }

  public static func aesDecrypt(with text: String, key: String) throws -> String {
    let key = Array(key.utf8)
    let iv: [UInt8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]
    let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
    let ciperData = Data(base64Encoded: text) ?? Data()
    let decryptedData = try aes.decrypt(ciperData.bytes)
    return String(bytes: decryptedData, encoding: .utf8) ?? ""
  }
}
