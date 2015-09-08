//
//  WBAccountTool.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/24.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#define kAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "WBAccountTool.h"

@implementation WBAccountTool

+ (void)saveAccount:(WBAccount *)account
{
    
    [NSKeyedArchiver archiveRootObject:account toFile:kAccountPath];
}

+(WBAccount *)account
{
    WBAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:kAccountPath];
    
    /** 验证账号是否过期  */
    long long expires_in = [account.expires_in longLongValue];
    
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    
    NSDate *now = [NSDate date];
    
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) {
        return nil;
    }
    return account;
}

@end
