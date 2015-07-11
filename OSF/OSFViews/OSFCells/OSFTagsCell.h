//
//  OSFTagsCell.h
//  OSF
//
//  Created by 赵锋 on 15/7/11.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseCell.h"
@protocol OSFTagDidSelectDelegate;
@interface OSFTagsCell : OSFBaseCell


@property(nonatomic, strong)NSArray *tags;

@property(nonatomic, strong)NSIndexPath *path;

@property(nonatomic, weak) id<OSFTagDidSelectDelegate> delegate;
/**
 * tags 标签数组
 */
-(CGFloat)calulateHeightWithTags:(NSArray *)tags;

@end

@protocol OSFTagDidSelectDelegate <NSObject>

@optional
-(void)tagDidSelect:(NSIndexPath *)path tagIndex:(NSUInteger)tagIndex;

@end