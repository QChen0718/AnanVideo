//
//  AnAnRequestApi.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/4.
//

import Foundation
import Moya
import HandyJSON
import SwiftyJSON
import UTDID

public typealias Success = (_ response: Moya.Response) -> Void
public typealias Failure = (_ error: Moya.MoyaError) -> Void



enum AnAnRequestApi {
//    首页
    case home(position:String)
//    验证码登录
    case checkCodelLogin(mobile:String,captchaSms:String,countryCode:String)
//    获取验证码
    case getCheckCode(mobile:String,countryCode:String)
//    退出登录
    case loginOut(token:String)
//    剧集详情
    case dramaDetail(dramaId:String,episodeSid:String,quality:String,isRecByUser:Int,subtitle:Int)
    case dramaDetailSecondary(dramaId:String)
    case dramaDetailIntro(dramaId:String)
    case dramaDetailModule(dramaId:String)
    case dramaDetailRecommend(dramaId:String,isRecByUser:Int)
    case markEntranceInDetail
    case moviePlayerInfo(seasonId:String, dramaId:String, episodeSid:String, quality:String)
//    猜你喜欢
    case guessLike
//    分类
    case category
//    搜索
    case search
//    类型筛选
    case typeFilter
//    分类筛选数据
    case typeCats(keys:[String:Any],page:String,rows:String)
    case dramaFocus
//    获取用户信息
    case getUserInfo(token:String,otherUser:String)
//    获取下载信息
    case getDownloadInfo(seasonId:String,episodeSid:String,quality:String)
//    短视频列表
    case shortVideoList
}

extension AnAnRequestApi:TargetType{
//    请求baseURL
    var baseURL: URL {
        return AnAnRequestApi.getBaseUrl()
    }
//    请求路径
//    https://api.rr.tv/auth/verification-code/sms
    var path: String {
        switch self{
        case .home:
            return "/v3plus/index/channel"
        case .checkCodelLogin:
            return "/auth/login/mobile"
        case .getCheckCode:
            return "/auth/verification-code/sms"
        case .loginOut:
            return "/auth/logout"
        case .dramaDetail:
            return "/drama/detail"
        case .dramaDetailSecondary:
            return "/drama/detail/secondary"
        case .dramaDetailIntro:
            return "/drama/detail/intro"
        case .guessLike:
            return "/drama/app/guess_user_like"
        case .category:
            return "/channel/page/category"
        case .search:
            return "/search/v5/season"
        case .typeFilter:
            return "/drama/app/get_drama_filter"
        case .typeCats:
            return "/drama/app/drama_filter_search"
        case .dramaFocus:
            return "/behavior/v4/focus/season"
        case .getUserInfo:
            return "/user/personal/information"
        case .moviePlayerInfo:
            return "/drama/detail/play/info"
        case .dramaDetailModule:
            return "/drama/detail/module"
        case .markEntranceInDetail:
            return "/mark/entrance-in-detail"
        case .dramaDetailRecommend:
            return "/drama/detail/recommend"
        case .getDownloadInfo:
            return "/watch/v4/get_movie_download_info"
        case .shortVideoList:
            return "/video/dramaList"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .home,.getCheckCode,.dramaDetail,.dramaDetailSecondary,.dramaDetailIntro,.guessLike,.category,.search,.typeFilter,.getUserInfo,.moviePlayerInfo,.dramaDetailModule,.markEntranceInDetail,.dramaDetailRecommend,.getDownloadInfo,.shortVideoList:
            return .get
        case .checkCodelLogin,.loginOut,.typeCats,.dramaFocus:
            return .post
        }
    }
    
//    设置请求参数
    
    var params:[String: Any]{
        var parmeters: [String : Any] = [:]
        switch self{
        case .home(let position):
            parmeters["position"] = position
            break
        case .checkCodelLogin(let mobile,let captchaSms,let countryCode):
            parmeters["mobile"] = mobile
            parmeters["captchaSms"] = captchaSms
            parmeters["countryCode"] = countryCode
            break
        case .getCheckCode(let mobile,let countryCode):
            parmeters["mobile"] = mobile
            parmeters["countryCode"] = countryCode
            break
        case .loginOut(let token):
            parmeters["token"] = token
            break
        case .dramaDetail(let dramaId,let episodeSid,let quality,let isRecByUser,let subtitle):
            parmeters["dramaId"] = dramaId
            parmeters["episodeSid"] = episodeSid
            parmeters["quality"] = quality
            parmeters["isRecByUser"] = isRecByUser
            parmeters["subtitle"] = subtitle
            parmeters["hsdrOpen"] = "1"
            break
        case .getUserInfo(let token,let otherUser):
            parmeters["token"] = token
            parmeters["otherUser"] = otherUser
            break
        case .moviePlayerInfo(let seasonId,let dramaId,let episodeSid,let quality):
            parmeters["seasonId"] = seasonId
            parmeters["dramaId"] = dramaId
            parmeters["episodeSid"] = episodeSid;
            parmeters["quality"] = quality;
            parmeters["subtitle"] = "0";
            parmeters["hsdrOpen"] = "1";
            break
        case .dramaDetailIntro(let dramaId):
            parmeters["dramaId"] = dramaId
            break
        case .dramaDetailModule(let dramaId):
            parmeters["dramaId"] = dramaId
            break
        case .dramaDetailSecondary(let dramaId):
            parmeters["dramaId"] = dramaId
            break
        case .dramaDetailRecommend(let dramaId,let isRecByUser):
            parmeters["dramaId"] = dramaId
            parmeters["isRecByUser"] = isRecByUser
            break
        case .getDownloadInfo(let seasonId,let episodeSid,let quality):
            parmeters["seasonId"] = seasonId
            parmeters["episodeSid"] = episodeSid
            parmeters["quality"] = quality
            parmeters["hsdrOpen"] = "1"
            break
        case .shortVideoList:
            parmeters["closeRecommend"] = "1"
            break
        case .typeCats(let keys, let page, let rows):
            parmeters = keys
            parmeters["page"] = page
            parmeters["rows"] = rows
            break
        default:
            break
        }
        parmeters["isAgeLimit"] = NSNumber(value: 0)
        return parmeters
    }
    
    var task: Moya.Task {
        let encoding: ParameterEncoding
        switch self.method {
            case .post:
            switch self {
                case .typeCats:
                    encoding = JSONEncoding.default
                    break
                default:
                    encoding = URLEncoding.default
                    break
                }
            default:
                encoding = URLEncoding.default
        }
        return .requestParameters(parameters: params, encoding: encoding)
    }
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    var headers: [String : String]? {
        var paramsStr:String = ""
        for  key in params.keys.sorted(by: {$0 < $1}){
            paramsStr += key +  String(format: "%@", params[key] as? CVarArg ?? "")
        }
        let timestamp = Int(Date().timeIntervalSince1970) * 1000
        let t = String(format: "%ld", timestamp)
        let sign = String(format: "%@t%@%@%@", path,t,paramsStr,AnAnAppDevice.AnAnServiceHeaderSignKey)
//        md5加密后转小写，不然接口解析后会拒绝请求
        let md5Sign = sign.addMD5()
        
        return ["clientVersion":AnAnAppDevice.AnAnAppVersion,
                "clientType":AnAnAppDevice.AnAnAppClientType,
                "p":"iOS",
                "token":AnAnUserData.readUserData()?.token ?? "",
                "userId":"",
                "deviceId":"",
                "deviceMode":"",
                "st":"",
                "t" : t,
                "sign":md5Sign,
                "aliId":UTDevice.utdid()
        ]
    }
    
    static func getBaseUrl() -> URL{
        return URL(string: AnAnAppDevice.AnAnDefaultHttpScheme + AnAnAppDevice.AnAnServiceUrlFragment + AnAnAppDevice.AnAnServiceDomainName)!
    }
}

// 扩展Response 请求结果模型解析
extension Response {
    func mapModel<T:HandyJSON>(_ type:T.Type) throws -> T {
//        data utf8编码成字符串
        let jsonString = String(data: data, encoding: .utf8)
//        将字符串转换成model
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else { throw MoyaError.jsonMapping(self) }
        return model
    }
}


//统一请求封装,对MoyaProvider进行扩展
extension MoyaProvider {
    //当有返回值的方法未得到接收和使用会有警告 ， @discardableResult 消除警告
    @discardableResult
    public func requestModel<T:HandyJSON>(_ target:Target,callbackQueue:DispatchQueue? = DispatchQueue.main,
                                          model:T.Type?,success:((_ returnData:T?,_ msg:String?) -> Void)?,failure:Failure? = nil) -> Cancellable? {
        return self.requestData(target,callbackQueue: callbackQueue,success:{ (response) in
            guard let success = success else { return }
            do {
                let modelData:AnAnBaseModel = try response.mapModel(AnAnBaseModel<T>.self)
                success(modelData.data,modelData.msg)
            } catch (let error) {
                failure?(error as! MoyaError)
            }
        }){(error) in
            guard let failure = failure else { return }
            failure(error)
        }
    }
//    返回数组
    @discardableResult
    public func requestListModel<T:HandyJSON>(_ target:Target,callbackQueue:DispatchQueue? = DispatchQueue.main,
                                          model:T.Type?,success:((_ returnData:[T?],_ msg:String?) -> Void)?,failure:Failure? = nil) -> Cancellable? {
        return self.requestData(target,callbackQueue: callbackQueue,success:{ (response) in
            guard let success = success else { return }
            do {
                let modelData:AnAnBaseModel = try response.mapModel(AnAnBaseModel<[T]>.self)
                success(modelData.data ?? [],modelData.msg)
            } catch (let error) {
                failure?(error as! MoyaError)
            }
        }){(error) in
            guard let failure = failure else { return }
            failure(error)
        }
    }
    
    @discardableResult
    public func requestData(_ target:Target,callbackQueue:DispatchQueue? = DispatchQueue.main,success: Success? = nil,failure: Failure? = nil) -> Cancellable?{
    
        return request(target,callbackQueue: callbackQueue,progress:.none) { result in
            switch result {
            case let .success(response):
                let json = JSON(response.data)
                print("\(target.path) 接口返回结果-->\(json)")
                success?(response)
                break
            case let .failure(error):
                failure?(error)
                break
            }
            
        }
    }
}
