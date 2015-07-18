//
//  OSFQuestions.m
//  OSF
//
//  Created by 赵锋 on 15/7/7.
//  Copyright (c) 2015年 赵锋. All rights reserved.
//

#import "OSFQuestions.h"
#import "OSFQuestionLatest.h"
#import "OSFQuestionHot.h"
#import "OSFQuestionNoAnswer.h"
#import "Masonry.h"
#import "OColors.h"
#import "Okeys.h"
typedef NS_ENUM(NSInteger, ViewControllerType)
{
    OSFQLastest, // 最新
    OSFQHot,    // 热门
    OSFQNoAnswer //未回答
};

@interface OSFQuestions ()
///问题--最新的
@property(nonatomic, strong) OSFQuestionLatest *questionLastest;
///问题--热门的
@property(nonatomic, strong) OSFQuestionHot *questionHot;
///问题--未解答的
@property(nonatomic, strong) OSFQuestionNoAnswer *questionNoAnswer;

@property(nonatomic, strong) UISegmentedControl *segmentedControl;

@property(nonatomic, strong) UITableViewController *currentViewController;

@property(nonatomic, copy) NSString *questionType;

@property(nonatomic, assign) BOOL statusbarHidden;

@end

@implementation OSFQuestions

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"问题";
    self.questionType=@"查询最新问题";
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self addChildViewController:self.questionLastest];
    [self addChildViewController:self.questionHot];
    [self addChildViewController:self.questionNoAnswer];
    self.currentViewController=self.questionLastest;
    
    [self layoutPageViews];
    
    
    //接收child的tableview滚动的消息
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(monitorTable:) name:tableRolling object:nil];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark -- 布局
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    
}
-(void)layoutPageViews
{
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(260, 40));
        make.top.mas_equalTo(5);
    }];
}


#pragma mark -- 视图
-(OSFQuestionLatest *)questionLastest
{
    if (_questionLastest==nil) {
        OSFQuestionLatest *lastest=[[OSFQuestionLatest alloc] initWithStyle:UITableViewStylePlain];
        lastest.view.frame=CGRectMake(0, 55.0, self.view.bounds.size.width, self.view.bounds.size.height-55.0);
        _questionLastest = lastest;
        
        
        [self.view addSubview:self.questionLastest.view];
        
    }
    
    return _questionLastest;
}

-(OSFQuestionHot *)questionHot
{
    if (_questionHot==nil) {
        OSFQuestionHot *hot=[[OSFQuestionHot alloc] init];
        hot.view.frame=CGRectMake(0, 55.0, self.view.bounds.size.width, self.view.bounds.size.height-55.0);
        _questionHot=hot;
        
        
    }
    
    return _questionHot;
}

-(OSFQuestionNoAnswer *)questionNoAnswer
{
    if (_questionNoAnswer==nil) {
        OSFQuestionNoAnswer *answer=[[OSFQuestionNoAnswer alloc] init];
        answer.view.frame=CGRectMake(0, 55.0, self.view.bounds.size.width, self.view.bounds.size.height-55.0);
        _questionNoAnswer=answer;
        
        
    }
    return _questionNoAnswer;
}

-(UISegmentedControl *)segmentedControl
{
    if (_segmentedControl==nil) {
        UISegmentedControl *segmented=[[UISegmentedControl alloc] initWithItems:@[@"最新的",@"热门的",@"未回答"]];
        [segmented addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
        segmented.selectedSegmentIndex=0;
        segmented.tintColor=[OColors OSFNavBarColor];
        
        _segmentedControl=segmented;
        
        [self.view addSubview:self.segmentedControl];
    }
    return _segmentedControl;
}

#pragma mark -- 控件 action
-(void)segmentedControlChange:(UISegmentedControl *)sender
{
    switch (sender.selectedSegmentIndex) {
        case OSFQLastest:
        {
            self.questionType=@"查询最新问题";
            [self.questionLastest.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self replaceOldController:self.currentViewController toNewController:self.questionLastest];
        }
            break;
        case OSFQHot:
        {
            self.questionType=@"查询热门问题";
            [self.questionLastest.view setTranslatesAutoresizingMaskIntoConstraints:NO];

            [self replaceOldController:self.currentViewController toNewController:self.questionHot];
        }
            break;
        case OSFQNoAnswer:
        {
            self.questionType=@"查询未回答问题";

            [self.questionNoAnswer.view setTranslatesAutoresizingMaskIntoConstraints:NO];
            [self replaceOldController:self.currentViewController toNewController:self.questionNoAnswer];
        }
            break;
    }
}

#pragma mark --切换当前显示的controller
-(void)replaceOldController:(UITableViewController *)oldController  toNewController:(UITableViewController *)newController
{
    
    [self addChildViewController:newController];
    
    [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:nil completion:^(BOOL finished) {
        
        if (finished) {
            
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentViewController = newController;

        }else{
            
            self.currentViewController = oldController;
            
        }
    }];
}

#pragma mark - status bar style
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (BOOL)prefersStatusBarHidden
{
    return self.statusbarHidden;
}

#pragma mark -- 监听 表视图的滚动
-(void)monitorTable:(NSNotification *)noti
{
   
    NSValue *value=noti.object;
    CGPoint velocity=[value CGPointValue];
    if (velocity.y>0) {
        
        
        
        [UIView animateWithDuration:0.15 animations:^{
            self.navigationController.navigationBarHidden=YES;
            self.statusbarHidden=YES;
            
            [self setNeedsStatusBarAppearanceUpdate];
            
        }];
        
    }else
    {
        [UIView animateWithDuration:0.2 animations:^{
            self.navigationController.navigationBarHidden=NO;
            self.statusbarHidden=NO;
            
            [self setNeedsStatusBarAppearanceUpdate];
        }];
        
    }

}


#pragma mark -- parent
-(void)initParams
{
    self.viewControllerKey=@"OSFQuestions";
}
-(BOOL)rightHandleButtonHidden
{
    return  NO;
}
-(NSString *)searchbarPlaceholder
{
    return self.questionType;
}

#pragma mark -- delloc
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:tableRolling object:nil];
}


@end
