//
//  OSFLeftViewController.h
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"

@interface OSFLeftViewController : UITableViewController<ICSDrawerControllerChild, ICSDrawerControllerPresenting>

@property(nonatomic, weak) ICSDrawerController *drawer;

-(instancetype)initWithUserName:(NSString *)userName userHeadUrl:(NSString *)userHeadUrl;

@end
