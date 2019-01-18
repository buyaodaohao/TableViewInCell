//
//  PullListTableView.m
//  TableViewInCell
//
//  Created by 云联智慧 on 2018/9/17.
//  Copyright © 2018年 云联智慧. All rights reserved.
//

#import "PullListTableView.h"

@implementation PullListTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = self;
        self.dataSource = self;
        self.count = 0;
        self.limit = 20;
        // 1.下拉刷新
        self.estimatedRowHeight =0;
        
        self.estimatedSectionHeaderHeight =0;
        
        self.estimatedSectionFooterHeight =0;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing:)];
        
        [header setTitle:@"下拉加载更多数据" forState:MJRefreshStateIdle];
        [header setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
        [header setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
        [header setTitle:@"松开加载更多数据" forState:MJRefreshStatePulling];
        header.lastUpdatedTimeLabel.text = @"刷新时间";
        self.mj_header = header;
        // 设置自动切换透明度(在导航栏下面自动隐藏)
        self.mj_header.automaticallyChangeAlpha = YES;
        //    // 2.上拉加载更多
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing:)];
        [footer setTitle:@"上拉加载更多数据" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载数据" forState:MJRefreshStateRefreshing];
        [footer setTitle:@"没有更多数据" forState:MJRefreshStateNoMoreData];
        [footer setTitle:@"松开加载更多数据" forState:MJRefreshStatePulling];
        self.mj_footer  = footer;
        
        
    }
    return self;
}
-(void)setFooterNil
{
    self.mj_footer = nil;
}
- (void)setupRefresh
{
    
    //自动刷新
    
    [self.mj_header beginRefreshing];
    
    //
    
}
-(void)setHeaderColor:(UIColor *)headerColor
{
    _headerColor = headerColor;
    self.mj_header.backgroundColor = headerColor;
}
-(void)setFooterColor:(UIColor *)footerColor
{
    _footerColor = footerColor;
    self.mj_footer.backgroundColor = footerColor;
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing:(PullListTableView *)tableview
{
    [self getHeaderRereshing:[self viewWithTag:self.tag]];
    
}

- (void)footerRereshing:(PullListTableView *)tableview
{
    self.count = self.count +self.limit;
    
    [self getFooterRereshing:self];
    
}
-(void)getHeaderRereshing:(PullListTableView *)tableview
{
    
    if (_pullListDelegate&&[_pullListDelegate respondsToSelector:@selector(getHeaderRereshing:)]) {
        [_pullListDelegate getHeaderRereshing:self];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getHeaderRereshed: self];
        });
        
        
    }
}
-(void)getFooterRereshing:(PullListTableView *)tableview
{
    if (_pullListDelegate&&[_pullListDelegate respondsToSelector:@selector(getFooterRereshing:)]) {
        [_pullListDelegate getFooterRereshing:self];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getFooterRereshed: self];
        });
        
    }
}
-(void)getHeaderRereshed:(PullListTableView *)tableview
{
    if (_pullListDelegate&&[_pullListDelegate respondsToSelector:@selector(getHeaderRereshed:)]) {
        
        [_pullListDelegate getHeaderRereshed: self];
        
    }
}
-(void)endHeaderFresh
{
    [self reloadData];
    [self.mj_header endRefreshing];
    self.count = 0;
}
-(void)endFooterFresh
{
    [self reloadData];
    
    [self.mj_footer endRefreshing];
}
-(void)getFooterRereshed:(PullListTableView *)tableview
{
    if (_pullListDelegate&&[_pullListDelegate respondsToSelector:@selector(getFooterRereshed:)]) {
        
        [_pullListDelegate getFooterRereshed:self];
        
    }
}
//tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  0;
}

@end
