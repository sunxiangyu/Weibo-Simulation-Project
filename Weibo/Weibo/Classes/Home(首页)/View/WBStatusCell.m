//
//  WBStatusCell.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/29.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBStatusCell.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "WBStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "WBPhoto.h"
#import "WBStatusToolbar.h"
#import "WBStatusPhotosView.h"
#import "WBStatusPhotoView.h"
#import "WBIconView.h"

@interface WBStatusCell()

/**  原创微博整体*/
@property(nonatomic, weak) UIView *originalView;

@property(nonatomic, weak) WBIconView *iconView;

@property(nonatomic, weak) UIImageView *vipView;

@property(nonatomic, weak) UILabel *nameLabel;

@property(nonatomic, weak) UILabel *sourceLabel;

@property(nonatomic, weak) UILabel *timeLabel;

@property(nonatomic, weak) UILabel *contentLabel;

@property(nonatomic, weak) WBStatusPhotosView *photosView;


@property(nonatomic, weak) UIView *retweetView;

@property(nonatomic, weak) UILabel *retweetContentLabel;

@property(nonatomic, weak) WBStatusPhotosView *retweetPhotosView;

@property(nonatomic, weak) WBStatusToolbar *toolbar;

@end

@implementation WBStatusCell

+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    WBStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[WBStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupOriginal];
        
        [self setupRetweet];
        
        [self setupToolbar];
    }
    return self;
}

-(void)setupToolbar
{
    WBStatusToolbar *toolbar = [WBStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

/**
 * 初始化转发微博
 */
-(void)setupRetweet
{
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = WBColor(240, 240, 240);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = kStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel = retweetContentLabel;
    
    
    WBStatusPhotosView *retweetPhotoView = [[WBStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotoView];
    self.retweetPhotosView = retweetPhotoView;
}

/**
 * 初始化原创微博
 */

- (void)setupOriginal
{
    UIView *originalView = [[UIView alloc] init];
    [self.contentView addSubview:originalView];
    self.originalView = originalView;
    
    /**头像 */
    WBIconView *iconView = [[WBIconView alloc] init];
    [originalView addSubview:iconView];
    self.iconView = iconView;
    
    /** 会员图标*/
    UIImageView *vipView = [[UIImageView alloc] init];
    vipView.contentMode = UIViewContentModeCenter;
    [originalView addSubview:vipView];
    self.vipView = vipView;
    
    WBStatusPhotosView *photoView = [[WBStatusPhotosView alloc] init];
    [originalView addSubview:photoView];
    self.photosView = photoView;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = kStatusCellNameFont;
    [originalView addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.font = kStatusCellTimeFont;
    [originalView addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = kStatusCellSourceFont;
    [originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
    
    UILabel *contentLabel = [[UILabel alloc] init];
    contentLabel.font = kStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [originalView addSubview:contentLabel];
    self.contentLabel = contentLabel;
}

-(void)setStatusFrame:(WBStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    WBStatus *status = statusFrame.status;
    WBUser *user = status.user;
    
    self.originalView.frame = statusFrame.orginViewF;
    
    self.iconView.frame = statusFrame.iconViewF;
    self.iconView.user = user;
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        
        self.nameLabel.textColor = [UIColor orangeColor];
        
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    if (status.pic_urls.count) {
        self.photosView.frame = statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    
    NSString *time =status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + kStatusCellBorderW;
    CGSize timeSize = [time sizeWithfont:kStatusCellTimeFont];
    self.timeLabel.frame = (CGRect){{timeX, timeY}, timeSize};
    self.timeLabel.text = time;
    
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabel.frame) + kStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithfont:kStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX, sourceY}, sourceSize};
    self.sourceLabel.text = status.source;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    
    //被转发的微博
    if (status.retweeted_status) {
        WBStatus *retweeted_status = status.retweeted_status;
        WBUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
            
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
    
    
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
}

@end
