//
//  AnAnRecommendViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/19.
//

import UIKit

class AnAnRecommendViewController: AnAnBaseViewController {

    lazy var recommendTableview:AnAnHomeTableView = {
        let tableView = AnAnHomeTableView(frame: .zero, style: .grouped)
        return tableView
    }()
    var dataArray:[SectionModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view .addSubview(recommendTableview)
        recommendTableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        AnAnHomeRequest.position = "CHANNEL_INDEX"
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
            self?.recommendTableview.sections = self?.dataArray
        }
    }
}


