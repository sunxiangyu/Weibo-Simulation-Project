//
//  WBEmotion.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotion.h"
#import "MJExtension.h"

@implementation WBEmotion

MJCodingImplementation

- (BOOL)isEqual:(WBEmotion *)other
{
    return [self.chs isEqualToString:other.chs] || [self.code isEqualToString:other.code];
}

@end
