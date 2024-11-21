//
//  AnAnSearchSynthesisViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchSynthesisViewController: UIViewController {

    lazy var resultCollection:AnAnSearchResultCollectionView = {
        let view = AnAnSearchResultCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    var sectionArray:[[String:Any]] = []
    var searchKey:String?{
        didSet{
            loadSearchResultListData(keyword: searchKey ?? "")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(resultCollection)
        
        resultCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

extension AnAnSearchSynthesisViewController{
    func loadSearchResultListData(keyword:String) {
        let params:[String:Any] = ["keywords":keyword,"size":"20","search_after":"1","order":""]
        AnAnRequest.shared.requestSearchResultListData(params: params) {[weak self] searchModel in
            guard let `self` else {return}
            guard let seasonList = searchModel?.seasonList else { return }
            guard let actorList = searchModel?.actorList else { return }
            guard let sheetList = searchModel?.sheetList else { return }
            guard let videoList = searchModel?.videoList else { return}
            if !seasonList.isEmpty {
                let dict = ["type":SearchResultType.season,"dataArray":seasonList]
                self.sectionArray.append(dict)
            }
            if !actorList.isEmpty {
                let dict = ["type":SearchResultType.actor,"dataArray":actorList]
                self.sectionArray.append(dict)
            }
            if !sheetList.isEmpty{
                let dict = ["type":SearchResultType.sheet,"dataArray":sheetList]
                self.sectionArray.append(dict)
            }
            if !videoList.isEmpty{
                let dict = ["type":SearchResultType.video,"dataArray":videoList]
                self.sectionArray.append(dict)
            }
            self.resultCollection.dataList = self.sectionArray;
        }
    }
}
