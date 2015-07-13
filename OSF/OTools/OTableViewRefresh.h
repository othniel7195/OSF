//
//  OTableViewRefresh.h
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol OTableViewRefreshDelegate;

@interface OTableViewRefresh : NSObject

@property(nonatomic, weak) id<OTableViewRefreshDelegate> delegate;

///下拉刷新
-(void)o_tableViewHeadRefresh:(UITableView *)tableView;
///上拉刷新
-(void)o_tableViewFootRefresh:(UITableView *)tableView;
///手动开始刷新
-(void)o_beginingHeadToRefresh:(UITableView *)tableView;
-(void)o_beginingFootToRefresh:(UITableView *)tableView;
///结束刷新
-(void)o_endHeadRefresh:(UITableView *)tableView;
-(void)o_endFootRefresh:(UITableView *)tableView;
@end

@protocol OTableViewRefreshDelegate <NSObject>

@optional
///加载新数据
-(void)o_loadNewData;
///加载更多数据
-(void)o_loadMoreData;

@end