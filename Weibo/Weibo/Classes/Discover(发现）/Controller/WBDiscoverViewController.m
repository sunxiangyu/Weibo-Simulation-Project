//
//  WBDiscoverViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/17.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBDiscoverViewController.h"
#import "WBSearchBar.h"

@interface WBDiscoverViewController ()

@end

@implementation WBDiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WBSearchBar *searchBar = [WBSearchBar searchBar];
    searchBar.width = 340;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}


@end
