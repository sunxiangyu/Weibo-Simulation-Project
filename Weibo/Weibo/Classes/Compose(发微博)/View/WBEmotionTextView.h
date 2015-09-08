//
//  WBEmotionTextView.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/13.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBTextVIew.h"
@class WBEmotion;

@interface WBEmotionTextView : WBTextVIew
- (void)insertEmotion:(WBEmotion *)emotion;

- (NSString *)fullText;
@end
