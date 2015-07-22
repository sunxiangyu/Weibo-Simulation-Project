//
//  WBDropdownMenu.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/20.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBDropdownMenu.h"

@interface WBDropdownMenu ()

@property(nonatomic, weak) UIView *containerView;

@end
@implementation WBDropdownMenu

-(UIView *)containerView
{
    if (_containerView == nil) {
        UIImageView *containerView = [[UIImageView alloc] init];
        containerView.image = [UIImage imageNamed:@"popover_background"];
        containerView.userInteractionEnabled = YES;
        [self addSubview:containerView];
        self.containerView = containerView;
    }
    return _containerView;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu
{
    return [[self alloc] init];
}

-(void)setContent:(UIView *)content
{
    _content = content;
    
    content.x = 10;
    content.y = 15;
    
    self.containerView.width = CGRectGetMaxX(content.frame) + 10;
    self.containerView.height = CGRectGetMaxY(content.frame) + 11;
    
    [self.containerView addSubview:content];
}

- (void)setContentController:(UIViewController *)contentController
{
    _contentController = contentController;
    
    self.content = contentController.view;
}

-(void)showFrom:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    [window addSubview:self];
    
    self.frame = window.bounds;
    
    CGRect newFrame = [from convertRect:from.bounds toView:window];
    
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidshow:)]) {
        [self.delegate dropdownMenuDidshow:self];
    }
}

-(void)dismiss
{
    [self removeFromSuperview];
    
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}


@end
