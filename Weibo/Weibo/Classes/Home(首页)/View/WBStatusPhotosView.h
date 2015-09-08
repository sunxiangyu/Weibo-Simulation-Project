//
//  WBStatusPhotosView.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/5.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WBStatusPhotosView : UIView

@property(nonatomic, strong) NSArray *photos;

+ (CGSize)sizeWithCount:(NSUInteger)count;

@end
