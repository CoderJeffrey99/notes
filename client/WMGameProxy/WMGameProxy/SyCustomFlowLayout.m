//
//  SyCustomFlowLayout.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2020/3/13.
//  Copyright © 2020 zali. All rights reserved.
//

#import "SyCustomFlowLayout.h"

@implementation SyCustomFlowLayout
// 什么时候调用：UICollectionView第一次布局/UICollectionView刷新
// 作用：计算cell的布局/cell的位置固定不变
// 默认只会调用一次/除非在此刷新
- (void)prepareLayout {
    // 必须调用super
    [super prepareLayout];
    
}

/*
 ！！！最常用！！！
 1.UICollectionViewLayoutAttributes - 确定cell的尺寸/操作cell
 2.什么时候调用：返回"指定一段区域内cell的尺寸"/当超过该区域会改变rect继续调用该方法
 3.作用：返回"指定一段区域内cell的尺寸"/可以一次性全部返回/可以每隔一段距离返回
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
//    // 1、每隔一段距离返回（rect系统自动设置）
//    NSArray *array = [super layoutAttributesForElementsInRect:rect];
//    // 2、获取当前显示cell的布局
//    NSArray *array = [super layoutAttributesForElementsInRect:self.collectionView.bounds];
    // 3、一次性全部返回（手动rect设置无穷大）
    NSArray *array = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, MAXFLOAT, MAXFLOAT)];
    for (UICollectionViewLayoutAttributes *attr in array) {
        attr.transform = CGAffineTransformMakeScale(0.5, 0.5);
    }
    return array;
}

/*
 BOOL是否
 should允许
 */
// 作用：在滚动的时候是否允许刷新布局
// 默认选择NO
// Invalidate
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return NO;
}

// 什么时候调用：用户手指一松开就会调用
// 作用：确定最终偏移量（指的是最终停止时候的偏移量，不是手指离开时候的偏移量：手指一松开如果速度过快还会有惯性）
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    // 如果返回(0, 0)则每次松手都会返回到原处
    return [super targetContentOffsetForProposedContentOffset:proposedContentOffset withScrollingVelocity:velocity];
}

// 作用：计算UICollectionView滚动范围
- (CGSize)collectionViewContentSize {
    return [super collectionViewContentSize];
}

@end
