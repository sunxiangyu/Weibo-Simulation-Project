//
//  NSString+Extension.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/5.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithfont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithfont:(UIFont *)font
{
    return [self sizeWithfont:font maxW:MAXFLOAT];
}


@end
