//
//  OSFUser.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFUser.h"

@interface OSFUser ()

@end

@implementation OSFUser

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的主页";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFUser";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
}

@end
