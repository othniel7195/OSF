//
//  HHLabelCell.h
//  HeartHealth
//
//  Created by 赵锋 on 15/7/3.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseCell.h"

@interface OSFLabelCell : OSFBaseCell

@property(nonatomic, strong)UIImage * normalLabelImage;
@property(nonatomic, strong)UIImage * selectLabelImage;
@property(nonatomic, copy) NSString *labelInfo;
@property(nonatomic, assign) NSInteger indexTag;



@end
