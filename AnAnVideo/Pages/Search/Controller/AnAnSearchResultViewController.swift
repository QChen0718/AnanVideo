//
//  AnAnSearchResultViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchResultViewController: AnAnBaseViewController {

    lazy var cancelBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_222222), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        return btn
    }()
    
    lazy var pagetitleCollection:AnAnPageTitleCollectionview = {
        let view = AnAnPageTitleCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var resultPagecontrol:UIPageViewController = {
        let control = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
    }

}


fileprivate class SearchView: UIView {
    
    lazy var searchTextField:UITextField = {
       let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "大家都在搜“扶摇”", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_CACBCC),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
        textfield.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        textfield.font = .systemFont(ofSize: 15, weight: .regular)
        return textfield
    }()
    
    lazy var closeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 24
        
        addSubview(searchTextField)

        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(12)
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
