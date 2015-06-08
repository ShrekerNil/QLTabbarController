//
//  QLViewController.m
//  Demo_QLTabbarController
//
//  Created by Temeier on 15/4/23.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLViewController.h"
#import "QLTestViewController.h"
#import "QLTestTableViewController.h"

@interface QLViewController () <QLTabBarControllerDelegate, QLTabBarDelegate>

@end

@implementation QLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.actionDelegate = self;
    [self loadViewControllers];
    UIButton *btnMiddle = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnMiddle setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [btnMiddle setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
    [btnMiddle setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [btnMiddle setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [self.tabBar setActionDelegate:self];
    [self.tabBar insertSpecifiedMiddleView:btnMiddle];
}

- (void)loadViewControllers {
    QLTestViewController *vc1 = [[QLTestViewController alloc] init];
    vc1.view.backgroundColor = QLColorRandom;
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    QLTestTableViewController *vc2 = [[QLTestTableViewController alloc] init];
    vc2.view.backgroundColor = QLColorRandom;
    vc2.title = @"发现";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = QLColorRandom;
    vc3.title = @"消息";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = QLColorRandom;
    vc4.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
    
    [self setViewControllers:@[vc1, vc2, vc3, vc4] animated:NO];
}

#pragma mark - QLTabBarControllerDelegate
- (void)tabBarController:(QLTabBarController *)tabBarController didSelectViewControllerAtIndex:(NSUInteger)index {
    QLLog(@"%@", @(index));
}
- (void)tabBarController:(QLTabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    QLLog(@"%@", viewController);
}
#pragma mark - QLTabBarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectSpecifiedButton:(UIButton *)button {
    QLLog(@"%@", button);
    UIViewController *vcTest = [[UIViewController alloc] init];
    vcTest.view.backgroundColor = QLColorRandom;
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btnBack addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [vcTest.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:btnBack]];
    vcTest.title = @"测试";
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vcTest] animated:YES completion:nil];
}

- (void)cancelAction:(UIButton *)btn {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
