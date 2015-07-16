//
//  OSFQuestionModel.h
//  OSF
//
//  Created by 赵锋 on 15/7/13.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSFUserModel.h"
#import "OSFTagModel.h"
#import "OSFLastAnswer.h"
@interface OSFQuestionModel : NSObject
///回答人数
@property(nonatomic, assign)NSInteger answers;
///书签数
@property(nonatomic, assign)NSInteger bookmarks;
///创建时间
@property(nonatomic, assign)long long created;
///创建时间的 文字表示
@property(nonatomic, copy)NSString *createdDate;
///摘录
@property(nonatomic, copy)NSString *excerpt;
/// id 标识
@property(nonatomic, assign)long long index;//id
///被关注 false true
@property(nonatomic, assign)NSInteger isAccepted;
///被标签 false true
@property(nonatomic, assign)NSInteger isBookmarked;
///被关闭
@property(nonatomic, assign)NSInteger isClosed;
///
@property(nonatomic, assign)long long siteId;
///标题
@property(nonatomic, copy)NSString *title;
///问题 url
@property(nonatomic, copy)NSString *url;

@property(nonatomic, assign)NSInteger viewsWord;
///投票
@property(nonatomic, assign)NSInteger votes;

@property(nonatomic, strong)OSFUserModel *user;
@property(nonatomic, strong)OSFLastAnswer *lastAnswer;
@property(nonatomic, strong)NSArray *tags;

///通过字典设置model
-(instancetype)initWithDic:(NSDictionary *)dic;

@end
