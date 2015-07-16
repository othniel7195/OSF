//
//  OSFLastAnswer.h
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSFUserModel.h"
@interface OSFLastAnswer : NSObject
///创建时间的 文字表示
@property(nonatomic, copy)NSString *createdDate;
@property(nonatomic, copy)NSString *url;
@property(nonatomic, strong)OSFUserModel *user;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
