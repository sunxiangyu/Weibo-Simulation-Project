//
//  WBIconView.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/6.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBIconView.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"

@interface WBIconView()
@property (nonatomic, weak) UIImageView *verifiedView;
@end

@implementation WBIconView

- (UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}

- (void)setUser:(WBUser *)user
{
    _user = user;
    
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    switch (user.verified_type) {
        case WBUserVerifiedTypePersonal:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        
        case WBUserVerifiedTypeOrgEnterprise:
        case WBUserVerifiedTypeOrgMedia:
        case WBUserVerifiedTypeOrgWebsite:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case WBUserVerifiedTypeDaren:
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

@end
