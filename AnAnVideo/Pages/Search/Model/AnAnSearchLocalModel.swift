//
//  AnAnSearchLocalModel.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/26.
//

import UIKit

class AnAnSearchLocalModel: NSObject {

    var searchContent:String
    var currentTime:Double
    init( searchContent: String, currentTime: Double) {
        self.searchContent = searchContent
        self.currentTime = currentTime
    }
}
