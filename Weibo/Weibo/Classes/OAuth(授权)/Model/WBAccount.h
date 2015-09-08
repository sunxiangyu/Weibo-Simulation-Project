//
//  WBAccount.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/24.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WBAccount : NSObject<NSCoding>

@property(nonatomic, copy) NSString *access_token;

@property(nonatomic, copy) NSNumber *expires_in;

@property(nonatomic, copy) NSString *uid;

@property(nonatomic, strong) NSDate *created_time;

/**
 用户昵称
 */
@property(nonatomic, copy) NSString *name;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
