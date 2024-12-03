//
//  AnAnHotRecommendTableViewCell.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/13.
//

import UIKit

class AnAnHotRecommendTableViewCell: UITableViewCell {
    lazy var searchCollection:AnAnSearchCollectionview = {
        let view = AnAnSearchCollectionview(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return view
    }()
    private var controllersArray:[UIViewController] = []
    private var currentScrollIndex:Int = 0
    private var oldScrollIndex:Int = 0
    
    lazy var pageControll: UIPageViewController = {
        let view = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewController.OptionsKey.spineLocation:0,UIPageViewController.OptionsKey.interPageSpacing:0])
        view.setViewControllers([], direction: .forward, animated: true)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .white
        contentView.addSubview(searchCollection)
        searchCollection.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AnAnHotRecommendTableViewCell:UIPageViewControllerDelegate,UIPageViewControllerDataSource{
//    上个界面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index:Int = controllersArray.firstIndex(of: viewController) ?? 0
//        第一页
        if index == 0 || index == NSNotFound{
            return nil
        }
        index-=1
        return controllersArray[index]
    }
//    下个界面
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        var index:Int = controllersArray.firstIndex(of: viewController) ?? 0
//        第一页
        if index == controllersArray.count-1 || index == NSNotFound{
            return nil
        }
        index+=1
        return controllersArray[index]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        let index:Int = controllersArray.firstIndex(of: pendingViewControllers.first ?? UIViewController()) ?? 0
        currentScrollIndex = index
        print("index----->\(currentScrollIndex)")
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if(completed){
//            sengmentCollectionView.selectIndex = currentScrollIndex
            oldScrollIndex = currentScrollIndex
        }
    }
}
