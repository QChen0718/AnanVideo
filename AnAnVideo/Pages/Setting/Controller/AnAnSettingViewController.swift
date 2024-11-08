//
//  AnAnSettingViewController.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/7.
//

import UIKit

class AnAnSettingViewController: AnAnBaseViewController {

    lazy var settingTable:AnAnSettingTable = {
        let table = AnAnSettingTable(frame: .zero, style: .plain)
        return table
    }()
    
    lazy var navTitleLab:UILabel = {
       let lab = UILabel()
        lab.text = "设置"
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        lab.textAlignment = .center
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        return lab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        arrowBackBtn.setImage(UIImage(named: "ic_universal_navbar_back_gray_40"), for: .normal)
        view.addSubview(navTitleLab)
        navTitleLab.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(56)
            make.centerY.equalTo(arrowBackBtn)
        }
        view.addSubview(settingTable)
        settingTable.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(AnAnAppDevice.deviceTop()+52)
        }
    }
}
