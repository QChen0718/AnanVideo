//
//  AnAnDownloadEpisodePopView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/4/13.
//

import UIKit

class AnAnDownloadEpisodePopView: UIView {

    var selectBtnBlock:SelectBtnBlock?
    var dramaId:String?
    var dramaInfo:DramaInfoModel?
    private lazy var titleLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"选择下载的剧集",fontColor: UIColor.hexadecimalColor(hexadecimal: An_333333), font: UIFont.pingFangSemiboldWithSize(fontSize: 17))
        return label
    }()
    
    private lazy var closeIconBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_video_pop_close"),target:self,action: #selector(btnClick))
        btn.tag = 100
        return btn
    }()
    
    private lazy var qualityInfoLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"清晰度",fontColor: UIColor.hexadecimalColor(hexadecimal: An_919699), font: UIFont.pingFangRegularWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var currentQualityLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"臻彩",fontColor: UIColor.hexadecimalColor(hexadecimal: An_35CCFF), font: UIFont.pingFangSemiboldWithSize(fontSize: 14))
        return label
    }()
    
    private lazy var moreBtn:UIButton = {
        let btn = AnAnButton.createButton(image:UIImage(named: "ic_video_sharpness_more"),target: self, action: #selector(btnClick))
        btn.tag = 200
        return btn
    }()
    
    private lazy var memorySpaceLabel:UILabel = {
        let label = AnAnLabel.createLabel(text:"剩余 1.5G 可用空间",fontColor: UIColor.hexadecimalColor(hexadecimal: An_333333,alpha: 0.6), font: UIFont.pingFangRegularWithSize(fontSize: 12))
        label.textAlignment = .right
        return label
    }()
    
    private lazy var episodeSectionCollectionView:AnAnEpisodeSectionCollectionView = {
        let collectionView = AnAnEpisodeSectionCollectionView()
        return collectionView
    }()
    
    private lazy var bannerImageView:UIImageView = {
        let imageView = AnAnImageView.createImageView(name: "open_vip_download_banner")
        return imageView
    }()
    
    private lazy var viewLayout:UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 57, height: 57)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        return layout
    }()
    
    private lazy var episodeCollectionView:AnAnDetailEpisodeCollectionView = {
        let collectionView = AnAnDetailEpisodeCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.contentInset = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
        collectionView.collectionViewType = .CollectionViewDownload
        return collectionView
    }()
    
    private lazy var hlineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_E6E7E8)
        return view
    }()
    
    private lazy var bottomBtnBgView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var allCachaBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"全部缓存",font: UIFont.pingFangRegularWithSize(fontSize: 14),fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222),target: self, action: #selector(btnClick))
        btn.tag = 300
        return btn
    }()
    
    private lazy var vlineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.hexadecimalColor(hexadecimal: An_E6E7E8)
        return view
    }()
    
    private lazy var lookCacheBtn:UIButton = {
        let btn = AnAnButton.createButton(title:"查看缓存",font: UIFont.pingFangRegularWithSize(fontSize: 14),fontColor: UIColor.hexadecimalColor(hexadecimal: An_222222),target: self, action: #selector(btnClick))
        btn.tag = 400
        return btn
    }()
    
    var episodeList:[EpisodeListModel]?{
        didSet{
            episodeCollectionView.episodeList = episodeList
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        createSubviews()
        setSubviewsFrame()
        NotificationCenter.default.addObserver(self, selector: #selector(videoDownloadInfoNotifi), name: AnAnNotifacationName.VideoDownloadInfo, object: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(titleLabel)
        addSubview(closeIconBtn)
        addSubview(qualityInfoLabel)
        addSubview(currentQualityLabel)
        addSubview(moreBtn)
        addSubview(memorySpaceLabel)
        addSubview(episodeSectionCollectionView)
        addSubview(bannerImageView)
        addSubview(episodeCollectionView)
        addSubview(hlineView)
        addSubview(bottomBtnBgView)
        bottomBtnBgView.addSubview(allCachaBtn)
        bottomBtnBgView.addSubview(vlineView)
        bottomBtnBgView.addSubview(lookCacheBtn)
    }
    
    private func setSubviewsFrame() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(16)
            make.height.equalTo(21)
            make.trailing.equalTo(-40)
        }
        closeIconBtn.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalTo(titleLabel)
            make.size.equalTo(30)
        }
        qualityInfoLabel.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.size.equalTo(CGSize(width: 42, height: 14))
        }
        currentQualityLabel.snp.makeConstraints { make in
            make.leading.equalTo(qualityInfoLabel.snp.trailing).offset(8)
            make.centerY.height.equalTo(qualityInfoLabel)
            make.width.equalTo(28)
        }
        moreBtn.snp.makeConstraints { make in
            make.leading.equalTo(currentQualityLabel.snp.trailing).offset(5)
            make.centerY.equalTo(currentQualityLabel)
            make.size.equalTo(12)
        }
        memorySpaceLabel.snp.makeConstraints { make in
            make.trailing.equalTo(-16)
            make.centerY.equalTo(currentQualityLabel)
            make.height.equalTo(12)
            make.leading.equalTo(moreBtn.snp.trailing).offset(10)
        }
        
        episodeSectionCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(qualityInfoLabel.snp.bottom)
            make.height.equalTo(58)
        }
        
        bannerImageView.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.top.equalTo(episodeSectionCollectionView.snp.bottom)
            make.height.equalTo(43.5)
        }
        
        episodeCollectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(bannerImageView.snp.bottom)
            make.bottom.equalTo(hlineView.snp.top)
        }
        
        hlineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.bottom.equalTo(allCachaBtn.snp.top)
        }
        
        bottomBtnBgView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(53)
            make.bottom.equalTo(-AnAnAppDevice.deviceBottom)
        }
        
        allCachaBtn.snp.makeConstraints { make in
            make.leading.bottom.top.equalToSuperview()
            make.width.equalTo(AnAnAppDevice.an_screenWidth()/2)
        }
        
        vlineView.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.width.equalTo(0.5)
            make.centerX.equalToSuperview()
        }
        
        lookCacheBtn.snp.makeConstraints { make in
            make.trailing.bottom.top.equalToSuperview()
            make.width.equalTo(AnAnAppDevice.an_screenWidth()/2)
        }
    }
    
    
    @objc private func videoDownloadInfoNotifi(noti:Notification){
        let eipsiodeModel:EpisodeListModel = noti.userInfo?["episodeModel"] as? EpisodeListModel ?? EpisodeListModel()
        
//        进入到下载列表界面在进行下载操作更新下载的进度
        AnAnRequest.shared.requestVideoDownloadInfoData(seasonId: dramaId ?? "", episodeSid: eipsiodeModel.sid ?? "", quality: "SD") {[weak self] model in
            AnAnPlayerUrlParse.playerUrlParse(url: model?.m3u8?.url ?? "") { parseUrl in
                print("downloadUrl--->\(parseUrl)")
                let downloadModel = AnAnDownloadModel()
                downloadModel.fileId = self?.dramaId
//                downloadModel.movieSize = model?.m3u8?.size
                downloadModel.filePath = String.getFilePathWithUrl(url: parseUrl.videoFileName())
                downloadModel.fileName = parseUrl.videoFileName()
                downloadModel.movieCover = self?.dramaInfo?.cover
                downloadModel.movieTitle = self?.dramaInfo?.title
                downloadModel.episodeNo = eipsiodeModel.episodeNo
                AnAnDownloadData.shareDefault.downloadDataArray.append(downloadModel)
//                AnAnDownloadManager.shareDownloadInstance.addDownloadQueue(downloadFileUrl: AnAnDownloadPcdnUrl.shareDownloadPcdn.an_rewriteDownloadUrl(url: parseUrl))
            }
        }
    }
    
    @objc private func btnClick(btn:UIButton){
        selectBtnBlock!(btn)
    }
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
