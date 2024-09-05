//
//  AnAnLoginModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/12.
//

import UIKit
import HandyJSON

class AnAnLoginModel:NSObject,HandyJSON,NSCoding {
    
    var privilegeList:[AnAnPrivilegeModel]?
    var commentUser:Bool = false
    var token:String?
    var isNeedUpdatePwd:Bool = false
    var user:AnAnUserModel?
    var vipMedal:AnAnVipMedal?
    var isNewUser:Bool = false
    
    required override init() {
        
    }
//    归档
    func encode(with coder: NSCoder) {
        coder.encode(privilegeList,forKey:"privilegeList")
        coder.encode(commentUser, forKey: "commentUser")
        coder.encode(token, forKey: "token")
        coder.encode(isNeedUpdatePwd, forKey: "isNeedUpdatePwd")
        coder.encode(user, forKey: "user")
        coder.encode(vipMedal, forKey: "vipMedal")
        coder.encode(isNewUser, forKey: "isNewUser")
    }
    
    required init?(coder: NSCoder) {
        privilegeList = coder.decodeObject(forKey: "privilegeList") as? [AnAnPrivilegeModel]
        commentUser = coder.decodeBool(forKey: "commentUser")
        token = coder.decodeObject(forKey: "token") as? String
        isNeedUpdatePwd = coder.decodeBool(forKey: "isNeedUpdatePwd")
        user = coder.decodeObject(forKey: "user") as? AnAnUserModel
        vipMedal = coder.decodeObject(forKey: "vipMedal") as? AnAnVipMedal
        isNewUser = coder.decodeBool(forKey: "isNewUser")
    }
}

class AnAnPrivilegeModel:NSObject,HandyJSON,NSCoding {
    var createTimeStr:String?
    var updateTime:String?
    var id:String?
//    override var description: String:String?
    var effectObject:String?
    var function:String?
    var endTime:String?
    var icon:String?
    var action:String?
    var createTime:String?
    
    required override init() {
    
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(createTimeStr,forKey:"createTimeStr")
        coder.encode(updateTime, forKey: "updateTime")
        coder.encode(id, forKey: "id")
//        coder.encode(description, forKey: "description")
        coder.encode(effectObject, forKey: "effectObject")
        coder.encode(function, forKey: "function")
        coder.encode(endTime, forKey: "endTime")
        coder.encode(icon, forKey: "icon")
        coder.encode(action, forKey: "action")
        coder.encode(createTime, forKey: "createTime")
    }
    
    required init?(coder: NSCoder) {
        createTimeStr = coder.decodeObject(forKey: "createTimeStr") as? String
        updateTime = coder.decodeObject(forKey: "updateTime") as? String
        id = coder.decodeObject(forKey: "id") as? String
//        description = coder.decodeObject(forKey: "description") as? String
        effectObject = coder.decodeObject(forKey: "effectObject") as? String
        function = coder.decodeObject(forKey: "function") as? String
        endTime = coder.decodeObject(forKey: "endTime") as? String
        icon = coder.decodeObject(forKey: "icon") as? String
        action = coder.decodeObject(forKey: "action") as? String
        createTime = coder.decodeObject(forKey: "createTime") as? String
    }
}

class AnAnUserModel:NSObject,HandyJSON,NSCoding{
    var nickName:String?
    var headImgUrl:String?
    var birthday:String?
    var mobile:String?
    
    required override init() {
    
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(nickName,forKey:"nickName")
        coder.encode(headImgUrl, forKey: "headImgUrl")
        coder.encode(birthday, forKey: "birthday")
        coder.encode(mobile, forKey: "mobile")
    }
    
    required init?(coder: NSCoder) {
        nickName = coder.decodeObject(forKey: "nickName") as? String
        headImgUrl = coder.decodeObject(forKey: "headImgUrl") as? String
        birthday = coder.decodeObject(forKey: "birthday") as? String
        mobile = coder.decodeObject(forKey: "mobile") as? String
    }
}

class AnAnVipMedal:NSObject,HandyJSON,NSCoding{
    var isExpired:Bool = false
    var id:String?
    var endTime:String?
    var name:String?
    var imgUrl:String?
    
    required override init() {
    
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(isExpired,forKey:"isExpired")
        coder.encode(id, forKey: "id")
        coder.encode(endTime, forKey: "endTime")
        coder.encode(name, forKey: "name")
        coder.encode(imgUrl, forKey: "imgUrl")
    }
    
    required init?(coder: NSCoder) {
        isExpired = coder.decodeBool(forKey: "isExpired")
        endTime = coder.decodeObject(forKey: "endTime") as? String
        id = coder.decodeObject(forKey: "id") as? String
        name = coder.decodeObject(forKey: "name") as? String
        imgUrl = coder.decodeObject(forKey: "imgUrl") as? String
    }
}
