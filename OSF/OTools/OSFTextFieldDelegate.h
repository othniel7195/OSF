//
//  OSFTextFieldDelegate.h
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OSFTextFieldDelegate <NSObject>
@optional
-(void)OSFTextFieldDidChange:(NSString *)text  tagString:(NSString *)tagString;
@end
