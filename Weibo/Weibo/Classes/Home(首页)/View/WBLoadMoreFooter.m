//
//  WBLoadMoreFooter.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/27.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBLoadMoreFooter.h"

@implementation WBLoadMoreFooter

+ (instancetype)footer
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WBLoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
