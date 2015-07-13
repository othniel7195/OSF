//
//  OSFQuestionLatest.m
//  OSF
//
//  Created by 赵锋 on 15/7/8.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionLatest.h"
#import "OSFCellCollection.h"
#import <objc/message.h>
#import "OTableViewRefresh.h"
#import "OSFRefreshView.h"
@interface OSFQuestionLatest ()<OTableViewRefreshDelegate,OSFRefreshViewDelegate>

///自己得刷新类
@property(nonatomic, strong) OTableViewRefresh *orefreshControl;
///第一次  界面上没数据时的刷新控件
@property(nonatomic, strong) OSFRefreshView *osfRefreshView;

@end

@implementation OSFQuestionLatest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [OSFCellCollection registerQuestionCell:self.tableView];
    self.tableView.hidden=NO;
    [self.osfRefreshView o_startRefresh];
    
    [self.orefreshControl o_tableViewHeadRefresh:self.tableView];
    [self.orefreshControl o_tableViewFootRefresh:self.tableView];
    
    self.tableView.tableFooterView=[[UIView alloc] init];
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    [OLog showMessage:@"latest frame :%@",NSStringFromCGRect(self.view.bounds)];
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark --refresh table
-(OSFRefreshView *)osfRefreshView
{
    if (!_osfRefreshView) {
        OSFRefreshView *rv=[[OSFRefreshView alloc] initWithFrame:CGRectMake(0, -55, self.tableView.bounds.size.width,self.tableView.bounds.size.height-55)];
        rv.delegate=self;
        
        _osfRefreshView=rv;
        
        [self.view insertSubview:_osfRefreshView belowSubview:self.tableView];
    }
    
    return _osfRefreshView;
}

#pragma mark --refresh table
-(OTableViewRefresh *)orefreshControl
{
    if (!_orefreshControl) {
        OTableViewRefresh *refresh=[[OTableViewRefresh alloc] init];
        refresh.delegate=self;
        _orefreshControl=refresh;
    }
    return _orefreshControl;
}

-(void)o_loadNewData
{
    __weak OSFQuestionLatest * WEAKSELF = self;
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [WEAKSELF.orefreshControl o_endHeadRefresh:WEAKSELF.tableView];
    });
}
-(void)o_loadMoreData
{
    __weak OSFQuestionLatest * WEAKSELF = self;
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [WEAKSELF.orefreshControl o_endFootRefresh:WEAKSELF.tableView];
    });
}

#pragma mark  -- table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[OSFCellCollection cellForQuestion:tableView indexPath:indexPath answerNum:@"0" questionStatus:0 userName:@"赵锋" date:@"一天前" content:@"IOS的问题，天天天天天天天天我不知道如何打开keyboard得开关什么的 导致keyboard打不开，一片底色灰的"];
  
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static UITableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:QuestionCell];
    });
    
    CGFloat height=70.0;
    if([cell respondsToSelector:@selector(calulateHeight:)])
    {
        CGFloat (*action)(id, SEL, NSString*) = (CGFloat (*)(id, SEL, NSString*)) objc_msgSend;
        height =  action(cell, @selector(calulateHeight:), @"IOS的问题，天天天天天天天天我不知道如何打开keyboard得开关什么的 导致keyboard打不开，一片底色灰的");
      
    }

    return height;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

@end
