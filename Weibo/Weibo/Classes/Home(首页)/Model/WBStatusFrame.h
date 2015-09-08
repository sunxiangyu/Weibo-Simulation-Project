//
//  WBStatusFrame.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/29.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

// 昵称字体
#define kStatusCellNameFont [UIFont systemFontOfSize:15]
// 时间字体
#define kStatusCellTimeFont [UIFont systemFontOfSize:10]
// 来源字体
#define kStatusCellSourceFont [UIFont systemFontOfSize:10]
// 正文字体
#define kStatusCellContentFont [UIFont systemFontOfSize:14]

#define kStatusCellRetweetContentFont [UIFont systemFontOfSize:13]


#define kStatusCellMargin 15

#define kStatusCellBorderW 10

@class WBStatus;

@interface WBStatusFrame : NSObject

@property(nonatomic, strong) WBStatus *status;

@property(nonatomic, assign) CGRect orginViewF;

@property(nonatomic, assign) CGRect iconViewF;

@property(nonatomic, assign) CGRect vipViewF;

@property(nonatomic, assign) CGRect photosViewF;

@property(nonatomic, assign) CGRect nameLabelF;

@property(nonatomic, assign) CGRect timeLabelF;

@property(nonatomic, assign) CGRect sourceLabelF;

@property(nonatomic, assign) CGRect contentLabelF;


/** 转发微博 */
@property(nonatomic, assign) CGRect retweetViewF;

/** 正文 ＋ 昵称 */
@property(nonatomic, assign) CGRect retweetContentLabelF;

@property(nonatomic, assign) CGRect retweetPhotosViewF;

@property(nonatomic, assign) CGRect toolbarF;

@property(nonatomic, assign) CGFloat cellHeight;

@end
