//
//  WBEmotionButton.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/13.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionButton.h"
#import "WBEmotion.h"

@implementation WBEmotionButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.titleLabel.font = [UIFont systemFontOfSize:32];
}

- (void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } else if (emotion.code) {
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
    }
}

@end
