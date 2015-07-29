//
//  OSFQuestionDetail.m
//  OSF
//
//  Created by 赵锋 on 15/7/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestionDetail.h"
#import "OSFCellCollection.h"
@interface OSFQuestionDetail ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *detailList;

@end

@implementation OSFQuestionDetail

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.detailList];
    
    [OSFCellCollection registerQuestionDetailCell:self.detailList];
    
}

#pragma mark -- 视图
-(UITableView *)detailList
{
    if (!_detailList) {
        UITableView *detail_list=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        detail_list.dataSource=self;
        detail_list.delegate=self;
        
        _detailList=detail_list;
    }
    return _detailList;
}

#pragma makr - table DataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[OSFCellCollection cellForQuestionDetail:tableView indexPath:indexPath title:@"IOS 中那些运动类的APP，如何实现在View中实时显示当前的速度和运动的距离的呢? 如何刷新界面" userName:@"赵锋" time:@"一天前" htmlString:@"<p>感觉写的都一样啊，很奇怪？<br><img src=\"/img/bVmRRs\" alt=\"图片描述\"></p><p><img src=\"/img/bVmRRv\" alt=\"图片描述\"><br><img src=\"/img/bVmRRx\" alt=\"图片描述\"></p>" tags:@[@"iOS",@"view",@"刷新",@"objective-c"]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.bounds.size.height;
}
@end
