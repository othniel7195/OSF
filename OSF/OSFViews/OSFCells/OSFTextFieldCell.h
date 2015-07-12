//
//  OSFTextFieldCell.h
//  OSF
//
//  Created by 赵锋 on 15/7/12.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseCell.h"
@protocol OSFTextFieldDelegate;
@interface OSFTextFieldCell : OSFBaseCell

/// textField 的类型  1普通类型  2 password类型
@property(nonatomic, assign) NSInteger textFieldType;
/// return 按钮类型 1 done  2 next
@property(nonatomic, assign) NSInteger returnType;
///
@property(nonatomic, copy) NSString *placeholder;

@property(nonatomic, weak) id <OSFTextFieldDelegate> delegate;

@end
