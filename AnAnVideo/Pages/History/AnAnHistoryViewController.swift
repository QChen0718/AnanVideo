//
//  AnAnHistoryViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2025/1/21.
//

import UIKit

class AnAnHistoryViewController: AnAnBaseViewController {
    
    lazy var navTitle: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        lab.text = "观看历史"
        return lab
    }()
    
    lazy var rightBtn: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("编辑", for: .normal)
        btn.setTitleColor(UIColor.hexadecimalColor(hexadecimal: An_454753), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        btn.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var historyTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.delegate = self
        table.dataSource = self
        table.register(AnAnHistoryTableViewCell.self, forCellReuseIdentifier: "AnAnHistoryTableViewCell")
        table.backgroundColor = .white
        table.separatorStyle = .none
        table.contentInsetAdjustmentBehavior = .never
        table.rowHeight = 84
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrowBackBtn.setImage(UIImage(named: "ic_arrow_back_black"), for: .normal)
        view.addSubview(navTitle)
        view.addSubview(rightBtn)
        view.addSubview(historyTable)
        navTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(arrowBackBtn)
        }
        rightBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.height.equalTo(37)
            make.width.equalTo(48)
            make.centerY.equalTo(navTitle)
        }
        
        historyTable.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(navTitle.snp.bottom).offset(24)
        }
    }
    

    @objc private func editBtnClick(){
        
    }

}

extension AnAnHistoryViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnAnHistoryTableViewCell", for: indexPath) as! AnAnHistoryTableViewCell
        return cell
    }
    
}
