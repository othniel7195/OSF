//
//  ONetClient.m
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ONetClient.h"
#import "ONetConfig.h"
#import "OLog.h"
@interface ONetClient ()

///网络请求配置文件类
@property(nonatomic, strong)ONetConfig *config;

@property(nonatomic, strong)AFHTTPRequestOperationManager *manager;

///存储request的记录
@property(nonatomic, strong)NSMutableDictionary *requestRecords;

@end

@implementation ONetClient

+(ONetClient *)sharedNetClient
{
    static ONetClient * instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
        
    });
    
    return instance;
}

-(instancetype)init
{
    self=[super init];
    if (!self) return nil;
    
    _config=[ONetConfig sharedNetConfig];
    _manager=[AFHTTPRequestOperationManager manager];
    //最多4个并发
    _manager.operationQueue.maxConcurrentOperationCount = 4;
    
    //
    _requestRecords=[NSMutableDictionary dictionary];
    
    return self;
}


- (void)addRequest:(ONetBaseRequest *)request
{
    
    //序列化
    if ([request o_requestSerializerType]==ORequestSerializerHttp) {
        
        self.manager.requestSerializer=[AFHTTPRequestSerializer serializer];
        
    }else if ([request o_requestSerializerType]==ORequestSerializerJson)
    {
        self.manager.requestSerializer=[AFJSONRequestSerializer serializer];
    }
    
    //超时时间
    
    self.manager.requestSerializer.timeoutInterval=[request o_requestTimeoutInterval];
    
    
    if ([request o_requestMethod]==ORequestMethodGet) {
        //get
       request.orequestOpertion = [self.manager GET:[self buildRequestUrl:request] parameters:[self buildRequestParams:request] success:^(AFHTTPRequestOperation * operation, id responseObject) {
           
           [self handleRequestResult:operation];
           
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            
            [self handleRequestResult:operation];
        }];
        
    }else if ([request o_requestMethod]==ORequestMethodPost)
    {
        //post
        request.orequestOpertion = [self.manager POST:[self buildRequestUrl:request] parameters:[self buildRequestParams:request] success:^(AFHTTPRequestOperation * operation, id responseObject) {
            
            [self handleRequestResult:operation];
        } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
            
            [self handleRequestResult:operation];
        }];
    }
    
    
    [self addRequest:request];
}
- (void)cancelRequest:(ONetBaseRequest *)request
{
    [request.orequestOpertion cancel];
    [request clearCompletionBlock];
    
}
- (void)cancelAllRequests
{
    NSDictionary *copyRecord = [self.requestRecords copy];
    for (NSString *key in copyRecord) {
        ONetBaseRequest *request = copyRecord[key];
        [request stop];
    }
}

//验证请求结果
-(BOOL)checkResult:(ONetBaseRequest *)request
{
    BOOL result = [request statusCodevalidator];
    if (!result) {
        return result;
    }
    
    id jsonValidator =[request jsonValidator];
    if (jsonValidator==nil) {
        
    }else{
        //去验证返回的json 和 json验证器里面得类型
    }
    return YES;
}

#pragma mark -- 网络请求回调数据的
-(void)handleRequestResult:(AFHTTPRequestOperation *)operation
{
    NSString *key =[self requestHashKey:operation];
    ONetBaseRequest *request =self.requestRecords[key];
    if (request) {
        BOOL successed=[self checkResult:request];
        if (successed) {
            
            if (request.successCompletionBlock) {
                request.successCompletionBlock(request);
            }
        }else{
            if (request.failureCompletionBlock) {
                request.failureCompletionBlock(request);
            }
        }
        
    }
    
    [self removeOperation:operation];
    [request clearCompletionBlock];
}

#pragma mark -- 组合request 和基础 config
/// 根据request和networkConfig构建url
- (NSString *)buildRequestUrl:(ONetBaseRequest *)request
{
    NSAssert([request o_requestURL]!=nil,@"request URL 不能为nil");
    NSString *fullURLString = [self.config.baseURL stringByAppendingPathComponent:[request o_requestURL]];
    [OLog showMessage:@"fullURLString :%@ ",fullURLString];
    
    return fullURLString;
}
/// 根据request和networkConfig构建请求参数
- (NSMutableDictionary *)buildRequestParams:(ONetBaseRequest *)request
{
    NSAssert([request o_requestParams]==nil, @"request params 不能为nil");
    NSAssert(self.config.globalParams==nil, @"全局参数 不能为 nil");
    NSMutableDictionary *params_mdic=[[NSMutableDictionary alloc] init];
    
    params_mdic = [self.config.globalParams mutableCopy];
    
    [params_mdic setDictionary:(NSDictionary *)[request o_requestParams]];
    
    
    return params_mdic;
}

- (NSString *)requestHashKey:(AFHTTPRequestOperation *)operation {
    NSString *key = [NSString stringWithFormat:@"%lu", (unsigned long)[operation hash]];
    return key;
}

-(void)addOperation:(ONetBaseRequest *)request
{
    if (request.orequestOpertion != nil) {
        NSString *key = [self requestHashKey:request.orequestOpertion];
        self.requestRecords[key] = request;
    }
}

- (void)removeOperation:(AFHTTPRequestOperation *)operation {
    NSString *key = [self requestHashKey:operation];
    [self.requestRecords removeObjectForKey:key];
}

@end
