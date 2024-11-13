//
//  AnAnSearchHitoryKeyTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnSearchHitoryKeyTableViewCell: UITableViewCell {

    lazy var historyTitleLab:UILabel = {
       let lab = UILabel()
        lab.text = "历史搜索"
        lab.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
        lab.font = .systemFont(ofSize: 17, weight: .semibold)
        return lab
    }()
    
    lazy var closeBtn:UIButton = {
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: ""), for: .normal)
        btn.addTarget(self, action: #selector(closeBtnClick), for: .touchUpInside)
        return btn
    }()
    
    lazy var historyKeyCollection: AnAnSearchHistoryKeyCollectionView = {
        let view = AnAnSearchHistoryKeyCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(historyTitleLab)
        contentView.addSubview(closeBtn)
        contentView.addSubview(historyKeyCollection)
        historyTitleLab.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalToSuperview()
        }
        closeBtn.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(10)
            make.size.equalTo(21)
        }
        historyKeyCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(historyTitleLab.snp.bottom).offset(16)
            make.height.equalTo(72)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closeBtnClick(){
        
    }
}
