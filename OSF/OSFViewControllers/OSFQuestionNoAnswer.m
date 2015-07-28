//
//  OSFQuestionNoAnswer.m
//  OSF
//
//  Created by 赵锋 on 15/7/9.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionNoAnswer.h"
#import "OSFCellCollection.h"
#import <objc/message.h>
#import "OTableViewRefresh.h"
#import "OSFRefreshView.h"
#import "QuestionNoAnswerHandle.h"
#import "OSFQuestionModel.h"
#import "OTypes.h"
@interface OSFQuestionNoAnswer ()<OTableViewRefreshDelegate,OSFRefreshViewDelegate,UIScrollViewDelegate>
///自己得刷新类
@property(nonatomic, strong) OTableViewRefresh *orefreshControl;
///第一次  界面上没数据时的刷新控件
@property(nonatomic, strong) OSFRefreshView *osfRefreshView;
///最热问题操作
@property(nonatomic, strong) QuestionNoAnswerHandle *qNoAnswerHandle;

@end

@implementation OSFQuestionNoAnswer

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
    
    [self stepNoAnswerQuestionNetWork:ONetWorkFirst];

    
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

-(void)stepNoAnswerQuestionNetWork:(ONetWorkState)networkState
{
    
    [self.qNoAnswerHandle startNetWorking];
    
    __weak typeof(self) weakSelf = self;
    self.qNoAnswerHandle.successBlock = ^{
        
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
    
    self.qNoAnswerHandle.failureBlock = ^{
        
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

-(QuestionNoAnswerHandle *)qNoAnswerHandle
{
    if (_qNoAnswerHandle==nil) {
        
        QuestionNoAnswerHandle *handle=[[QuestionNoAnswerHandle alloc] init];
        
        _qNoAnswerHandle=handle;
    }
    return _qNoAnswerHandle;
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
    
    [self stepNoAnswerQuestionNetWork:ONetWorkFirst];
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
    
    self.qNoAnswerHandle.qNoAnswerNet.page=@"1";
    [self stepNoAnswerQuestionNetWork:ONetWorkTopPull];
}
-(void)o_loadMoreData
{
    self.qNoAnswerHandle.qNoAnswerNet.page=[NSString stringWithFormat:@"%ld",self.qNoAnswerHandle.pageModel.next];
    [self stepNoAnswerQuestionNetWork:ONetWorkBottomPull];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.qNoAnswerHandle.questionArrs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    OSFQuestionModel *QModel=[self.qNoAnswerHandle questionWithIndex:indexPath.row];
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
        OSFQuestionModel *QModel=[self.qNoAnswerHandle questionWithIndex:indexPath.row];
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
    OSFQuestionModel *QModel=[self.qNoAnswerHandle questionWithIndex:indexPath.row];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:questionCellSelected object:[NSNumber numberWithLongLong:QModel.index]];
}
@end
