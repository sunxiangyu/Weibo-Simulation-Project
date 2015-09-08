//
//  WBEmotionTabBar.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/8.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBEmotionTabBarButtonTypeRecent,
    WBEmotionTabBarButtonTypeDefault,
    WBEmotionTabBarButtonTypeEmoji,
    WBEmotionTabBarButtonTypeLxh,
} WBEmotionTabBarButtonType;

@class WBEmotionTabBar;

@protocol WBEmotionTabBarDelegate <NSObject>

@optional
- (void)emotionTabBar:(WBEmotionTabBar *)taBar didClickButton:(WBEmotionTabBarButtonType)buttonType;

@end

@interface WBEmotionTabBar : UIView
@property(nonatomic, weak) id<WBEmotionTabBarDelegate> delegate;

@end
