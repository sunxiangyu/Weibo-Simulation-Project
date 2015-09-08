//
//  WBUser.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/27.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBUser.h"

@implementation WBUser

- (void)setMbtype:(int)mbtype
{
    _mbtype = mbtype;
    
    self.vip = mbtype > 2;
}

//+(instancetype)userWithDict:(NSDictionary *)dict
//{
//    WBUser *user = [[WBUser alloc] init];
//    user.idstr = dict[@"idstr"];
//    user.name = dict[@"name"];
//    user.profile_image_url = dict[@"profile_image_url"];
//    return user;
//}

@end
