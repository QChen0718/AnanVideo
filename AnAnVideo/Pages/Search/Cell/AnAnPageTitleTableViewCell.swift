//
//  AnAnPageTitleTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnPageTitleTableViewCell: UITableViewCell {

    lazy var pagetitleCollection: AnAnPageTitleCollectionview = {
        let view = AnAnPageTitleCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_E6E7E8)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(pagetitleCollection)
        pagetitleCollection.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(16)
            make.height.equalTo(21)
        }
        contentView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
