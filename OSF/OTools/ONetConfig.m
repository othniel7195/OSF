//
//  ONetConfig.m
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "ONetConfig.h"

@interface ONetConfig ()

@property(nonatomic, strong, readwrite)NSMutableDictionary *globalParams;
@property(nonatomic, copy, readwrite)NSString *baseURL;

@end

@implementation ONetConfig

+(ONetConfig *)sharedNetConfig
{
    static id instance =nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance=[[self alloc] init];
        
    });
    
    return instance;
}
-(instancetype)init
{
    self = [super init];
    if (!self)  return nil;
    
    _globalParams=[NSMutableDictionary dictionary];
    
    return self;
}


-(void)addParams:(NSDictionary *)params
{
    [self.globalParams setDictionary:params];
}
-(void)addOneParamValue:(NSString *)paramValue paramKey:(NSString *)paramKey
{
    [self.globalParams setValue:paramValue forKey:paramKey];
}
-(void)removeParamKeys:(NSArray *)paramkeys
{
    [self.globalParams removeObjectsForKeys:paramkeys];
}
-(void)removeOneParamKey:(NSString *)paramKey
{
    [self.globalParams removeObjectForKey:paramKey];
}
-(void)addNetBaseURL:(NSString *)baseUrl
{
    self.baseURL=baseUrl;
}

@end
