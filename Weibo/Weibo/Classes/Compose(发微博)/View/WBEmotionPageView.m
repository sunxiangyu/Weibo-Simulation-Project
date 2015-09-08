//
//  WBEmotionPageView.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionPageView.h"
#import "WBEmotion.h"
#import "WBEmotionButton.h"
#import "WBEmotionPopView.h"
#import "WBEmotionTool.h"

@interface WBEmotionPageView()
@property (nonatomic, strong) WBEmotionPopView *popView;
@property (nonatomic, weak) UIButton *deleteButton;
@end

@implementation WBEmotionPageView

- (WBEmotionPopView *)popView
{
    if (!_popView) {
        self.popView = [WBEmotionPopView popView];
    }
    return _popView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:deleteButton];
        self.deleteButton = deleteButton;
        
        
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
        
    }
    return self;
}

- (WBEmotionButton *)emotionButtonWithLocation:(CGPoint)location
{
    NSUInteger count = self.emotions.count;
    for (int i = 0; i < count; i++) {
        WBEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            return btn;
        }
    }
    return nil;
}

/**
 * 处理长按手势
 */

- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:recognizer.view];
    WBEmotionButton *btn = [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateEnded:
            [self.popView removeFromSuperview];
            if (btn) {
                [WBEmotionTool addRecentEmotion:btn.emotion];
                
                NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
                userInfo[WBSelectEmotionKey] = btn.emotion;
                [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionDidSelectNotification object:nil userInfo:userInfo];
            }
            break;
        
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged:
            
            [self.popView showFrom:btn];
            break;
        default:
            break;
    }
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    NSUInteger count = emotions.count;
    for (int i = 0; i < count; i++) {
        WBEmotionButton *btn = [[WBEmotionButton alloc] init];
        [self addSubview:btn];
        
        btn.emotion = emotions[i];
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat inset = 20;
    NSUInteger count = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / kEmotionMaxCols;
    CGFloat btnH = (self.height - inset) / kEmotionMaxRows;
    for (int i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % kEmotionMaxCols) * btnW;
        btn.y = inset + (i / kEmotionMaxCols) * btnH;
        
    }
    
    self.deleteButton.x = self.width - btnW - inset;
    self.deleteButton.y = self.height - btnH;
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
}

#pragma mark - 点击监听

- (void)deleteClick
{
    [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionDidDeleteNotification object:nil];
}

- (void)btnClick:(WBEmotionButton *)btn
{
    [self.popView showFrom:btn];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    [WBEmotionTool addRecentEmotion:btn.emotion];
    
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[WBSelectEmotionKey] = btn.emotion;
    [[NSNotificationCenter defaultCenter] postNotificationName:WBEmotionDidSelectNotification object:nil userInfo:userInfo];
}

@end
