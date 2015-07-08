//
//  OSFQuestions.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestions.h"
#import "OSFQuestionLatest.h"
@interface OSFQuestions ()
///问题--最新的
@property(nonatomic, strong) OSFQuestionLatest *questionLastest;
@end

@implementation OSFQuestions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"问题";
    
    [self addChildViewController:self.questionLastest];
    [self.view addSubview:self.questionLastest.view];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- 视图
-(OSFQuestionLatest *)questionLastest
{
    if (_questionLastest==nil) {
        OSFQuestionLatest *lastest=[[OSFQuestionLatest alloc] initWithStyle:UITableViewStylePlain];
        
        _questionLastest = lastest;
    }
    
    return _questionLastest;
}


#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFQuestions";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
}

@end
