//
//  OColors.h
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface OColors : NSObject

+(UIColor *)OSFNavBarColor;//导航颜色
+(UIColor *)OSFLabelCellBackgroundColor;// 左边菜单cell原始颜色
+(UIColor *)OSFLabelCellSelectBackgroundColor;// 左边菜单cell被点击后的颜色
+(UIColor *)OSFQuestionFlagBackgroundColo:(NSInteger) questionType;
@end
