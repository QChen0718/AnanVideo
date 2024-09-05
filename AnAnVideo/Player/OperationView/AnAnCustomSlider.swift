//
//  AnAnCustomSlider.swift
//  RuanVideo
//
//  Created by 陈庆 on 2023/3/24.
//

import UIKit

class AnAnCustomSlider: UISlider {

    var sliderHeight:CGFloat = 2.5
    
    override func minimumValueImageRect(forBounds bounds: CGRect) -> CGRect {
        return self.bounds
    }

    override func maximumValueImageRect(forBounds bounds: CGRect) -> CGRect {
        return self.bounds
    }
//    修改slider的宽高
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.trackRect(forBounds: bounds)
        layer.cornerRadius = 0
        return CGRect.init(x: rect.origin.x, y: (bounds.size.height-sliderHeight)/2, width: bounds.size.width, height: sliderHeight)
    }
//    修改滑块触摸范围
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
      var bounds: CGRect = self.bounds
      bounds = CGRectInset(bounds, -10, -15)
      return CGRectContainsPoint(bounds, point)
  }


}
