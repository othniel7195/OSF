//
//  OSFQuestionUserModel.h
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFUserModel : NSObject
///头像地址
@property(nonatomic, copy)NSString *avatarUrl;
///id
@property(nonatomic, copy)NSString *index;
///用户名
@property(nonatomic, copy)NSString *name;
///等级
@property(nonatomic, copy)NSString *rank;
///
@property(nonatomic, copy)NSString *url;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
