//
//  WBStatus.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/27.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WBUser;

@interface WBStatus : NSObject

@property(nonatomic, copy) NSString *idstr;
@property(nonatomic, copy) NSString *text;
@property(nonatomic, strong) WBUser *user;

/** 来源 */
@property(nonatomic, copy) NSString *source;

@property(nonatomic, copy) NSString *created_at;

@property(nonatomic, strong) NSArray *pic_urls;

@property(nonatomic, strong) WBStatus *retweeted_status;

@property(nonatomic, assign) int reposts_count;

@property(nonatomic, assign) int comments_count;

@property(nonatomic, assign) int attitudes_count;

//+ (instancetype)statusWithDict:(NSDictionary *)dict;

@end
