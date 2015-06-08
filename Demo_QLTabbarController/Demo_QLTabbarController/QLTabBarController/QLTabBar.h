//
//  QLTabBar.h
//  Demo_QLTabbarController
//
//  Created by Temeier on 15/4/24.
//  Copyright (c) 2015年 Shrek. All rights reserved.
//

#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define QLColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

/** QLDEBUG Print | M:method, L:line, C:content*/
#ifdef DEBUG
#define QLLog(FORMAT, ...) fprintf(stderr,"M:%s|L:%d|C->%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define QLLog(FORMAT, ...)
#endif

#import <UIKit/UIKit.h>

@protocol QLTabBarDelegate;

@interface QLTabBar : UITabBar

@property (nonatomic, copy) void (^blkDidSelectAtIndex)(NSUInteger index);
@property (nonatomic, weak) id<QLTabBarDelegate> actionDelegate;

- (void)insertSpecifiedMiddleView:(UIButton *)btnSpecified;

@end

@protocol QLTabBarDelegate <NSObject>

@optional
- (void)tabBar:(UITabBar *)tabBar didSelectAtIndex:(NSUInteger)index;
- (void)tabBar:(UITabBar *)tabBar didSelectSpecifiedButton:(UIButton *)button;

@end
