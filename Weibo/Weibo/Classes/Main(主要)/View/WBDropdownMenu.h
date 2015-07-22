//
//  WBDropdownMenu.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/20.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WBDropdownMenu;

@protocol WBDropdownMenuDelegate <NSObject>
@optional
-(void)dropdownMenuDidDismiss:(WBDropdownMenu *)menu;
-(void)dropdownMenuDidshow:(WBDropdownMenu *)menu;

@end

@interface WBDropdownMenu : UIView

@property(nonatomic, strong) UIView *content;

@property(nonatomic, strong) UIViewController *contentController;

@property(nonatomic, weak) id<WBDropdownMenuDelegate> delegate;

+(instancetype)menu;

-(void)showFrom:(UIView *)from;

-(void)dismiss;

@end
