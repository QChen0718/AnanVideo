//
//  AnAnShortVideoViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchShortVideoViewController: UIViewController {

    lazy var shotCollection:AnAnSearchShotVideoCollectionview = {
        let view = AnAnSearchShotVideoCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(shotCollection)
        shotCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadSearchResultListData(keyword: searchKey ?? "")
    }

    var searchKey:String?
}
extension AnAnSearchShortVideoViewController{
    func loadSearchResultListData(keyword:String) {
        let params:[String:Any] = ["keywords":keyword,"size":"20"]
        AnAnRequest.shared.requestSearchQuickData(params: params) {[weak self] searchModels in
            guard let `self` else {return}
            self.shotCollection.dataList = searchModels
        }
    }
}
