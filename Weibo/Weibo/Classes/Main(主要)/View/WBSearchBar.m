//
//  WBSearchBar.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/20.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBSearchBar.h"

@implementation WBSearchBar

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"请输入搜索条件";
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
        
    }
    return self;
}

+(instancetype)searchBar
{
    return [[self alloc] init];
}

@end
