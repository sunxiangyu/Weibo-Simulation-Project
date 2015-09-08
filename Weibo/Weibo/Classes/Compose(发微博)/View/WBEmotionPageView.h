//
//  WBEmotionPageView.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/10.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kEmotionMaxRows 3
#define kEmotionMaxCols 7
#define kEmotionPageSize ((kEmotionMaxRows * kEmotionMaxCols) - 1)

@interface WBEmotionPageView : UIView

@property (nonatomic, strong) NSArray *emotions;

@end
