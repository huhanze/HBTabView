//
//  HBSegmentBar.m
//  HBTabView
//
//  Created by DylanHu on 2016/6/12.
//  Copyright © 2016年 DylanHu. All rights reserved.
//

#import "HBSegmentBar.h"
#import "UIView+HHBExtension.h"

static const NSInteger kBaseItemTag = 10000;
@interface HBSegmentBar ()
@property (nonatomic, assign) HBTabViewShowType showType;
/// tabItems,这里使用的UIButton，当然可以自定义其他的控件
@property (nonatomic, strong) NSMutableArray <UIButton *> *items;
/// 线性indicator
@property (nonatomic, strong) UIView *indicatorView;
/// 当前item的索引
@property (nonatomic, assign) NSInteger currentIndex;
/// 前一个item的索引
@property (nonatomic, assign) NSInteger preIndex;
/// 最后一个item的索引
@property (nonatomic, assign) NSInteger lastItemIndex;
/// 当前选中的item
@property (nonatomic, weak) UIButton *currentSelectedItem;
/// 上一个被选中的item
@property (nonatomic, weak) UIButton *preSelectedItem;
@property (nonatomic, strong) CALayer *seperatorLine;


@end

@implementation HBSegmentBar

#pragma mark - Properties
- (NSMutableArray<UIButton *> *)items {
    if (!_items) {
        _items = @[].mutableCopy;
    }
    return _items;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.backgroundColor = self.indicatorColor ? self.indicatorColor : [UIColor redColor];
    }
    if (![self.subviews containsObject:_indicatorView]) {
        [self addSubview:_indicatorView];
    }
    return _indicatorView;
}

- (CALayer *)seperatorLine {
    if (!_seperatorLine) {
        _seperatorLine = [[CALayer alloc] init];
        _seperatorLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    }
    if (![self.layer.sublayers containsObject:_seperatorLine]) {
        [self.layer addSublayer:_seperatorLine];
    }
    return _seperatorLine;
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame showType:(HBTabViewShowType)showType {
    if (self = [super initWithFrame:frame]) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.showType = showType;
    }
    return self;
}

- (instancetype)initWithItems:(NSArray <UIButton *> *)items {
    if (self = [super init]) {
        [self.items addObjectsFromArray:items];
    }
    return self;
}

#pragma mark - 添加item
- (void)addItemWithTitle:(NSString *)title {
    UIButton *btn = [self createDefaultButtonWithTitle:title];
    [self addItemWithButton:btn];
//    [self setFrameForItemsWithSize:self.bounds.size];
}

- (void)addItemWithTitles:(NSArray <NSString *> *)titles {
    for (NSString *title in titles) {
        [self addItemWithTitle:title];
    }
}

- (UIButton *)createDefaultButtonWithTitle:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:self.titleNormalColor ? self.titleNormalColor : [UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitleColor:self.titleSelectedColor ? self.titleSelectedColor : [UIColor redColor] forState:UIControlStateSelected];
    btn.adjustsImageWhenHighlighted = NO;
    btn.titleLabel.font = [UIFont systemFontOfSize:15];

    return btn;
}

- (void)addItemWithButton:(UIButton *)button {
    if (!button || ![button isKindOfClass:[UIButton class]]) {
        return;
    }
    
    button.tag = kBaseItemTag + self.items.count;
    [self.items addObject:button];
}

#pragma mark 显示items
/* 添加完items后，调用该方法将设置items的frame */
- (void)showItems {
    [self setFrameForItemsWithSize:self.bounds.size];
}

- (void)setFrameForItemsWithSize:(CGSize)size {
    NSInteger count = self.items.count;
    self.lastItemIndex = count - 1;
    if (!count) {
        return;
    }
    
    for (int i = 0; i < count; ++i) {
        UIButton *preBtn = nil;
        UIButton *curBtn = self.items[i];
        if (i > 0) {
            preBtn = self.items[i-1];
        }
        
        [curBtn.titleLabel sizeToFit];
        [curBtn sizeToFit];
        
        CGFloat margin = 10;
        CGFloat btnX = CGRectGetMaxX(preBtn.frame) + margin;
        CGFloat btnY = (size.height - curBtn.bounds.size.height) * 0.5;
        if (self.showType == HBTabViewShowTypeVertical) {
            btnX = (size.width - curBtn.bounds.size.width) * 0.5;
            btnY = CGRectGetMaxY(preBtn.frame) + margin;
        }
        if (self.showType == HBTabViewShowTypeVertical) {
            curBtn.frame = CGRectMake(margin, btnY, size.width - margin * 2, curBtn.bounds.size.height);
        } else {
            curBtn.frame = CGRectMake(btnX, btnY, curBtn.bounds.size.width, curBtn.bounds.size.height);
        }
        [curBtn addTarget:self action:@selector(itemTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:curBtn];
    }
    if (self.showType == HBTabViewShowTypeVertical) {
        self.contentSize = CGSizeMake(self.contentSize.width, CGRectGetMaxY(self.items.lastObject.frame) + 10);
    } else {
        self.contentSize = CGSizeMake(CGRectGetMaxX(self.items.lastObject.frame) + 10, self.contentSize.height);
    }
    [self setPositionForSeperatorLine];
    [self setDefaultPositionForIndicator];
}

#pragma mark item点击事件
- (void)itemTouchUpInside:(UIButton *)sender {
    NSInteger index = sender.tag - kBaseItemTag;
    [self selectItemWithIndex:index];
    if (self.segmentBarItemsDidClicked) {
        self.segmentBarItemsDidClicked(sender,index);
    }
}

- (void)setPositionForIndicatorView {
    if (self.showType == HBTabViewShowTypeVertical) {
        self.indicatorView.hb_right = self.currentSelectedItem.hb_left;
    } else {
        self.indicatorView.hb_top = self.currentSelectedItem.hb_bottom;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        if (self.showType == HBTabViewShowTypeVertical) {
            self.indicatorView.hb_centerY = self.currentSelectedItem.hb_centerY;
            self.indicatorView.hb_height = self.currentSelectedItem.titleLabel.hb_height;
            self.indicatorView.hb_width = 3;
        } else {
            self.indicatorView.hb_left = self.currentSelectedItem.hb_left;
            self.indicatorView.hb_width = self.currentSelectedItem.hb_width;
            self.indicatorView.hb_height = 3;
        }
    }];
}

- (void)setPositionForSeperatorLine {
    if (self.showType == HBTabViewShowTypeVertical) {
        self.seperatorLine.frame = CGRectMake(self.bounds.size.width - 0.8, 0, 0.8, self.contentSize.height);
    } else {
        self.seperatorLine.frame = CGRectMake(0, self.bounds.size.height - 0.8, self.contentSize.width, 0.8);
    }
}

- (void)setDefaultPositionForIndicator {
    [self selectItemWithIndex:0];
    if (self.showType == HBTabViewShowTypeVertical) {
        self.indicatorView.hb_centerY = self.currentSelectedItem.hb_centerY;
    } else {
        self.indicatorView.hb_centerX = self.currentSelectedItem.hb_centerX;
    }
}

- (void)selectItemWithIndex:(NSInteger) index{
    if (index >= self.items.count) {
        return;
    }
    UIButton *sender = self.items[index];
    if (self.currentSelectedItem) {
        self.preSelectedItem = self.currentSelectedItem;
        self.preIndex = self.currentSelectedItem.tag - kBaseItemTag;
        self.currentSelectedItem.selected = NO;
        self.currentSelectedItem = nil;
    }
    self.currentIndex = index;
    self.currentSelectedItem = sender;
    sender.selected = YES;
    [self setPositionForIndicatorView];
    if (self.currentIndex != self.preIndex) {
        [self setScrollPositionWithIndex:index];
    }
}

#pragma mark - 设置scrollView的公洞位置
- (void)setScrollPositionWithIndex:(NSInteger)index {
    UIButton *item = self.items[index];
    CGFloat offsetX = item.center.x - self.bounds.size.width * 0.5;
    CGFloat maxOffsetX = self.contentSize.width - self.bounds.size.width;
    CGFloat offsetY = item.center.y - self.bounds.size.height * 0.5;;
    CGFloat maxOffsetY = self.contentSize.height - self.bounds.size.height;
    if (self.showType == HBTabViewShowTypeVertical) {
        offsetX = 0;
        offsetY = offsetY < 0 ? 0 : offsetY;
        maxOffsetY = maxOffsetY < 0 ? 0 : maxOffsetY;
        offsetY = offsetY > maxOffsetY ? maxOffsetY : offsetY;
    } else {
        offsetY = 0;
        offsetX = offsetX < 0 ? 0 : offsetX;
        maxOffsetX = maxOffsetX < 0 ? 0 : maxOffsetX;
        offsetX = offsetX > maxOffsetX ? maxOffsetX : offsetX;
    }
    
    [self setContentOffset:CGPointMake(offsetX, offsetY) animated:YES];
}

@end



