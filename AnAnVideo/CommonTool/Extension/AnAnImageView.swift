//
//  AnAnImageView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/2.
//

import UIKit
import Kingfisher

class AnAnImageView:UIImageView {
    static func createImageView(name:String) -> UIImageView{
        let imageView = UIImageView(image: UIImage(named: name))
        return imageView
    }
}

extension UIImageView {
    func setImageWith(url:String){
        self.layoutIfNeeded()
//        self.kf.setImage(with: URL(string: url))
        self.kf.setImage(with: URL(string: url),placeholder: UIColor.imageFromColor(color: UIColor.lightGray, viewSize: self.bounds.size))
    }
//    旋转图片
    func rotate360Degree() {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z") // 让其在z轴旋转
        rotationAnimation.toValue = NSNumber(value: .pi * 2.0) // 旋转角度
        rotationAnimation.duration = 2 // 旋转周期
        rotationAnimation.isCumulative = true // 旋转累加角度
        rotationAnimation.repeatCount = 100000 // 旋转次数
        layer.add(rotationAnimation, forKey: "rotationAnimation")
    }
//   停止旋转
    func stopRotate() {
        layer.removeAllAnimations()
    }
}

extension UIImage {
    func setCornerWithImage(cornerRadius:CGFloat) -> UIImage? {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height), cornerRadius: cornerRadius).cgPath
        UIGraphicsBeginImageContext(self.size)
        let context:CGContext? = UIGraphicsGetCurrentContext()
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        context?.addPath(path)
        context?.clip()
        self.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
