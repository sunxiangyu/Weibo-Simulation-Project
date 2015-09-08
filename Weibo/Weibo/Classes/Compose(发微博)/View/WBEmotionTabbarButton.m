//
//  WBEmotionTabbarButton.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionTabbarButton.h"

@implementation WBEmotionTabbarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateHighlighted];
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted
{
    
}

@end
