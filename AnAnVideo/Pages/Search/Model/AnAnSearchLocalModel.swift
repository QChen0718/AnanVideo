//
//  AnAnSearchLocalModel.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/26.
//

import UIKit

class AnAnSearchLocalModel: NSObject {
    var searchId:String
    var searchContent:String
    var currentTime:Double
    init(searchId: String, searchContent: String, currentTime: Double) {
        self.searchId = searchId
        self.searchContent = searchContent
        self.currentTime = currentTime
    }
}
