//
//  AnAnSearchPDViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchPDViewController: UIViewController {

    lazy var pdCollection:AnAnSearchVPDCollectionview = {
        let view = AnAnSearchVPDCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(pdCollection)
        pdCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadSearchResultListData(keyword: searchKey ?? "")
    }

    var searchKey:String?
}

extension AnAnSearchPDViewController{
    func loadSearchResultListData(keyword:String) {
        let params:[String:Any] = ["keywords":keyword,"size":"20"]
        AnAnRequest.shared.requestSearchPDData(params: params) {[weak self] searchModels in
            guard let `self` else {return}
            pdCollection.dataList = searchModels
        }
    }
}
