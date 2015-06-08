//
//  QLMainViewController.m
//  Demo_QLTabbarController
//
//  Created by Temeier on 15/4/27.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#import "QLMainViewController.h"
#import "QLTestViewController.h"
#import "QLTestTableViewController.h"

#define kColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define kColorRandom kColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

@interface QLMainViewController ()

@end

@implementation QLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadViewControllers];
}

- (void)loadViewControllers {
    QLTestViewController *vc1 = [[QLTestViewController alloc] init];
    vc1.view.backgroundColor = kColorRandom;
    vc1.title = @"首页";
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected"];
    
    QLTestTableViewController *vc2 = [[QLTestTableViewController alloc] init];
    vc2.view.backgroundColor = kColorRandom;
    vc2.title = @"发现";
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected"];
    
    UIViewController *vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = kColorRandom;
    vc3.title = @"消息";
    vc3.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected"];
    
    UIViewController *vc4 = [[UIViewController alloc] init];
    vc4.view.backgroundColor = kColorRandom;
    vc4.title = @"我";
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_profile"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_profile_selected"];
    
    [self setViewControllers:@[vc1, vc2, vc3, vc4] animated:NO];
}

@end
