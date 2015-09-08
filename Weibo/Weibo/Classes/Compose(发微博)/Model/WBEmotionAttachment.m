//
//  WBEmotionAttachment.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/13.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionAttachment.h"
#import "WBEmotion.h"

@implementation WBEmotionAttachment

- (void)setEmotion:(WBEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}

@end
