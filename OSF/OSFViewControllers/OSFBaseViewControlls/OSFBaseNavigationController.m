//
//  OSFBaseNavigationController.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseNavigationController.h"
#import "OSFBaseViewController.h"
#import "Okeys.h"
static NSMutableDictionary *config;
@interface OSFBaseNavigationController ()

@end

@implementation OSFBaseNavigationController

- (instancetype)init
{
    self=[super init];
    
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openDrawer) name:openDrawer object:nil];
}

#pragma mark ---
- (NSMutableDictionary *)config
{
    
    if (nil == config) {
        config = [[NSMutableDictionary alloc] init];
    }
    
    return config;
}

#pragma  mark -- 打开抽屉
-(void)openDrawer
{
    [self.drawer open];
}


#pragma mark -- parent

- (id)initWithRootViewController:(OSFBaseViewController *)aRootViewController
{
    self = [super initWithRootViewController:aRootViewController];
    if (self) {
        
        self.rootViewController = aRootViewController;
        
        [self.config setValue:aRootViewController.viewControllerKey forKey:aRootViewController.viewControllerKey];
        
        return self;
    }
    return nil;
}


- (void)pushViewController:(OSFBaseViewController *)viewController animated:(BOOL)animated
{
    [self.config setValue:viewController.viewControllerKey forKey:viewController.viewControllerKey];
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - ICSDrawerControllerPresenting
- (void)drawerControllerWillOpen:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = NO;
}

- (void)drawerControllerDidClose:(ICSDrawerController *)drawerController
{
    self.view.userInteractionEnabled = YES;
}
#pragma mark -- status bar
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark -delloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:openDrawer object:nil];
}


@end
