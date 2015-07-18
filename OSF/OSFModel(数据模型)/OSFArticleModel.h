//
//  OSFArticleModel.h
//  OSF
//
//  Created by 赵锋 on 15/7/18.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OSFUserModel.h"
#import "OSFBlog.h"
@interface OSFArticleModel : NSObject

///文章id
@property(nonatomic, assign) long long index;
///文章地址
@property(nonatomic, copy) NSString *url;
///文章标题
@property(nonatomic, copy) NSString *title;
///投票
@property(nonatomic, assign) NSInteger votes;
///书签数
@property(nonatomic, assign)NSInteger bookmarks;
///创建时间的 文字表示
@property(nonatomic, copy)NSString *createdDate;
///摘录
@property(nonatomic, copy)NSString *excerpt;

@property(nonatomic, assign)NSInteger viewsWord;
///评论数
@property(nonatomic, assign)NSInteger comments;

@property(nonatomic, strong)OSFUserModel *user;
@property(nonatomic, strong)OSFBlog *blog;
@property(nonatomic, strong)NSArray *tags;

-(instancetype)initWithDic:(NSDictionary *)dic;

@end
