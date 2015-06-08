//
//  QLTabBar.m
//  Demo_QLTabbarController
//
//  Created by Temeier on 15/4/24.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLTabBar.h"

@interface QLTabBar () <UITabBarDelegate>
{
    BOOL _hasSpecifiedMiddleView;
    __weak UIButton *_btnSpecified;
}

@end

@implementation QLTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadUI];
    }
    return self;
}

#pragma mark - 加载子视图
- (void)loadUI {
    self.delegate = self;
}

#pragma mark - UITabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    NSInteger indexSelected = -1;
    if ([_actionDelegate respondsToSelector:@selector(tabBar:didSelectAtIndex:)]) {
        indexSelected = [self selectedIndexWithItem:item];
        [_actionDelegate tabBar:self didSelectAtIndex:indexSelected];
    }
    
    if (indexSelected != -1) {
        if (_blkDidSelectAtIndex) {
            _blkDidSelectAtIndex(indexSelected);
        }
    }
    
}

- (NSUInteger)selectedIndexWithItem:(UITabBarItem *)item {
    NSArray *arrItems = self.items;
    NSUInteger count = arrItems.count;
    for (NSUInteger index = 0; index < count; index ++) {
        if (item == arrItems[index]) {
            return index;
        }
    }
    return 0;
}


- (void)insertSpecifiedMiddleView:(UIButton *)btnSpecified {
    if (btnSpecified) {
        _hasSpecifiedMiddleView = YES;
        [btnSpecified addTarget:self action:@selector(specifiedButtonClickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btnSpecified];
        _btnSpecified = btnSpecified;
        [self layoutIfNeeded];
    } else {
        _hasSpecifiedMiddleView = NO;
        [_btnSpecified removeFromSuperview];
    }
}

- (void)specifiedButtonClickAction:(UIButton *)button {
    if ([_actionDelegate respondsToSelector:@selector(tabBar:didSelectSpecifiedButton:)]) {
        [_actionDelegate tabBar:self didSelectSpecifiedButton:button];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (_hasSpecifiedMiddleView) {
        NSString *strUITabBarButton = @"UITabBarButton";
        NSArray *arrSubViews = self.subviews;
        NSUInteger countSubviews = arrSubViews.count;
        NSUInteger countTabBarItem = 0;
        for (NSUInteger index = 0; index < countSubviews; index ++) {
            UIView *child = arrSubViews[index];
            if ([child isKindOfClass:NSClassFromString(strUITabBarButton)]) {
                countTabBarItem ++;
            }
        }
        NSUInteger indexCurrent = 0;
        CGFloat fXBtnSpecified = 0;
        CGRect rectChild;
        for (NSUInteger index = 0; index < countSubviews; index ++) {
            UIView *child = arrSubViews[index];
            if ([child isKindOfClass:NSClassFromString(strUITabBarButton)]) {
                rectChild = child.frame;
                rectChild.size.width = self.frame.size.width / (countTabBarItem + 1);
                if (index >= (countTabBarItem / 2) + 1) {
                    rectChild.origin.x = (indexCurrent + 1) *rectChild.size.width;
                } else {
                    rectChild.origin.x = indexCurrent *rectChild.size.width;
                }
                child.frame = rectChild;
                if ((countTabBarItem / 2) == index) {
                    fXBtnSpecified = CGRectGetMaxX(child.frame);
                }
                indexCurrent ++;
            }
        }
        //  布局中间的View
        CGRect rectBtnSpecified = CGRectMake(fXBtnSpecified, 0, rectChild.size.width, self.frame.size.height);
        _btnSpecified.frame = rectBtnSpecified;
    }
}

- (void)setSelectedItem:(UITabBarItem *)selectedItem {
    [super setSelectedItem:selectedItem];
    if ([_actionDelegate respondsToSelector:@selector(tabBar:didSelectAtIndex:)]) {
        [_actionDelegate tabBar:self didSelectAtIndex:selectedItem.tag];
    }
}

@end
