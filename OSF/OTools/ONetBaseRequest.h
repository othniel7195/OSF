//
//  ONetBaseRequest.h
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//
//每个接口自己得参数 和 请求方式 等得基类

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
typedef NS_ENUM(NSInteger, ORequestMethod)
{
    ORequestMethodGet,
    ORequestMethodPost
};// 其他用不到 就支持get 和post

typedef NS_ENUM(NSInteger, ORequestSerializerType)
{
    ORequestSerializerHttp,
    ORequestSerializerJson
};//序列化方式

@interface ONetBaseRequest : NSObject

@property(nonatomic, assign) NSInteger opertionTag;
@property(nonatomic, strong) NSDictionary *userInfo;

@property(nonatomic, strong) AFHTTPRequestOperation * orequestOpertion;

@property(nonatomic, strong, readonly) NSString *responseString;

@property(nonatomic, strong, readonly) id responseJSONObject;

@property(nonatomic, readonly) NSInteger responseStatusCode;

@property(nonatomic, copy) void (^successCompletionBlock)(ONetBaseRequest *);

@property(nonatomic, copy) void (^failureCompletionBlock)(ONetBaseRequest *);


///返回方法 是get 还是 post 默认get
-(ORequestMethod)o_requestMethod;
///特定接口的请求参数
-(NSDictionary *)o_requestParams;
///自己接口的URL地址  不包含基础url的
-(NSString *)o_requestURL;
///请求超时时间 默认20s
-(NSTimeInterval)o_requestTimeoutInterval;
///请求的序列化 默认json
-(ORequestSerializerType)o_requestSerializerType;
///检测json是否为合法对象
-(id)jsonValidator;
///检测statusCode 是否正确
-(BOOL)statusCodevalidator;

//--------------------
/// block回调
- (void)startWithCompletionBlockWithSuccess:(void (^)(ONetBaseRequest *request))success
                                    failure:(void (^)(ONetBaseRequest *request))failure;

- (void)setCompletionBlockWithSuccess:(void (^)(ONetBaseRequest *request))success
                              failure:(void (^)(ONetBaseRequest *request))failure;

/// 把block置nil来打破循环引用
- (void)clearCompletionBlock;

/// 加入请求队列
- (void)start;

/// 从请求队列删除
- (void)stop;

- (BOOL)isExecuting;


@end
