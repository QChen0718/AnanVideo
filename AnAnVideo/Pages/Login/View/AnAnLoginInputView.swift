//
//  AnAnLoginInputView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/11.
//

import UIKit

enum InputType {
    case InputTypePhone //手机输入框
    case InputTypeCheckCode // 验证码
}
class AnAnLoginInputView: UIView {

    var btnBlock:((UIButton)->Void)?
    
    var placeholderName:String?{
        didSet{
            inputTextField.placeholder = placeholderName
            inputTextField.attributedPlaceholder = placeHolderTextSetting(str: placeholderName)
        }
    }
    var inputType:InputType?{
        didSet{
            switch inputType {
            case .InputTypePhone:
                areaCodeBtn.isHidden = false
                lineView.isHidden = false
                sendBtn.isHidden = true
                inputBgView.snp.remakeConstraints { make in
                    make.leading.equalTo(32)
                    make.trailing.equalTo(-32)
                    make.top.bottom.equalToSuperview()
                }
                inputTextField.snp.remakeConstraints{ make in
                    make.leading.equalTo(lineView.snp.trailing).offset(8)
                    make.centerY.equalToSuperview()
                    make.trailing.equalTo(closeBtn.snp.leading).offset(-10)
                    make.height.equalToSuperview()
                }
                break
            case .InputTypeCheckCode:
                areaCodeBtn.isHidden = true
                lineView.isHidden = true
                sendBtn.isHidden = false
                inputBgView.snp.remakeConstraints { make in
                    make.leading.equalTo(32)
                    make.trailing.equalTo(sendBtn.snp.leading).offset(-12)
                    make.top.bottom.equalToSuperview()
                }
                inputTextField.snp.remakeConstraints{ make in
                    make.leading.equalTo(20)
                    make.centerY.equalToSuperview()
                    make.trailing.equalTo(closeBtn.snp.leading).offset(-10)
                    make.height.equalToSuperview()
                }
                break
            default:
                break
            }
        }
    }
    private lazy var inputBgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_F2F4F8)
        view.layer.cornerRadius = 17
        return view
    }()
    private lazy var areaCodeBtn:UIButton = {
        let btn = AnAnButton.createButton(title: "+86", font: UIFont.pingFangRegularWithSize(fontSize: 17), fontColor: .black, target: self, action: #selector(btnClick))
        btn.tag = 100
        return btn
    }()
    private lazy var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_E6E7E8)
        return view
    }()
    lazy var inputTextField:UITextField = {
        let textField = UITextField()
        textField.textColor = UIColor.hexadecimalColor(hexadecimal: An_333333)
        textField.font = UIFont.pingFangSemiboldWithSize(fontSize: 17)
        return textField
    }()
    private lazy var closeBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_videoplayer_ad_close"),target: self, action: #selector(btnClick))
        btn.tag = 200
        return btn
    }()
    lazy var sendBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"发送验证码",font: UIFont.pingFangRegularWithSize(fontSize: 12),fontColor: UIColor.white,bgColor: UIColor.hexadecimalColor(hexadecimal: An_1890FF),target: self, action: #selector(btnClick))
        btn.tag = 300
        btn.layer.cornerRadius = 14
        return btn
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func createSubviews() {
        self.addSubview(inputBgView)
        self.addSubview(sendBtn)
        inputBgView.addSubview(areaCodeBtn)
        inputBgView.addSubview(lineView)
        inputBgView.addSubview(inputTextField)
        inputBgView.addSubview(closeBtn)
    }
    
    private func setSubviewsFrame() {
        inputBgView.snp.makeConstraints { make in
            make.leading.equalTo(32)
            make.trailing.equalTo(-32)
            make.top.bottom.equalToSuperview()
        }
        
        areaCodeBtn.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 31, height: 17))
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(areaCodeBtn.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 1, height: 17))
        }
        
        inputTextField.snp.makeConstraints { make in
            make.leading.equalTo(lineView.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(closeBtn.snp.leading).offset(-10)
            make.height.equalToSuperview()
        }
        
        closeBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-30)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        
        sendBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-32)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(84)
        }
    }
    
    @objc func btnClick(btn:UIButton){
       btnBlock?(btn)
    }
    func placeHolderTextSetting(str:String?) -> NSAttributedString {
        let attributedStr = NSAttributedString(string: str ?? "",attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_CACBCC),NSAttributedString.Key.font:UIFont.pingFangRegularWithSize(fontSize: 14)])
        return attributedStr
    }
}
