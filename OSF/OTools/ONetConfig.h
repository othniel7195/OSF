//
//  ONetConfig.h
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//
//全局配置的参数和baseURL
#import <Foundation/Foundation.h>

@interface ONetConfig : NSObject

///全局参数
@property(nonatomic, strong, readonly)NSMutableDictionary *globalParams;
///baseURL
@property(nonatomic, copy, readonly)NSString *baseURL;

+(ONetConfig *)sharedNetConfig;

///加一些参数
-(void)addParams:(NSDictionary *)params;
///加一个参数
-(void)addOneParamValue:(NSString *)paramValue paramKey:(NSString *)paramKey ;
///删除一些参数
-(void)removeParamKeys:(NSArray *)paramkeys;
///删除一个参数
-(void)removeOneParamKey:(NSString *)paramKey;
///设置baseURL
-(void)addNetBaseURL:(NSString *)baseUrl;


@end
