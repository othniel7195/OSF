//
//  OSFWebViewWithComment.h
//  OSF
//
//  Created by 赵锋 on 15/7/23.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseView.h"

@interface OSFWebViewWithComment : OSFBaseView

@property(nonatomic, copy) NSString *htmlString;
@property(nonatomic, assign) BOOL hasTags;
@property(nonatomic, strong)NSArray *tags;
-(instancetype)initWithFrame:(CGRect)frame hasTags:(BOOL)hasTags;
/**
 * tags 标签数组
 */
-(CGFloat)calulateHeightWithTags:(NSArray *)tags;
@end
