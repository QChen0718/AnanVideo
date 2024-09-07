//
//  AnAnCategoryViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit

class AnAnCategoryViewController: AnAnBaseViewController {

    private lazy var ananSearchView:AnAnSearch = {
        let view = AnAnSearch()
        return view
    }()
    private lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    private lazy var categoryCollectionView:AnAnCategoryCollectionView = {
        let collectionView = AnAnCategoryCollectionView(frame: .zero,collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.addSubview(ananSearchView)
        self.view.addSubview(categoryCollectionView)
        ananSearchView.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.top.equalTo(AnAnAppDevice.deviceTop())
            make.height.equalTo(40)
        }
        categoryCollectionView.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.top.equalTo(ananSearchView.snp.bottom).offset(4)
        }
        
        loadData()
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ananSearchView.layoutIfNeeded()
        ananSearchView.insertGradientColor(cornerRadius: 20, colors: [UIColor.hexadecimalColor(hexadecimal: An_C1ECFA).cgColor,UIColor.hexadecimalColor(hexadecimal: An_DADCFF).cgColor])
    }
    
    func loadData() {
        AnAnRequest.shared.requestCatoryFilterTagData {[weak self] listModel in
            guard let `self` else {return}
            var filterDatas:[AnAnFilterModel?] = listModel
            filterDatas.append(AnAnFilterModel(filterType: CellType.CellTypeCategoryItem.rawValue))
            categoryCollectionView.tagsArray = filterDatas
            loadCategoryListData()
        }
    }
    
    private func loadCategoryListData() {
        var paramsDict:[String:Any] = [:]
        categoryCollectionView.tagsArray?.forEach({ model in
            guard let key = model?.filterType else {return}
            paramsDict[key] = model?.dramaFilterItemList?.first?.value
            
        })
        AnAnRequest.shared.requestCategoryListData(keys: paramsDict, page: String(format: "%d", 1), rows: String(format: "%d", 20)) {[weak self] listModel in
            guard let `self` else {return}
            self.categoryCollectionView.categoryDataArray = listModel
        }
    }
}

