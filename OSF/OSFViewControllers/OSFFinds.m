//
//  OSFFinds.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFFinds.h"
#import "OSFCellCollection.h"
#import <objc/message.h>
@interface OSFFinds ()<UITableViewDelegate,UITableViewDataSource,OSFTagDidSelectDelegate>

@property(nonatomic, strong)UITableView *tagsList;
@property(nonatomic, strong)NSArray *tableTitles;

@end

@implementation OSFFinds

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"发现";
    
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    self.tableTitles=@[@"关注的",@"热门的"];
    
    [self.view addSubview:self.tagsList];
    [OSFCellCollection registerTagsCell:self.tagsList];
    
    [self layoutPageViews];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

#pragma mark -- 布局
-(void)layoutPageViews
{
    [self.tagsList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(self.view);
    }];
}

#pragma mark -- 视图
-(UITableView *)tagsList
{
    if (!_tagsList) {
        UITableView *tags_table=[[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tags_table.dataSource=self;
        tags_table.delegate=self;
        
        _tagsList=tags_table;
    }
    return _tagsList;
}


#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFFinds";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
}

#pragma mark -- table datasouce
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.tableTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[OSFCellCollection cellForTags:tableView indexPath:indexPath delegate:self tags:@[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"]];
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.tableTitles[section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static UITableViewCell *cell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cell = [tableView dequeueReusableCellWithIdentifier:TagCell];
    });
    CGFloat height=70.0;
    if([cell respondsToSelector:@selector(calulateHeightWithTags:)])
    {
        CGFloat (*action)(id, SEL, NSArray*) = (CGFloat (*)(id, SEL, NSArray*)) objc_msgSend;
        height =  action(cell, @selector(calulateHeightWithTags:), @[@"Python", @"Javascript", @"HTML", @"Go", @"Objective-C",@"C", @"PHP"]);
        
    }

    return height;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

#pragma mark tags select
-(void)tagDidSelect:(NSIndexPath *)path tagIndex:(NSUInteger)tagIndex
{
    [OLog showMessage:@"tag path :%@  tagIndex:%d",path,tagIndex];
}

@end
