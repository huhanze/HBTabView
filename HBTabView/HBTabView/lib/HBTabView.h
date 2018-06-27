//
//  HBTabView.h
//  HBTabView
//
//  Created by DylanHu on 2016/6/11.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HBConstant.h"

@interface HBTabView : UIView

/// tabView展示方式(垂直布局、水平布局)
@property (nonatomic, assign) HBTabViewShowType tabViewShowType;
/// 滚动条颜色
@property (nonatomic, strong) UIColor *indicatorColor;
/// item被选中时的title颜色
@property (nonatomic, strong) UIColor *titleSelectedColor;
/// item未被选中时的title颜色
@property (nonatomic, strong) UIColor *titleNormalColor;


/**
 初始化方法

 @param frame 控件frame
 @param parentViewController 控件之所在的控制器
 @param showType 展示方式，垂直布局或水平布局
 @return HBTabView视图对象
 */
- (instancetype)initWithFrame:(CGRect)frame
         parentViewController:(UIViewController *)parentViewController
                     showType:(HBTabViewShowType)showType;

/**
 添加单个item及对应的contentView

 @param title item的标题
 @param viewController item所对应的内容视图
 */
- (void)addItemWithTitle:(nonnull NSString *)title containerViewWithViewController:(nonnull UIViewController *)viewController;

/**
 显示tabView
 */
- (void)show;

@end


