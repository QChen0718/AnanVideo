//
//  AnAnSearchViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/8.
//

import UIKit

class AnAnSearchViewController: AnAnBaseViewController {

   fileprivate lazy var searchView:SearchView = {
       let view = SearchView()
        return view
    }()
    
    lazy var searchCollectionView:AnAnSearchCollectionview = {
        let view = AnAnSearchCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrowBackBtn.setImage(UIImage(named: "ic_video_navbar_back_gray_60"), for: .normal)
        self.view.addSubview(searchView)
        searchView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(21)
            make.height.equalTo(48)
            make.top.equalTo(160)
        }
        view.addSubview(searchCollectionView)
        searchCollectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(16)
        }
        
        searchCollectionView.loadSearchTopData()
    }

}

fileprivate class SearchView: UIView {
    
    lazy var searchIcon:UIImageView = {
       let img = UIImageView(image: UIImage(named: ""))
        return img
    }()
    
    lazy var searchTextField:UITextField = {
       let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "大家都在搜“扶摇”", attributes: [NSAttributedString.Key.foregroundColor:UIColor.hexadecimalColor(hexadecimal: An_CACBCC),NSAttributedString.Key.font:UIFont.systemFont(ofSize: 15, weight: .regular)])
        textfield.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        textfield.font = .systemFont(ofSize: 15, weight: .regular)
        return textfield
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.layer.cornerRadius = 24
        addSubview(searchIcon)
        addSubview(searchTextField)
        searchIcon.snp.makeConstraints { make in
            make.leading.equalTo(18)
            make.centerY.equalTo(self)
            make.size.equalTo(15)
        }
        searchTextField.snp.makeConstraints { make in
            make.leading.equalTo(searchIcon.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(18)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layoutIfNeeded()
        self.layer.shadowColor = UIColor.hexadecimalColor(hexadecimal: An_000000, alpha: 0.08).cgColor
        self.layer.shadowOffset = CGSizeMake(0,5)
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 15
    }
}
