//
//  AnAnBarrageInputView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/27.
//

import UIKit

class AnAnBarrageInputView: UIView {

    var sendBarrageBlock:((String)->Void)?
    var closeBarrageBlock:(()->Void)?
    lazy var barrageInputBgView:UIView = {
       let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#F2F4F5",alpha: 0.1)
        view.layer.cornerRadius = 18
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var barrageTextField:UITextField = {
       let text = UITextField()
        text.attributedPlaceholder = NSMutableAttributedString(string: "发条弹幕一起交流吧~", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_E5E7EB,alpha: 0.6),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 14, weight: .regular)])
        text.textColor = UIColor.hexadecimalColor(hexadecimal: An_FFFFFF)
        text.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        text.delegate = self
        return text
    }()
    
    lazy var sendBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("发送", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        btn.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_216DFF)
        btn.addTarget(self, action: #selector(sendBtnClick), for: .touchUpInside)
        return btn
    }()
    
    private lazy var tapGesture:UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.delegate = self
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#000000",alpha: 0.8)
        addGestureRecognizer(tapGesture)
        addSubview(barrageInputBgView)
        barrageInputBgView.addSubview(barrageTextField)
        barrageInputBgView.addSubview(sendBtn)
        
        barrageInputBgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(140)
            make.bottom.equalToSuperview()
            make.height.equalTo(36)
        }
        
        barrageTextField.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(36)
            make.trailing.equalToSuperview().inset(78)
        }
        
        sendBtn.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(78)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func sendBtnClick(){
        sendBarrageBlock?(barrageTextField.text ?? "")
    }
    
    @objc func tapAction(){
        closeBarrageBlock?()
        self.removeFromSuperview()
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
              
            // 使用keyboardHeight变量进行你的逻辑处理
            print("Keyboard Height: \(keyboardHeight)")
            UIView.animate(withDuration: 0.3) {
                self.barrageInputBgView.snp.updateConstraints { make in
                    make.bottom.equalToSuperview().inset(keyboardHeight+10)
                }
                self.layoutIfNeeded()
            }
        }
    }
      
    @objc func keyboardWillHide(_ notification: Notification) {
        // 这里可以处理键盘隐藏后的逻辑
        print("Keyboard will hide")
        UIView.animate(withDuration: 0.3) {
            self.barrageInputBgView.snp.updateConstraints { make in
                make.bottom.equalToSuperview()
            }
            self.layoutIfNeeded()
        }
    }
    
    func responseTextField() {
        barrageTextField.becomeFirstResponder()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension AnAnBarrageInputView:UITextFieldDelegate{
    
}

extension AnAnBarrageInputView:UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if touch.view != self {
            return false
        }
        return true
    }
}
