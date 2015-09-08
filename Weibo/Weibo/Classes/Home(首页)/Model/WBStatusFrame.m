//
//  WBStatusFrame.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/29.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBStatusFrame.h"
#import "WBUser.h"
#import "WBStatus.h"
#import "WBStatusPhotosView.h"



@implementation WBStatusFrame


-(void)setStatus:(WBStatus *)status
{
    _status = status;
    
    WBUser *user = status.user;
    
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat iconWH = 35;
    CGFloat iconX = kStatusCellBorderW;
    CGFloat iconY = kStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + kStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithfont:kStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX, nameY}, nameSize};
    
    if (user.isVip) {
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + kStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + kStatusCellBorderW;
    CGSize timeSize = [status.created_at sizeWithfont:kStatusCellTimeFont];
    self.timeLabelF = (CGRect){{timeX, timeY}, timeSize};
    
    CGFloat sourceX = CGRectGetMaxX(self.timeLabelF) + kStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithfont:kStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX, sourceY}, sourceSize};
    
    
    CGFloat contentX =iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.timeLabelF)) + kStatusCellBorderW;
    CGFloat maxW = cellW - 2 * kStatusCellBorderW;
    CGSize contentSize = [status.text sizeWithfont:kStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX, contentY}, contentSize};
    
    /** 配图*/
    CGFloat originalH = 0;
    if (status.pic_urls.count) {
        CGSize photosSize = [WBStatusPhotosView sizeWithCount:status.pic_urls.count];
        CGFloat photosX = contentX;
        CGFloat photosY = CGRectGetMaxY(self.contentLabelF) + kStatusCellBorderW;
        self.photosViewF = (CGRect){{photosX, photosY}, photosSize};
        
        originalH = CGRectGetMaxY(self.photosViewF) + kStatusCellBorderW;
    } else {
        originalH = CGRectGetMaxY(self.contentLabelF) + kStatusCellBorderW;
    }
    
    
    /** 原创微博整体 */
    CGFloat originalX = 0;
    CGFloat originalY = kStatusCellMargin;
    CGFloat originalW = cellW;
    self.orginViewF = CGRectMake(originalX, originalY, originalW, originalH);
    
    CGFloat toolbarY = 0;
    /** 被转发微博 */
    if (status.retweeted_status) {
        WBStatus *retweeted_status = status.retweeted_status;
        WBUser *retweeted_status_user = retweeted_status.user;
        
        CGFloat retweetContentX = kStatusCellBorderW;
        CGFloat retweetContentY = kStatusCellBorderW;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@", retweeted_status_user.name, retweeted_status.text];
        CGSize retweetContentSize = [retweetContent sizeWithfont:kStatusCellRetweetContentFont maxW:maxW];
        self.retweetContentLabelF = (CGRect){{retweetContentX, retweetContentY}, retweetContentSize};
        
        
        CGFloat retweetH = 0;
        if (retweeted_status.pic_urls.count) {
            CGSize retweetPhotosSize = [WBStatusPhotosView sizeWithCount:retweeted_status.pic_urls.count];
            CGFloat retweetPhotosX = retweetContentX;
            CGFloat retweetPhotosY = CGRectGetMaxY(self.retweetContentLabelF) + kStatusCellBorderW;
            self.retweetPhotosViewF =(CGRect){{retweetPhotosX, retweetPhotosY},retweetPhotosSize};
            
            retweetH = CGRectGetMaxY(self.retweetPhotosViewF) + kStatusCellBorderW;
        } else {
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) + kStatusCellBorderW;
        }
        
        /**被转发微博整体 */
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.orginViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    } else {
        toolbarY = CGRectGetMaxY(self.orginViewF);
    }
    
    /** 工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

@end
