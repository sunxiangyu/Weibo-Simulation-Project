//
//  WBStatusCell.h
//  Weibo
//
//  Created by 孙翔宇 on 15/7/29.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WBStatusFrame;

@interface WBStatusCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property(nonatomic, strong) WBStatusFrame *statusFrame;

@end
