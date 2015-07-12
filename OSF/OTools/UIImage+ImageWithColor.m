//
//  UIImage+ImageWithColor.m
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "UIImage+ImageWithColor.h"

@implementation UIImage (ImageWithColor)
+(UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGSize imageSize = size;
    UIGraphicsBeginImageContextWithOptions(imageSize, 0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
    UIImage *pressedColorImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return pressedColorImg;

}
@end
