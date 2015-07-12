//
//  OSFBaseRightViewController.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFBaseRightViewController.h"
#import "OSFSearchBarView.h"
#import "UIImage+ImageWithColor.h"
#import "Okeys.h"
@interface OSFBaseRightViewController ()

@property(nonatomic, strong) UIButton *openDrawerButton;
@property(nonatomic, strong) UIButton *rightHandleButton;//右边操作的按钮
@property(nonatomic, strong) OSFSearchBarView *searchBarView;
@property(nonatomic, assign) BOOL rightTopSelect;//右上按钮点击了吗

@end

@implementation OSFBaseRightViewController

- (instancetype)init
{
    self=[super init];
    if (self) {
        [self initParams];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
         self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.openDrawerButton];
    
    if ([self rightHandleButtonHidden]==NO) {
        self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithCustomView:self.rightHandleButton];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

#pragma mark ---控制器基本参数

-(void)initParams
{
    self.viewControllerKey=@"OSFBaseRightViewController";
    
}
#pragma mark ---控制器基本视图
-(UIButton *)openDrawerButton
{
    if (_openDrawerButton==nil) {
        
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"icon_menu"] forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 25, 25);
        [button addTarget:self action:@selector(openDrawer:) forControlEvents:UIControlEventTouchUpInside];
        _openDrawerButton=button;
    }
    
    return _openDrawerButton;
}
-(UIButton *)rightHandleButton
{
    if (_rightHandleButton==nil) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:@"icon_tab_search"] forState:UIControlStateNormal];
        button.frame=CGRectMake(0, 0, 25, 25);
        [button addTarget:self action:@selector(rightHandle:) forControlEvents:UIControlEventTouchUpInside];
        
        _rightHandleButton=button;
    }
    return _rightHandleButton;
}

-(BOOL)rightHandleButtonHidden{
    
    return NO;
}

-(OSFSearchBarView *)searchBarView
{
    if (!_searchBarView) {
        OSFSearchBarView *searchbar=[[OSFSearchBarView alloc] initWithFrame:CGRectMake(0, -self.view.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height)];
        searchbar.placeholder=[self searchbarPlaceholder];
        
        _searchBarView=searchbar;
    }
    
    return _searchBarView;
}

-(NSString *)searchbarPlaceholder
{
    return @"";
}

#pragma mark ---基本视图的操作
-(void)openDrawer:(UIButton *)button
{
    [OLog showMessage:@"open Drawer"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:openDrawer object:nil];
    
}
-(void)rightHandle:(UIButton *)button
{
    [OLog showMessage:@"右顶上的按钮触发了"];
    
    self.rightTopSelect=!self.rightTopSelect;
    if (self.rightTopSelect) {
        
        [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut|UIViewAnimationOptionTransitionFlipFromTop animations:^{
            
            [self.view addSubview:self.searchBarView];
            
            self.searchBarView.placeholder=[self searchbarPlaceholder];
            
            CGRect frame = self.searchBarView.frame;
            frame.origin.y = 0;
            self.searchBarView.frame=frame;
            
        } completion:^(BOOL finished) {
          
        }];
        
        
    }else{
        [UIView animateWithDuration:0.35 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            
            CGRect frame = self.searchBarView.frame;
            frame.origin.y = -self.view.bounds.size.height;
            self.searchBarView.frame=frame;
            
        } completion:^(BOOL finished) {
            [self.searchBarView removeFromSuperview];
        }];
        
    }
    
    
}
- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


@end
