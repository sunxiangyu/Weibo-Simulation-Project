//
//  WBMenuTitleViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/20.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBMenuTitleViewController.h"

@interface WBMenuTitleViewController ()

@end

@implementation WBMenuTitleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = @"好友";
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"同学";
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"家人";
    }
    
    return cell;
}


@end
