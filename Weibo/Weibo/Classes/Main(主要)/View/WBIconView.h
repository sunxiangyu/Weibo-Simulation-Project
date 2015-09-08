//
//  WBIconView.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/6.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBUser;

@interface WBIconView : UIImageView
@property(nonatomic, strong) WBUser *user;
@end
