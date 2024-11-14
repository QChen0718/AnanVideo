//
//  AnAnSearchLinkTableview.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnSearchLinkTableview: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        separatorStyle = .none
        backgroundColor = .white
        delegate = self
        dataSource = self
        contentInsetAdjustmentBehavior = .never
        register(AnAnSearchResultNameTableViewCell.self, forCellReuseIdentifier: "AnAnSearchResultNameTableViewCell")
        register(AnAnSearchResultVideoTableViewCell.self, forCellReuseIdentifier: "AnAnSearchResultVideoTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var searchlinkModel:AnAnSearchLinkModel? {
        didSet{
            self.reloadData()
        }
    }
}

extension AnAnSearchLinkTableview:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return searchlinkModel?.seasonList?.count ?? 0
        }
        return searchlinkModel?.searchTips?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell:AnAnSearchResultVideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnSearchResultVideoTableViewCell", for: indexPath) as! AnAnSearchResultVideoTableViewCell
            cell.seasonModel = searchlinkModel?.seasonList?[indexPath.row]
            return cell
        }else{
            let cell:AnAnSearchResultNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnSearchResultNameTableViewCell", for: indexPath) as! AnAnSearchResultNameTableViewCell
            cell.searchTipModel = searchlinkModel?.searchTips?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 79
        }
        return 43
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isHidden = true
        AnAnJumpPageManager.goToSearchResultPage(keyword: "女王")
    }
}
