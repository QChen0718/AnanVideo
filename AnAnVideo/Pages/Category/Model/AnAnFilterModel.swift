//
//  AnAnFilterModel.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/3.
//

import UIKit
import HandyJSON

struct AnAnFilterModel: HandyJSON {
    var filterType:String?
    var dramaFilterItemList:[AnAnFilterItemModel]?
}

struct AnAnFilterItemModel:HandyJSON {
    var displayName:String?
    var value:String?
}
