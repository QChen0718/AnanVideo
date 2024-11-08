//
//  AnAnSettingTable.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/7.
//

import UIKit

class AnAnSettingTable: UITableView {

    let dataArray:[String] = ["允许差移动网络播放","允许移动网络缓存","清理缓存","关于我们","隐私政策","用户协议"]
    
    lazy var footerBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: AnAnAppDevice.an_screenWidth(), height: 57)
        btn.setTitle("退出登录", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_333333), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        btn.addTarget(self, action: #selector(logoutClick), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        delegate = self;
        dataSource = self;
        separatorStyle = .none
        backgroundColor = .white
        register(AnAnSettingBaseTableViewCell.self, forCellReuseIdentifier: AnAnSettingBaseTableViewCell.description())
//        register(AnAnSettingSwichTableViewCell.self, forCellReuseIdentifier: AnAnSettingSwichTableViewCell.description())
//        register(AnAnSettingContentTableViewCell.self, forHeaderFooterViewReuseIdentifier: AnAnSettingContentTableViewCell.description())
        tableFooterView = footerBtn
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func logoutClick(){
        AnAnUserData.removeUserData()
        AnAnJumpPageManager.backPage()
    }
    
}

extension AnAnSettingTable:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AnAnSettingBaseTableViewCell = tableView.dequeueReusableCell(withIdentifier: AnAnSettingBaseTableViewCell.description(), for: indexPath) as! AnAnSettingBaseTableViewCell
        cell.titleContentStr = dataArray[indexPath.row]
        return cell
    }
}
