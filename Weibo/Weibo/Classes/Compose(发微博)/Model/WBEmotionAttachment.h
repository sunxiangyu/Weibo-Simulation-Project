//
//  WBEmotionAttachment.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/13.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBEmotion;

@interface WBEmotionAttachment : NSTextAttachment
@property (nonatomic, strong) WBEmotion *emotion;
@end
