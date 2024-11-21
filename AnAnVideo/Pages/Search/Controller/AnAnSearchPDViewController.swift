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
    }

}
