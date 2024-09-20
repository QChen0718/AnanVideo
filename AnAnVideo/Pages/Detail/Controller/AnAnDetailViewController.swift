//
//  AnAnDetailViewController.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/20.
//  详情

import UIKit
import MJRefresh

class AnAnDetailViewController: UIViewController {

    var videoDetailModel:AnAnDetailModel?{
        didSet{
            detailCollectionView.videoDetailModel = videoDetailModel
        }
    }
    
    var seconDarayModel:SeconDarayModel?{
        didSet{
            detailCollectionView.seconDraayModel = seconDarayModel
        }
    }
    
    var dramaIntroModel:DramaIntroModel?{
        didSet{
            detailCollectionView.dramaIntroModel = dramaIntroModel
        }
    }
    
    var dramaModuleModel:DramaModuleModel?{
        didSet{
            detailCollectionView.dramaModuleModel = dramaModuleModel
        }
    }
    
    var recommendModel:RecommendListModel?{
        didSet{
            detailCollectionView.recommendModel = recommendModel
        }
    }
    
    var playerManager:AnAnVideoPlayerManager?
    
    var loadMoreRecommentBlock:(()->Void)?
    
    private lazy var viewLayout:AnAnWaterFallFlowLayout = {
        let layout = AnAnWaterFallFlowLayout()
        return layout
    }()
    
    private lazy var detailCollectionView:AnAnVideoDetailCollectionView = {
        let collectionView = AnAnVideoDetailCollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .white
        collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingBlock: {[weak self] in
            guard let `self` else { return }
            self.loadMoreRecommentBlock?()
            collectionView.mj_footer?.endRefreshing()
        })
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createSubviews()
        setSubviewsFrame()
    }
    
    private func createSubviews() {
        view.addSubview(detailCollectionView)
    }
    
    private func setSubviewsFrame() {
        detailCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}

