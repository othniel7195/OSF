//
//  OSFUser.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFUser.h"
#import "OSFUserLogin.h"
@interface OSFUser ()
@property(nonatomic, strong)OSFUserLogin *userLogin;
@end

@implementation OSFUser

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的主页";
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self addChildViewController:self.userLogin];
    [self.view addSubview:self.userLogin.view];
    self.userLogin.view.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- 视图
-(OSFUserLogin *)userLogin
{
    if (!_userLogin) {
        OSFUserLogin *ulogin=[[OSFUserLogin alloc] initWithStyle:UITableViewStyleGrouped];
        
        _userLogin=ulogin;
    }
    return _userLogin;
}


#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFUser";
}
-(BOOL)rightHandleButtonHidden
{
    return  YES;
}

@end
