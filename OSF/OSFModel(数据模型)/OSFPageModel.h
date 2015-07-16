//
//  OSFPageModel.h
//  OSF
//
//  Created by 赵锋 on 15/7/16.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSFPageModel : NSObject

///当前页码数
@property(nonatomic, assign)NSInteger current;
///下一页页码数
@property(nonatomic, assign)NSInteger next;
///当前页数据数量
@property(nonatomic, assign)NSInteger size;
///总共数据数量
@property(nonatomic, assign)NSInteger total;

-(instancetype)initWithDic:(NSDictionary *)dic;

///刷新数据
-(void)refreshPageDic:(NSDictionary *)dic;

@end
