//
//  AnAnDownloadSuccessTableview.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/18.
//

import UIKit

class AnAnDownloadSuccessTableview: UITableView {
    
    private let cellId = "AnAnDownloadSuccessTableViewCellId"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(AnAnDownloadSuccessTableViewCell.self, forCellReuseIdentifier: cellId)
        rowHeight = 124
        backgroundColor = .clear
        separatorStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnDownloadSuccessTableview:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnDownloadSuccessTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnAnDownloadSuccessTableViewCell
        return cell
    }
}
