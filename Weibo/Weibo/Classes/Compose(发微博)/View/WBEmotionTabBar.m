//
//  WBEmotionTabBar.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/8.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionTabBar.h"
#import "WBEmotionTabbarButton.h"

@interface WBEmotionTabBar()
@property (nonatomic, weak) WBEmotionTabbarButton *selectedBtn;
@end

@implementation WBEmotionTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:WBEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:WBEmotionTabBarButtonTypeDefault];
        [self setupBtn:@"Emoji" buttonType:WBEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:WBEmotionTabBarButtonTypeLxh];
    }
    return self;
}

- (WBEmotionTabbarButton *)setupBtn:(NSString *)title buttonType:(WBEmotionTabBarButtonType)buttonType
{
    WBEmotionTabbarButton *btn = [[WBEmotionTabbarButton alloc] init];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = buttonType;
    [btn setTitle:title forState:UIControlStateNormal];
    [self addSubview:btn];
    
    if (buttonType == WBEmotionTabBarButtonTypeDefault) {
        [self btnClick:btn];
    }
    
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (self.subviews.count == 1) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    } else if (self.subviews.count == 4) {
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    
    return btn;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger btnCount = self.subviews.count;
    CGFloat btnW = self.width / btnCount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btnCount; i++) {
        WBEmotionTabbarButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = i * btnW;
        btn.width = btnW;
        btn.height = btnH;
    }
}

- (void)btnClick:(WBEmotionTabbarButton *)btn
{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didClickButton:)]) {
        [self.delegate emotionTabBar:self didClickButton:(WBEmotionTabBarButtonType)btn.tag];
    }
}

- (void)setDelegate:(id<WBEmotionTabBarDelegate>)delegate
{
    _delegate = delegate;
    
    [self btnClick:(WBEmotionTabbarButton *)[self viewWithTag:WBEmotionTabBarButtonTypeDefault]];
}

@end
