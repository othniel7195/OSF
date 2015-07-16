//
//  QuestionHotNet.m
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "QuestionHotNet.h"

@implementation QuestionHotNet

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
    return @"question/hottest";
}

@end
