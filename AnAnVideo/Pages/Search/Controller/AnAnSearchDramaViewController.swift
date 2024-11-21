//
//  AnAnSearchDramaViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchDramaViewController: UIViewController {

    
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
    }

}
