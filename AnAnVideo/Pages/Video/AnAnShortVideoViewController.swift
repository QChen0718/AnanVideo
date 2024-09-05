//
//  AnAnShortVideoViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/20.
//  短视频

import UIKit

class AnAnShortVideoViewController: AnAnBaseViewController {

    private lazy var tableView:AnAnShortTableView = {
        let tableview = AnAnShortTableView(frame: .zero, style: .plain)
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.bottom.equalTo(-(AnAnAppDevice.deviceBottom + AnAnAppDevice.navigationBarHeight()))
        }
        tableView.layoutIfNeeded()
        tableView.rowHeight = tableView.frame.height
        requestData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.startPlayer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tableView.stopPlayer()
    }
    
    
    private func requestData(){
        AnAnRequest.shared.provider.requestModel(.shortVideoList, model: AnAnShortModel.self) { (returnData, msg) in
            
        }
    }
}
