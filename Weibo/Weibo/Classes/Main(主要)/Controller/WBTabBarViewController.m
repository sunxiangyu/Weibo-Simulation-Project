//
//  WBTabBarViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/17.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBTabBarViewController.h"
#import "WBHomeViewController.h"
#import "WBDiscoverViewController.h"
#import "WBMessageCenterViewController.h"
#import "WBProfileViewController.h"
#import "WBNavigationController.h"
#import "WBTabBar.h"
#import "WBComposeViewController.h"

@interface WBTabBarViewController ()<WBTabBarDelegate>

@end

@implementation WBTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WBHomeViewController *home = [[WBHomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"tabbar_home" selectedImage:@"tabbar_home_selected"];
    
    WBMessageCenterViewController *messageCenter = [[WBMessageCenterViewController alloc] init];
    [self addChildVc:messageCenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    
    WBDiscoverViewController *discover = [[WBDiscoverViewController alloc] init];
    [self addChildVc:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    
    WBProfileViewController *profile = [[WBProfileViewController alloc] init];
    [self addChildVc:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    
    WBTabBar *tabBar = [[WBTabBar alloc] init];
    tabBar.delegate = self;
    [self setValue:tabBar forKeyPath:@"tabBar"];
    

}

- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image
     selectedImage:(NSString *)selectedImage
{
    childVc.tabBarItem.title = title;
    childVc.navigationItem.title = title;
    
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = WBColor(123, 123, 123);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
//    childVc.view.backgroundColor = WBRandomColor;
    
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}

#pragma mark - WBTabBarDelegate

- (void)tabBarDidClickPlusButton:(WBTabBar *)tabBar
{
    WBComposeViewController *compose = [[WBComposeViewController alloc] init];
    WBNavigationController *nav = [[WBNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
