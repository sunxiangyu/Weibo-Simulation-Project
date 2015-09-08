//
//  WBHomeViewController.m
//  Weibo
//
//  Created by 孙翔宇 on 15/7/17.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBHomeViewController.h"
#import "WBDropdownMenu.h"
#import "WBMenuTitleViewController.h"
#import "AFNetworking.h"
#import "WBAccountTool.h"
#import "WBTitleButton.h"
#import "WBStatus.h"
#import "WBUser.h"
#import "UIImageView+WebCache.h"
#import "MJExtension.h"
#import "WBLoadMoreFooter.h"
#import "WBStatusFrame.h"
#import "WBStatusCell.h"

@interface WBHomeViewController ()<WBDropdownMenuDelegate>

@property (nonatomic, strong) NSMutableArray *statuseFrames;

@end

@implementation WBHomeViewController

-(NSMutableArray *)statuseFrames
{
    if (_statuseFrames == nil) {
        _statuseFrames = [NSMutableArray array];
    }
    return _statuseFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = WBColor(211, 211, 211);
    
    [self setupNav];
    
    [self setupUserInfo];
    
//    [self loadNewStatus];
    
    [self setupDownRefresh];
    
    [self setupUpRefresh];
    
//    NSTimer *timer = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(setupUnreadCount) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

/**
 * 获得未读数
 */

-(void)setupUnreadCount
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://rm.api.weibo.com/2/remind/unread_count.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *status = [responseObject[@"status"] description];
        
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        } else {
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"请求失败 -- %@", error);
    }];
}

-(void)setupUpRefresh
{
    WBLoadMoreFooter *footer = [WBLoadMoreFooter footer];
    footer.hidden = YES;
    self.tableView.tableFooterView = footer;
}

-(void)setupDownRefresh
{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    [control beginRefreshing];
    
    [self loadNewStatus:control];
}

- (NSArray *)statusFrameWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (WBStatus *status in statuses) {
        WBStatusFrame *f = [[WBStatusFrame alloc] init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

-(void)loadNewStatus:(UIRefreshControl *)control
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    WBStatusFrame *firstStatusF = [self.statuseFrames firstObject];
    if (firstStatusF) {
        params[@"since_id"] = firstStatusF.status.idstr;
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        NSArray *newStatuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFrameWithStatuses:newStatuses];
        
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statuseFrames insertObjects:newFrames atIndexes:set];
        
        [self.tableView reloadData];
        
        [control endRefreshing];
        
        [self showNewStatusCount:newFrames.count];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"%@", error);
        [control endRefreshing];
    }];

}

-(void)showNewStatusCount:(NSUInteger)count
{
//    self.tabBarItem.badgeValue = nil;
//    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    label.y = 64 - label.height;
    if (count == 0) {
        label.text = @"没有新的微博数据";
    } else {
        label.text = [NSString stringWithFormat:@"共有%ld条微博数据", count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        [UIView animateKeyframesWithDuration:1.0 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}


-(void)loadMoreStatus
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    
    WBStatusFrame *lastStatusF = [self.statuseFrames lastObject];
    if (lastStatusF) {
        long long maxId = lastStatusF.status.idstr.longLongValue - 1;
        params[@"max_id"] = @(maxId);
    }
    
    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *newStatuses = [WBStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        NSArray *newFrames = [self statusFrameWithStatuses:newStatuses];
        
        [self.statuseFrames addObjectsFromArray:newFrames];
        
        
        [self.tableView reloadData];
        
        self.tableView.tableFooterView.hidden = YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"%@", error);
        self.tableView.tableFooterView.hidden = YES;
    }];
}
/**
 设置用户昵称
 */
-(void)setupUserInfo
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    WBAccount *account = [WBAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    [mgr GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        WBUser *user = [WBUser objectWithKeyValues:responseObject];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        account.name = user.name;
        [WBAccountTool saveAccount:account];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        WBLog(@"%@", error);
    }];
}

-(void)setupNav
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendSearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
//    WBTitleButton *titleButton = [[WBTitleButton alloc] init];
    UIButton *titleButton = [[UIButton alloc] init];
    titleButton.width = 300;
    titleButton.height = 30;
    NSString *name = [WBAccountTool account].name;
    [titleButton setTitle:name?name:@"首页" forState:UIControlStateNormal];
    [titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    titleButton.imageView.backgroundColor = [UIColor clearColor];
    CGFloat titleW = titleButton.titleLabel.width *[UIScreen mainScreen].scale;
    CGFloat imageW = titleButton.imageView.width * [UIScreen mainScreen].scale;
    CGFloat left = titleW + imageW;
    titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, left, 0, 0);
    
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;

}

-(void)titleClick:(UIButton *)titileButton
{
    WBDropdownMenu *dropdownMenu = [WBDropdownMenu menu];
    dropdownMenu.delegate = self;
    
    WBMenuTitleViewController *vc = [[WBMenuTitleViewController alloc] init];
    vc.view.height = 150;
    vc.view.width = 150;
    dropdownMenu.contentController = vc;
    
    [dropdownMenu showFrom:titileButton];
}

#pragma mark - WBDropdownMenuDelegate

-(void)dropdownMenuDidshow:(WBDropdownMenu *)menu
{
    UIButton *titleButton =(UIButton *) self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
}

- (void)dropdownMenuDidDismiss:(WBDropdownMenu *)menu
{
    UIButton *titleButton =(UIButton *) self.navigationItem.titleView;
    [titleButton setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
}

-(void)friendSearch
{
    NSLog(@"friendSearch");
}

-(void)pop
{
    NSLog(@"pop");
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuseFrames.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusCell *cell = [WBStatusCell cellWithTableView:tableView];
    
    cell.statusFrame = self.statuseFrames[indexPath.row];
    
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.statuseFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) {
        return;
    }
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat judgeOffSetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffSetY) {
        self.tableView.tableFooterView.hidden = NO;
        
        [self loadMoreStatus];
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBStatusFrame *frame = self.statuseFrames[indexPath.row];
    
    return frame.cellHeight;
}

@end
