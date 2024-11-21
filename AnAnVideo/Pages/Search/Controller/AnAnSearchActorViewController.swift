//
//  AnAnSearchActorViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/21.
//

import UIKit

class AnAnSearchActorViewController: UIViewController {

    lazy var mxCollection:AnAnSearchMXCollectionview = {
        let view = AnAnSearchMXCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(mxCollection)
        mxCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
