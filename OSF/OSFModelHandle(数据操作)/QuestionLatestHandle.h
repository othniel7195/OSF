//
//  QuestionLatestHandle.h
//  OSF
//
//  Created by 赵锋 on 15/7/15.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionLatestNet.h"

@interface QuestionLatestHandle : NSObject

///最新问题 请求
@property(nonatomic, strong)QuestionLatestNet *qLatestNet;
-(void)startNetWorking;
-(void)stopNetWorking;
@end
