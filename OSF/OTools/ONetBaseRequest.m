//
//  ONetBaseRequest.m
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ONetBaseRequest.h"

@implementation ONetBaseRequest




-(ORequestMethod)o_requestMethod
{
    return ORequestMethodGet;
}
-(NSDictionary *)o_requestParams
{
    return nil;
}
-(NSString *)o_requestURL
{
    return @"";
}
-(NSTimeInterval)o_requestTimeoutInterval
{
    return 20.0;
}
-(ORequestSerializerType)o_requestSerializerType
{
    return ORequestSerializerJson;
}
-(id)jsonValidator
{
    return nil;
}
-(BOOL)statusCodevalidator
{
    NSInteger statusCode = [self responseStatusCode];
    if (statusCode>=200&&statusCode<=299) {
        return YES;
    }
    
    return NO;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(ONetBaseRequest *request))success
                                    failure:(void (^)(ONetBaseRequest *request))failure
{
    [self setCompletionBlockWithSuccess:success failure:failure];
}

- (void)setCompletionBlockWithSuccess:(void (^)(ONetBaseRequest *request))success
                              failure:(void (^)(ONetBaseRequest *request))failure
{
    self.successCompletionBlock=success;
    self.failureCompletionBlock=failure;
}
- (void)clearCompletionBlock
{
    self.successCompletionBlock=nil;
    self.failureCompletionBlock=nil;
}
- (void)start
{
    
}
- (void)stop
{
    
}

- (BOOL)isExecuting
{
    return self.orequestOpertion.isExecuting;
}


@end
