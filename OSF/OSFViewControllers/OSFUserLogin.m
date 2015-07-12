//
//  OSFUserLogin.m
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFUserLogin.h"
#import "OSFCellCollection.h"
#import "OSFTextFieldDelegate.h"
#import "OColors.h"
@interface OSFUserLogin ()<OSFTextFieldDelegate>
@property(nonatomic, strong)UIButton *loginBtn;
@property(nonatomic, strong)UIView *footView;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *password;
@end

@implementation OSFUserLogin

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [OSFCellCollection registerTextFieldCell:self.tableView];
    
    
    self.tableView.tableFooterView = self.footView;
    [self.footView addSubview:self.loginBtn];
    
    [self layoutPageViews];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -- 布局
-(void)layoutPageViews
{
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark -- 视图
-(UIButton *)loginBtn
{
    if (!_loginBtn) {
        UIButton *lbtn=[UIButton buttonWithType:UIButtonTypeSystem];
        lbtn.backgroundColor=[UIColor lightGrayColor];
        lbtn.enabled=NO;
        lbtn.layer.masksToBounds=YES;
        lbtn.layer.cornerRadius=4.0;
        [lbtn setTitle:@"登陆" forState:UIControlStateNormal];
        [lbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [lbtn addTarget:self action:@selector(loginDone) forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn=lbtn;
    }
    return _loginBtn;
}
-(UIView*)footView
{
    if (!_footView) {
        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
        view.backgroundColor=[UIColor clearColor];
        
        _footView=view;
    }
    return _footView;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *placeholder;
    NSInteger textFiledType=2;
    NSInteger returnType=1;
    if (indexPath.row==0) {
        placeholder=@"Email";
        textFiledType=1;
        returnType=1;
    }else{
        placeholder=@"密码";
        textFiledType=2;
        returnType=1;
    }
    
    UITableViewCell *cell = [OSFCellCollection cellForTextField:tableView indexPath:indexPath delegate:self placeholder:placeholder textFieldType:textFiledType returnType:returnType];
   
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"请用segmentfault账号登陆";
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

#pragma mark -- action
-(void)loginDone
{
    
}

#pragma mark -- text delegate
-(void)OSFTextFieldDidChange:(NSString *)text tagString:(NSString *)tagString
{
    if ([tagString isEqualToString:@"Email"]) {
        self.email=text;
    }else if ([tagString isEqualToString:@"密码"])
    {
        self.password=text;
    }
    
    
    [self loginBtnStateChange];
}

-(void)loginBtnStateChange
{
    //[OLog showMessage:@"email:%@  ----- password:%@",self.email,self.password];
    if (self.email!=nil&&![self.email isEqualToString:@""]&&self.password!=nil&&![self.password isEqualToString:@""]) {
        self.loginBtn.enabled=YES;
        self.loginBtn.backgroundColor=[OColors OSFNavBarColor];
    }else{
        self.loginBtn.enabled=NO;
        self.loginBtn.backgroundColor=[UIColor lightGrayColor];
    }
}

@end
