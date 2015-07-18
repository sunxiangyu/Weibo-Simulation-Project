//
//  WBMessageCenterViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/17.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBMessageCenterViewController.h"
#import "WBTest1ViewController.h"

@interface WBMessageCenterViewController ()

@end

@implementation WBMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style:UIBarButtonItemStylePlain target:self action:@selector(composeMsg)];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

-(void)composeMsg
{
    NSLog(@"composeMsg");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"message";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"text-message %ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 20;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBTest1ViewController *test1 = [[WBTest1ViewController alloc] init];
    test1.title = @"测试1控制器";
    [self.navigationController pushViewController:test1 animated:YES];
}



@end
