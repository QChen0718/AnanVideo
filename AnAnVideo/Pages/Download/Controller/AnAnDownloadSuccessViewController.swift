//
//  AnAnDownloadSuccessViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnDownloadSuccessViewController: UIViewController {
    
    private lazy var successTableView:AnAnDownloadSuccessTableview = {
        let tableView = AnAnDownloadSuccessTableview(frame: .zero, style: .plain)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_16161C)
        createSubviews()
        setSubviewsFrame()
    }

    private func createSubviews() {
        view.addSubview(successTableView)
    }
    
    private func setSubviewsFrame() {
        successTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
