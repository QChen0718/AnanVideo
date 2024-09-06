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
    
    private lazy var filterDataArray:[[AnAnFilterModel]] = {
        let array1 = [addFilterItem(title: "最热播放", index: 0),
        addFilterItem(title: "最近更新", index: 1),
        addFilterItem(title: "最受好评", index: 2),
        addFilterItem(title: "本季新剧", index: 3)]
        let array2 = [addFilterItem(title: "全部", index: 0),
        addFilterItem(title: "2023", index: 1),
        addFilterItem(title: "2022", index: 2),
        addFilterItem(title: "2021", index: 3),
        addFilterItem(title: "2020", index: 4),
                      addFilterItem(title: "2019", index: 4),
                      addFilterItem(title: "2018", index: 4)]
        let array3 = [addFilterItem(title: "全部", index: 0),
        addFilterItem(title: "美国", index: 1),
        addFilterItem(title: "", index: 2),
        addFilterItem(title: "", index: 3),
        addFilterItem(title: "", index: 4)]
        let modelArray = [array1,array2,array3]
        return modelArray
    }()
    
    func addFilterItem(title:String,index:Int) -> AnAnFilterModel {
        var model = AnAnFilterModel()
        model.title = title
        model.index = index
        return model
    }
    
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
        AnAnRequest.shared.requestCatoryFilterTagData {[weak self] model in
            guard let `self` else {return}
        }
    }
}

