//
//  OSFArticles.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFArticles.h"

@interface OSFArticles ()

@end

@implementation OSFArticles

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"文章";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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


@end
