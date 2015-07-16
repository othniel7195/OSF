//
//  OSFRefreshView.h
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseView.h"
@protocol OSFRefreshViewDelegate ;

@interface OSFRefreshView : OSFBaseView
///刷新的信息
@property(nonatomic, copy) NSString * oRefreshInfo;
@property(nonatomic, weak) id<OSFRefreshViewDelegate> delegate;

@property(nonatomic, assign) BOOL canTouch;

-(void)o_startRefresh;
-(void)o_endRefresh;

@end


@protocol OSFRefreshViewDelegate <NSObject>

-(void)OSFRefreshViewReloadData;

@end