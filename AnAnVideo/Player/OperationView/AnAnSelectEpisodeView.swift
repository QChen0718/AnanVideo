//
//  AnAnSelectEpisodeView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/22.
//  选集view

import UIKit

// 将选择的剧集回调出去
typealias ReportCurrentEpisodeBlock = (EpisodeListModel?,Int)->Void

class AnAnSelectEpisodeView: UIView {
    
    var reportEpisodeBlock:ReportCurrentEpisodeBlock?
    
    lazy var epBgview:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: "#000000", alpha: 0.85)
        return view
    }()
    
    private lazy var selectEpLab:UILabel = {
        let label = AnAnLabel.createLabel(text:"选集",fontColor: UIColor.hexadecimalColor(hexadecimal: "#FFFFFF"), font: UIFont.systemFont(ofSize: 17, weight: .semibold))
        return label
    }()
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.itemSize = CGSize(width: 48, height: 48)
        return layout
    }()
    
//    选择剧集
    private lazy var episodeCollectionView:AnAnEpisodeCollectionView = {
        let view = AnAnEpisodeCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        view.selectEpisodeBlock = {[weak self] model,index in
            self?.reportEpisodeBlock!(model,index)
        }
        return view
    }()
    
    
    var episodeListArray:[EpisodeListModel]?{
        didSet{
            episodeCollectionView.episodeListArray = episodeListArray
        }
    }
    var currentPlayerIndex:Int = 0{
        didSet{
            episodeCollectionView.currentEpisode = currentPlayerIndex
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        createSubviews()
        setSubviewsFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(epBgview)
        epBgview.addSubview(selectEpLab)
        epBgview.addSubview(episodeCollectionView)
    }
    
    private func setSubviewsFrame() {
        epBgview.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(270)
            make.width.equalTo(270)
        }
        selectEpLab.snp.makeConstraints { make in
            make.leading.equalTo(21)
            make.top.equalTo(30)
        }
        episodeCollectionView.snp.makeConstraints { make in
            make.trailing.bottom.width.equalToSuperview()
            make.top.equalTo(selectEpLab.snp.bottom).offset(21)
        }
    }
    
    func showSelectEpView(){
        self.layoutIfNeeded()
        self.epBgview.snp.updateConstraints { make in
            make.trailing.equalToSuperview()
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let `self` else {return}
            
            self.layoutIfNeeded()
        }
    }
    
    func hiddenSelectEpView() {
        self.epBgview.snp.updateConstraints { make in
            make.trailing.equalTo(270)
        }
        UIView.animate(withDuration: 0.5) {[weak self] in
            guard let `self` else {return}
            self.layoutIfNeeded()
        } completion: { success in
            if success {
                self.removeFromSuperview()
            }
        }

    }
}
