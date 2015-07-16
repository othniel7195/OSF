//
//  OSFPageModel.m
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFPageModel.h"

@implementation OSFPageModel

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self = [super init];
    if (!self) return nil;
    
    [self setValuesForKeysWithDictionary:dic];
    
    return self;
}

-(void)refreshPageDic:(NSDictionary *)dic
{
    [self setValuesForKeysWithDictionary:dic];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
