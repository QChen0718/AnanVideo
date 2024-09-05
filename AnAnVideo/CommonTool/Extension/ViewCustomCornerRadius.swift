//
//  ViewCustomCornerRadius.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/28.
//

import UIKit
extension UIView {
    
//    设置顶部圆角
    func setConerTop(radius:CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
//    设置底部圆角
    func setConerBottom(radius:CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.bottomLeft,.bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
//    设置任意圆角
    func setCorner(corner:UIRectCorner,radius:CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corner, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
//    设置渐变色
    func insertGradientColor(cornerRadius:CGFloat,colors:[CGColor],startPoint:CGPoint = CGPoint(x: 0, y: 0.5),endPoint:CGPoint = CGPoint(x: 1, y: 0.5)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.name = "gradientLayer"
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    func addGradientColor(colors:[CGColor],locations:[NSNumber],startPoint:CGPoint = CGPoint(x: 0, y: 0.5),endPoint:CGPoint = CGPoint(x: 1, y: 0.5)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.name = "addgradientLayer"
        gradientLayer.colors = colors
        gradientLayer.locations = locations
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    ///生成渐变颜色图片
    func getGradientImage(size:CGSize,colors:[CGColor],startPoint:CGPoint = CGPoint(x: 0, y: 0.5),endPoint:CGPoint = CGPoint(x: 1, y: 0.5)) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else{return UIImage()}
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        ///设置渐变颜色
        let gradientRef = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: nil)!
        let startPoint = startPoint
        let endPoint = endPoint
        
        context.drawLinearGradient(gradientRef, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(arrayLiteral: .drawsBeforeStartLocation,.drawsAfterEndLocation))
        let gradientImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return gradientImage ?? UIImage()
    }
}
