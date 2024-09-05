//
//  AnAnDownloadLoadingViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnDownloadLoadingViewController: UIViewController {
    
    private lazy var downloadingTableview:AnAnDownloadLoadingTableview = {
        let tableview = AnAnDownloadLoadingTableview(frame: .zero, style: .plain)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createSubviews()
        setSubviewsFrame()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_16161C)
    }
    
    private func createSubviews() {
        view.addSubview(downloadingTableview)
    }
    
    private func setSubviewsFrame() {
        downloadingTableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
