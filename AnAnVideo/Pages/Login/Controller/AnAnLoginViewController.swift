//
//  AnAnLoginViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/11.
//

import UIKit
import Toast_Swift

class AnAnLoginViewController: AnAnBaseViewController {

    private lazy var headerBgImg:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "img_login_bg")
        return imageView
    }()
    private lazy var backIconBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_login_return"),target:self,action: #selector(btnClick))
        btn.tag = 100
        return btn
    }()
    private lazy var helpIconBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_pop_login_help_44"),target:self,action: #selector(btnClick))
        btn.tag = 200
        return btn
    }()
    private lazy var loginTitle:UILabel = {
        let label = AnAnLabel.createLabel(text: "欢迎登录", fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.pingFangSemiboldWithSize(fontSize: 32))
        return label
    }()
    private lazy var descLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"使用手机号进行登录/注册",fontColor: UIColor.hexadecimalColor(hexadecimal: An_84879A), font: UIFont.pingFangRegularWithSize(fontSize: 15))
        return label
    }()
    
    private lazy var phoneInputView:AnAnLoginInputView = {
        let view = AnAnLoginInputView()
        view.placeholderName = "请输入手机号码"
        view.inputType = .InputTypePhone
        view.inputTextField.delegate = self
        return view
    }()
    private lazy var checkCodeInputView:AnAnLoginInputView = {
        let view = AnAnLoginInputView()
        view.placeholderName = "请输验证码"
        view.inputType = .InputTypeCheckCode
        view.inputTextField.delegate = self
        view.sendBtn.addTarget(self, action: #selector(sendCheckCodeClick), for: .touchUpInside)
        return view
    }()
    private lazy var loginBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"登录/注册",font:UIFont.pingFangSemiboldWithSize(fontSize: 17),fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF),target: self,action: #selector(btnClick))
        btn.isEnabled = false
        btn.tag = 300
        return btn
    }()
    private lazy var selectBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_login_checked_n"),selectImage: UIImage(named: "ic_login_checked"),target: self,action: #selector(btnClick))
        btn.tag = 400
        return btn
    }()
    private lazy var textView:UITextView = {
        let textview = UITextView()
        textview.delegate = self
        let attrString = NSMutableAttributedString(string: "我已阅读并同意《用户协议》和《隐私政策》《多多视频儿童隐私政策》")
        attrString.addAttribute(.link, value: "agreement://", range: attrString.string.nsRange(from: attrString.string.range(of: "《用户协议》")) ?? NSRange())
        attrString.addAttribute(.link, value: "privacy://", range: attrString.string.nsRange(from:attrString.string.range(of: "《隐私政策》")) ?? NSRange())
        
        attrString.addAttribute(.link, value: "yongPrivacy://", range: attrString.string.nsRange(from: attrString.string.range(of: "《多多视频儿童隐私政策》")) ?? NSRange())
        attrString.addAttribute(.font, value: UIFont.pingFangRegularWithSize(fontSize: 12), range: NSRange(location: 0, length: attrString.string.count))
        attrString.addAttribute(.foregroundColor, value: UIColor.hexadecimalColor(hexadecimal: An_222222), range: NSRange(location: 0, length: attrString.string.count))
        textview.attributedText = attrString
        textview.linkTextAttributes = [.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_1890FF)]
        textview.isEditable = false
        textview.isScrollEnabled = false
        textview.textAlignment = .left
        return  textview
    }()
    
    var gradientLayer:CAGradientLayer?
    var updateGradientColor:Bool = false
    
//    private lazy var timer:Timer = {
//        let timer = Timer(timeInterval: 1, target: self, selector: <#T##Selector#>, userInfo: <#T##Any?#>, repeats: <#T##Bool#>)
//        return timer
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        createSubviews()
        setSubviewsFrame()
        
        NotificationCenter.default.addObserver(self, selector: #selector(textfieldDidChangeClick), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func createSubviews() {
        view.addSubview(headerBgImg)
        view.addSubview(backIconBtn)
        view.addSubview(helpIconBtn)
        view.addSubview(loginTitle)
        view.addSubview(descLabel)
        view.addSubview(phoneInputView)
        view.addSubview(checkCodeInputView)
        view.addSubview(loginBtn)
        view.addSubview(selectBtn)
        view.addSubview(textView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        loginBtn.layoutIfNeeded()
        self.loginBtn.insertGradientColor(cornerRadius: 17, colors: [UIColor.hexadecimalColor(hexadecimal: An_CED6DE).cgColor,UIColor.hexadecimalColor(hexadecimal: An_B4C2CF).cgColor])
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
    }
    
    
    private func setSubviewsFrame() {
        headerBgImg.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(160 + AnAnAppDevice.navigationBarHeight())
        }
        backIconBtn.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(AnAnAppDevice.navigationBarHeight() + 13)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }
        helpIconBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-20)
            make.top.size.equalTo(backIconBtn)
        }
        loginTitle.snp.makeConstraints { make in
            make.leading.equalTo(32)
            make.top.equalTo(backIconBtn.snp.bottom).offset(45)
            make.trailing.equalTo(-32)
            make.height.equalTo(32)
        }
        descLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(loginTitle)
            make.top.equalTo(loginTitle.snp.bottom).offset(15)
            make.height.equalTo(18)
        }
        phoneInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(35)
            make.height.equalTo(49)
        }
        checkCodeInputView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(phoneInputView.snp.bottom).offset(16)
            make.height.equalTo(phoneInputView)
        }
        loginBtn.snp.makeConstraints { make in
            make.leading.equalTo(32)
            make.trailing.equalTo(-32)
            make.top.equalTo(checkCodeInputView.snp.bottom).offset(16)
            make.height.equalTo(phoneInputView)
        }
        selectBtn.snp.makeConstraints { make in
            make.leading.equalTo(loginBtn)
            make.top.equalTo(loginBtn.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 15, height: 15))
        }
        textView.snp.makeConstraints { make in
            make.leading.equalTo(selectBtn.snp.trailing).offset(8)
            make.top.equalTo(loginBtn.snp.bottom).offset(6)
            make.trailing.equalTo(-32)
            make.height.equalTo(50)
        }
    }
    
    @objc func btnClick(btn:UIButton){
        switch btn.tag {
        case 100:
            self.navigationController?.popViewController(animated: true)
            break
        case 200:
            break
        case 300:
            self.view.makeToastActivity(.center)
            AnAnRequest.shared.requestLogin(mobile: phoneInputView.inputTextField.text ?? "", countryCode: "+86", code: checkCodeInputView.inputTextField.text ?? "") {[weak self] in
//                保存用户信息
                self?.saveUserInfo()
                self?.navigationController?.popViewController(animated: true)
            }
            break
        case 400:
            self.selectBtn.isSelected = !self.selectBtn.isSelected
            break
        default:
            break
        }
    }
    
    @objc func textfieldDidChangeClick(notify:NSNotification){
        if notify.object as! UITextField == phoneInputView.inputTextField{
            if let count = phoneInputView.inputTextField.text?.count, let checkCode = checkCodeInputView.inputTextField.text?.count,count > 0 && checkCode == 6 {
                loginBtn.isEnabled = true
                updateLoginBtnGradientColor(colors: [UIColor.hexadecimalColor(hexadecimal: An_1890FF).cgColor,UIColor.hexadecimalColor(hexadecimal: An_076AFF).cgColor])
            }else{
                loginBtn.isEnabled = false
                updateLoginBtnGradientColor(colors: [UIColor.hexadecimalColor(hexadecimal: An_CED6DE).cgColor,UIColor.hexadecimalColor(hexadecimal: An_B4C2CF).cgColor])
            }
        }else{
//            超出截取
            if let count = checkCodeInputView.inputTextField.text?.count , count > 6{
                if let text = checkCodeInputView.inputTextField.text{
                    checkCodeInputView.inputTextField.text = String(text.prefix(6))
                }
            }
            if let count = phoneInputView.inputTextField.text?.count, let checkCode = checkCodeInputView.inputTextField.text?.count, count > 0 && checkCode == 6{
                loginBtn.isEnabled = true
                updateLoginBtnGradientColor(colors: [UIColor.hexadecimalColor(hexadecimal: An_1890FF).cgColor,UIColor.hexadecimalColor(hexadecimal: An_076AFF).cgColor])
                
            }else{
                loginBtn.isEnabled = false
                updateLoginBtnGradientColor(colors: [UIColor.hexadecimalColor(hexadecimal: An_CED6DE).cgColor,UIColor.hexadecimalColor(hexadecimal: An_B4C2CF).cgColor])
            }
        }
    }
}

extension AnAnLoginViewController:UITextViewDelegate{
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        switch URL.scheme {
        case "agreement":
            print("用户协议")
            return false
        case "privacy":
            print("隐私政策")
            return false
        case "yongPrivacy":
            print("儿童隐私协议")
            return false
        default:
            break
        }
        return true
    }
}

extension AnAnLoginViewController:UITextFieldDelegate{
    
}


extension AnAnLoginViewController{
    @objc func sendCheckCodeClick() {
        if checkPhoneNumber {
            self.view.makeToastActivity(.center)
            AnAnRequest.shared.getCheckCodel(mobile: phoneInputView.inputTextField.text!, countryCode: "+86")
        }
    }
    
    var checkPhoneNumber:Bool {
        if phoneInputView.inputTextField.text == nil || phoneInputView.inputTextField.text!.count < 11 {
            self.view.makeToast("请输入正确的手机号",position: .center)
            return false
        }
        return true
    }
    
    fileprivate func saveUserInfo(){
        
    }
    
//    获取当前渐变色layer,更改颜色
    fileprivate func updateLoginBtnGradientColor(colors:[CGColor]){
        if let sublayers = loginBtn.layer.sublayers {
            for layer:CALayer in sublayers {
                if let name = layer.name, name == "gradientLayer"{
                    let calayer = layer as! CAGradientLayer
                    calayer.colors = colors
                }
            }
        }
    }
}
