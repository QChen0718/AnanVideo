//
//  AnAnCustomProgress.swift
//  RuanVideo
//
//  Created by 陈庆 on 2023/4/11.
//

import UIKit

class AnAnCustomProgress: UIView {

    private var isOne:Bool = true
    
    private lazy var maskLayer:CALayer = {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 0, height: 3)
        layer.backgroundColor = UIColor.white.cgColor
        return layer
    }()
    
    private lazy var progressView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_46464A)
        return view
    }()
    
    private var currentColors:[CGColor] = []
    
    private var initProgress:CGFloat?
    
    private var locations:[NSNumber] = []
    
    private var startPoint:CGPoint = CGPoint(x: 0, y: 1)
    
    private var endPoint:CGPoint = CGPoint(x: 1, y: 1)
    
    init(colors:[CGColor],progress:CGFloat?,locations:[NSNumber],startPoint:CGPoint,endPoint:CGPoint) {
        super.init(frame: .zero)
        backgroundColor = .clear
        initProgress = progress
        currentColors = colors
        self.startPoint = startPoint
        self.endPoint = endPoint
        self.locations = locations
        createSubviews()
        setSubviewsFrame()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if isOne {
            progressView.layoutIfNeeded()
            progressView.addGradientColor(colors: currentColors, locations: self.locations,startPoint: startPoint,endPoint: endPoint)
            layerAddMask()
            isOne = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layerAddMask(){
        if let sublayers = progressView.layer.sublayers {
            for layer:CALayer in sublayers {
                if let name = layer.name, name == "addgradientLayer"{
                    let calayer = layer as! CAGradientLayer
                    if let progress = initProgress{
                        maskLayer.frame = CGRect(x: 0, y: 0, width: progress * progressView.frame.width, height: 3)
                        calayer.mask = maskLayer
                    }
                }
            }
        }
    }
    private func createSubviews() {
        addSubview(progressView)
    }
    
    private func setSubviewsFrame() {
        progressView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    var updateMaskLayerWidth:CGFloat = 0.0{
        didSet{
            var rect = maskLayer.bounds
            rect.size.width = updateMaskLayerWidth*self.frame.width
            maskLayer.frame = rect
        }
    }
    
    var updateColors:[CGColor]?{
        didSet{
            if let sublayers = progressView.layer.sublayers {
                for layer:CALayer in sublayers {
                    if let name = layer.name, name == "addgradientLayer"{
                        let calayer = layer as! CAGradientLayer
                        calayer.colors = updateColors
                    }
                }
            }
        }
    }
}
