//
//  HBSegmentContentView.h
//  HBTabView
//
//  Created by DylanHu on 2016/6/21.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBConstant.h"

@interface HBSegmentContentView : UIView

/// UICollectionView结束拖拽回调
@property (nonatomic, copy) void (^segmentContentViewDidEndDragingBlock)(NSInteger currentPageIndex);
/// UICollectionViewCell显示结束回调
@property (nonatomic, copy) void (^segmentContentViewDidEndDisplayingCellBlock)(NSInteger currentPageIndex);
/// UICollectionView停止滚动回调
@property (nonatomic, copy) void (^segmentContentViewDidScrollBlock)(UIScrollView *scrollView, NSInteger fromIndex, NSInteger toIndex, CGFloat progress);
@property (nonatomic, copy) void (^segmentContentViewDidEndDeceleratingBlock)(NSInteger currentPageIndex);

@property (nonatomic, copy) void (^segmentContentViewPanGestureBlock)(BOOL canPop);

- (instancetype)initWithFrame:(CGRect)frame showType:(HBTabViewShowType)showType;

/**
 滚动到指定页面

 @param index 页面索引(collectionViewCell对应的indexPath.row)
 */
- (void)scrollToPageWithIndex:(NSInteger)index;

/**
 向container中添加单个控制器，其实是控制器的View，这里使用控制器更方便操作

 @param viewController UIViewController控制器
 */
- (void)addContainerViewWithViewController:(UIViewController *)viewController;

/**
 向container中添加批量控制器

 @param viewControllers 存储UIViewController对象的NSArray
 */
- (void)addContainerViewsWithViewControllers:(NSArray <UIViewController *> *)viewControllers;
- (void)reloadData;

@end


@interface HBCollectionView : UICollectionView

@property (nonatomic, copy) BOOL (^panGestureShouldBeginBlock)(UICollectionView *,UIPanGestureRecognizer *panGesture);

@end
