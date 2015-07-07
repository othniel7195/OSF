//
//  HHBaseCell.h
//  HeartHealth
//
//  Created by 赵锋 on 15/7/3.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "OLog.h"
@interface OSFBaseCell : UITableViewCell

@property (nonatomic, strong, readonly) NSNumber * cellHeight;

-(void)initConstraints;
@end
