//
//  AnAnSeriesCodeData.swift
//  RuanVideo
//
//  Created by Henry on 2023/3/27.
//  视频播放地址解码

import UIKit
import CommonCrypto
final class AnAnSeriesCodeData {
    private static let DataInfoStringList : String = "w9f1[" + "oK8%" + "fwH" + "Bsw7"
    
    public static func videoPlayerUrlDecode(str:String, deviceKey:String) throws -> String {
        
        let tokenKey = deviceKey.dropFirst(2).prefix(16) as Substring
        let contentData = Data(base64Encoded: str, options: Data.Base64DecodingOptions.ignoreUnknownCharacters)
        let keyData = tokenKey.data(using: String.Encoding.utf8)
        if (contentData == nil || keyData == nil)  {
            return "contentData ？？？ keyData ？？？"
        }
        let decryptedData : Data = try dataInfoBaes(stringData:contentData ?? Data(), keyData: keyData ?? Data())
        let resultStr : String = String(data: decryptedData, encoding: String.Encoding.utf8) ?? ""
        if (resultStr.isEmpty || resultStr.count < 1 ) {
            return AnAnSeriesCodeData.dataInfoReloadError().localizedDescription
        }
        return resultStr
        
        
    }
    private static func dataInfoBaes(stringData: Data, keyData: Data) throws -> Data {

        let operation: CCOperation = UInt32(kCCDecrypt)
        return try cipherOperation(contentData: stringData, keyData: keyData, operation: operation)
    }

    private static func cipherOperation(contentData: Data, keyData: Data, operation: CCOperation) throws -> Data {
        let dataLength = contentData.count
        let resultStr = DataInfoStringList

        let initVectorBytes = (resultStr.data(using: .utf8)! as NSData).bytes
        let contentBytes = (contentData as NSData).bytes
        let keyBytes = (keyData as NSData).bytes

        let operationSize = dataLength + kCCBlockSizeAES128
        let operationBytes = UnsafeMutableRawPointer.allocate(byteCount: operationSize, alignment: 1)
        let aes: CCOperation = UInt32(kCCAlgorithmAES)
        let padding: CCOperation = UInt32(kCCOptionPKCS7Padding)
        var actualOutSize : size_t = 0
        var cryptStatus: CCCryptorStatus = -1
        do {
            cryptStatus = CCCrypt(operation,
                                  aes,
                                  padding,
                                  keyBytes,
                                  kCCKeySizeAES128,
                                  initVectorBytes,
                                  contentBytes,
                                  dataLength,
                                  operationBytes,
                                  operationSize,
                                  &actualOutSize)
            guard cryptStatus == kCCSuccess else {
                
                throw dataInfoReloadError()
            }
            return Data(bytesNoCopy: operationBytes, count: actualOutSize, deallocator: .none)
        } catch {
            
            throw error
        }
    }

    private static func dataInfoReloadError() -> Error {
        let error = NSError(domain: "error", code: 9999, userInfo: [NSLocalizedDescriptionKey: "Decode"])
        return error
    }
}


class AnAnPlayerUrlParse {
    static func playerUrlParse(url:String,result:(String)->Void){
        let userToken : String = AnAnUserData.readUserData()?.token ?? ""
        if (url.count > 0) {
            if (url.hasPrefix("http")) {
                result(url)
            } else {
                do {
                    let deurl: String = try AnAnSeriesCodeData.videoPlayerUrlDecode(str: url, deviceKey: userToken)
                    result(deurl)
                } catch {
                    result("")
                }
            }
        }
    }
}
