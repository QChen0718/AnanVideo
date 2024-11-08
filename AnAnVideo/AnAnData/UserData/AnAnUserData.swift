//
//  AnAnUserData.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/16.
//

import UIKit



class AnAnUserData {
   class func saveUserData(user:AnAnLoginModel) {
//        对象转换为Data
        let moData:Data = NSKeyedArchiver.archivedData(withRootObject: user)
        AnAnSaveTool.setNormalDefault(key: "userInfo", value: moData)
   }
    
   class func readUserData() -> AnAnLoginModel?{
//        读取用户信息
        let myuserData = AnAnSaveTool.getNormalDefult(key: "userInfo") as? Data
//        解档
        let model:AnAnLoginModel? = NSKeyedUnarchiver.unarchiveObject(with: myuserData ?? Data()) as? AnAnLoginModel
        return model
   }

//   移除本地用户信息，退出登录
    class func removeUserData(){
        AnAnSaveTool.removeNormalUserDefault(key: "userInfo")
    }
    
    class var isLogin:Bool{
        if let model = readUserData(){
            if model.token != nil || model.token != "" {
                return true
            }
        }
        return false
    }
    
    class var isVip:Bool {
        return true
    }
}
