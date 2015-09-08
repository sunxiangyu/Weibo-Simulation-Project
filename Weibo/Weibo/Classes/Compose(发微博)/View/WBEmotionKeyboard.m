//
//  WBEmotionKeyboard.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/8.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionKeyboard.h"
#import "WBEmotionListView.h"
#import "WBEmotionTabBar.h"
#import "WBEmotion.h"
#import "MJExtension.h"
#import "WBEmotionTool.h"

@interface WBEmotionKeyboard() <WBEmotionTabBarDelegate>

@property (nonatomic, weak) WBEmotionListView *showingListView;

@property (nonatomic, strong) WBEmotionListView *recentListView;
@property (nonatomic, strong) WBEmotionListView *defaultListView;
@property (nonatomic, strong) WBEmotionListView *emojiListView;
@property (nonatomic, strong) WBEmotionListView *lxhListView;

@property (nonatomic, weak) WBEmotionTabBar *tabBar;
@end

@implementation WBEmotionKeyboard

#pragma mark - 懒加载
- (WBEmotionListView *)recentListView
{
    if (!_recentListView) {
        self.recentListView = [[WBEmotionListView alloc] init];
        self.recentListView.emotions = [WBEmotionTool recentEmotions];
    }
    return _recentListView;
}

- (WBEmotionListView *)defaultListView
{
    if (!_defaultListView) {
        self.defaultListView = [[WBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        self.defaultListView.emotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defaultListView;
}

- (WBEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        self.emojiListView = [[WBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        self.emojiListView.emotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (WBEmotionListView *)lxhListView
{
    if (!_lxhListView) {
        self.lxhListView = [[WBEmotionListView alloc] init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        self.lxhListView.emotions = [WBEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        WBEmotionTabBar *tabBar = [[WBEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        self.tabBar = tabBar;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(emotionDidSelect) name:WBEmotionDidSelectNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.tabBar.width = self.width;
    self.tabBar.height = 37;
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    
    self.showingListView.x = self.showingListView.y = 0;
    self.showingListView.width = self.width;
    self.showingListView.height = self.tabBar.y;
    
    
}

- (void)emotionDidSelect
{
    self.recentListView.emotions = [WBEmotionTool recentEmotions];
}

- (void)emotionTabBar:(WBEmotionTabBar *)taBar didClickButton:(WBEmotionTabBarButtonType)buttonType
{
    [self.showingListView removeFromSuperview];
    switch (buttonType) {
        case WBEmotionTabBarButtonTypeRecent: {
            [self addSubview:self.recentListView];
            break;
        }
        case WBEmotionTabBarButtonTypeDefault: {
            [self addSubview:self.defaultListView];
            break;
        }
        case WBEmotionTabBarButtonTypeEmoji: {
            [self addSubview:self.emojiListView];
            break;
        }
        case WBEmotionTabBarButtonTypeLxh: {
            [self addSubview:self.lxhListView];
            break;
        }
    }
    self.showingListView = [self.subviews lastObject];
    
    [self setNeedsLayout];
}


@end
