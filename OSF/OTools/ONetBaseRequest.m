//
//  ONetBaseRequest.m
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ONetBaseRequest.h"
#import "ONetClient.h"
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
    return 60.0;
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
-(NSError *)o_requestError
{
    return  self.orequestOpertion.error;
}

- (void)startWithCompletionBlockWithSuccess:(void (^)(ONetBaseRequest *request))success
                                    failure:(void (^)(ONetBaseRequest *request))failure
{
    [self setCompletionBlockWithSuccess:success failure:failure];
    [self start];
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
    [[ONetClient sharedNetClient] addRequest:self];
}
- (void)stop
{
    [[ONetClient sharedNetClient] cancelRequest:self];
}

- (BOOL)isExecuting
{
    return self.orequestOpertion.isExecuting;
}


@end
