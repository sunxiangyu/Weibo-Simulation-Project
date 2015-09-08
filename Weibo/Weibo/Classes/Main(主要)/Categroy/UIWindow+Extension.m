//
//  UIWindow+Extension.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/24.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "WBTabBarViewController.h"
#import "WBNewFeatureViewController.h"

@implementation UIWindow (Extension)

-(void)switchRootViewController
{
    NSString *key = @"CFBundleVersion";
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    if ([currentVersion isEqualToString:lastVersion]) {
        self.rootViewController = [[WBTabBarViewController alloc] init];
    } else {
        self.rootViewController = [[WBNewFeatureViewController alloc] init];
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
