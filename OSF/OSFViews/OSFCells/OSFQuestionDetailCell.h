//
//  OSFQuestionDetailCell.h
//  OSF
//
//  Created by 赵锋 on 15/7/22.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseCell.h"

@interface OSFQuestionDetailCell : OSFBaseCell


-(void)osfQuestionTitle:(NSString *)title  name:(NSString *)name time:(NSString *)time;
-(void)osfQuestionHtmlString:(NSString *)htmlString tags:(NSArray *)tags;
@end
