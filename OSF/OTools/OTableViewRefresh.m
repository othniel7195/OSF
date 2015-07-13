//
//  OTableViewRefresh.m
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OTableViewRefresh.h"
#import "MJRefresh.h"

@interface OTableViewRefresh ()

@end

@implementation OTableViewRefresh

-(instancetype)init
{
    self=[super init];
    if (self) {
        
    }
    return self;
}

-(void)o_tableViewHeadRefresh:(UITableView *)tableView
{
    tableView.header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
}

-(void)o_tableViewFootRefresh:(UITableView *)tableView
{
    tableView.footer=[MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

-(void)o_beginingHeadToRefresh:(UITableView *)tableView
{
    [tableView.header beginRefreshing];
}
-(void)o_beginingFootToRefresh:(UITableView *)tableView
{
    [tableView.footer beginRefreshing];
}

-(void)o_endHeadRefresh:(UITableView *)tableView
{
    [tableView.header endRefreshing];
}
-(void)o_endFootRefresh:(UITableView *)tableView
{
    [tableView.footer endRefreshing];
}

-(void)loadNewData
{
    if ([self.delegate respondsToSelector:@selector(o_loadNewData)]) {
        [self.delegate o_loadNewData];
    }
}
-(void)loadMoreData
{
    if ([self.delegate respondsToSelector:@selector(o_loadMoreData)]) {
        [self.delegate o_loadMoreData];
    }
}
@end
