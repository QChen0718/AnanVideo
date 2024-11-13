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
    
}

extension AnAnSearchLinkTableview:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:AnAnSearchResultVideoTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnSearchResultVideoTableViewCell", for: indexPath) as! AnAnSearchResultVideoTableViewCell
            return cell
        }else{
            let cell:AnAnSearchResultNameTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AnAnSearchResultNameTableViewCell", for: indexPath) as! AnAnSearchResultNameTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 79
        }
        return 43
    }
}
