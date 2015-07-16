//
//  QuestionLatestHandle.m
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "QuestionLatestHandle.h"
#import "OLog.h"
@implementation QuestionLatestHandle

-(instancetype)init
{
    self=[super init];
    if (!self) return nil;
    
    _qLatestNet=[[QuestionLatestNet alloc] init];
    _qLatestNet.page=@"1";
    return self;
}

-(void)startNetWorking
{
    [self.qLatestNet startWithCompletionBlockWithSuccess:^(ONetBaseRequest *request) {
        
        NSDictionary *dic=request.responseJSONObject;
        
        [OLog showMessage:@"问题最新网络返回数据 :%@",dic];
        
    } failure:^(ONetBaseRequest *request) {
        
        NSError *error = [request o_requestError];
        
        [OLog showMessage:@"问题最新 Error :%@",error];
        
    }];
}
-(void)stopNetWorking
{
    
}
@end
