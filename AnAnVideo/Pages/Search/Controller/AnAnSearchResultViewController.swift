//
//  AnAnSearchResultViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/14.
//

import UIKit

class AnAnSearchResultViewController: AnAnBaseViewController {

    fileprivate lazy var searchView:SearchView = {
      let view = SearchView()
        return view
    }()
    
    var searchKey:String?{
        didSet{
            searchView.searchTextField.text = searchKey
            loadSearchResultListData(keyword: searchKey ?? "")
        }
    }
    
    lazy var cancelBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("取消", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_222222), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.addTarget(self, action: #selector(cancelBtnClick), for: .touchUpInside)
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
    
    lazy var resultCollection:AnAnSearchResultCollectionView = {
        let view = AnAnSearchResultCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(searchView)
        view.addSubview(cancelBtn)
        view.addSubview(pagetitleCollection)
        view.addSubview(resultPagecontrol.view)
        view.addSubview(resultCollection)
        searchView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(cancelBtn.snp.leading).offset(-20)
            make.top.equalTo(AnAnAppDevice.deviceTop()+6)
            make.height.equalTo(36)
        }
        cancelBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.centerY.equalTo(searchView)
            make.size.equalTo(CGSize(width: 40, height: 21))
        }
        pagetitleCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchView.snp.bottom).offset(6)
            make.height.equalTo(40)
        }
        resultCollection.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(pagetitleCollection.snp.bottom).offset(10)
        }
    }

    @objc func cancelBtnClick(){
        self.navigationController?.popViewController(animated: true)
    }
}


extension AnAnSearchResultViewController{
    func loadSearchResultListData(keyword:String) {
        let params:[String:Any] = ["keywords":keyword,"size":"20","search_after":"1","order":""]
        AnAnRequest.shared.requestSearchResultListData(params: params) { searchModel in
            
        }
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
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_00A3FF,alpha: 0.1)
        self.layer.cornerRadius = 18
        
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

    @objc func closeBtnClick(){
        
    }
}
