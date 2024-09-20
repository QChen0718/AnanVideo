//
//  AnAnSpeedTableView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2024/9/16.
//

import UIKit

typealias CurrentSelectSpeedBlock = (Float?)->Void

class AnAnSpeedTableView: UITableView {

    private var speedArray:[SpeedModel] = [SpeedModel(value: 2.0, name: "2.0X", isSelect: false),SpeedModel(value: 1.5, name: "1.5X", isSelect: false),SpeedModel(value: 1.25, name: "1.25X", isSelect: false),SpeedModel(value: 1.0, name: "1.0X", isSelect: true),SpeedModel(value: 0.75, name: "0.75X", isSelect: false)]
    
    var currentSpeedBlock:CurrentSelectSpeedBlock?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        separatorStyle = .none
        rowHeight = 64
        register(AnAnSpeedTableViewCell.self, forCellReuseIdentifier: AnAnSpeedTableViewCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnSpeedTableView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return speedArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnSpeedTableViewCell = tableView.dequeueReusableCell(withIdentifier: AnAnSpeedTableViewCell.description()) as! AnAnSpeedTableViewCell
        cell.speedModel = speedArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<speedArray.count{
            speedArray[i].isSelect = false
        }
        speedArray[indexPath.row].isSelect = true
        currentSpeedBlock?(speedArray[indexPath.row].value)
        self.reloadData()
    }
}
