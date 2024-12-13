//
//  AnAnShortTableView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/5/20.
//

import UIKit

class AnAnShortTableView: UITableView {

    private let cellId = "AnAnShortTableViewCellId"
    var currentIndex:Int = 0
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        register(AnAnShortTableViewCell.self, forCellReuseIdentifier: cellId)
        separatorStyle = .none
        isPagingEnabled = true
        scrollsToTop = false
        contentInsetAdjustmentBehavior = .never
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    离开界面暂停播放
    func stopPlayer() {
        let currentcell = self.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as? AnAnShortTableViewCell
        currentcell?.pausePl()
    }
//    进入界面开始播放
    func startPlayer() {
        let currentcell = self.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as? AnAnShortTableViewCell
        currentcell?.player()
    }
    
    var dataList:[AnAnShortModel?]? {
        didSet{
            reloadData()
        }
    }
}

extension AnAnShortTableView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnShortTableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! AnAnShortTableViewCell
        cell.model = dataList?[indexPath.row]
        if indexPath.row == currentIndex {
            cell.player()
        }else{
            cell.pausePl()
        }
        return cell
    }
}

extension AnAnShortTableView:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollview-->\(scrollView.contentOffset.y)")
        let oldcell = self.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as? AnAnShortTableViewCell
        oldcell?.pausePl()
        let index = scrollView.contentOffset.y/self.frame.height
        currentIndex = Int(index);
        let currentcell = self.cellForRow(at: IndexPath.init(row: currentIndex, section: 0)) as? AnAnShortTableViewCell
        currentcell?.player()
        print("index--->\(index)")
    }
    
}
