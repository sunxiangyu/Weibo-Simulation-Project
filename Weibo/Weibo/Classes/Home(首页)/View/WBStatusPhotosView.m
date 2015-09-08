//
//  WBStatusPhotosView.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/5.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBStatusPhotosView.h"
#import "WBPhoto.h"
#import "WBStatusPhotoView.h"

#define kStatusPhotoWH 70
#define kStatusphotoMargin 10
#define kStatusPhotoMaxCol(count) ((count==4)?2:3)

@implementation WBStatusPhotosView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    NSUInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        WBStatusPhotoView *photoView = [[WBStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    for (int i = 0; i < self.subviews.count; i++) {
        WBStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {
            photoView.hidden = NO;
            photoView.photo = photos[i];
        } else {
            photoView.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSUInteger photosCount = self.photos.count;
    int maxCol = kStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        WBStatusPhotoView *photoView = self.subviews[i];
        int col = i % maxCol;
        photoView.x = col * (kStatusPhotoWH + kStatusphotoMargin);
        
        int row = i / maxCol;
        photoView.y = row * (kStatusPhotoWH + kStatusphotoMargin);
        photoView.width = kStatusPhotoWH;
        photoView.height = kStatusPhotoWH;
    }
}

+ (CGSize)sizeWithCount:(NSUInteger)count
{
    NSUInteger maxCols = kStatusPhotoMaxCol(count);
    
    NSUInteger cols = (count >= maxCols) ? maxCols : count;
    CGFloat photosW = cols * kStatusPhotoWH + (cols - 1) * kStatusphotoMargin;
    
    NSUInteger rows = (count + maxCols - 1) / maxCols;
    CGFloat photosH = rows * kStatusPhotoWH + (rows - 1) * kStatusphotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

@end
