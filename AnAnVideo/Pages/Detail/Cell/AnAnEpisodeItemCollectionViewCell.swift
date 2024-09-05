//
//  AnAnEpisodeItemCollectionViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/25.
//

import UIKit

class AnAnEpisodeItemCollectionViewCell: UICollectionViewCell {
    
    private lazy var episodeNumberLabel:UILabel = {
        let label = AnAnLabel.createLabel(fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222), font: UIFont.orbitronSemiBoldWithSize(fontSize: 17))
        label.textAlignment = .center
        return label
    }()
    
    private lazy var vipIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_poster_corner_mark_vip")
        return imageView
    }()
    
    private lazy var downloadIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_video_set_download")
        return imageView
    }()
    
    private lazy var downloadSuccessIcon:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "ic_video_set_download_finish")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_F6F8FA)
        layer.cornerRadius = 8
        clipsToBounds = true
        createSubviews()
        setSubviewsFrame()
        downloadIcon.isHidden = true
        downloadSuccessIcon.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(episodeNumberLabel)
        contentView.addSubview(vipIcon)
        contentView.addSubview(downloadIcon)
        contentView.addSubview(downloadSuccessIcon)
    }
    
    private func setSubviewsFrame() {
        episodeNumberLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        vipIcon.snp.makeConstraints { make in
            make.top.trailing.equalToSuperview()
            make.size.equalTo(CGSize(width: 27, height: 16))
        }
        downloadIcon.snp.makeConstraints { make in
            make.bottom.equalTo(-5)
            make.trailing.equalTo(-5)
            make.size.equalTo(9)
        }
        downloadSuccessIcon.snp.makeConstraints { make in
            make.edges.equalTo(downloadIcon)
        }
    }
    
    var episodeListModel:EpisodeListModel?{
        didSet{
            if let feeMode = episodeListModel?.feeMode, feeMode == "vip"{
                vipIcon.isHidden = false
            }else{
                vipIcon.isHidden = true
            }
            episodeNumberLabel.text = episodeListModel?.episodeNo
            if let isDownloading = episodeListModel?.isDownloading, isDownloading{
                downloadIcon.isHidden = false
            }else{
                downloadIcon.isHidden = true
            }
        }
    }
    
    var selectEpisode:Bool = false{
        didSet{
            if selectEpisode{
                episodeNumberLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_1890FF)
                layer.borderWidth = 1.5
                layer.borderColor = UIColor.hexadecimalColor(hexadecimal: An_1890FF).cgColor
            }else{
                episodeNumberLabel.textColor = UIColor.hexadecimalColor(hexadecimal: An_222222)
                layer.borderWidth = 0
            }
        }
    }
}
