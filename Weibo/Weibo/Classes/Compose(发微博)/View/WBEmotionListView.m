//
//  WBEmotionListView.m
//  Weibo
//
//  Created by 孙翔宇 on 15/8/8.
//  Copyright (c) 2015年 孙翔宇. All rights reserved.
//

#import "WBEmotionListView.h"
#import "WBEmotionPageView.h"


@interface WBEmotionListView()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation WBEmotionListView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.delegate = self;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.userInteractionEnabled = NO;
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

- (void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    NSUInteger count = (emotions.count + kEmotionPageSize - 1) / kEmotionPageSize;
    
    self.pageControl.numberOfPages = count;
    
    for (int i = 0; i < count; i++) {
        WBEmotionPageView *pageView = [[WBEmotionPageView alloc] init];
        NSRange range;
        range.location = i * kEmotionPageSize;
        NSUInteger left = emotions.count - range.location;
        if (left >= kEmotionPageSize) {
            range.length = kEmotionPageSize;
        } else {
            range.length = left;
        }
        
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.pageControl.width = self.width;
    self.pageControl.height = 25;
    self.pageControl.x = 0;
    self.pageControl.y = self.height - self.pageControl.height;
    
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        WBEmotionPageView *pageView = self.scrollView.subviews[i];
        pageView.width = self.scrollView.width;
        pageView.height = self.scrollView.height;
        pageView.x = i * pageView.width;
        pageView.y = 0;
    }
    
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (int)(page + 0.5);
}

@end
