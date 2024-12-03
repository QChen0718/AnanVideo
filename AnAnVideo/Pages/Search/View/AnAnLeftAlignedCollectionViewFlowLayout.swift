//
//  AnAnLeftAlignedCollectionViewFlowLayout.swift
//  AnAnVideo
//
//  Created by chenqing on 2024/11/28.
//

import UIKit

class AnAnLeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 获取当前区域内的所有布局属性
        guard let attributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        // 深拷贝布局属性，避免直接修改系统布局
        var updatedAttributes = [UICollectionViewLayoutAttributes]()
        
        // 记录当前行的最右端坐标
        var _: CGFloat = sectionInset.left
        
        for attribute in attributes {
            if attribute.representedElementCategory == .cell {
                let previousAttributes = updatedAttributes.last
                
                // 判断是否能与上一项放在同一行
                let itemWidth = attribute.frame.width
                let itemSpacing = minimumInteritemSpacing
                
                if let previous = previousAttributes {
                    // 如果当前项和上一项总宽度大于一行宽度，则换行
                    if previous.frame.maxX + itemSpacing + itemWidth > collectionView!.frame.width - sectionInset.right {
                        // 换行，当前项的 x 坐标从左边开始
                        var frame = attribute.frame
                        frame.origin.x = sectionInset.left
                        attribute.frame = frame
                    } else {
                        // 同一行，继续靠前排列
                        var frame = attribute.frame
                        frame.origin.x = previous.frame.maxX + itemSpacing
                        attribute.frame = frame
                    }
                } else {
                    // 第一项，直接放到左侧
                    var frame = attribute.frame
                    frame.origin.x = sectionInset.left
                    attribute.frame = frame
                }
                
                updatedAttributes.append(attribute)
            } else {
                updatedAttributes.append(attribute)
            }
        }
        
        return updatedAttributes
    }
}
