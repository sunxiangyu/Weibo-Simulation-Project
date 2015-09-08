//
//  WBAccountTool.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/24.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WBAccount.h"
@class WBAccount;

@interface WBAccountTool : NSObject

+ (void)saveAccount:(WBAccount *)account;

+ (WBAccount *)account;

@end
