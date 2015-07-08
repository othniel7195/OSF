//
//  OColors.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OColors.h"
#define RGB(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@implementation OColors

+(UIColor *)OSFNavBarColor
{
    return  RGB(68, 98, 88, 1.0);
}

+(UIColor *)OSFLabelCellBackgroundColor
{
    return RGB(68, 128, 78, 0.8);
}

+(UIColor *)OSFLabelCellSelectBackgroundColor
{
    return RGB(200, 200, 200, 1.0);
}
+(UIColor *)OSFQuestionFlagBackgroundColo:(NSInteger) questionType
{
    UIColor *color=nil;
    switch (questionType) {
        case 0:
        {
            color=RGB(240, 65, 85, 1.0);
        }
            break;
            
        case 1:
        {
            color=RGB(18, 139, 78, 1.0);
        }
            break;
        case 2:
        {
            color=RGB(128, 128, 128, 1.0);
        }
            break;
    }
    
    return color;
}
+(UIColor *)OSFRightCellHighlightColor
{
    return RGB(68, 98, 88, 0.1);
}
@end
