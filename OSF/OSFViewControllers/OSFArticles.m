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
@interface OSFArticles ()<UITableViewDataSource,UITableViewDelegate,OTableViewRefreshDelegate>
@property(nonatomic, strong)UITableView *articlesList;
@property(nonatomic, strong)OTableViewRefresh *orefreshControl;
@end

@implementation OSFArticles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"文章";
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self.view addSubview:self.articlesList];
    
    [OSFCellCollection registerArticleCell:self.articlesList];
    
    [self layoutPageViews];
    
    [self.orefreshControl o_tableViewHeadRefresh:self.articlesList];
    [self.orefreshControl o_tableViewFootRefresh:self.articlesList];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
    __weak OSFArticles * WEAKSELF = self;
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [WEAKSELF.orefreshControl o_endHeadRefresh:WEAKSELF.articlesList];
    });
}
-(void)o_loadMoreData
{
    __weak OSFArticles * WEAKSELF = self;
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2.0*NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
        [WEAKSELF.orefreshControl o_endFootRefresh:WEAKSELF.articlesList];
    });
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

#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFArticles";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
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
    
    return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[OSFCellCollection cellForArticle:tableView indexPath:indexPath articleTitle:@"IOS的一些问题想办法解决后得问题，IOSruntime的一些细节后得操作" articleContent:@"IOS的一些问题想办法解决后得问题，IOSruntime的一些细节后得操作" headImgURL:nil userName:@"赵锋" publishDate:@"6月12日" praiseNum:@"11"];
    
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
        CGFloat (*action)(id, SEL, NSString*,NSString *) = (CGFloat (*)(id, SEL, NSString*,NSString *)) objc_msgSend;
        height =  action(cell, @selector(calulateHeightWithTitle:content:), @"IOS的一些问题想办法解决后得问题，IOSruntime的一些细节后得操作",@"IOS的一些问题想办法解决后得问题，IOSruntime的一些细节后得操作");
        
    }
    
    return height;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}


@end
