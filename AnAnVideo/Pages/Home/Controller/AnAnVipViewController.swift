//
//  AnAnVipViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit
import MJRefresh

class AnAnVipViewController: AnAnBaseViewController {
    lazy var vipTableview:AnAnHomeTableView = {
        let tableView = AnAnHomeTableView(frame: .zero, style: .grouped)
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] in
            guard let `self` else {return}
            self.loadData()
            tableView.mj_header?.endRefreshing()
        })
        return tableView
    }()
    var dataArray:[SectionModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view .addSubview(vipTableview)
        vipTableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        AnAnHomeRequest.position = "CHANNEL_VIP"
        loadData()
    }

    private func loadData(){
        dataArray.removeAll()
        AnAnHomeRequest.requestRecommendData {[weak self] model in
            self?.dataArray = model?.sections ?? []
            var newModel = SectionModel()
            newModel.sectionType = "BANNER_TOP"
            newModel.bannerTop = model?.bannerTop
            self?.dataArray.insert(newModel, at: 0)
            self?.vipTableview.sections = self?.dataArray
        }
    }
}

