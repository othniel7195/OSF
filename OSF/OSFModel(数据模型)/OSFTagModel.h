//
//  OSFTagModel.h
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFTagModel : NSObject
///id
@property(nonatomic, assign)NSInteger index;
///标签名
@property(nonatomic, copy)NSString *name;
///相似的标签数组
@property(nonatomic, strong)NSArray *similarTags;
///标签 url
@property(nonatomic, copy)NSString *url;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
