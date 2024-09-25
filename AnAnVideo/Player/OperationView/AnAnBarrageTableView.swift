//
//  AnAnBarrageTableView.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/9/24.
//

import UIKit

class AnAnBarrageTableView: UITableView {

    private let dataList:[AnAnBarrageModel] = [AnAnBarrageModel(setType:.BarrageSetTypeArea,setName: "显示区域", value: 0.0),AnAnBarrageModel(setType:.BarrageSetTypeAlpha,setName: "不透明度", value: 0.0),AnAnBarrageModel(setType:.BarrageSetTypeFont,setName: "字体大小", value: 0.0),AnAnBarrageModel(setType:.BarrageSetTypeSpeed,setName: "弹幕速度", value: 0.0)]
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self
        dataSource = self
        backgroundColor = .clear
        contentInsetAdjustmentBehavior = .never
        rowHeight = 67
        register(AnAnBarrageSetItemCell.self, forCellReuseIdentifier: AnAnBarrageSetItemCell.description())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnBarrageTableView:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnBarrageSetItemCell = tableView.dequeueReusableCell(withIdentifier: AnAnBarrageSetItemCell.description(), for: indexPath) as! AnAnBarrageSetItemCell
        cell.barrageSetModel = dataList[indexPath.row]
        return cell
    }
}
