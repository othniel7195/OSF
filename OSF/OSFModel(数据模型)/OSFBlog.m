//
//  OSFBlog.m
//  OSF
//
//  Created by 赵锋 on 15/7/18.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBlog.h"

@implementation OSFBlog

-(instancetype)initWithDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
