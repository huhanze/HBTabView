//
//  HBSegmentBar.h
//  HBTabView
//
//  Created by DylanHu on 2016/6/12.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBConstant.h"

NS_ASSUME_NONNULL_BEGIN

@interface HBSegmentBar : UIScrollView
/// 当前item的索引
@property (nonatomic, assign, readonly) NSInteger currentIndex;
/// 上一个被选中item的索引
@property (nonatomic, assign, readonly) NSInteger preIndex;
/// 当前被选中的item
@property (nonatomic, weak, readonly) UIButton *currentSelectedItem;
/// 上一个被选中的item
@property (nonatomic, weak, readonly) UIButton *preSelectedItem;
/// indicator
@property (nonatomic, strong, readonly) UIView *indicatorView;
/// 滚动条颜色
@property (nonatomic, strong) UIColor *indicatorColor;
/// item被选中时的title颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
/// item未被选中时的title颜色
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, assign) CGFloat maxItemWidth;

- (instancetype)initWithFrame:(CGRect)frame showType:(HBTabViewShowType)showType;

/// 被点击的item回调
@property (nonatomic, copy) void (^segmentBarItemsDidClicked)(UIButton *itemClicked, NSInteger index);

/**
 通过titles批量添加item，每个title为item的标题

 @param titles 一组标题
 */
- (void)addItemWithTitles:(NSArray <NSString *> *)titles;

/**
 添加单个item

 @param title item的title
 */
- (void)addItemWithTitle:(NSString *)title;

/**
展示items，需调用此方法来显示items
 */
- (void)showItems;

/**
 通过索引设置选中指定item

 @param index item索引
 */
- (void)selectItemWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END

