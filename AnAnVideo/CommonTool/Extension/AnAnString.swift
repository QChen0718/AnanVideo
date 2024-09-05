//
//  AnAnString.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/5.
//

import Foundation
//使用系统的MD5
import CommonCrypto
import UIKit

extension String {
    public func addMD5() -> String {
            let str = self.cString(using: .utf8)
            let strLen = CUnsignedInt(self.lengthOfBytes(using: .utf8))
            let digestLen = Int(CC_MD5_DIGEST_LENGTH)
            let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity:digestLen)
            CC_MD5(str!, strLen, result)
                
        let hash = NSMutableString(capacity: Int(CC_MD5_DIGEST_LENGTH) * 2)
            for i in 0 ..< digestLen {
                hash.appendFormat("%02X", result[i])
            }
            free(result)//解决MD5加密造成的内存泄漏问题
        return String(format: hash as String).lowercased()
    }
    
    //range转换为NSRange
    public func nsRange(from range: Range<String.Index>?) -> NSRange? {
        let utf16view = self.utf16
        if let from = range?.lowerBound.samePosition(in: utf16view), let to = range?.upperBound.samePosition(in: utf16view) {
           return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    public func textWidth(font:UIFont,width:CGFloat,height:CGFloat) -> CGFloat{
        let str = self as NSString
        let size = CGSize(width: width, height: height)
        let attributes = [NSAttributedString.Key.font:font]
        let labelSize = str.boundingRect(with: size, options: .usesLineFragmentOrigin,attributes: attributes,context: nil).size
        return labelSize.width
    }
    
//    获取存储地址
    static func getFilePathWithUrl(url:String)->String{
        var path:String = ""
        if url.contains("mp4"){
            path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last?.appending("/\(url.videoFileName())mp4") ?? ""
        }else if url.contains("m3u8"){
            path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last?.appending("/\(url.videoFileName())m3u8") ?? ""
        }
        print("path: %@",path)
        return path
    }
    
//    获取document文件地址
    static func getDocumentFilePath() -> String{
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first?.appending("/") ?? ""
    }
    
    
    func videoFileName() -> String {
        if self.contains("mp4") {
            let newUrlArray:[String] = self.components(separatedBy: "mp4")
           return newUrlArray.first?.components(separatedBy: "/").last ?? ""
        }else if self.contains("m3u8"){
            let newUrlArray:[String] = self.components(separatedBy: "m3u8")
           return newUrlArray.first?.components(separatedBy: "/").last ?? ""
        }
        return ""
    }
    //    播放时间格式化
    func playerTimerFormat() -> String {
//        转换成整形
        let d_timer = Double(self) ?? 0.0
        let seconds:Int =  Int(d_timer)
        
        let hour:String = String(format: "%02ld", seconds/3600)
        
        let minute:String = String(format: "%02ld", (seconds%3600)/60)
        
        let second:String = String(format: "%02ld", seconds % 60)
        
        var formatTimeStr:String = "00:00"
        if seconds / 3600 == 0 {
            formatTimeStr = minute + ":" + second
        }else {
            formatTimeStr = hour + ":" + minute + ":" + second
        }
        return formatTimeStr
    }
    
    /// 格式化
   static func formatSpeed(octets: UInt32) -> String {
        var speedString = ""
        if octets < 1024 {
            speedString = String(format: "%.1fdB/S",Double(octets))
        } else if octets >= 1024 && octets < 1024 * 1024 {
            speedString = String(format: "%.1fKB/S", Double(octets) / 1024.0)
        } else if octets >= 1024 * 1024 {
            speedString = String(format: "%.1fMB/S", Double(octets) / (1024.0*1024.0))
        }
        return speedString
    }
    
    static func formatFileSize(octets: UInt32) -> String {
        var sizeString = ""
        if octets < 1024 {
            sizeString = String(format: "%lludB", octets)
        } else if octets >= 1024 && octets < 1024 * 1024 {
            sizeString = String(format: "%.1fK", Double(octets) / 1024.0)
        } else if octets >= 1024 * 1024 {
            sizeString = String(format: "%.1fM", Double(octets) / (1024.0*1024.0))
        } else if octets >= 1024*1024*1024 {
            sizeString = String(format: "%.1fG", Double(octets) / (1024.0*1024.0*1024.0))
        }
        return sizeString
    }
    
    func isM3u8UrlString() -> Bool {
        let url = URL(string: self)
        return url?.pathExtension.lowercased() == "m3u8"
    }
}
