//
//  AnAnHomeTableView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/2/27.
//

import UIKit

class AnAnHomeTableView: UITableView {
    let recommentCellId = "AnAnHomeRecommentTableViewCellId"
    let vipCellId = "AnAnHomeHorizontalTableViewCellId"
    let anAnHomeActorTableViewCellId = "AnAnHomeActorTableViewCellId"
    let anAnBannerTableViewCellId = "AnAnBannerTableViewCellId"
    var sections:[SectionModel]?{
        didSet{
            self.reloadData()
        }
    }
    private lazy var sectionsArray:[String] = {
        let array:[String] = [recommentCellId,vipCellId]
        return array
    }()
    private lazy var sectionTitleArray:[String] = {
        let array:[String] = ["为你推荐","今日必看"]
        return array
    }()
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
        self.estimatedRowHeight = 100
        self.backgroundColor = .white
        self.separatorStyle = .none
        self.rowHeight = UITableView.automaticDimension
        self.showsVerticalScrollIndicator = false
        self.register(AnAnHomeRecommentTableViewCell.self, forCellReuseIdentifier: recommentCellId);
        self.register(AnAnHomeHorizontalTableViewCell.self, forCellReuseIdentifier: vipCellId);
        self.register(AnAnHomeActorTableViewCell.self, forCellReuseIdentifier: anAnHomeActorTableViewCellId)
        self.register(AnAnBannerTableViewCell.self, forCellReuseIdentifier: anAnBannerTableViewCellId)
        self.register(AnAnMAGICCUBETableViewCell.self, forCellReuseIdentifier: AnAnMAGICCUBETableViewCell.description())
        self.register(AnAnShortVideoTableViewCell.self, forCellReuseIdentifier: AnAnShortVideoTableViewCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension AnAnHomeTableView:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections?.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionModel = self.sections?[indexPath.section]
        guard let sectionType = sectionModel?.sectionType else { return UITableViewCell() }
        if sectionType == "VIDEO"{
            let cell:AnAnHomeRecommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: recommentCellId) as! AnAnHomeRecommentTableViewCell
            cell.sectionContentModels = sectionModel?.sectionContents
            return cell
        }else if sectionType == "VIDEO_RECOMMEND"{
            if let display = sectionModel?.display,display == "SLIDE" {
//                横滑组件
                let cell:AnAnHomeHorizontalTableViewCell = tableView.dequeueReusableCell(withIdentifier: vipCellId) as! AnAnHomeHorizontalTableViewCell
                cell.sectionContentModels = sectionModel?.sectionContents
                return cell
            }else{
//                平铺组件
                let cell:AnAnHomeRecommentTableViewCell = tableView.dequeueReusableCell(withIdentifier: recommentCellId) as! AnAnHomeRecommentTableViewCell
                cell.sectionContentModels = sectionModel?.sectionContents
                return cell
            }
        }else if sectionType == "MULTI_IMAGE"{
            let cell:AnAnHomeActorTableViewCell = tableView.dequeueReusableCell(withIdentifier: anAnHomeActorTableViewCellId) as! AnAnHomeActorTableViewCell
            cell.sectionContentModels = sectionModel?.sectionContents
            return cell
        }else if sectionType == "BANNER_TOP"{
            let cell:AnAnBannerTableViewCell = tableView.dequeueReusableCell(withIdentifier: anAnBannerTableViewCellId) as! AnAnBannerTableViewCell
            cell.bannerTops = sectionModel?.bannerTop
            return cell
        }else if sectionType == "MAGIC_CUBE"{
//            魔方组件（支持平铺）
            let cell:AnAnMAGICCUBETableViewCell = tableView.dequeueReusableCell(withIdentifier: AnAnMAGICCUBETableViewCell.description(), for: indexPath) as! AnAnMAGICCUBETableViewCell
            cell.sectionContentModels = sectionModel?.sectionContents
            return cell
        }
        else if sectionType == "SHORT_VIDEO"{
//            短视频
            let cell:AnAnShortVideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: AnAnShortVideoTableViewCell.description(), for: indexPath) as! AnAnShortVideoTableViewCell
            cell.sectionContentModels = sectionModel?.sectionContents
            return cell
        }
        else{
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionModel = self.sections?[section]
        guard let sectionType = sectionModel?.sectionType else { return UIView() }
        if sectionType == "BANNER_TOP"{
            return UIView()
        }else{
            let view = AnAnTableSectionView()
            view.titleLabel.text = self.sections?[section].name
//            if cellType == recommentCellId{
//                view.refreshBtn.isHidden = false
//            }else{
                view.refreshBtn.isHidden = true
//            }
            return view
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionModel = self.sections?[section]
        guard let sectionType = sectionModel?.sectionType else { return 0 }
        if sectionType == "BANNER_TOP" || sectionType == "MAGIC_CUBE"{
            return 0
        }
        return 34
    }
    
    
}
