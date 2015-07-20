//
//  OSFArticles.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFArticles.h"
#import "OSFCellCollection.h"
#import <objc/message.h>
#import "OTableViewRefresh.h"
#import "OSFRefreshView.h"
#import "ArticleHandle.h"
#import "OSFArticleModel.h"
#import "OTypes.h"
@interface OSFArticles ()<UITableViewDataSource,UITableViewDelegate,OTableViewRefreshDelegate,UIScrollViewDelegate,OSFRefreshViewDelegate>
@property(nonatomic, strong)UITableView *articlesList;
@property(nonatomic, strong)OTableViewRefresh *orefreshControl;
///第一次  界面上没数据时的刷新控件
@property(nonatomic, strong) OSFRefreshView *osfRefreshView;
@property(nonatomic, strong) ArticleHandle *articleHandle;
@property(nonatomic, assign) BOOL statusbarHidden;

@end

@implementation OSFArticles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"文章";
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.articlesList];
    
    [self.osfRefreshView o_startRefresh];
    
    [OSFCellCollection registerArticleCell:self.articlesList];
    
    //tableView上什么数据都没的时候禁止滚动
    self.articlesList.scrollEnabled=NO;
    
    self.articlesList.tableFooterView=[[UIView alloc] init];
    
    [self layoutPageViews];
    
    [self.orefreshControl o_tableViewHeadRefresh:self.articlesList];
    [self.orefreshControl o_tableViewFootRefresh:self.articlesList];
    
    
    [self stepArticleNetWork:ONetWorkFirst];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- scrollView delegate

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.y>0) {
        
        [UIView animateWithDuration:0.15 animations:^{
            self.navigationController.navigationBarHidden=YES;
            self.statusbarHidden=YES;
            
            [self setNeedsStatusBarAppearanceUpdate];
            
        }];
        
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.navigationBarHidden=NO;
            self.statusbarHidden=NO;
            
            [self setNeedsStatusBarAppearanceUpdate];
        }];
        
    }

}

#pragma mark -- first refresh table
-(OSFRefreshView *)osfRefreshView
{
    if (!_osfRefreshView) {
        OSFRefreshView *rv=[[OSFRefreshView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height)];
        rv.delegate=self;
        
        _osfRefreshView=rv;
        
        [self.view addSubview:_osfRefreshView];
    }
    
    return _osfRefreshView;
}

-(void)OSFRefreshViewReloadData
{
    
    [self stepArticleNetWork:ONetWorkFirst];
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
    
    self.articleHandle.articleNet.page=@"1";
    [self stepArticleNetWork:ONetWorkTopPull];
}
-(void)o_loadMoreData
{
    self.articleHandle.articleNet.page=[NSString stringWithFormat:@"%ld",self.articleHandle.pageModel.next];
    [self stepArticleNetWork:ONetWorkBottomPull];
}


#pragma mark -- 布局
-(void)layoutPageViews
{
    [self.articlesList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
}

#pragma mark -- 视图
-(UITableView *)articlesList
{
    if (_articlesList==nil) {
        UITableView *articelsList=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        articelsList.dataSource=self;
        articelsList.delegate=self;
        
        _articlesList=articelsList;
    }
    return _articlesList;
}

#pragma mark -- 网络操作

-(void)stepArticleNetWork:(ONetWorkState)networkState
{
    
    [self.articleHandle startNetWorking];
    
    __weak typeof(self) weakSelf = self;
    self.articleHandle.successBlock = ^{
        
        switch (networkState) {
            case ONetWorkFirst:
            {
                weakSelf.articlesList.scrollEnabled=YES;
                [weakSelf.articlesList reloadData];
                [weakSelf.osfRefreshView  o_endRefresh];
                [weakSelf.osfRefreshView removeFromSuperview];
            }
                break;
            case ONetWorkTopPull:
            {
                
                [weakSelf.articlesList reloadData];
                [weakSelf.orefreshControl o_endHeadRefresh:weakSelf.articlesList];
            }
                break;
            case ONetWorkBottomPull:
            {
                [weakSelf.articlesList reloadData];
                [weakSelf.orefreshControl o_endFootRefresh:weakSelf.articlesList];
            }
                break;
        }
        
    };
    
    self.articleHandle.failureBlock = ^{
        
        switch (networkState) {
            case ONetWorkFirst:
            {
                [weakSelf.osfRefreshView  o_endRefresh];
            }
                break;
            case ONetWorkTopPull:
            {
                [weakSelf.orefreshControl o_endHeadRefresh:weakSelf.articlesList];
            }
                break;
            case ONetWorkBottomPull:
            {
                [weakSelf.orefreshControl o_endFootRefresh:weakSelf.articlesList];
            }
                break;
        }
    };
    
}

-(ArticleHandle *)articleHandle
{
    if (_articleHandle==nil) {
        
        ArticleHandle *handle =[[ArticleHandle alloc] init];
        
        _articleHandle=handle;
    }
    
    return _articleHandle;
}


#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFArticles";
}
-(BOOL)rightHandleButtonHidden
{
    return  self.statusbarHidden;
}
-(NSString *)searchbarPlaceholder
{
    return @"查询文章";
}
#pragma mark -- table datasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.articleHandle.articleArrs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    OSFArticleModel *am=self.articleHandle.articleArrs[indexPath.row];
    
    UITableViewCell *cell=[OSFCellCollection cellForArticle:tableView indexPath:indexPath articleTitle:am.title articleContent:am.excerpt headImgURL:am.user.avatarUrl userName:am.user.name publishDate:am.createdDate praiseNum:[NSString stringWithFormat:@"%ld",am.votes]];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static UITableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:ArticleCell];
    });
    
    CGFloat height=70.0;
    if([cell respondsToSelector:@selector(calulateHeightWithTitle:content:)])
    {
        OSFArticleModel *am=self.articleHandle.articleArrs[indexPath.row];
        CGFloat (*action)(id, SEL, NSString*,NSString *) = (CGFloat (*)(id, SEL, NSString*,NSString *)) objc_msgSend;
        height =  action(cell, @selector(calulateHeightWithTitle:content:), am.title,am.excerpt);
        
    }
    
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


@end
