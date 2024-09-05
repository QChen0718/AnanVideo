//
//  AnAnDownloadLoadingTableview.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnDownloadLoadingTableview: UITableView {

    private let anAnDownloadLoadingItemTableViewCellId = "AnAnDownloadLoadingItemTableViewCellId"
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        separatorStyle = .none
        rowHeight = 100
        register(AnAnDownloadLoadingItemTableViewCell.self, forCellReuseIdentifier: anAnDownloadLoadingItemTableViewCellId)
        NotificationCenter.default.addObserver(self, selector: #selector(updateDownloadProgress), name: AnAnNotifacationName.UpdateVideoDownloadProgress, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc private func updateDownloadProgress(noti:Notification){
        let currentSize = noti.userInfo?["downloadSize"] as? Int
        print("currentSize=\(currentSize ?? 0)")
    }
}

extension AnAnDownloadLoadingTableview:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AnAnDownloadData.shareDefault.downloadDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnDownloadLoadingItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: anAnDownloadLoadingItemTableViewCellId, for: indexPath) as! AnAnDownloadLoadingItemTableViewCell
        cell.downloadModel = AnAnDownloadData.shareDefault.downloadDataArray[indexPath.row]
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell:AnAnDownloadLoadingItemTableViewCell = tableView.cellForRow(at: indexPath) as! AnAnDownloadLoadingItemTableViewCell
        cell.stopDownload()
//        reloadData()
    }
}
