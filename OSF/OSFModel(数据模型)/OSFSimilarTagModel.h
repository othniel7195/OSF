//
//  OSFSimilarTagModel.h
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFSimilarTagModel : NSObject

///id
@property(nonatomic, copy)NSString *index;
///标签名字
@property(nonatomic, copy)NSString *name;

-(instancetype)initWithDic:(NSDictionary *)dic;
@end
