//
//  OSFUserLoginSuccess.m
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFUserLoginSuccess.h"
#import "Masonry.h"
@interface OSFUserLoginSuccess ()
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIImageView *headImageView;

@end

@implementation OSFUserLoginSuccess

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView=self.headView;
    [self.headView addSubview:self.headImageView];
    
    [self layoutPageViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 布局
-(void)layoutPageViews
{
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.size.mas_equalTo(CGSizeMake(32.0, 32.0));
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.headView);
    }];
}
#pragma mark -- 视图
-(UIView*)headView
{
    if (!_headView) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        view.backgroundColor=[UIColor clearColor];
        
        _headView=view;
    }
    return _headView;
}
-(UIImageView *)headImageView
{
    if (!_headImageView) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_avatar"]];
        imageView.layer.masksToBounds=YES;
        imageView.layer.cornerRadius=16.0;
        imageView.layer.borderWidth=2.0;
        imageView.layer.borderColor=[UIColor lightGrayColor].CGColor;
        
        _headImageView=imageView;
    }
    return _headImageView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier=@"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (cell==nil) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    if (indexPath.row==0) {
        cell.textLabel.text=@"赵锋";
    }else if (indexPath.row==1)
    {
        cell.textLabel.text=@"退出登陆";
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
#pragma mark -- table delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
