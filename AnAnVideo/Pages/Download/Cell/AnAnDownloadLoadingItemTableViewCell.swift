//
//  AnAnDownloadLoadingItemTableViewCell.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnDownloadLoadingItemTableViewCell: UITableViewCell {

    private lazy var movieCover:UIImageView = {
        let imageView = AnAnImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var movieNameLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"最后生还者 04",fontColor: UIColor.hexadecimalColor(hexadecimal: An_FFFFFF), font: UIFont.pingFangRegularWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var downloadProgress:AnAnCustomProgress = {
        let view = AnAnCustomProgress(colors: [UIColor.hexadecimalColor(hexadecimal: An_64C2F7).cgColor,UIColor.hexadecimalColor(hexadecimal: An_9253F6).cgColor],progress: 0.5,locations: [0,1],startPoint: CGPoint(x: 0.28, y: 0.51),endPoint: CGPoint(x: 0.51, y: 0.51))
        return view
    }()
    
    private lazy var statusLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"等待中",fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        return label
    }()
    
    private lazy var totalSizeLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"未知",fontColor: UIColor.hexadecimalColor(hexadecimal: An_85888F), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSubviews()
        setSubviewsFrame()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        contentView.addSubview(movieCover)
        contentView.addSubview(movieNameLabel)
        contentView.addSubview(downloadProgress)
        contentView.addSubview(statusLabel)
        contentView.addSubview(totalSizeLabel)
    }
    
    private func setSubviewsFrame() {
        movieCover.snp.makeConstraints { make in
            make.leading.equalTo(20)
            make.top.equalTo(20)
            make.size.equalTo(CGSize(width: 106, height: 60))
        }
        movieNameLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieCover.snp.trailing).offset(12)
            make.trailing.equalTo(-16)
            make.top.equalTo(movieCover.snp.top).offset(3.5)
            make.height.equalTo(14)
        }
        downloadProgress.snp.makeConstraints { make in
            make.leading.trailing.equalTo(movieNameLabel)
            make.top.equalTo(movieNameLabel.snp.bottom).offset(12)
            make.height.equalTo(3)
        }
        statusLabel.snp.makeConstraints { make in
            make.leading.equalTo(movieNameLabel)
            make.top.equalTo(downloadProgress.snp.bottom).offset(12)
            make.trailing.equalTo(totalSizeLabel.snp.leading).offset(-10)
            make.height.equalTo(12)
        }
        totalSizeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.top.equalTo(statusLabel)
            make.height.equalTo(12)
            make.width.equalTo(53)
        }
    }
    
    var downloadModel:AnAnDownloadModel?{
        didSet{
            movieCover.setImageWith(url: downloadModel?.movieCover ?? "")
            movieNameLabel.text = (downloadModel?.movieTitle ?? "") + (downloadModel?.episodeNo ?? "")
//            totalSizeLabel.text = String.formatFileSize(octets: UInt32(downloadModel?.movieSize ?? "") ?? 0)
        }
    }
    func stopDownload() {
        downloadProgress.updateColors = [UIColor.hexadecimalColor(hexadecimal: An_46464A).cgColor,UIColor.hexadecimalColor(hexadecimal: An_8D8D93).cgColor]
    }
}
