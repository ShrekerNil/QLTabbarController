//
//  QLTabBarController.h
//  Demo_QLTabbarController
//
//  Created by Temeier on 15/4/23.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QLTabBar.h"

@protocol QLTabBarControllerDelegate;

@interface QLTabBarController : UIViewController

@property (nonatomic, readonly) QLTabBar *tabBar;
@property (nonatomic, assign) CGFloat tabBarHeight;
@property (nonatomic, strong) NSArray *viewControllers; // child Controllers
@property (nonatomic, weak) UIViewController *selectedViewController;
@property (nonatomic) NSUInteger selectedIndex;

@property (nonatomic, weak) id<QLTabBarControllerDelegate> actionDelegate;

- (void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated;

@end

@protocol QLTabBarControllerDelegate <NSObject>

@optional
- (void)tabBarController:(QLTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
- (void)tabBarController:(QLTabBarController *)tabBarController didSelectViewControllerAtIndex:(NSUInteger)index;
//- (BOOL)tabBarController:(QLTabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController;

//- (void)tabBarController:(QLTabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers NS_AVAILABLE_IOS(3_0);
//- (void)tabBarController:(QLTabBarController *)tabBarController willEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed NS_AVAILABLE_IOS(3_0);
//- (void)tabBarController:(QLTabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed;
//- (NSUInteger)tabBarControllerSupportedInterfaceOrientations:(QLTabBarController *)tabBarController NS_AVAILABLE_IOS(7_0);
//- (UIInterfaceOrientation)tabBarControllerPreferredInterfaceOrientationForPresentation:(QLTabBarController *)tabBarController NS_AVAILABLE_IOS(7_0);
//- (id <UIViewControllerInteractiveTransitioning>)tabBarController:(QLTabBarController *)tabBarController interactionControllerForAnimationController: (id <UIViewControllerAnimatedTransitioning>)animationController NS_AVAILABLE_IOS(7_0);
//- (id <UIViewControllerAnimatedTransitioning>)tabBarController:(QLTabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);

@end
