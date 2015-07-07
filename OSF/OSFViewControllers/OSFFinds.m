//
//  OSFFinds.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFFinds.h"

@interface OSFFinds ()

@end

@implementation OSFFinds

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"发现";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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

@end
