//
//  OSFSearch.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFSearch.h"

@interface OSFSearch ()

@end

@implementation OSFSearch

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"搜索";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFSearch";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
}

@end
