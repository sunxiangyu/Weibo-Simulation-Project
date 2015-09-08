//
//  WBComposeToolbar.h
//  Weibo
//
//  Created by 孙翔宇 on 15/8/7.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WBComposeToolbarButtonTypeCamera,
    WBComposeToolbarButtonTypePicture,
    WBComposeToolbarButtonTypeMention,
    WBComposeToolbarButtonTypeTrend,
    WBComposeToolbarButtonTypeEmotion
    
} WBComposeToolbarButtonType;

@class WBComposeToolbar;

@protocol WBComposeToolbarDelegate <NSObject>

@optional
- (void)composeToolbar:(WBComposeToolbar *)toolbar didClickButton:(WBComposeToolbarButtonType)buttonType;

@end

@interface WBComposeToolbar : UIView

@property(nonatomic, weak) id<WBComposeToolbarDelegate> delegate;

@property (nonatomic, assign) BOOL showKeyboardButton;

@end
