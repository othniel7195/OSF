//
//  QuestionLatestHandle.m
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "QuestionLatestNet.h"

@implementation QuestionLatestNet

-(ORequestMethod)o_requestMethod
{
    return ORequestMethodGet;
}
-(NSDictionary *)o_requestParams
{
    return @{@"page":self.page};
}
-(NSString *)o_requestURL
{
    return @"question/newest";
}

@end
