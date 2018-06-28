//
//  HBTabView.m
//  HBTabView
//
//  Created by DylanHu on 2016/6/11.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import "HBTabView.h"
#import "HBSegmentBar.h"
#import "HBSegmentContentView.h"
#import "UIView+HHBExtension.h"

static CGFloat const kHorizontalBarH = 49;
static CGFloat const kVerticalBarW = 80;
@interface HBTabView ()
/// 顶部标题滚动栏
@property (nonatomic, strong) HBSegmentBar *segmentBar;
/// item对应的内容视图
@property (nonatomic, strong) HBSegmentContentView *segementContentView;
/// 管理当前View的控制器(这里用weak声明防止循环引用)
@property (nonatomic, weak) UIViewController *parentViewController;
/// 存储item及对应的内容视图信息
@property (nonatomic, strong) NSMutableDictionary <NSString *, UIViewController *> *itemsInfo;

@end

@implementation HBTabView
#pragma mark - Properties
- (NSMutableDictionary<NSString *,UIViewController *> *)itemsInfo {
    if (!_itemsInfo) {
        _itemsInfo = @{}.mutableCopy;
    }
    return _itemsInfo;
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    self.segmentBar.titleNormalColor = titleNormalColor;
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    self.segmentBar.titleSelectedColor = titleSelectedColor;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.segmentBar.indicatorColor = indicatorColor;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame parentViewController:(UIViewController *)parentViewController showType:(HBTabViewShowType)showType {
    if (self = [super initWithFrame:frame]) {
        self.parentViewController = parentViewController;
        if (@available(iOS 11.0, *)) {
            [self.segmentBar setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        } else {
            self.parentViewController.automaticallyAdjustsScrollViewInsets = NO; // 防止scrollView中的控件会偏移
        }
        self.tabViewShowType = showType;
        [self _commonInitWithFrame:frame showType:showType];
    }
    return self;
}

- (void)_commonInitWithFrame:(CGRect)frame showType:(HBTabViewShowType)showType {
    CGRect segmentBarFrame = CGRectZero;
    CGRect segementContentViewFrame = CGRectZero;
    if (self.tabViewShowType == HBTabViewShowTypeVertical) {
        segmentBarFrame = CGRectMake(0, 0, kVerticalBarW, frame.size.height);
        segementContentViewFrame = CGRectMake(kVerticalBarW, 0, frame.size.width - kVerticalBarW, frame.size.height);
    } else {
        segmentBarFrame = CGRectMake(0, 0, frame.size.width, kHorizontalBarH);
        segementContentViewFrame = CGRectMake(0, kHorizontalBarH, frame.size.width, frame.size.height - kHorizontalBarH);
    }
    _segmentBar = [[HBSegmentBar alloc] initWithFrame:segmentBarFrame showType:showType];
    _segementContentView = [[HBSegmentContentView alloc] initWithFrame:segementContentViewFrame showType:showType];
    [self addSubview:_segmentBar];
    [self addSubview:_segementContentView];
    [self handleSegmentBarAndContentViewScrollEvent];
}

#pragma mark - 添加item及contentView
- (void)addItemWithTitle:(nonnull NSString *)title containerViewWithViewController:(nonnull UIViewController *)viewController {
    if (![self.itemsInfo.allKeys containsObject:title] && title.length) {
        [self.itemsInfo setValue:viewController forKey:title];
        
        if (![self.parentViewController.childViewControllers containsObject:viewController] ) {
            [self.parentViewController addChildViewController:viewController];
        }
        
        [self.segmentBar addItemWithTitle:title];
        [self.segementContentView addContainerViewWithViewController:viewController];
    }
}

#pragma mark - segmentBar及ContView相关事件处理
- (void)handleSegmentBarAndContentViewScrollEvent {
    __weak typeof(self) weakSelf = self;
    // items被点击
    self.segmentBar.segmentBarItemsDidClicked = ^(UIButton * _Nonnull itemClicked, NSInteger index) {
        [weakSelf.segementContentView scrollToPageWithIndex:index];
    };
    // contentView停止拖拽
    self.segementContentView.segmentContentViewDidEndDragingBlock = ^(NSInteger currentPageIndex) {
        [weakSelf.segmentBar adjustIndictorPositionWithIndex:currentPageIndex];
    };
    
    self.segementContentView.segmentContentViewDidEndDisplayingCellBlock = ^(NSInteger currentPageIndex) {
        if (weakSelf.segmentBar.currentIndex != currentPageIndex) {
            [weakSelf.segementContentView scrollToPageWithIndex:currentPageIndex];
        }
    };
    
    self.segementContentView.segmentContentViewDidScrollBlock = ^(UIScrollView *scrollView, NSInteger fromIndex, NSInteger toIndex, CGFloat progress) {
        [weakSelf.segmentBar indicatorScrollFromIndex:fromIndex toIndex:toIndex progress:progress];
    };
    
    self.segementContentView.segmentContentViewDidEndDeceleratingBlock = ^(NSInteger currentPageIndex) {
        [weakSelf.segmentBar adjustIndictorPositionWithIndex:currentPageIndex];
    };

    self.segementContentView.segmentContentViewPanGestureBlock = ^(BOOL canPop) {
        UINavigationController *nav = weakSelf.parentViewController.navigationController;
        if (nav.interactivePopGestureRecognizer) {
            nav.interactivePopGestureRecognizer.enabled = canPop;
        }
    };
}

- (void)show {
    [self.segmentBar showItems];
    [self.segementContentView reloadData];
}

@end

