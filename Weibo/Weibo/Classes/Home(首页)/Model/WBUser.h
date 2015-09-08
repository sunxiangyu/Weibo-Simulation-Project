//
//  WBUser.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/27.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    WBUserVerifiedTypeNone = -1,
    WBUserVerifiedTypePersonal = 0,
    
    WBUserVerifiedTypeOrgEnterprise = 2,
    WBUserVerifiedTypeOrgMedia = 3,
    WBUserVerifiedTypeOrgWebsite = 5,
    
    WBUserVerifiedTypeDaren = 220
    
} WBUserVerifiedType;

@interface WBUser : NSObject

@property(nonatomic, copy) NSString *idstr;

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *profile_image_url;

@property(nonatomic, assign) int mbtype;

@property(nonatomic, assign) int mbrank;

@property(nonatomic, assign, getter = isVip) BOOL vip;

@property(nonatomic, assign) WBUserVerifiedType verified_type;

//+(instancetype)userWithDict:(NSDictionary *)dict;

@end
