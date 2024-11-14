//
//  AnAnRequest.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/5.
//

import UIKit
import Moya
import SwiftyJSON
import HandyJSON

class AnAnRequest{
    static let shared = AnAnRequest()
    var provider:MoyaProvider<AnAnRequestApi>
    
    private init() {
        var plugins:[PluginType] = []
        let networkActivityPlugin = NetworkActivityPlugin { change, target in
            if change == .began{
//                开始请求
//                AnAnJumpPageManager.shared.currentVC?.view.makeToastActivity(.center)
            }else {
//                结束请求
//                AnAnJumpPageManager.shared.currentVC?.view?.hideToastActivity()
            }
        }
        plugins.append(networkActivityPlugin)
        provider = MoyaProvider<AnAnRequestApi>(plugins:plugins)
    }
//    获取验证码
    func getCheckCodel(mobile:String,countryCode:String) {
        provider.requestData(.getCheckCode(mobile: mobile, countryCode: countryCode)) { response in
            let jsonString = String(data: response.data, encoding: .utf8)
    //        将字符串转换成model
            guard let model = JSONDeserializer<AnAnBaseModel<Any>>.deserializeFrom(json: jsonString) else {
                return
            }
            print("解析-->\(model)")
            if let code = model.code, code != "0000"{
                AnAnJumpPageManager.shared.currentVC?.view?.makeToast(model.msg ?? "",position: .center)
            }
            AnAnJumpPageManager.shared.currentVC?.view.hideToastActivity()
        }
        
    }
//    请求登录
    func requestLogin(mobile:String,countryCode:String,code:String, successBlock:@escaping ()->()) {
        provider.requestModel(.checkCodelLogin(mobile: mobile, captchaSms: code, countryCode: countryCode), model: AnAnLoginModel.self) { returnData, msg in
            
//            print("nikename--->\(returnData?.user?.nickName)")
//            保存用户信息
            AnAnUserData.saveUserData(user: returnData ?? AnAnLoginModel())
            successBlock()
            AnAnJumpPageManager.shared.currentVC?.view.hideToastActivity()
            AnAnJumpPageManager.shared.currentVC?.view?.makeToast("登录成功",position: .center)
        }failure: { error in
            AnAnJumpPageManager.shared.currentVC?.view.hideToastActivity()
        }
    }
    
    func requestPersonalCenterData(token:String,otherUser:String) {

    }
//    获取首页数据
    func requestHomeRecommendData(position:String,success:@escaping (AnAnHomeModel?)->Void){
        provider.requestModel(.home(position:position), model: AnAnHomeModel.self) { returnData, msg in
            success(returnData)
        }
    }
    
//    获取详情页数据
    func requestDramaDetailData(dramaId:String,episodeSid:String,quality:String,isRecByUser:Int,subtitle:Int,success:@escaping (AnAnDetailModel?)->Void) {
        provider.requestModel(.dramaDetail(dramaId: dramaId, episodeSid: episodeSid, quality: quality, isRecByUser: isRecByUser, subtitle: subtitle), model: AnAnDetailModel.self) { returnData, msg in
            success(returnData)
        }
    }
    
//    获取视频详情作者信息数据
    func requestDramaDetailIntroData(dramaId:String,success:@escaping (DramaIntroModel?)->Void) {
        provider.requestModel(.dramaDetailIntro(dramaId: dramaId), model: DramaIntroModel.self) { returnData, msg in
            success(returnData)
        }failure: { error in
            
        }
    }

    func requestDramaDetailModule(dramaId:String,success:@escaping(DramaModuleModel?)->Void) {
        
        provider.requestModel(.dramaDetailModule(dramaId: dramaId), model: DramaModuleModel.self) { returnData, msg in
            success(returnData)
        }failure: { error in
            
        }
    }
    func requestMarkEntranceInDetailData() {
        provider.requestData(.markEntranceInDetail) { response in

        }failure: { error in
            
        }
    }
    func requestDramaDetailSecondaryData(dramaId:String,success:@escaping (SeconDarayModel?)->Void) {
        provider.requestModel(.dramaDetailSecondary(dramaId: dramaId), model: SeconDarayModel.self) { returnData, msg in
            success(returnData)
        }
    }
    func requestDramaRecommendData(dramaId:String,isRecByUser:Int,success:@escaping (RecommendListModel?)->Void) {
        provider.requestModel(.dramaDetailRecommend(dramaId: dramaId, isRecByUser: isRecByUser), model: RecommendListModel.self) { returnData, msg in
            success(returnData)
        }failure: { error in
            
        }
    }
//    获取视频下载地址信息
    func requestVideoDownloadInfoData(seasonId:String,episodeSid:String,quality:String,success:@escaping (AnAnDownloadInfoModel?)->Void) {
        provider.requestModel(.getDownloadInfo(seasonId: seasonId, episodeSid: episodeSid, quality: quality), model: AnAnDownloadInfoModel.self) { returnData, msg in
            success(returnData)
        }failure: { error in
            
        }
    }
    
//    获取分类筛选项
    func requestCatoryFilterTagData(success:@escaping ([AnAnFilterModel?])->Void) {
        
        provider.requestDataListModel(.typeFilter, model: AnAnFilterModel.self) { returnData, msg in
            success(returnData)
        }failure: { error in
            
        }
    }
//    获取分类数据
    func requestCategoryListData(keys:[String:Any],page:String,rows:String,success:@escaping ([AnAnCategoryDataModel?])->Void) {
        provider.requestDataListModel(.typeCats(keys: keys, page: page, rows: rows), model: AnAnCategoryDataModel.self) { returnData, msg in
            success(returnData)
        }failure: { error in
            
        }
    }
    
//    获取CDN弹幕数据
    func requestCDNBarrageData(episodeId:String,success:@escaping ([AnAnBarrageDataModel?])->Void) {
        provider.requestListModel(.cdnBarrage(episodeId: episodeId), model: AnAnBarrageDataModel.self) { returnData, msg in
            success(returnData)
        }
    }
//    获取实时弹幕数据
    func requestNewBarrageData(param:[String:Any],success:@escaping (AnAnBarrageDataModel?)->Void) {
        provider.requestModel(.newBarrage(params: param), model: AnAnBarrageDataModel.self) { returnData, msg in
            success(returnData)
        }
    }
//    获取搜索top列表
    func requestSearchTopListData(page:Int,rows:Int,success:@escaping((AnAnSearchModel?)->Void)) {
        provider.requestModel(.relatedTopList(page: "\(page)", rows: "\(rows)"), model: AnAnSearchModel.self) { returnData, msg in
            success(returnData)
        }
    }
//    获取热门推荐列表
    func requestHotRecommendListData(success:@escaping ([AnAnHotModel?])->Void) {
        provider.requestDataListModel(.recommendHotList, model: AnAnHotModel.self) { returnData, msg in
            success(returnData)
        }
    }
//    获取搜索联想数据
    func requestSearchLinkListData(keyword:String,success:@escaping (AnAnSearchLinkModel?)->Void) {
        provider.requestModel(.searchLink(keywords: keyword), model: AnAnSearchLinkModel.self) { returnData, msg in
            success(returnData)
        }
    }
}
