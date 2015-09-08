//
//  WBStatusToolbar.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/30.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBStatus;

@interface WBStatusToolbar : UIView

@property(nonatomic, strong) WBStatus *status;

+ (instancetype)toolbar;

@end
