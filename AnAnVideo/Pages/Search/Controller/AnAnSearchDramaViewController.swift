//
//  AnAnSearchDramaViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchDramaViewController: UIViewController {

//    排序方式，match:匹配 date:更新 hot:热度
    var order:String = "match"
    
    lazy var videosCollection:AnAnSearchVideosCollectionview = {
        let view = AnAnSearchVideosCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(videosCollection)
        videosCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        loadSearchResultListData(keyword: searchKey ?? "")
    }
    var searchKey:String?
}

extension AnAnSearchDramaViewController{
    func loadSearchResultListData(keyword:String) {
        let params:[String:Any] = ["keywords":keyword,"size":"10","order":order]
        AnAnRequest.shared.requestSearchVideosData(params: params) {[weak self] searchModels in
            guard let `self` else {return}
            self.videosCollection.dataList = searchModels
        }
    }
}
