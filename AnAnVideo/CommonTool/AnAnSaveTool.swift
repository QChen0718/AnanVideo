//
//  AnAnSaveTool.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/16.
//

import UIKit

class AnAnSaveTool {
    //    存储
   class func setNormalDefault(key:String, value:Any?) {
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        }else{
            UserDefaults.standard.set(value, forKey: key)
            UserDefaults.standard.synchronize()
        }
    }
    
    //通过对应的key移除存储
    class func removeNormalUserDefault(key: String?) {
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
    //通过key找到储存的value
    class func getNormalDefult(key:String) -> AnyObject? {
        return UserDefaults.standard.value(forKey: key) as AnyObject?
    }
}
