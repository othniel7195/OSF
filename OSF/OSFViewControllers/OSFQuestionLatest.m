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
#import "OSFQuestionLatest.h"
#import "QuestionLatestHandle.h"
#import "OSFQuestionModel.h"
#import "OTypes.h"
@interface OSFQuestionLatest ()<OTableViewRefreshDelegate,OSFRefreshViewDelegate,UIScrollViewDelegate>

///自己得刷新类
@property(nonatomic, strong) OTableViewRefresh *orefreshControl;
///第一次  界面上没数据时的刷新控件
@property(nonatomic, strong) OSFRefreshView *osfRefreshView;
///最新问题操作
@property(nonatomic, strong) QuestionLatestHandle *qLatestHandle;

@end

@implementation OSFQuestionLatest

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [OSFCellCollection registerQuestionCell:self.tableView];
    [self.osfRefreshView o_startRefresh];
    
    //tableView上什么数据都没的时候禁止滚动
    self.tableView.scrollEnabled=NO;
    
    [self.orefreshControl o_tableViewHeadRefresh:self.tableView];
    [self.orefreshControl o_tableViewFootRefresh:self.tableView];
    
    self.tableView.tableFooterView=[[UIView alloc] init];
    
    [self stepLastestQuestionNetWork:ONetWorkFirst];
    
    
    
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- scrollView delegate

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    NSValue *value =[NSValue valueWithCGPoint:velocity];
        
    [[NSNotificationCenter defaultCenter] postNotificationName:tableRolling object:value];
}


#pragma mark -- 网络操作

-(void)stepLastestQuestionNetWork:(ONetWorkState)networkState
{
    
    [self.qLatestHandle startNetWorking];
    
    __weak typeof(self) weakSelf = self;
    self.qLatestHandle.successBlock = ^{
        
        switch (networkState) {
            case ONetWorkFirst:
            {
                weakSelf.tableView.scrollEnabled=YES;
                [weakSelf.tableView reloadData];
                [weakSelf.osfRefreshView  o_endRefresh];
                [weakSelf.osfRefreshView removeFromSuperview];
            }
                break;
            case ONetWorkTopPull:
            {
                
                [weakSelf.tableView reloadData];
                [weakSelf.orefreshControl o_endHeadRefresh:weakSelf.tableView];
            }
                break;
            case ONetWorkBottomPull:
            {
                [weakSelf.tableView reloadData];
                [weakSelf.orefreshControl o_endFootRefresh:weakSelf.tableView];
            }
                break;
        }
        
    };
    
    self.qLatestHandle.failureBlock = ^{
        
        switch (networkState) {
            case ONetWorkFirst:
            {
               [weakSelf.osfRefreshView  o_endRefresh];
            }
                break;
            case ONetWorkTopPull:
            {
                [weakSelf.orefreshControl o_endHeadRefresh:weakSelf.tableView];
            }
                break;
            case ONetWorkBottomPull:
            {
                [weakSelf.orefreshControl o_endFootRefresh:weakSelf.tableView];
            }
                break;
        }
    };
   
}


-(QuestionLatestHandle *)qLatestHandle
{
    if (_qLatestHandle==nil) {
        
        QuestionLatestHandle *handle =[[QuestionLatestHandle alloc] init];
        
        _qLatestHandle=handle;
    }
    
    return _qLatestHandle;
}
#pragma mark -- first refresh table
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

-(void)OSFRefreshViewReloadData
{
    
    [self stepLastestQuestionNetWork:ONetWorkFirst];
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
    
    self.qLatestHandle.qLatestNet.page=@"1";
    [self stepLastestQuestionNetWork:ONetWorkTopPull];
}
-(void)o_loadMoreData
{
    self.qLatestHandle.qLatestNet.page=[NSString stringWithFormat:@"%ld",self.qLatestHandle.pageModel.next];
    [self stepLastestQuestionNetWork:ONetWorkBottomPull];
}

#pragma mark  -- table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.qLatestHandle.questionArrs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSFQuestionModel *QModel=[self.qLatestHandle questionWithIndex:indexPath.row];
    NSInteger questionStatus=0;
    if (QModel.answers>0) {
        
        if (QModel.isAccepted==1) {
            questionStatus=2;
        }else{
            questionStatus=1;
        }
        
    }else{
        questionStatus=0;
    }
    
    NSString *createdDate=QModel.lastAnswer.createdDate;
    if (createdDate==nil) {
        createdDate=QModel.createdDate;
    }
    
    UITableViewCell *cell=[OSFCellCollection cellForQuestion:tableView indexPath:indexPath answerNum:[NSString stringWithFormat:@"%ld",QModel.answers] questionStatus:questionStatus userName:QModel.user.name date:createdDate content:QModel.title];
  
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
        OSFQuestionModel *QModel=[self.qLatestHandle questionWithIndex:indexPath.row];
        
        CGFloat (*action)(id, SEL, NSString*) = (CGFloat (*)(id, SEL, NSString*)) objc_msgSend;
        height =  action(cell, @selector(calulateHeight:), QModel.title);
    }

    return height;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OSFQuestionModel *QModel=[self.qLatestHandle questionWithIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:questionCellSelected object:[NSNumber numberWithLongLong:QModel.index]];
    
}

#pragma mark --delloc
-(void)dealloc
{
    [OLog showMessage:@"question latest 释放了"];
}

@end
