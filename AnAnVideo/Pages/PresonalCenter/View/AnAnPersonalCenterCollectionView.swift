//
//  AnAnPersonalCenterCollectionView.swift
//  AnAnVideo
//
//  Created by 陈庆 on 2023/3/7.
//

import UIKit

enum MenuType:Int {
    case MenuTypeLike//我的追剧
    case MenuTypeHelpFeedback//帮助与反馈
    case MenuTypeSetting //设置
}
enum PersionCenterSectionType {
    case PersionCenterSectionTypeHistory  //历史记录
    case PersionCenterSectionTypeOther //其他功能
}
class AnAnPersonalCenterCollectionView: UICollectionView {

    let anAnHeaderCollectionViewCellId = "AnAnHeaderCollectionViewCellId"
    let anAnHistoryCollectionViewCellId = "AnAnHistoryCollectionViewCellId"
    let anAnMenuCollectionViewCellId = "AnAnMenuCollectionViewCellId"
    let anAnPersonalSectionCollectionReusableViewId = "AnAnPersonalSectionCollectionReusableViewId"
    
    private lazy var sectionArray:[String] = {
        let array = [anAnHeaderCollectionViewCellId,anAnHistoryCollectionViewCellId,anAnMenuCollectionViewCellId]
        return array
    }()
    
    private lazy var menuArray:[AnAnPersonalCenterModel] = {
        let likeModel = createMenuModel(imgName: "ic_me_function_heart", title: "我的追剧", index: .MenuTypeLike)
        let helpFeedbackModel = createMenuModel(imgName: "ic_me_function_help", title: "帮助与反馈", index: .MenuTypeHelpFeedback)
        let settingModel = createMenuModel(imgName: "ic_me_function_install", title: "设置", index: .MenuTypeSetting)
        let array = [likeModel,helpFeedbackModel,settingModel]
        return array
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.delegate = self
        self.dataSource = self
        self.contentInsetAdjustmentBehavior = .never
        self.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.register(AnAnHeaderCollectionViewCell.self, forCellWithReuseIdentifier: anAnHeaderCollectionViewCellId)
        self.register(AnAnHistoryCollectionViewCell.self, forCellWithReuseIdentifier: anAnHistoryCollectionViewCellId)
        self.register(AnAnMenuCollectionViewCell.self, forCellWithReuseIdentifier: anAnMenuCollectionViewCellId)
        self.register(AnAnPersonalSectionCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: anAnPersonalSectionCollectionReusableViewId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createMenuModel(imgName:String?,title:String,index:MenuType) -> AnAnPersonalCenterModel {
        let model = AnAnPersonalCenterModel()
        model.iconImg = imgName
        model.titleLab = title
        model.index = index
        return model
    }
    
    
}
extension AnAnPersonalCenterCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cellType = sectionArray[section]
        if cellType == anAnMenuCollectionViewCellId{
            return menuArray.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnHeaderCollectionViewCellId {
            let cell:AnAnHeaderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnHeaderCollectionViewCellId, for: indexPath) as! AnAnHeaderCollectionViewCell
            cell.updateData()
            return cell
        }else if cellType == anAnHistoryCollectionViewCellId{
            let cell:AnAnHistoryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnHistoryCollectionViewCellId, for: indexPath) as! AnAnHistoryCollectionViewCell
            return cell
        }else{
            let cell:AnAnMenuCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: anAnMenuCollectionViewCellId, for: indexPath) as! AnAnMenuCollectionViewCell
            cell.ananPersonalModel = menuArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = sectionArray[indexPath.section]
        if(cellType == anAnHeaderCollectionViewCellId){
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 210+AnAnAppDevice.navigationBarHeight())
        }else if(cellType == anAnHistoryCollectionViewCellId){
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 110)
        }else{
            let width = Int((AnAnAppDevice.an_screenWidth()-60)/3)
            return CGSize(width: width, height: width*82/105)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if(kind == UICollectionView.elementKindSectionHeader){
            let cellType = sectionArray[indexPath.section]
            let view:AnAnPersonalSectionCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: anAnPersonalSectionCollectionReusableViewId, for: indexPath) as! AnAnPersonalSectionCollectionReusableView
            view.bounds = CGRect(x: 0, y: 0, width: AnAnAppDevice.an_screenWidth(), height: 34)
            if cellType == anAnHistoryCollectionViewCellId{
                view.titleLabel.text = "历史记录"
                view.arrowImg.isHidden = false
            }else if cellType == anAnMenuCollectionViewCellId{
                view.titleLabel.text = "其他功能"
                view.arrowImg.isHidden = true
            }
            
            return view
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let cellType = sectionArray[section]
        if cellType == anAnHeaderCollectionViewCellId{
            return CGSize.zero
        }else{
            return CGSize(width: AnAnAppDevice.an_screenWidth(), height: 34)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellType = sectionArray[indexPath.section]
        if cellType == anAnMenuCollectionViewCellId{
            let menuType = menuArray[indexPath.row]
            switch menuType.index {
            case .MenuTypeLike:
                print("我的追剧")
                break
            case .MenuTypeHelpFeedback:
                
                break
            case .MenuTypeSetting:
                AnAnJumpPageManager.goToSeetingPage()
                break
            default:
                break
            }
        }
    }
}
