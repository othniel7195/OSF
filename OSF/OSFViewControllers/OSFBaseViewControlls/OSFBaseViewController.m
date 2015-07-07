//
//  OSFBaseViewController.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseViewController.h"
#import "OColors.h"
@interface OSFBaseViewController ()

@end

@implementation OSFBaseViewController

-(instancetype)init
{
    self=[super init];
    if (self) {
        
        [self initParams];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barTintColor=[OColors OSFNavBarColor];
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
#pragma mark ---控制器基本参数

-(void)initParams
{
    self.viewControllerKey=@"OSFBaseViewController";
    
}


@end
