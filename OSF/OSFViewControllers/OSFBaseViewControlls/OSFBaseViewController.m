//
//  OSFBaseViewController.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseViewController.h"
#import "OColors.h"
#import "UIImage+ImageWithColor.h"
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
    
    self.navigationController.navigationBar.translucent=NO;
    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:18.0]};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:[UIImage imageWithColor:[OColors OSFNavBarColor] size:CGSizeMake(self.view.bounds.size.width, 64)]
                       forBarPosition:UIBarPositionAny
                           barMetrics:UIBarMetricsDefault];
    
    [navigationBar setShadowImage:[UIImage new]];
}
#pragma mark ---控制器基本参数

-(void)initParams
{
    self.viewControllerKey=@"OSFBaseViewController";
    
}


@end
