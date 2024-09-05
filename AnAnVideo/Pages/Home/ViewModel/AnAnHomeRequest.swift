//
//  AnAnHomeRequest.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/16.
//

import UIKit

class AnAnHomeRequest: NSObject {
    static var position:String?
    class public func requestRecommendData(success:@escaping (AnAnHomeModel?)->Void){
        AnAnRequest.shared.requestHomeRecommendData(position: position ?? "") { model in
            success(model)
        }
    }
}
