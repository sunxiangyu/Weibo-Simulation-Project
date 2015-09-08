//
//  WBEmotionTool.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/13.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBEmotion;

@interface WBEmotionTool : NSObject
+ (void)addRecentEmotion:(WBEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
