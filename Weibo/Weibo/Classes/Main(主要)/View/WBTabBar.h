//
//  WBTabBar.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/20.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBTabBar;

@protocol WBTabBarDelegate <UITabBarDelegate>
@optional

- (void)tabBarDidClickPlusButton:(WBTabBar *)tabBar;

@end

@interface WBTabBar : UITabBar

@property(nonatomic, weak) id<WBTabBarDelegate> delegate;

@end
