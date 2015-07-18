//
//  OSFBlog.h
//  OSF
//
//  Created by 赵锋 on 15/7/18.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFBlog : NSObject

@property(nonatomic, copy) NSString *name;

@property(nonatomic, copy) NSString *url;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
