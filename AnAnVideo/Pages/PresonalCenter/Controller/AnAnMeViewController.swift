//
//  AnAnMeViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit

class AnAnMeViewController: AnAnBaseViewController {

    private lazy var layout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        return layout
    }()
    
    private lazy var collectionView:AnAnPersonalCenterCollectionView = {
        let view = AnAnPersonalCenterCollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createSubviews()
        setSubviewsFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    private func createSubviews() {
        self.view.addSubview(collectionView)
    }
    
    private func setSubviewsFrame() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension AnAnMeViewController{
    fileprivate func requestMeData(){
        
    }
}
