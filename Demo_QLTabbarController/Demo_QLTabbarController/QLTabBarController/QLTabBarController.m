//
//  QLTabBarController.m
//  Demo_QLTabbarController
//
//  Created by Temeier on 15/4/23.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLTabBarController.h"

#define kHeightNavigationBar 64
#define kHeightTabBar 49

@interface QLTabBarController () <QLTabBarDelegate>
{
    UIViewController *_vcCurrent;
}

@end

@implementation QLTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
}

#pragma mark - 加载初始化配置
- (void)loadDefaultSetting {
    CGFloat fHeightDefault = kHeightTabBar;
    _tabBar = [[QLTabBar alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-fHeightDefault, self.view.frame.size.width, fHeightDefault)];
    _tabBar.actionDelegate = self;
    [self.view addSubview:_tabBar];
}

#pragma mark - 设置字控制器
- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated {
    _viewControllers = viewControllers;
    
    NSUInteger countViewControllers = _viewControllers.count;
    NSMutableArray *arrMTabBarItems = [NSMutableArray arrayWithCapacity:countViewControllers];
    for (NSUInteger index = 0; index < countViewControllers; index ++) {
        UITabBarItem *tabBarItem = [viewControllers[index] tabBarItem];
        tabBarItem.tag = index;
        [arrMTabBarItems addObject:tabBarItem];
        
        UIViewController *viewController = viewControllers[index];
        UIView *view = viewController.view;
        if ([view isKindOfClass:[UIView class]] && ![view isKindOfClass:[UIScrollView class]]) {
            CGSize sizeScreen = [UIScreen mainScreen].bounds.size;
            view.bounds = CGRectMake(0, -kHeightNavigationBar, sizeScreen.width, CGRectGetHeight(view.frame)-kHeightNavigationBar);
            view.frame = CGRectMake(0, 0, sizeScreen.width, sizeScreen.height);
        } else if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView *scrollView = (UIScrollView *)view;
            [scrollView setContentInset:UIEdgeInsetsMake(kHeightNavigationBar, 0, kHeightTabBar, 0)];
            [scrollView setScrollIndicatorInsets:scrollView.contentInset];
        }
        [self addChildViewController:viewController];
    }
    [_tabBar setItems:[arrMTabBarItems copy] animated:animated];
    [_tabBar setSelectedItem:[[arrMTabBarItems copy] firstObject]];
}

#pragma mark - 属性重写
- (void)setViewControllers:(NSArray *)viewControllers {
    _viewControllers = viewControllers;
    [self setViewControllers:viewControllers animated:NO];
}

#pragma mark - QLTabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectAtIndex:(NSUInteger)index {
    UIViewController *viewController = self.viewControllers[index]; // 多态的应用
    if (viewController == _vcCurrent) return ;
    if (_vcCurrent) {
        [_vcCurrent.view removeFromSuperview];
    }
    viewController.view.frame = [UIScreen mainScreen].bounds;
    [viewController.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight];
    [self.view addSubview:viewController.view];
    _vcCurrent = viewController;
    
    self.navigationItem.leftBarButtonItem = _vcCurrent.navigationItem.leftBarButtonItem;
    self.navigationItem.leftBarButtonItems = _vcCurrent.navigationItem.leftBarButtonItems;
    self.navigationItem.rightBarButtonItem = _vcCurrent.navigationItem.rightBarButtonItem;
    self.navigationItem.rightBarButtonItems = _vcCurrent.navigationItem.rightBarButtonItems;
    self.navigationItem.titleView = _vcCurrent.navigationItem.titleView;
    self.navigationItem.title = _vcCurrent.navigationItem.title;
    
    // 通知代理点击事件
    if ([_actionDelegate respondsToSelector:@selector(tabBarController:didSelectViewControllerAtIndex:)]) {
        [_actionDelegate tabBarController:self didSelectViewControllerAtIndex:index];
    }
    if ([_actionDelegate respondsToSelector:@selector(tabBarController:didSelectViewController:)]) {
        [_actionDelegate tabBarController:self didSelectViewController:_vcCurrent];
    }
    
    [self.view bringSubviewToFront:_tabBar];
}

@end
