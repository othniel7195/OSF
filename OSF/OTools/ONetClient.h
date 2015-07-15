//
//  ONetClient.h
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ONetBaseRequest.h"
#import "AFNetworking.h"
@interface ONetClient : NSObject

+(ONetClient *)sharedNetClient;

///加入请求队列
- (void)addRequest:(ONetBaseRequest *)request;
///从请求队列取消
- (void)cancelRequest:(ONetBaseRequest *)request;
///取消当前所有请求
- (void)cancelAllRequests;

@end
