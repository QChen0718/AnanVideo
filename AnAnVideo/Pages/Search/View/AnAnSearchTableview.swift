//
//  AnAnSearchTableview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnSearchTableview: UITableView {
    var hotList:[AnAnHotModel?] = []
    var selectIndex:Int = 0
    var disKeyworld:(()->Void)?
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        separatorStyle = .none
        backgroundColor = .white
        register(AnAnSearchHitoryKeyTableViewCell.self, forCellReuseIdentifier: "AnAnSearchHitoryKeyTableViewCell")
        register(AnAnPageTitleTableViewCell.self, forCellReuseIdentifier: "AnAnPageTitleTableViewCell")
        register(AnAnHotRecommendTableViewCell.self, forCellReuseIdentifier: "AnAnHotRecommendTableViewCell")
        contentInsetAdjustmentBehavior = .never
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableDataList), name: NSNotification.Name("updateSearchTable"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    @objc func refreshTableDataList(noti:Notification){
        let dict = noti.userInfo
        guard let index = dict?["selectIndex"] as? Int else { return }
        self.selectIndex = index
        self.reloadData()
    }
}


extension AnAnSearchTableview{
    func loadSearchTopData() {
//        加载下一页数据
        AnAnRequest.shared.requestSearchTopListData(page: 1, rows: 20) { model in
            
        }
//        加载热门推荐数据
        AnAnRequest.shared.requestHotRecommendListData {[weak self] modelArray in
            guard let `self` else { return }
            self.hotList = modelArray
            self.hotList[self.selectIndex]?.isSelect = true
            self.reloadData()
        }
    }
}

extension AnAnSearchTableview:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:AnAnSearchHitoryKeyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnSearchHitoryKeyTableViewCell", for: indexPath) as! AnAnSearchHitoryKeyTableViewCell
            return cell
        }else if indexPath.section == 1{
            let cell:AnAnPageTitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnPageTitleTableViewCell", for: indexPath) as! AnAnPageTitleTableViewCell
            cell.pagetitleCollection.dataList = hotList
            return cell
        }else {
            let cell:AnAnHotRecommendTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnHotRecommendTableViewCell", for: indexPath) as! AnAnHotRecommendTableViewCell
            if hotList.count > 0 {
                cell.searchCollection.recommentVideoList = hotList[selectIndex]?.searchRecommendDtos
            }
            return cell
        }
    }
//    滑动 135
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return AnAnSearchData.shareDB.fetchAllSearchData().count == 0 ? 0 : 120
        }else if indexPath.section == 1{
            return 47
        }else{
            return AnAnAppDevice.an_screenHeight() - 233
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 2 {
            return 16
        }
        return 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        disKeyworld?()
    }
}


