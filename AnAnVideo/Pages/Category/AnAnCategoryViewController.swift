//
//  AnAnCategoryViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit
import MJRefresh

class AnAnCategoryViewController: AnAnBaseViewController {
    private var page:Int = 1
    var categoryDataArray:[AnAnCategoryDataModel?] = []
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
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock:{[weak self] in
            guard let `self` else { return }
            page += 1
            self.loadCategoryListData()
        })
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
        NotificationCenter.default.addObserver(self, selector: #selector(updateCategoryListData), name: Notification.Name(rawValue: "notification.updateCategoryListData"), object: nil)
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
            for i in 0..<listModel.count{
                listModel[i]?.dramaFilterItemList?[0].isSelect = true
            }
            var filterDatas:[AnAnFilterModel?] = listModel
            filterDatas.append(AnAnFilterModel(filterType: CellType.CellTypeCategoryItem.rawValue))
            
            categoryCollectionView.tagsArray = filterDatas
            loadCategoryListData()
        }
    }
    @objc func updateCategoryListData(){
        page = 1
        categoryDataArray = []
        loadCategoryListData()
    }
    private func loadCategoryListData() {
        var paramsDict:[String:Any] = [:]
        categoryCollectionView.tagsArray?.forEach({ model in
            guard let key = model?.filterType else {return}
            model?.dramaFilterItemList?.forEach({ itemModel in
                if itemModel.isSelect == true {
                    paramsDict[key] = itemModel.value
                }
            })
        })
        AnAnRequest.shared.requestCategoryListData(keys: paramsDict, page: String(format: "%d", page), rows: String(format: "%d", 21)) {[weak self] listModel in
            guard let `self` else {return}
            
            if listModel.count < 21 {
                self.categoryCollectionView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                self.categoryCollectionView.mj_footer?.endRefreshing()
            }
            categoryDataArray.append(contentsOf: listModel)
            self.categoryCollectionView.categoryDataArray = categoryDataArray
        }
    }
}

